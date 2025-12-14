-- ============================================================
-- File: format_player.sql
--
-- Purpose:
-- SQL*Plus session formatting for readable output.
-- Automatically executed on SQL*Plus login.
--
-- Scope:
-- Optimized for PLAYER-centric queries.
-- ============================================================

-- General session formatting
SET LINESIZE 200
SET PAGESIZE 50
SET TRIMSPOOL ON
SET TAB OFF

-- PLAYER table column formatting
COLUMN player_id     FORMAT 9999          HEADING "ID"
COLUMN first_name    FORMAT A15           HEADING "FIRST_NAME"
COLUMN last_name     FORMAT A15           HEADING "LAST_NAME"
COLUMN sport         FORMAT A10           HEADING "SPORT"
COLUMN country       FORMAT A15           HEADING "COUNTRY"
COLUMN batting_style FORMAT A12           HEADING "BATTING"
COLUMN role          FORMAT A15           HEADING "ROLE"
COLUMN debut_year    FORMAT 9999           HEADING "DEBUT"
COLUMN is_active     FORMAT A3            HEADING "ACT"
COLUMN date_of_birth FORMAT A12           HEADING "DOB"

-- End of login.sql
-- ============================================================
