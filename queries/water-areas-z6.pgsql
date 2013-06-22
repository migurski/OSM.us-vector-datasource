SELECT name, area, kind, source, __geometry__

FROM
(
    --
    -- Ocean
    --
    SELECT '' AS name,
           Area(geom) AS area,
           'ocean' AS kind,
           'naturalearthdata.com' AS source,
           ST_Intersection(geom, !bbox!) AS __geometry__
    
    FROM ne_10m_ocean
    
    WHERE geom && !bbox!
    
    --
    -- Lakes
    --
    UNION

    SELECT name,
           Area(geom) AS area,
           'lake' AS kind,
           'naturalearthdata.com' AS source,
           ST_Intersection(geom, !bbox!) AS __geometry__
    
    FROM ne_10m_lakes
    
    WHERE geom && !bbox!
    
    --
    -- Playas
    --
    UNION

    SELECT name,
           Area(geom) AS area,
           'playa' AS kind,
           'naturalearthdata.com' AS source,
           ST_Intersection(geom, !bbox!) AS __geometry__
    
    FROM ne_10m_playas
    
    WHERE geom && !bbox!

) AS water_areas
