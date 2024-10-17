-- Drops the view if it exists
DROP VIEW IF EXISTS need_meeting;

-- Creates a view for students needing a meeting based on their score and last meeting
CREATE VIEW need_meeting AS
    SELECT name
        FROM students
        -- Filters students with a score below 80
        WHERE score < 80 AND
            (
                -- Checks if last meeting is null or over a month ago
                last_meeting IS NULL
                OR last_meeting < SUBDATE(CURRENT_DATE(), INTERVAL 1 MONTH)
            )
;