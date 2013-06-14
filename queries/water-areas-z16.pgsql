SELECT name, area, kind, __geometry__, __id__

FROM
(
    --
    -- Ocean
    --
    SELECT '' AS name,
           Area(the_geom) AS area,
           'ocean' AS kind,
           the_geom AS __geometry__,
           gid::varchar AS __id__
    
    FROM water_polygons
    
    WHERE the_geom && !bbox!
    
    --
    -- Other water areas
    --
    UNION

    SELECT name,
           Area(way) AS area,
           COALESCE("waterway", "natural", "landuse") AS kind,
           way AS __geometry__,
        
           --
           -- Negative osm_id is synthetic, with possibly multiple geometry rows.
           --
           (CASE WHEN osm_id < 0 THEN Substr(MD5(ST_AsBinary(way)), 1, 10)
                 ELSE osm_id::varchar END) AS __id__
    
    FROM planet_osm_polygon
    
    WHERE (
         "waterway" IN ('riverbank')
       OR "natural" IN ('water')
       OR "landuse" IN ('basin', 'reservoir')
       )
       AND way && !bbox!

) AS water_areas
