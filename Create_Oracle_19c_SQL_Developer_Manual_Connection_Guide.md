## CREATING ORACLE SQL DEVELOPER CONNECTIONS (SYSDBA AND NON-SYSDBA)

PREREQUISITE
Before creating connections in SQL Developer, ensure:

* Oracle database is running
* Listener is running on port 1521
* SYSDBA login works from command prompt

For verification, refer to:
Create_Oracle_19c_Windows_Health_Check_and_SYSDBA_Login.md

---

## SECTION 1: Open New Database Connection Dialog

1. Launch Oracle SQL Developer
2. In the left panel, under “Connections”
3. Click the green “+” icon (New Connection)

This opens the “New / Select Database Connection” window.

---

## SECTION 2: Create SYSDBA Connection (sysdba_login)

Connection Name:
sysdba_login

Database Type:
Oracle

Authentication Type:
Default

Username:
sys

Password: <enter SYS password>
(Optional: check “Save Password”)

Role:
SYSDBA

---

## Connection Details

Connection Type:
Basic

Hostname:
localhost

Port:
1521

Select:
SID

SID value:
orcl

(Service name is left unselected)

---

## Test and Save

1. Click “Test”
2. Status should show:
   Status: Success
3. Click “Save”
4. Click “Connect”

This connection is used for:

* Administration
* Startup / shutdown
* User management
* Privilege management

---

## SECTION 3: Create Non-SYSDBA Connection (sdp_login_non_admin)

Connection Name:
sdp_login_non_admin

Database Type:
Oracle

Authentication Type:
Default

Username:
sdp

Password: <enter SDP password>
(Optional: check “Save Password”)

Role:
default

IMPORTANT
Do NOT select SYSDBA or SYSOPER here.

---

## Connection Details

Connection Type:
Basic

Hostname:
localhost

Port:
1521

Select:
SID

SID value:
orcl

(Service name remains unselected)

---

## Test and Save

1. Click “Test”
2. Status should show:
   Status: Success
3. Click “Save”
4. Click “Connect”

This connection is used for:

* Application queries
* Table access
* Normal schema work
* Non-administrative operations

---

## SECTION 4: Verifying the Connected User

After connecting, open a SQL Worksheet and run:

select user from dual;

Expected results:

For SYSDBA connection:
SYS

For non-SYSDBA connection:
SDP

---

## SECTION 5: Key Differences Between the Two Connections

SYSDBA connection:

* Username: sys
* Role: SYSDBA
* Full database control
* Bypasses normal authentication

Non-SYSDBA connection:

* Username: sdp
* Role: default
* Restricted to granted privileges
* Used for day-to-day work

---

## SECTION 6: Common Mistakes to Avoid

* Do not use SYSDBA role for application users
* Do not mix passwords between users
* Do not select “Service name” unless you are explicitly using one
* Do not assume SQL Developer success means DB is healthy; always verify services

---

## FINAL NOTE

These two connections together form a complete setup:

* SYSDBA connection for control and maintenance
* Non-SYSDBA connection for safe, routine usage

This mirrors best practices used in production environments and matches exactly what is shown in the screenshots.
