-- Create 'users' table only if it doesn't exist
CREATE TABLE IF NOT EXISTS users (
    -- 'id' is the primary key, auto-increments, not null
    id INT AUTO_INCREMENT PRIMARY KEY,
    
    -- 'email' is a 255-char string, unique, not null
    email VARCHAR(255) NOT NULL UNIQUE,
    
    -- 'name' is a 255-char string, can be null
    name VARCHAR(255)
);