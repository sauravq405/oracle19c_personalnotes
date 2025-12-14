-- ============================================================
-- File: format_team.sql
-- Purpose: SQL*Plus formatting for TEAM table
-- ============================================================


SET LINESIZE 200
SET PAGESIZE 50
SET TRIMSPOOL ON
SET TAB OFF

COLUMN team_id   FORMAT 9999    HEADING "ID"
COLUMN team_name FORMAT A20     HEADING "TEAM_NAME"
COLUMN country   FORMAT A15     HEADING "COUNTRY"

-- Example usage:
-- SELECT * FROM team;

-- ============================================================
