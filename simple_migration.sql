-- Simple migration to add columns if they don't exist
ALTER TABLE spin_wheel_items ADD COLUMN IF NOT EXISTS item_type VARCHAR(50) DEFAULT 'POINTS';
ALTER TABLE spin_wheel_items ADD COLUMN IF NOT EXISTS item_color VARCHAR(7) DEFAULT '#007bff';
ALTER TABLE spin_wheel_items ADD COLUMN IF NOT EXISTS icon VARCHAR(50) DEFAULT 'bi-star';
