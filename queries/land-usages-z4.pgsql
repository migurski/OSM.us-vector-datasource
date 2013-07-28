SELECT name, area, kind, source, __geometry__

FROM
(
    --
    -- Urban Areas
    --
    SELECT '' AS name,
           Area(the_geom)::bigint AS area,
           'urban area' AS kind,
           'naturalearthdata.com' AS source,
           the_geom AS __geometry__
    
    FROM ne_50m_urban_areas
    
    WHERE the_geom && !bbox!

) AS land_usages
