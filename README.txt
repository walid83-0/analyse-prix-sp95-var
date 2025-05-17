
# Analyse des prix du Sans Plomb 95 dans le Var

## Présentation

Ce projet personnel a été réalisé dans le but d’affiner mes compétences en manipulation de données, analyse et visualisation.
Il porte sur l’analyse des prix du carburant Sans Plomb 95 (SP95) dans le département du Var (83).

Au-delà de l’aspect formateur, ce travail présente une application concrète pour l’entreprise **Trans Qualiter Service**, 
spécialisée dans la livraison et implantée dans le Var.

L’objectif est de localiser les stations proposant les prix les plus compétitifs en SP95 autour de l’entreprise, afin d’optimiser les trajets et les coûts en carburant.

## Outils et technologies utilisés

- **Microsoft Excel** : nettoyage des données (doublons, formats, tri)
- **SQL** : filtrage, regroupements, calculs statistiques
- **Google BigQuery** : traitement et interrogation de jeux de données volumineux
- **Google Looker Studio** : création de visualisations interactives (carte des prix SP95)

## Contenu du projet

- `prix_sp95_var.csv données nettoyées sous Excel  
- `requêtes_bigquery.sql` : requêtes SQL exécutées sur BigQuery  
- `looker_studio_visualisation` : aperçu de la visualisation Looker Studio et des captures de la mise en place de la visualisation
- `README.md` : ce fichier de présentation  
- `https://lookerstudio.google.com/reporting/051a85cb-f4a9-4e08-bbbd-2fe6d27d166c` : lien vers la carte interactive publique

## Utilité pour l’entreprise

L’étude est conçue pour un usage pratique par **Trans Qualiter Service**, afin de déterminer les stations les plus rentables sur les trajets quotidiens dans le Var. 
Le SP95 est utilisé par certains de leurs véhicules utilitaires légers.


#ETAPES


## 1. Récupération des données  
Les données proviennent du site officiel [data.economie.gouv.fr](https://data.economie.gouv.fr/explore/dataset/prix-des-carburants-en-france-flux-instantane-v2/export/), fournissant des informations en temps réel sur les prix des carburants.  
Un fichier CSV a été exporté pour traitement.

---


## 2. Nettoyage des données sous Excel  
- Suppression des doublons afin d’éviter les redondances.  
- Élimination des champs inutiles à l’étude (notamment les prix d’autres carburants non analysés).  
- Extraction des données au format JSON dans des colonnes à part puis suppression de ces colonnes pour simplifier l’analyse.  
- Uniformisation des noms de colonnes (remplacement des espaces par des tirets bas, suppression des accents et majuscules).

---

## 3. Chargement dans BigQuery  
Les données nettoyées ont été importées dans Google BigQuery pour une exploitation avancée.  
BigQuery permet d’exécuter des requêtes SQL très rapidement sur de gros volumes de données.

---

## 4. Analyse avec requêtes SQL  

Voici un exemple de requête utilisée pour extraire les prix du Sans Plomb 95 dans le département du Var (code 83) et calculer la distance en kilomètres entre chaque station-service et un point de référence (coordonnées GPS de l'entreprise)

```sql
SELECT 
    adresse,                       -- Adresse de la station
    ville,                        -- Ville de la station
    CONCAT(adresse, ' ', code_postal, ' ', ville) AS adresse_complete,  -- Adresse complète formatée
    ROUND(prix_sp95, 2) AS prix_sp95,        -- Prix du SP95 arrondi à 2 décimales
    ROUND(ST_DISTANCE(
        ST_GEOGPOINT(longitude, latitude),   -- Point géographique de la station
        ST_GEOGPOINT(6.737, 43.432)           -- Point de référence (longitude, latitude)
    ) / 1000, 2) AS distance_km,              -- Distance entre la station et le point, en kilomètres
    code_departement,          -- Code département (pour filtrage)
    departement                -- Nom du département
FROM `fr_caburant.fr_carburant`
WHERE code_departement = '83'    -- Filtrer uniquement le département 83 (Var)
  AND prix_sp95 IS NOT NULL      -- Ne garder que les stations avec un prix renseigné
ORDER BY distance_km;            -- Trier les résultats par distance croissante


##5.  Visualisation

Il est possible de connecter directement Google BigQuery à Looker Studio (anciennement Google Data Studio) pour visualiser les données.  

Après connexion, on peut utiliser la requête SQL testée dans BigQuery pour récupérer et afficher les données de prix du Sans Plomb 95 dans le Var 
sous forme de graphiques et de cartes interactives.

## 6. Résultats  
L’analyse montre que la station **la moins chère près de Fréjus** est située aux Arcs (1,66 €/L), à ~21km

## Auteur

**Bel Moussa Walid**  
📍 Var, France  
