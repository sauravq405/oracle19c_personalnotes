# oracle19c_personalnotes

Personal, hands-on notes for working with **Oracle Database 19c on Windows**.
This repository is a practical runbook, built from real setup, troubleshooting, and daily usage scenarios rather than theory.

## What this repository contains

* Windows-specific Oracle 19c service checks and startup validation
* SYSDBA login and database health verification
* Non-SYSDBA user login via SQL*Plus (command prompt)
* Manual Oracle SQL Developer connection setup
* Common pitfalls, errors, and their fixes
* Clean, reproducible steps that actually work

## Documents overview

* **Oracle_19c_Windows_Health_Check_and_SYSDBA_Login.md**
  Verifying Oracle services, listener status, and logging in as SYSDBA on Windows.

* **Create_Oracle_19c_Windows_Non_SYSDBA_User_Login_and_SQLPlus_Usage.md**
  Logging in as a normal user from command prompt and working with SQL*Plus.

* **Create_Oracle_19c_SQL_Developer_Manual_Connection_Guide.md**
  Step-by-step guide to creating SYSDBA and non-SYSDBA connections in SQL Developer.

## Intended audience

* Developers learning Oracle 19c
* Anyone setting up Oracle on Windows
* People who want clear steps instead of generic documentation
* Those tired of “it should work” guides

## Scope

These notes focus on:

* Local Oracle 19c setup
* Windows environment
* Practical administration and usage

This is **not** meant to replace official Oracle documentation.
It exists to make Oracle usable without unnecessary friction.

---

If you want, next we can:

* Refine the README to be more “public-facing”
* Add a logical learning order section
* Add a troubleshooting index
* Normalize file naming even further
