-- Check if club_memberships table exists and create it if not
USE student_platform;

-- Check if table exists
SELECT COUNT(*) as table_exists 
FROM information_schema.tables 
WHERE table_schema = 'student_platform' 
AND table_name = 'club_memberships';

-- Create table if it doesn't exist
CREATE TABLE IF NOT EXISTS club_memberships (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    student_id BIGINT NOT NULL,
    club_id BIGINT NOT NULL,
    joined_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    approved_at DATETIME,
    approved_by_id BIGINT,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (club_id) REFERENCES clubs(id),
    FOREIGN KEY (approved_by_id) REFERENCES admins(id),
    UNIQUE KEY unique_student_club (student_id, club_id)
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_club_memberships_student ON club_memberships(student_id);
CREATE INDEX IF NOT EXISTS idx_club_memberships_club ON club_memberships(club_id);
CREATE INDEX IF NOT EXISTS idx_club_memberships_status ON club_memberships(status);
CREATE INDEX IF NOT EXISTS idx_club_memberships_joined_at ON club_memberships(joined_at);

-- Verify table was created
DESCRIBE club_memberships;
