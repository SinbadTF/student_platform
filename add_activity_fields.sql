-- Migration script to add new fields to activities table
-- Run this script to add the missing columns for Date, Time, and Place

-- Add new columns to activities table
ALTER TABLE activities 
ADD COLUMN activity_date VARCHAR(50) NOT NULL DEFAULT '2025-01-01' COMMENT 'Activity date in YYYY-MM-DD format',
ADD COLUMN activity_time VARCHAR(10) NOT NULL DEFAULT '12:00' COMMENT 'Activity time in HH:MM format',
ADD COLUMN activity_place VARCHAR(200) NOT NULL DEFAULT 'TBD' COMMENT 'Location where activity will be held';

-- Update existing records with default values (optional - remove if you want to handle existing data differently)
-- UPDATE activities SET activity_date = '2025-01-01', activity_time = '12:00', activity_place = 'TBD' WHERE activity_date IS NULL;

-- Add comments to describe the new columns
COMMENT ON COLUMN activities.activity_date IS 'Date when the activity will take place';
COMMENT ON COLUMN activities.activity_time IS 'Time when the activity will start';
COMMENT ON COLUMN activities.activity_place IS 'Physical location where the activity will be held';

-- Verify the changes
DESCRIBE activities;
