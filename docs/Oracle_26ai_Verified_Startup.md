# Oracle 26ai Verified Startup & 19c Conflict Management (Windows)

This guide documents a **verified, working setup** for running **Oracle 26ai FREE** alongside an existing **Oracle 19c** installation on Windows, without service conflicts or startup failures.

The core issue addressed here is **database startup failure caused by storage timing**, especially when Oracle datafiles live on a non-system drive (`D:`).  
The solution uses **Windows Service configuration + PowerShell validation** to ensure the drive is fully available before Oracle attempts to mount the database.

---

## Problem Statement

When Oracle 26ai FREE is installed with datafiles on `D:\`, the database service may fail during system boot with errors such as:

- `ORA-01157: cannot identify/lock data file`
- `File Not Found`
- Database stuck in `STARTING` state
- Listener running but database not mountable

This typically happens because:
- Windows services start **before** secondary drives are fully mounted
- Oracle attempts to open datafiles too early
- Oracle 19c and 26ai services may race during startup

---

## Environment Summary

- OS: Windows
- Oracle Versions Installed:
  - Oracle 19c (existing)
  - Oracle 26ai FREE (new)
- Oracle 26ai datafiles location:
```

D:\2025\ORACLE26AI\ORADATA\FREE\

````

---

## Key Design Principle

**Never let Oracle mount before the disk is ready.**

Windows service startup order is not disk-aware.  
The fix is to rely on:
- `Automatic (Delayed Start)` services
- Explicit validation via PowerShell
- Manual isolation of Oracle 19c services

---

## Verified Working Service Configuration

After stabilizing the setup, the following service state was confirmed as correct:

```powershell
Get-Service Oracle* | Select-Object Name, StartType, Status | Sort-Object Name
````

### Expected Output (Stable State)

```
OracleOraDB23Home1TNSListener     Automatic   Running
OracleServiceFREE                Automatic   Running

OracleOraDB19Home1TNSListener    Manual      Stopped
OracleServiceORCL                Manual      Stopped
OracleOraDB19Home1MTSRecovery    Manual      Stopped
```

This confirms:

* Oracle 26ai services are active
* Oracle 19c services are isolated
* No port, memory, or file locking conflicts



---

## Verified Startup Commands (PowerShell)

The following commands **successfully bring Oracle 26ai online**:

```powershell
Start-Service OracleOraDB23Home1TNSListener
Start-Service OracleServiceFREE
```

Expect a short delay while the service initializes.
Warnings during startup are normal as long as the service eventually transitions to `Running`.

---

## Database Validation (SQL*Plus)

```powershell
set ORACLE_SID=FREE
sqlplus / as sysdba
```

Expected banner:

```
Connected to:
Oracle AI Database 26ai Free Release 23.26.0.0.0
```

---

## Datafile Integrity Check

```sql
SELECT name FROM v$datafile;
```

Confirmed valid output:

```
D:\2025\ORACLE26AI\ORADATA\FREE\SYSTEM01.DBF
D:\2025\ORACLE26AI\ORADATA\FREE\SYSAUX01.DBF
D:\2025\ORACLE26AI\ORADATA\FREE\UNDOTBS01.DBF
D:\2025\ORACLE26AI\ORADATA\FREE\USERS01.DBF
D:\2025\ORACLE26AI\ORADATA\FREE\FREEPDB1\...
```

This proves:

* `D:` drive is mounted
* All datafiles are reachable
* CDB and PDBs are intact

---

## Why Automatic (Delayed Start) Matters

Oracle services marked as **Automatic (Delayed Start)**:

* Wait until Windows finishes boot-critical tasks
* Allow storage drivers to initialize
* Prevent early mount attempts on `D:`

This single setting eliminates most “random” Oracle startup failures.

---

## Oracle 19c Conflict Management Strategy

Oracle 19c is **not removed**, only **neutralized**:

* Services set to `Manual`
* No listeners running
* No SID conflicts
* Can be started later if needed

This allows:

* Safe coexistence
* Easy rollback
* Clean migration path

---

## Final Outcome

* Oracle 26ai FREE starts reliably
* Datafiles on `D:` mount without errors
* Oracle 19c remains installed but inactive
* No registry hacks
* No brittle boot scripts

This setup has been validated through repeated restarts.

---

## Closing Notes

If Oracle data lives outside `C:\`, **service timing matters more than configuration**.
Treat disk readiness as a first-class dependency, not an assumption.

This approach is simple, reproducible, and production-safe for developer machines.

```
