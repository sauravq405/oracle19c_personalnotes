ORACLE 19c INSTALLATION AND BASIC USAGE GUIDE (WINDOWS)

---

PURPOSE
This guide explains how to install Oracle Database 19c on Windows, verify the installation using SQL*Plus, and use SQL Developer to create tables and run basic SQL queries.

---

## PREREQUISITES

1. Windows 64-bit operating system
2. Stable internet connection (downloads ~3.5 GB total)
3. Administrator access on the system
4. Oracle account (free)

---

## REQUIRED SOFTWARE

You need TWO components:

1. Oracle Database 19c (Database Engine)
2. SQL Developer (Graphical User Interface)

---

## STEP 1: DOWNLOAD ORACLE DATABASE 19c

1. Open your browser
2. Search: Oracle 19c download
3. Open the official Oracle website
4. Select:

    * Oracle Database 19c for Windows x64
5. Accept the license agreement
6. Sign in using your Oracle account

    * If you don’t have one, create a new account
7. Download the ZIP file (~2.9 GB)

---

## STEP 2: EXTRACT ORACLE DATABASE FILES

1. Right-click the downloaded Oracle ZIP file
2. Click "Extract All"
3. Wait for extraction to complete
4. After extraction, the folder size will be ~6 GB

---

## STEP 3: DOWNLOAD SQL DEVELOPER

1. Open a new browser tab
2. Search: SQL Developer download
3. Open the official Oracle SQL Developer page
4. Select:

    * Windows 64-bit with JDK included
5. Accept the license agreement
6. Log in using the same Oracle account
7. Download the ZIP file (~430 MB)

---

## STEP 4: EXTRACT SQL DEVELOPER

1. Right-click the SQL Developer ZIP file
2. Click "Extract All"
3. Wait for extraction to finish

---

## STEP 5: INSTALL ORACLE DATABASE 19c

1. Open the extracted Oracle 19c folder
2. Scroll down and double-click setup.exe
3. Click "Yes" when prompted for admin access

INSTALLATION WIZARD SETTINGS:

4. Select:

    * Create and configure a single instance database
5. Click Next
6. Choose:

    * Desktop Class
7. Click Next

WINDOWS USER CONFIGURATION:

8. Select:

    * Create a new Windows user
9. Enter:

    * Username: oracle
    * Password: (your choice)
10. Click Next

ORACLE DIRECTORY SETTINGS:

11. Change Oracle Base directory to something readable
    Example:
    C:\Oracle19c
12. Leave other paths as default
13. Global Database Name / SID:

    * orcl
14. Set database password
15. Confirm password
16. Ignore weak password warning if prompted
17. Click Next

INSTALLATION:

18. Review summary
19. Click Install
20. When Windows Firewall prompts:

    * Click Allow Access
21. Wait for installation to complete
22. Click Close

---

## STEP 6: VERIFY INSTALLATION USING SQL*PLUS

1. Click Windows Search
2. Type: SQL Plus
3. Open SQL Plus

LOGIN:

4. Username:
   sys as sysdba
5. Press Enter
6. Enter the password you set during installation

VERIFY CONNECTION:

7. You should see Oracle Database 19c connected

8. Run test query:

   select * from tab;

9. If tables are listed, Oracle is installed correctly

---

## STEP 7: LAUNCH SQL DEVELOPER

1. Open the extracted SQL Developer folder
2. Double-click sqldeveloper.exe
3. If asked about importing preferences:

    * Select No
4. SQL Developer will open

OPTIONAL:

* Move SQL Developer folder to C:\ for convenience
* Pin SQL Developer to taskbar

---

## STEP 8: CREATE DATABASE CONNECTION IN SQL DEVELOPER

1. Click New Connection
2. Enter:

    * Connection Name: testdb
    * Username: sys
    * Password: (database password)
    * Role: SYSDBA
    * SID: orcl
3. Click Test
4. If status shows Success, click Connect

---

## STEP 9: CREATE A TABLE

Run the following SQL:

create table player (
player_id int,
first_name varchar(255),
last_name varchar(255),
sport varchar(255)
);

Click Run

---

## STEP 10: INSERT DATA INTO TABLE

insert into player values (1, 'Sachin', 'Tendulkar', 'Cricket');
insert into player values (2, 'Sourav', 'Ganguly', 'Cricket');

---

## STEP 11: FETCH DATA FROM TABLE

select * from player;

---

## WHAT YOU HAVE LEARNED

* How to install Oracle Database 19c on Windows
* How to verify Oracle using SQL*Plus
* How to use SQL Developer GUI
* How to create tables
* How to insert and retrieve data