SELECT name, area, kind, source, __geometry__

FROM
(
    --
    -- Ocean
    --
    SELECT '' AS name,
           Area(the_geom) AS area,
           'ocean' AS kind,
           'naturalearthdata.com' AS source,
           ST_Intersection(the_geom, !bbox!) AS __geometry__
    
    FROM ne_10m_ocean
    
    WHERE the_geom && !bbox!
    
    --
    -- Lakes
    --
    UNION

    SELECT name,
           Area(the_geom) AS area,
           'lake' AS kind,
           'naturalearthdata.com' AS source,
           ST_Intersection(the_geom, !bbox!) AS __geometry__
    
    FROM ne_10m_lakes
    
    WHERE the_geom && !bbox!
    
    --
    -- Playas
    --
    UNION

    SELECT name,
           Area(the_geom) AS area,
           'playa' AS kind,
           'naturalearthdata.com' AS source,
           ST_Intersection(the_geom, !bbox!) AS __geometry__
    
    FROM ne_10m_playas
    
    WHERE the_geom && !bbox!

) AS water_areas