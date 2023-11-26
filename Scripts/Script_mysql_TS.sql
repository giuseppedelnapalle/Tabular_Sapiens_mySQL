# retrieving records

USE mysql_Tabular_Sapiens;

SELECT * FROM obs;

# show column info
SHOW COLUMNS FROM obs;
# DESCRIBE obs;

# number of cells in the table
SELECT COUNT(*) 
FROM obs;

-- 1. basic statistics by column

# distinct organ_tissue
SELECT DISTINCT organ_tissue
FROM obs o;

# number of cells in each organ_tissue
SELECT organ_tissue, COUNT(*) 
FROM  obs o
GROUP BY organ_tissue;

# number of cells from each method
SELECT method, COUNT(*) 
FROM  obs o
GROUP BY method;

# number of cells from each donor
SELECT donor, COUNT(*) 
FROM  obs o
GROUP BY donor;

# number of cells in each cell_ontology_class
SELECT cell_ontology_class, COUNT(*) 
FROM  obs o
GROUP BY cell_ontology_class;

# number of cells in each organ_tissue
SELECT compartment, COUNT(*) 
FROM  obs o
GROUP BY compartment;

# number of cells in each gender
SELECT gender, COUNT(*) 
FROM  obs o
GROUP BY gender;

-- 2. filter records by conditions
# Mammary
SELECT cell_id, organ_tissue, n_counts_UMIs, n_genes, cell_ontology_class, compartment
FROM obs o 
WHERE organ_tissue = 'Mammary'
AND compartment IN ('epithelial', 'immune')
AND n_counts_UMIs > 20000
AND n_genes > 2500
ORDER BY n_counts_UMIs DESC;

# number of each cell_ontology_class in Mammary epithelial
SELECT cell_ontology_class, COUNT(*) 
FROM obs o
WHERE organ_tissue = 'Mammary' AND compartment IN ('epithelial')
GROUP BY cell_ontology_class;

# Thymus
SELECT cell_id, organ_tissue, n_counts_UMIs, n_genes, cell_ontology_class, compartment
FROM obs o 
WHERE organ_tissue = 'Thymus'
ORDER BY n_counts_UMIs DESC;

# number of cells in Thymus grouped by compartment
SELECT compartment, COUNT(*) 
FROM obs o 
WHERE organ_tissue = 'Thymus'
GROUP BY compartment;

# number of cells in Thymus
SELECT cell_ontology_class, COUNT(*) 
FROM obs o 
WHERE organ_tissue = 'Thymus'
GROUP BY cell_ontology_class;

# number of t cells in Thymus
SELECT cell_ontology_class, COUNT(*) 
FROM obs o 
WHERE organ_tissue = 'Thymus'
AND (cell_ontology_class REGEXP '[ -]t cell$'
OR cell_ontology_class REGEXP '^t.*cell$')
GROUP BY cell_ontology_class;

# Pancreas
SELECT cell_id, organ_tissue, n_counts_UMIs, n_genes, cell_ontology_class, compartment
FROM obs o 
WHERE organ_tissue = 'Pancreas'
AND n_genes BETWEEN 2000 AND 8000
ORDER BY n_genes DESC;

# number of cells in Pancreas with at least 9 cells
SELECT cell_ontology_class, COUNT(cell_ontology_class) # count only non-NULL values
FROM obs o 
WHERE organ_tissue = 'Pancreas'
AND n_genes >= 2000 AND n_genes < 8000
GROUP BY cell_ontology_class
HAVING COUNT(cell_ontology_class) >= 9
ORDER BY COUNT(cell_ontology_class) DESC;
