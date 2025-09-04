-- Fix Activities Table - Add Missing Columns
-- This script adds the new columns that the Activity entity expects

-- First, let's check what columns currently exist
DESCRIBE activities;

-- Add the missing columns that the Activity entity needs
ALTER TABLE activities 
ADD COLUMN IF NOT EXISTS club_date VARCHAR(50) DEFAULT '2025-01-01',
ADD COLUMN IF NOT EXISTS start_time VARCHAR(10) DEFAULT '09:00',
ADD COLUMN IF NOT EXISTS end_time VARCHAR(10) DEFAULT '10:00',
ADD COLUMN IF NOT EXISTS activity_place VARCHAR(200) DEFAULT 'TBD';

-- Make the new columns NOT NULL after adding them
ALTER TABLE activities 
MODIFY COLUMN club_date VARCHAR(50) NOT NULL,
MODIFY COLUMN start_time VARCHAR(10) NOT NULL,
MODIFY COLUMN end_time VARCHAR(10) NOT NULL,
MODIFY COLUMN activity_place VARCHAR(200) NOT NULL;

-- Add column comments for documentation
ALTER TABLE activities 
MODIFY COLUMN club_date VARCHAR(50) NOT NULL COMMENT 'Date when the club activity will take place',
MODIFY COLUMN start_time VARCHAR(10) NOT NULL COMMENT 'Time when the activity will start',
MODIFY COLUMN end_time VARCHAR(10) NOT NULL COMMENT 'Time when the activity will end',
MODIFY COLUMN activity_place VARCHAR(200) NOT NULL COMMENT 'Location where the activity will be held';

-- Verify the changes
DESCRIBE activities;

-- Show sample data to confirm everything works
SELECT id, title, club_date, start_time, end_time, activity_place FROM activities LIMIT 5;
