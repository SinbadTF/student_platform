-- Add club_memberships table to the database
-- Run this script to add the new table for tracking club memberships

-- Create club_memberships table
CREATE TABLE club_memberships (
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
CREATE INDEX idx_club_memberships_student ON club_memberships(student_id);
CREATE INDEX idx_club_memberships_club ON club_memberships(club_id);
CREATE INDEX idx_club_memberships_status ON club_memberships(status);
CREATE INDEX idx_club_memberships_joined_at ON club_memberships(joined_at);

-- Insert some sample memberships (optional)
-- INSERT INTO club_memberships (student_id, club_id, status) VALUES
-- (1, 1, 'ACTIVE'),  -- Alice Johnson joins Computer Science Club
-- (2, 2, 'ACTIVE'),  -- Bob Wilson joins Debate Society
-- (3, 3, 'ACTIVE');  -- Carol Brown joins Art Club
