## NON-SYSDBA USER LOGIN AND BASIC SQLPLUS USAGE (WINDOWS)

IMPORTANT PREREQUISITE
Before proceeding, first verify that the database and listener are healthy and that SYSDBA login works.

Refer to the document:
Create Oracle_19c_Windows_Health_Check_and_SYSDBA_Login.md

Only continue if:

* OracleServiceORCL is running
* Oracle listener is running
* `sqlplus / as sysdba` connects successfully
* Database status is OPEN and READ WRITE

---

## STEP 1: Open Command Prompt

For non-SYSDBA login, Administrator privileges are not mandatory.

Open Command Prompt normally:

* Start → cmd → Enter

---

## STEP 2: Login as a non-SYSDBA user (local database)

If you are logging in on the same machine where Oracle is installed:

sqlplus sdp@ORCL

Enter the password when prompted (password=sdp).

This connects:

* User: SDP
* Role: DEFAULT (non-SYSDBA)
* Database: ORCL

---

## STEP 3: Login using listener / EZCONNECT (explicit)

If you want to connect exactly like SQL Developer does:

sqlplus sdp@//localhost:1521/orcl

Enter the password when prompted (password=sdp).

Use this method if:

* You want to ensure listener connectivity
* You are troubleshooting connection issues

---

## STEP 4: Confirm you are NOT SYSDBA

After login, immediately verify context:

select user from dual;

Expected output:
SDP

Optional role check:

select * from user_role_privs;

You should NOT see SYSDBA or SYSOPER.

---

## STEP 5: List tables owned by the user

Oracle does not support `SHOW TABLES`.

To list your own tables:

select table_name from user_tables;

Example output:
PLAYER

---

## STEP 6: Query data from a table

Basic query:

select * from player;

Initial output may look vertically broken. This is normal SQL*Plus formatting behavior.

---

## STEP 7: Fix SQL*Plus formatting for readable output

Run the following formatting commands once per session:

SET LINESIZE 200
SET PAGESIZE 50

COLUMN first_name FORMAT A15
COLUMN last_name  FORMAT A15
COLUMN sport      FORMAT A10

Now re-run the query:

select * from player;

Expected output format:

PLAYER_ID  FIRST_NAME   LAST_NAME    SPORT

---

1          Sachin       Tendulkar    Cricket
2          Sourav       Ganguly      Cricket

---

## STEP 8: Optional – make formatting permanent

To avoid retyping formatting commands:

1. Create a file named:
   login.sql

2. Add the following content:

SET LINESIZE 200
SET PAGESIZE 50
COLUMN first_name FORMAT A15
COLUMN last_name  FORMAT A15
COLUMN sport      FORMAT A10

3. Place `login.sql` in:

* Your working directory, or
* %ORACLE_HOME%\sqlplus\admin

SQL*Plus will automatically execute it on every login.

---

## STEP 9: Common mistakes to avoid

Do NOT use SYSDBA for normal users:

Wrong:
sqlplus sdp/password as sysdba

Correct:
sqlplus sdp@ORCL

---

## STEP 10: Common error scenarios

ORA-12541: no listener
→ Listener is not running. Start it as Administrator.

ORA-01017: invalid username/password
→ Wrong credentials or expired password.

ORA-28000: account locked
→ Unlock as SYSDBA:
alter user sdp account unlock;

---

## FINAL SUMMARY

1. Verify DB health and SYSDBA login first (referenced document)
2. Login using `sqlplus username@ORCL`
3. Confirm user context
4. Use USER_* views instead of SHOW commands
5. Apply SQL*Plus formatting for readable output

At this point, you are fully set up to work as a non-SYSDBA Oracle user from the command line.
