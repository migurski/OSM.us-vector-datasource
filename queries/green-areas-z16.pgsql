SELECT name,
       Area(way) AS area,
       COALESCE(leisure, amenity, landuse) AS kind,
       way AS geometry

FROM planet_osm_polygon

WHERE (
      leisure IN ('park', 'water_park', 'marina', 'nature_reserve',
                  'playground', 'garden', 'common')
   OR amenity IN ('graveyard')
   OR landuse IN ('cemetery')
   OR leisure IN ('sports_centre', 'golf_course', 'stadium',
                  'track', 'pitch')
   OR landuse IN ('recreation_ground')
   OR landuse IN ('forest', 'wood')
   )

