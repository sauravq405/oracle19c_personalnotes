-- ============================================================
-- File: format_sport.sql
-- Purpose: SQL*Plus formatting for SPORT table
-- ============================================================

SET LINESIZE 200
SET PAGESIZE 50
SET TRIMSPOOL ON
SET TAB OFF

COLUMN sport_id   FORMAT 9999    HEADING "ID"
COLUMN sport_name FORMAT A15     HEADING "SPORT_NAME"

-- Example usage:
-- SELECT * FROM sport;

-- ============================================================
