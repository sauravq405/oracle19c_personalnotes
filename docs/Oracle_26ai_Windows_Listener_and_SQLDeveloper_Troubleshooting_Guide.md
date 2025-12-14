
# Oracle 26ai on Windows – Listener & SQL Developer Troubleshooting Guide

---

## Context

This document captures a real-world troubleshooting journey while setting up **Oracle Database 26ai Free on Windows 10**, where:

- The database instance was running
- Local SYSDBA connections worked
- The listener service refused to start or showed “no services”
- SQL Developer connection tests failed
- Errors appeared inconsistent or misleading

Rather than reinstalling Oracle, the issue was resolved through **systematic investigation** across:
- Windows services
- Oracle networking
- Listener registration
- Service names
- SYS vs SYSTEM semantics
- SQL Developer connection behavior

This document preserves that investigative flow so the same mistakes are not repeated.

---

## Initial Symptoms

### 1. Database appeared healthy

```text
sqlplus / as sysdba
Connected to:
Oracle AI Database 26ai Free
````

### 2. Listener service problems

* Listener service would:

    * Start and immediately stop
    * Or start but show **“supports no services”**

### 3. Network connections failed

```text
sqlplus system@FREE
ORA-12170 / ORA-12514
```

### 4. SQL Developer connection tests failed

* Using SID
* Using port 1521
* Using SYS without SYSDBA role
* Using `sysdba` as a username

---

## Key Investigation Insight #1

### SQL*Plus `/ as sysdba` does NOT use the listener

This was the first major clarification.

```text
sqlplus / as sysdba
```

* Uses **local BEQ (bequeath) connection**
* Bypasses listener entirely
* Works even if the listener is completely down

Therefore:

> SQL*Plus local success does NOT mean listener health.

---

## Key Investigation Insight #2

### Listener was running, but not registering services

Listener output:

```text
The listener supports no services
```

This meant:

* Listener process was alive
* Database had not registered itself
* Dynamic registration was broken

---

## Listener Configuration Review

### listener.ora (final, working)

```ini
LISTENER =
  (DESCRIPTION_LIST =
    (DESCRIPTION =
      (ADDRESS = (PROTOCOL = TCP)(HOST = 127.0.0.1)(PORT = 1522))
    )
  )
```

Key decisions:

* Bound explicitly to `127.0.0.1`
* Avoided Windows DNS (`.mshome.net`)
* Avoided IPC and legacy parameters
* Used a non-conflicting port (1522 instead of 1521)

---

## Key Investigation Insight #3

### `local_listener` was misconfigured

Database parameter check:

```sql
show parameter local_listener;
```

Output:

```text
local_listener = LISTENER_FREE
```

Problem:

* Oracle does NOT validate this value
* If it does not resolve to a real address, PMON silently fails
* Result: listener runs but shows no services

---

## Fix: Correct `local_listener`

### Option chosen (explicit and safest)

```sql
alter system set local_listener =
'(ADDRESS=(PROTOCOL=TCP)(HOST=127.0.0.1)(PORT=1522))'
scope=both;

alter system register;
```

This immediately allowed PMON to announce the database to the listener.

---

## Verification Step (Critical)

```bat
lsnrctl status
```

Correct output:

```text
Service "FREE" has 1 instance(s).
Service "freepdb1" has 1 instance(s).
Service "FREEXDB" has 1 instance(s).
```

At this point:

* Listener ✔
* Registration ✔
* Networking ✔

---

## tnsnames.ora (Final, Working)

```ini
FREE =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 127.0.0.1)(PORT = 1522))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = FREE)
    )
  )

LISTENER_FREE =
  (ADDRESS = (PROTOCOL = TCP)(HOST = 127.0.0.1)(PORT = 1522))
```

---

## SQL*Plus Behavior Explained

### Works

```bat
sqlplus system@FREE
```

Reason:

* Normal user
* Uses listener
* Correct service

### Fails (by design)

```bat
sqlplus sys@FREE
```

Error:

```text
ORA-28009: connection as SYS should be as SYSDBA
```

Expected behavior.

### Also fails

```bat
sqlplus sysdba@FREE
```

Reason:

* `sysdba` is NOT a username
* SYSDBA is a role

---

## Correct Network SYSDBA Syntax

```text
Username: sys
Role: SYSDBA
Service: FREE
```

This rule applies to **SQL Developer as well**.

---

## SQL Developer – Correct Connection Configuration

### Normal Usage (Recommended)

* Username: `system`
* Role: `Default`
* Host: `127.0.0.1`
* Port: `1522`
* Service Name: `FREE`
* Connection Type: `Basic`

### SYSDBA (Admin Only)

* Username: `sys`
* Role: `SYSDBA`
* Host: `127.0.0.1`
* Port: `1522`
* Service Name: `FREE`
* Connection Type: `Basic`

Important:

* Do NOT use SID
* Do NOT use `xe`
* Do NOT expect `/ as sysdba` behavior in SQL Developer

---

## Root Cause Summary

The issue was **not one single problem**, but a chain:

1. Listener initially bound to an unstable Windows hostname
2. `local_listener` pointed to a non-resolvable alias
3. PMON could not register services
4. Listener stayed alive but empty
5. SQL Developer failed due to missing service registration
6. SYS login attempts failed due to role misuse

Each symptom masked the real cause.

---

## Final Outcome

After:

* Normalizing listener binding
* Fixing `local_listener`
* Forcing registration
* Using correct service names
* Understanding SYS vs SYSTEM roles

The system achieved:

* Stable listener startup
* Correct service registration
* Successful SQL*Plus network logins
* Successful SQL Developer connections

No reinstall was required.

---

## Key Takeaways (Save These)

* Database ≠ Listener
* `/ as sysdba` ≠ network connectivity
* SYS is not a normal user
* SYSDBA is a role, not a username
* `local_listener` can silently break everything
* Windows DNS can sabotage Oracle networking
* Always verify with `lsnrctl status`

---

## Closing Note

This troubleshooting session reinforces a core Oracle truth:

> Oracle almost never fails randomly.
> It fails quietly when one assumption is wrong.

Documenting the journey matters more than memorizing commands.
