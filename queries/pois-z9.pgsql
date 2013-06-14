SELECT name,
       COALESCE("aeroway") AS kind,
       way AS geometry,
       osm_id AS __id__

FROM planet_osm_point

WHERE (
      "aeroway" IN ('aerodrome', 'airport')
)
