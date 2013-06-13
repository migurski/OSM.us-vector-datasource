SELECT name,
       COALESCE("aeroway") AS kind,
       way AS geometry

FROM planet_osm_point

WHERE (
      "aeroway" IN ('aerodrome', 'airport')
)
