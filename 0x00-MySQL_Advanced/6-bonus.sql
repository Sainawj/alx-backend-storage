-- Drops the stored procedure if it exists
DROP PROCEDURE IF EXISTS AddBonus;

-- Sets the delimiter for defining the procedure
DELIMITER $$

-- Creates a procedure to add a correction for a student
CREATE PROCEDURE AddBonus (user_id INT, project_name VARCHAR(255), score FLOAT)
BEGIN
    -- Initializes project count and project ID
    DECLARE project_count INT DEFAULT 0;
    DECLARE project_id INT DEFAULT 0;

    -- Checks if the project exists, retrieves project count
    SELECT COUNT(id)
        INTO project_count
        FROM projects
        WHERE name = project_name;

    -- Inserts the project if it doesn't exist
    IF project_count = 0 THEN
        INSERT INTO projects(name)
            VALUES(project_name);
    END IF;

    -- Retrieves the project ID
    SELECT id
        INTO project_id
        FROM projects
        WHERE name = project_name;

    -- Adds a correction for the student
    INSERT INTO corrections(user_id, project_id, score)
        VALUES (user_id, project_id, score);
END $$

-- Resets the delimiter to the default
DELIMITER ;