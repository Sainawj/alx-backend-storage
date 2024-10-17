-- Drops the stored procedure if it exists
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUsers;

-- Sets the delimiter for defining the procedure
DELIMITER $$

-- Creates a procedure to compute average weighted scores for all students
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers ()
BEGIN
    -- Adds temporary columns for total weighted score and total weight
    ALTER TABLE users ADD total_weighted_score INT NOT NULL;
    ALTER TABLE users ADD total_weight INT NOT NULL;

    -- Updates total weighted score for each user
    UPDATE users
        SET total_weighted_score = (
            SELECT SUM(corrections.score * projects.weight)
            FROM corrections
                INNER JOIN projects
                    ON corrections.project_id = projects.id
            WHERE corrections.user_id = users.id
            );

    -- Updates total weight for each user
    UPDATE users
        SET total_weight = (
            SELECT SUM(projects.weight)
                FROM corrections
                    INNER JOIN projects
                        ON corrections.project_id = projects.id
                WHERE corrections.user_id = users.id
            );

    -- Calculates and updates the average score for each user
    UPDATE users
        SET users.average_score = IF(users.total_weight = 0, 0, users.total_weighted_score / users.total_weight);
    
    -- Drops the temporary columns from the users table
    ALTER TABLE users
        DROP COLUMN total_weighted_score;
    ALTER TABLE users
        DROP COLUMN total_weight;
END $$

-- Resets the delimiter to the default
DELIMITER ;