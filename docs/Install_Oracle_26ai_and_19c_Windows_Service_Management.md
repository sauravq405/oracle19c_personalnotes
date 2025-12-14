ORACLE AI DATABASE 26ai FREE
WINDOWS INSTALLATION & BASIC USAGE GUIDE (PLAIN TEXT)

---

PREREQUISITES

1. Windows 64-bit (x64) system
2. Administrator access on the machine
3. Stable internet connection
4. Ensure no port conflict on port 1522 (default for 26ai Free)

---

STEP 1: DOWNLOAD ORACLE AI DATABASE 26ai FREE

1. Open a browser
2. Go to:
   [https://www.oracle.com/in/database/free/get-started/#windows](https://www.oracle.com/in/database/free/get-started/#windows)
3. Download **Oracle AI Database 26ai Free for Windows x64**
4. Save the installer on your local drive

---

STEP 2: START THE INSTALLATION

1. Run the installer as **Administrator**

2. When prompted for installation location, use:

   Destination Folder:
   D:\2025\Oracle26ai\

   Oracle Home:
   D:\2025\Oracle26ai\dbhomeFree\

   Oracle Base:
   D:\2025\Oracle26ai\

3. Proceed with default configuration unless explicitly changed in the installer

---

STEP 3: DATABASE CONFIGURATION DETAILS

During installation, Oracle automatically configures a **Multitenant Database**.

Key defaults:

* Container Database (CDB):
  localhost:1522

* Pluggable Database (PDB):
  FREEPDB1

* Easy Connect String:
  localhost:1522/FREEPDB1

Default administrative users created:

* SYS
* SYSTEM
* PDBADMIN

Password (as per transcript / demo environment):

* root

(Note: This is acceptable for learning and local development only.)

---

STEP 4: VERIFY SQL*PLUS AVAILABILITY

1. Open Command Prompt

2. Run:
   where sqlplus

3. Ensure SQL*Plus resolves from the 26ai Oracle Home path

---

STEP 5: CONNECT TO ORACLE 26ai USING SQL*PLUS

Method 1: Connect as SYSDBA (local admin)

1. Open Command Prompt

2. Run:
   sqlplus

3. At prompt, enter:
   / as sysdba

4. Successful connection output should show:
   Oracle AI Database 26ai Free
   Release 23.26.0.0.0

Method 2: Explicit Easy Connect (recommended)

sqlplus username/password@localhost:1522/FREEPDB1

Example:
sqlplus system/root@localhost:1522/FREEPDB1

---

STEP 6: BEST PRACTICE – ALWAYS USE EXPLICIT CONNECTION STRINGS

When multiple Oracle versions exist on the same machine, always specify:

* Host
* Port
* Service name / PDB

Example for 26ai:
sqlplus user/password@localhost:1522/FREEPDB1

This avoids accidentally connecting to older databases like 19c.

---

STEP 7: VERIFY DATABASE VERSION

Once connected, run:

SELECT * FROM v$version;

Confirm output mentions:
Oracle AI Database 26ai Free

---

STEP 8: WINDOWS SERVICES OVERVIEW (IMPORTANT)

Oracle databases on Windows run as **Windows Services**.

Key 26ai services:

* OracleServiceFREE
  (Main database service – must be running)

* Oracle TNS Listener for 26ai
  (Allows client connections on port 1522)

Ensure these services are set to **Startup Type: Automatic**.

---

STEP 9: OPTIONAL – COEXISTENCE WITH ORACLE 19c

If Oracle 19c is also installed:

* Keep 26ai services set to Automatic
* Set 19c services to Disabled or Manual
* Always connect using explicit ports:

  * 19c → 1521/orcl
  * 26ai → 1522/FREEPDB1

---

STEP 10: NEXT STEPS AFTER INSTALLATION

1. Use SQL*Plus to:

   * Create tables
   * Insert data
   * Run queries
2. Install SQL Developer (optional GUI)
3. Practice multitenant concepts using FREEPDB1
4. Keep Oracle 26ai as the primary development database

---

ORACLE 19c SERVICES TO STOP (TO TURN IT OFF)

Stopping these will shut down Oracle 19c and prevent client connections.

1. **OracleServiceORCL**

   * Main 19c database instance
   * Stopping this shuts down the database itself

2. **OracleOraDB19Home1TNSListener**

   * Listener for 19c connections
   * Stopping this blocks all network access to 19c

3. **OracleOraDB19Home1MTSRecoveryService**

   * Distributed transaction / MTS support
   * Not required for normal use, but mentioned as running in your setup

4. **OracleVssWriterORCL**

   * VSS backup integration
   * Mentioned as Automatic in your list

---

ORACLE 19c
SERVICES REQUIRED TO TURN IT BACK ON (MINIMUM SET)

You only need **these two** to bring Oracle 19c back online and usable.

1. **OracleServiceORCL**

   * Mandatory
   * Starts the database instance

2. **OracleOraDB19Home1TNSListener**

   * Required for SQL*Plus, SQL Developer, and any remote/client connection

---

SERVICES NOT REQUIRED TO RE-ENABLE (OPTIONAL)

These can stay Disabled unless you explicitly need their features.

* **OracleJobSchedulerORCL**
* **OracleVssWriterORCL**
* **OracleOraDB19Home1MTSRecoveryService**

---

ONE-LINE SUMMARY

* **To turn OFF 19c:** Stop `OracleServiceORCL` and `OracleOraDB19Home1TNSListener`
* **To turn ON 19c:** Start `OracleServiceORCL` and `OracleOraDB19Home1TNSListener`

If you want, I can also give you:

* exact `net stop` / `net start` commands in the correct order, or
* a quick sanity checklist to confirm which database you’re connected to before running queries

* Create a **19c vs 26ai comparison cheat sheet**
* Or trim this into a **one-page quick install checklist**
