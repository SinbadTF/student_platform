-- Simple Fix for Activities Table
-- Add the missing columns that the Activity entity needs

-- Add new columns
ALTER TABLE activities ADD COLUMN club_date VARCHAR(50) NOT NULL DEFAULT '2025-01-01';
ALTER TABLE activities ADD COLUMN start_time VARCHAR(10) NOT NULL DEFAULT '09:00';
ALTER TABLE activities ADD COLUMN end_time VARCHAR(10) NOT NULL DEFAULT '10:00';
ALTER TABLE activities ADD COLUMN activity_place VARCHAR(200) NOT NULL DEFAULT 'TBD';

-- Verify the changes
DESCRIBE activities;
