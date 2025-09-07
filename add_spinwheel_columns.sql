-- Add new columns to spin_wheel_items table for enhanced UI features
-- Run this script to update existing database

-- Check if columns exist before adding them
SET @sql = (SELECT IF(
    (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS 
     WHERE TABLE_SCHEMA = DATABASE() 
     AND TABLE_NAME = 'spin_wheel_items' 
     AND COLUMN_NAME = 'item_type') = 0,
    'ALTER TABLE spin_wheel_items ADD COLUMN item_type VARCHAR(50) DEFAULT ''POINTS''',
    'SELECT ''Column item_type already exists'' as message'
));
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @sql = (SELECT IF(
    (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS 
     WHERE TABLE_SCHEMA = DATABASE() 
     AND TABLE_NAME = 'spin_wheel_items' 
     AND COLUMN_NAME = 'item_color') = 0,
    'ALTER TABLE spin_wheel_items ADD COLUMN item_color VARCHAR(7) DEFAULT ''#007bff''',
    'SELECT ''Column item_color already exists'' as message'
));
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @sql = (SELECT IF(
    (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS 
     WHERE TABLE_SCHEMA = DATABASE() 
     AND TABLE_NAME = 'spin_wheel_items' 
     AND COLUMN_NAME = 'icon') = 0,
    'ALTER TABLE spin_wheel_items ADD COLUMN icon VARCHAR(50) DEFAULT ''bi-star''',
    'SELECT ''Column icon already exists'' as message'
));
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Update existing records to have default values (only if columns exist)
UPDATE spin_wheel_items SET item_type = 'POINTS' WHERE item_type IS NULL;
UPDATE spin_wheel_items SET item_color = '#007bff' WHERE item_color IS NULL;
UPDATE spin_wheel_items SET icon = 'bi-star' WHERE icon IS NULL;
