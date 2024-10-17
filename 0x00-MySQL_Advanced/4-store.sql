-- Drops the trigger if it exists
DROP TRIGGER IF EXISTS reduce_quantity;

-- Sets the delimiter for defining the trigger
DELIMITER $$

-- Creates a trigger to reduce item quantity after a new order
CREATE TRIGGER reduce_quantity
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    -- Updates the item quantity by subtracting the ordered number
    UPDATE items
        SET quantity = quantity - NEW.number
        WHERE name = NEW.item_name;
END $$

-- Resets the delimiter to the default
DELIMITER ;