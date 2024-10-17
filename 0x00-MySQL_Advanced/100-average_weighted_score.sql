-- Drops the stored procedure if it exists
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUser;

-- Sets the delimiter for defining the procedure
DELIMITER $$

-- Creates a procedure to compute the average weighted score for a student
CREATE PROCEDURE ComputeAverageWeightedScoreForUser (user_id INT)
BEGIN
    -- Initializes total weighted score and total weight
    DECLARE total_weighted_score INT DEFAULT 0;
    DECLARE total_weight INT DEFAULT 0;

    -- Calculates the total weighted score for the specified user
    SELECT SUM(corrections.score * projects.weight)
        INTO total_weighted_score
        FROM corrections
            INNER JOIN projects
                ON corrections.project_id = projects.id
        WHERE corrections.user_id = user_id;

    -- Calculates the total weight for the specified user
    SELECT SUM(projects.weight)
        INTO total_weight
        FROM corrections
            INNER JOIN projects
                ON corrections.project_id = projects.id
        WHERE corrections.user_id = user_id;

    -- Updates the user's average score based on total weight
    IF total_weight = 0 THEN
        UPDATE users
            SET users.average_score = 0
            WHERE users.id = user_id;
    ELSE
        UPDATE users
            SET users.average_score = total_weighted_score / total_weight
            WHERE users.id = user_id;
    END IF;
END $$

-- Resets the delimiter to the default
DELIMITER ;