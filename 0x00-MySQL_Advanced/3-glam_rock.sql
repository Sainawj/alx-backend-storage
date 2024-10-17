-- Lists all bands with Glam rock as main style, ranked by longevity
SELECT band_name, (IFNULL(split, '2020') - formed) AS lifespan
    -- Calculates band's lifespan using split year or 2020 if not split
    FROM metal_bands
    -- Checks if 'Glam rock' is in the band's style
    WHERE FIND_IN_SET('Glam rock', IFNULL(style, "")) > 0
    -- Orders bands by lifespan in descending order
    ORDER BY lifespan DESC;