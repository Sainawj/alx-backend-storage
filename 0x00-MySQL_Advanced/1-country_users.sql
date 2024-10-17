-- Drops the 'users' table if it exists
DROP TABLE IF EXISTS users;

-- Creates a table with unique users
CREATE TABLE users (
    -- 'id' is the primary key, auto-increments, not null
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    
    -- 'email' is a 255-char string, unique, not null
    email VARCHAR(255) NOT NULL UNIQUE,
    
    -- 'name' is a 255-char string, can be null
    name VARCHAR(255),
    
    -- 'country' is a 2-char string, defaults to 'US', must be 'US', 'CO', or 'TN'
    country CHAR(2) NOT NULL DEFAULT 'US' CHECK (country IN ('US', 'CO', 'TN'))
);