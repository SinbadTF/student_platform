-- Complete Student Platform Database Schema
-- Matches all JPA entities exactly

-- Drop existing tables if they exist (for clean setup)
DROP TABLE IF EXISTS reward_exchanges;
DROP TABLE IF EXISTS event_participations;
DROP TABLE IF EXISTS rewards;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS clubs;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS admins;

-- Create admins table
CREATE TABLE admins (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    admin_id VARCHAR(50) NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- Create students table
CREATE TABLE students (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(50) UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    department VARCHAR(100),
    year INT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    points INT DEFAULT 0,
    status VARCHAR(20) DEFAULT 'PENDING'
);

-- Create staff table
CREATE TABLE staff (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    staff_id VARCHAR(50) NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    department VARCHAR(100) NOT NULL,
    position VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING'
);

-- Create clubs table (UPDATED with meetingScheduleTitle)
CREATE TABLE clubs (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(500),
    meeting_schedule_title VARCHAR(200),
    created_by_id BIGINT,
    FOREIGN KEY (created_by_id) REFERENCES admins(id)
);

-- Create events table
CREATE TABLE events (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(500) NOT NULL,
    location VARCHAR(255) NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    point_value INT NOT NULL,
    created_by_id BIGINT,
    FOREIGN KEY (created_by_id) REFERENCES admins(id)
);

-- Create activities table
CREATE TABLE activities (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description VARCHAR(500),
    points INT NOT NULL,
    club_id BIGINT,
    created_by_id BIGINT,
    FOREIGN KEY (club_id) REFERENCES clubs(id),
    FOREIGN KEY (created_by_id) REFERENCES admins(id)
);

-- Create rewards table (FIXED with active column)
CREATE TABLE rewards (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(500),
    point_value INT NOT NULL,
    issued_by_id BIGINT,
    active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (issued_by_id) REFERENCES staff(id)
);

-- Create event_participations table
CREATE TABLE event_participations (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    event_id BIGINT NOT NULL,
    student_id BIGINT NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING',
    points_awarded BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (event_id) REFERENCES events(id),
    FOREIGN KEY (student_id) REFERENCES students(id)
);

-- Create reward_exchanges table
CREATE TABLE reward_exchanges (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    student_id BIGINT NOT NULL,
    reward_id BIGINT NOT NULL,
    exchange_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    points_spent INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (reward_id) REFERENCES rewards(id)
);

-- Insert sample admin data
INSERT INTO admins (admin_id, first_name, last_name, email, username, password) VALUES
('ADMIN001', 'Admin', 'User', 'admin@university.edu', 'admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');

-- Insert sample staff data
INSERT INTO staff (staff_id, first_name, last_name, email, department, position, username, password, status) VALUES
('STAFF001', 'John', 'Smith', 'john.smith@university.edu', 'Computer Science', 'Lecturer', 'staff1', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 'APPROVED'),
('STAFF002', 'Jane', 'Doe', 'jane.doe@university.edu', 'Mathematics', 'Professor', 'staff2', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 'APPROVED');

-- Insert sample student data
INSERT INTO students (student_id, first_name, last_name, email, department, year, username, password, points, status) VALUES
('TNT-1001', 'Alice', 'Johnson', 'alice.johnson@student.edu', 'Computer Science', 2, 'student1', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 150, 'APPROVED'),
('TNT-1002', 'Bob', 'Wilson', 'bob.wilson@student.edu', 'Engineering', 3, 'student2', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 75, 'APPROVED'),
('TNT-1003', 'Carol', 'Brown', 'carol.brown@student.edu', 'Business', 1, 'student3', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 200, 'APPROVED');

-- Insert sample clubs data (UPDATED with meetingScheduleTitle)
INSERT INTO clubs (name, description, meeting_schedule_title, created_by_id) VALUES
('Computer Science Club', 'For students interested in programming and technology', 'Every Monday 2:00 PM in Room 101', 1),
('Debate Society', 'Develop public speaking and critical thinking skills', 'Weekly Friday 3:30 PM in Auditorium', 1),
('Art Club', 'Creative expression through various art forms', 'Every Wednesday 4:00 PM in Art Studio', 1),
('Sports Club', 'Various athletic activities and competitions', 'Every Tuesday and Thursday 5:00 PM in Gym', 1),
('Photography Club', 'Learn photography techniques and share your work', 'Every Saturday 10:00 AM in Photography Lab', 1),
('Music Band', 'Join our university band and perform at events', 'Every Monday and Thursday 6:00 PM in Music Hall', 1);

-- Insert sample events data
INSERT INTO events (name, description, location, start_time, end_time, point_value, created_by_id) VALUES
('Programming Workshop', 'Learn advanced programming concepts', 'Computer Lab A', '2024-01-15 14:00:00', '2024-01-15 16:00:00', 50, 1),
('Debate Competition', 'Annual inter-university debate competition', 'Main Auditorium', '2024-01-20 10:00:00', '2024-01-20 17:00:00', 100, 1),
('Art Exhibition', 'Student art showcase', 'Art Gallery', '2024-01-25 18:00:00', '2024-01-25 21:00:00', 75, 1);

-- Insert sample rewards data (FIXED with active column)
INSERT INTO rewards (name, description, point_value, issued_by_id, active) VALUES
('Gift Card', 'Amazon gift card worth $25', 200, 1, TRUE),
('Certificate', 'Certificate of achievement', 150, 1, TRUE),
('Merchandise', 'University branded merchandise', 100, 2, TRUE),
('Extra Credit', 'Extra credit in any course', 300, 2, TRUE);

-- Insert sample event participations
INSERT INTO event_participations (event_id, student_id, status, points_awarded) VALUES
(1, 1, 'APPROVED', TRUE),
(1, 2, 'PENDING', FALSE),
(2, 1, 'APPROVED', TRUE),
(3, 3, 'APPROVED', TRUE);

-- Insert sample reward exchanges
INSERT INTO reward_exchanges (student_id, reward_id, points_spent) VALUES
(1, 1, 200),
(3, 2, 150),
(2, 3, 100);

-- Create indexes for better performance
CREATE INDEX idx_clubs_created_by ON clubs(created_by_id);
CREATE INDEX idx_clubs_name ON clubs(name);
CREATE INDEX idx_clubs_meeting_schedule ON clubs(meeting_schedule_title);
CREATE INDEX idx_students_username ON students(username);
CREATE INDEX idx_staff_username ON staff(username);
CREATE INDEX idx_admins_username ON admins(username);
CREATE INDEX idx_rewards_active ON rewards(active);
CREATE INDEX idx_rewards_issued_by ON rewards(issued_by_id);
