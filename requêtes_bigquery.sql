SELECT 
adresse,
ville,
CONCAT(adresse,' ' ,code_postal,' ',ville) AS adresse_complete ,
 ROUND(prix_sp95,2) AS prix_sp95 ,
  ROUND(ST_DISTANCE (
        ST_GEOGPOINT(longitude, latitude),      
        ST_GEOGPOINT(6.737, 43.432)             
    )/1000,2 ) AS distance_km ,
  code_departement,
  departement
 FROM `fr_caburant.fr_carburant`  
 WHERE code_departement='83'
 AND prix_sp95 IS NOT NULL
 ORDER BY distance_km