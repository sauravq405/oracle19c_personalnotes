# Oracle 26ai Verified Startup & 19c Conflict Management

This guide provides a robust PowerShell script to manage the transition from Oracle 19c to Oracle 26ai (FREE). It uses **Automatic (Delayed Start)** to ensure your **D: Drive** is fully ready before the database attempts to mount, preventing "File Not Found" errors.

## 1. The Enhanced Automation Script

Copy this into a PowerShell window (Run as Administrator). This script will block the console until the 26ai environment is fully "Ready."

```powershell
<#
.SYNOPSIS
    Configures Oracle 26ai for Automatic (Delayed) start and 19c to Manual.
    Waits until the 26ai instance and listener are fully operational before exiting.
#>

Write-Host "--- Initializing Oracle Service Configuration ---" -ForegroundColor Cyan

# 1. Define Service Groups
$Oracle23aiServices = @("OracleServiceFREE", "OracleOraDB23Home1TNSListener")
$Oracle19cServices  = @("OracleServiceORCL", "OracleOraDB19Home1TNSListener", "OracleOraDB19Home1MTSRecoveryService", "OracleVssWriterORCL")

# 2. Prevent 19c Conflicts
Write-Host "[+] Ensuring 19c Services are Stopped and set to Manual..." -ForegroundColor Yellow
foreach ($service in $Oracle19cServices) {
    Stop-Service -Name $service -Force -ErrorAction SilentlyContinue
    Set-Service -Name $service -StartupType Manual -ErrorAction SilentlyContinue
    Write-Host "    -> $service set to Manual/Stopped."
}

# 3. Configure 26ai for Success (Delayed Start for D: Drive readiness)
Write-Host "[+] Setting 26ai Services to Automatic (Delayed Start)..." -ForegroundColor Yellow
foreach ($service in $Oracle23aiServices) {
    Set-Service -Name $service -StartupType AutomaticDelayedStart -ErrorAction SilentlyContinue
}

# 4. Start 26ai Fresh
Write-Host "[+] Starting 26ai Listener and Instance..." -ForegroundColor Yellow
Start-Service OracleOraDB23Home1TNSListener -ErrorAction SilentlyContinue
Start-Service OracleServiceFREE -ErrorAction SilentlyContinue

# 5. Verification Loop
Write-Host "`n[!] VERIFYING SYSTEM READINESS - Please wait..." -ForegroundColor Cyan
$isDatabaseReady = $false
$isListenerReady = $false
$timeoutSeconds = 300 
$elapsed = 0

while (($elapsed -lt $timeoutSeconds) -and (-not ($isDatabaseReady -and $isListenerReady))) {
    $lsnrStatus = lsnrctl status FREE 2>$null
    if ($lsnrStatus -match "Ready" -or $lsnrStatus -match "Open") {
        if (-not $isListenerReady) {
            Write-Host "    [✓] Listener is now READY." -ForegroundColor Green
            $isListenerReady = $true
        }
    }
    $svcStatus = Get-Service -Name "OracleServiceFREE"
    if ($svcStatus.Status -eq "Running") {
        if (-not $isDatabaseReady) {
            Write-Host "    [✓] OracleServiceFREE is now RUNNING." -ForegroundColor Green
            $isDatabaseReady = $true
        }
    }
    if (-not ($isDatabaseReady -and $isListenerReady)) {
        Start-Sleep -Seconds 5
        $elapsed += 5
    }
}

Write-Host "`n--- FINAL VERIFICATION ---" -ForegroundColor Cyan

```

## 2. Manual Verification Steps

Once the script completes, run these commands to manually confirm the state of your services and database files.

### Step A: Verify Windows Services

Ensure that 26ai services are `Running` and 19c services are `Stopped`.

```powershell
Get-Service Oracle* | Select-Object Name, StartType, Status | Sort-Object Name

```

### Step B: Verify Database Instance Connection

Log in via SQL*Plus to ensure the instance is responding.

```powershell
set ORACLE_SID=FREE
sqlplus / as sysdba

```

### Step C: Verify Datafile Paths (D: Drive Check)

Inside the SQL*Plus session, run the following to ensure all files are correctly mapped to your **D: Drive** and not the default C: drive ADE paths.

```sql
SELECT name FROM v$datafile;

```

---

## Troubleshooting Summary

| Error | Cause | Fix |
| --- | --- | --- |
| **ORA-12541** | Listener is not started or still initializing. | Wait for the script's "Listener is READY" message. |
| **ORA-12241** | Windows Service `OracleServiceFREE` is stopped. | Run `Start-Service OracleServiceFREE` in Admin PowerShell. |
| **Hanging on Start** | 19c is competing for RAM or D: drive is slow. | Use **Automatic (Delayed Start)** as configured in the script above. |
