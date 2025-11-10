USE plant_growth;
SHOW TABLES;

select * from plant_growth_analysis;

-- Total plants and treatment count
SELECT COUNT(DISTINCT Plant_ID) AS total_plants,
       COUNT(DISTINCT Treatment_Type) AS total_treatments
FROM plant_growth_analysis;

-- Average height, biomass, leaf area per treatment
SELECT Treatment_Type,
       ROUND(AVG(Height_cm),2) AS avg_height,
       ROUND(AVG(Biomass_g),2) AS avg_biomass,
       ROUND(AVG(Leaf_Area_cm2),2) AS avg_leaf_area
FROM plant_growth_analysis
GROUP BY Treatment_Type;


-- Growth trend over time
SELECT Growth_Day,
       ROUND(AVG(Height_cm),2) AS avg_height,
       ROUND(AVG(Biomass_g),2) AS avg_biomass
FROM plant_growth_analysis
GROUP BY Growth_Day
ORDER BY Growth_Day;

-- Fastest growing treatment
SELECT Treatment_Type,
       (MAX(Height_cm) - MIN(Height_cm)) / (MAX(Growth_Day) - MIN(Growth_Day)) AS growth_rate
FROM plant_growth_analysis
GROUP BY Treatment_Type
ORDER BY growth_rate DESC;

-- Correlation-like insight (height vs leaf count)
SELECT ROUND(AVG(Height_cm / Leaf_Count),2) AS avg_height_per_leaf
FROM plant_growth_analysis;

-- Total Records and Distinct Counts
SELECT 
  COUNT(*) AS total_records,
  COUNT(DISTINCT Plant_ID) AS total_plants,
  COUNT(DISTINCT Species) AS total_species,
  COUNT(DISTINCT Treatment_Type) AS total_treatments
FROM plant_growth_analysis;

-- Check for Missing / Null Data
SELECT 
  SUM(Plant_ID IS NULL) AS null_plantid,
  SUM(Species IS NULL) AS null_species,
  SUM(Height_cm IS NULL) AS null_height,
  SUM(Biomass_g IS NULL) AS null_biomass
FROM plant_growth_analysis;

-- Growth Metrics
SELECT 
  Growth_Day,
  ROUND(AVG(Height_cm),2) AS avg_height,
  ROUND(AVG(Biomass_g),2) AS avg_biomass
FROM plant_growth_analysis
GROUP BY Growth_Day
ORDER BY Growth_Day;

-- Average Growth by Species
SELECT 
  Species,
  ROUND(AVG(Height_cm),2) AS avg_height,
  ROUND(AVG(Stem_Diameter_mm),2) AS avg_stem,
  ROUND(AVG(Leaf_Count),2) AS avg_leaves
FROM plant_growth_analysis
GROUP BY Species
ORDER BY avg_height DESC;

-- Fastest Average Growth Species per Treatment
SELECT 
  Species,
  Treatment_Type,
  ROUND(AVG(Height_cm),2) AS avg_height
FROM plant_growth_analysis
GROUP BY Species, Treatment_Type
ORDER BY avg_height DESC;

-- Biomass vs Chlorophyll Relationship (approx)
SELECT 
  ROUND(AVG(Biomass_g / Chlorophyll_Content),3) AS biomass_to_chlorophyll_ratio
FROM plant_growth_analysis;


