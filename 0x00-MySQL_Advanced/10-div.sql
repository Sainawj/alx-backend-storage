-- Drops the function if it exists
DROP FUNCTION IF EXISTS SafeDiv;

-- Sets the delimiter for defining the function
DELIMITER $$

-- Creates a function to safely divide two integers
CREATE FUNCTION SafeDiv (a INT, b INT)
RETURNS FLOAT DETERMINISTIC
BEGIN
    -- Initializes the result to 0
    DECLARE result FLOAT DEFAULT 0;

    -- Checks if the denominator is not zero
    IF b != 0 THEN
        SET result = a / b; -- Performs the division
    END IF;

    RETURN result; -- Returns the result
END $$

-- Resets the delimiter to the default
DELIMITER ;