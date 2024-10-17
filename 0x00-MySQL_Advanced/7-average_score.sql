-- Drops the stored procedure if it exists
DROP PROCEDURE IF EXISTS ComputeAverageScoreForUser;

-- Sets the delimiter for defining the procedure
DELIMITER $$

-- Creates a procedure to compute average score for a student
CREATE PROCEDURE ComputeAverageScoreForUser (user_id INT)
BEGIN
    -- Initializes total score and project count
    DECLARE total_score INT DEFAULT 0;
    DECLARE projects_count INT DEFAULT 0;

    -- Sums the scores for the specified user
    SELECT SUM(score)
        INTO total_score
        FROM corrections
        WHERE corrections.user_id = user_id;

    -- Counts the number of projects for the user
    SELECT COUNT(*)
        INTO projects_count
        FROM corrections
        WHERE corrections.user_id = user_id;

    -- Updates the user's average score
    UPDATE users
        SET users.average_score = IF(projects_count = 0, 0, total_score / projects_count)
        WHERE users.id = user_id;
END $$

-- Resets the delimiter to the default
DELIMITER ;