-- Drops the trigger if it exists
DROP TRIGGER IF EXISTS validate_email;

-- Sets the delimiter for defining the trigger
DELIMITER $$

-- Creates a trigger to reset 'valid_email' if the email is changed
CREATE TRIGGER validate_email
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    -- Resets 'valid_email' to 0 if the email has changed
    IF OLD.email != NEW.email THEN
        SET NEW.valid_email = 0;
    -- Keeps 'valid_email' unchanged if the email remains the same
    ELSE
        SET NEW.valid_email = NEW.valid_email;
    END IF;
END $$

-- Resets the delimiter to the default
DELIMITER ;