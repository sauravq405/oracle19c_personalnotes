## STEP 1: Open the correct shell (important)

Oracle services and the listener are Windows services. Some actions require admin rights.

1. Close any existing Command Prompt or PowerShell.
2. Open Command Prompt as Administrator.

   * Click Start
   * Type: cmd
   * Right click Command Prompt
   * Click “Run as administrator”

You should land in:
C:\Windows\System32>

---

## STEP 2: Verify Oracle services exist

From Command Prompt (admin):

sc query | findstr /I oracle

You should see Oracle-related services such as:

* OracleServiceORCL
* OracleOraDB19Home1TNSListener
* OracleOraDB19Home1MTSRecoveryService

If these exist, Oracle is installed correctly.

---

## STEP 3: Check database service status

Start the database service if it is not running:

net start OracleServiceORCL

Expected result:
“The OracleServiceORCL service was started successfully.”

This service controls the database instance itself.

---

## STEP 4: Start and verify the listener

Still in elevated Command Prompt:

lsnrctl start

If you see “Unable to OpenSCManager: err=5”, it means the shell is not elevated. Fix that first.

Successful output will show:

* Listener started
* Listening on TCP port 1521
* STATUS of the LISTENER

Now verify:

lsnrctl status

You should see:

* Alias: LISTENER
* Status: READY
* Service “orcl” with instance status READY

---

## STEP 5: Optional one command service health check (PowerShell)

This is a quick sanity check you can reuse anytime.

Open PowerShell (can be normal or admin):

Get-Service OracleServiceORCL,OracleOraDB19Home1TNSListener

Both must show:
Status: Running

If both are running, Oracle is healthy.

---

## STEP 6: Login to SQL*Plus as SYSDBA

From Command Prompt (admin recommended):

sqlplus / as sysdba

Expected result:

* Connected to Oracle Database 19c
* SQL> prompt appears

---

## STEP 7: Verify database state (inside SQL*Plus)

Check instance status:

select status from v$instance;

Expected:
OPEN

Check database open mode:

select name, open_mode from v$database;

Expected:
ORCL  READ WRITE

---

## FINAL SUMMARY (mental checklist)

1. Use elevated Command Prompt on Windows
2. OracleServiceORCL must be running
3. Listener must be running (lsnrctl status)
4. sqlplus / as sysdba should connect
5. v$instance = OPEN
6. v$database = READ WRITE

If all six are true, Oracle is fully up and operational.
