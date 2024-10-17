-- Ranks country origins by total fans, ordered by descending fans
SELECT origin, SUM(fans) AS nb_fans
    FROM metal_bands
    -- Group by country of origin
    GROUP BY origin
    -- Order by total fans in descending order
    ORDER BY nb_fans DESC;