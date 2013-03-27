SELECT name, area, kind, geometry

FROM
(
    --
    -- Ocean
    --
    SELECT '' AS name,
           Area(the_geom) AS area,
           'ocean' AS kind,
           the_geom AS geometry
    
    FROM water_polygons
    
    WHERE the_geom && !bbox!
    
    --
    -- Other water areas
    --
    UNION

    SELECT name,
           Area(way) AS area,
           COALESCE("waterway", "natural", "landuse") AS kind,
           way AS geometry
    
    FROM planet_osm_polygon
    
    WHERE (
         "waterway" IN ('riverbank')
       OR "natural" IN ('water')
       OR "landuse" IN ('basin', 'reservoir')
       )
       AND Area(way) > 1600 -- 4px
       AND way && !bbox!

) AS water_areas
