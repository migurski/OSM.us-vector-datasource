SELECT name,
       Area(way) AS area,
       COALESCE("landuse", "leisure", "natural", "highway", "amenity") AS kind,
       way AS geometry

FROM planet_osm_polygon

WHERE (
      "landuse" IN ('park', 'forest', 'residential', 'retail', 'commercial',
                    'industrial', 'railway', 'cemetery', 'grass', 'farmyard',
                    'farm', 'farmland', 'wood', 'meadow', 'village_green',
                    'recreation_ground', 'allotments', 'quarry')
   OR "leisure" IN ('park', 'garden', 'playground', 'golf_course', 'sports_centre',
                    'pitch', 'stadium', 'common', 'nature_reserve')
   OR "natural" IN ('wood', 'land', 'scrub')
   OR "highway" IN ('pedestrian', 'footway')
   OR "amenity" IN ('university', 'school', 'college', 'library', 'fuel',
                    'parking', 'cinema', 'theatre', 'place_of_worship', 'hospital')
   )
   AND Area(way) > 102400 -- 4px
