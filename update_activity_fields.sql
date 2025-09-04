-- Migration script to update activities table with new fields
-- Run this script to add/update the columns for Club Date, Start Time, and End Time

-- First, drop the old columns if they exist
ALTER TABLE activities DROP COLUMN IF EXISTS activity_date;
ALTER TABLE activities DROP COLUMN IF EXISTS activity_time;

-- Add new columns to activities table
ALTER TABLE activities 
ADD COLUMN club_date VARCHAR(50) NOT NULL DEFAULT '2025-01-01' COMMENT 'Club activity date in YYYY-MM-DD format',
ADD COLUMN start_time VARCHAR(10) NOT NULL DEFAULT '09:00' COMMENT 'Activity start time in HH:MM format',
ADD COLUMN end_time VARCHAR(10) NOT NULL DEFAULT '10:00' COMMENT 'Activity end time in HH:MM format';

-- Add comments to describe the new columns
COMMENT ON COLUMN activities.club_date IS 'Date when the club activity will take place';
COMMENT ON COLUMN activities.start_time IS 'Time when the activity will start';
COMMENT ON COLUMN activities.end_time IS 'Time when the activity will end';

-- Verify the changes
DESCRIBE activities;
