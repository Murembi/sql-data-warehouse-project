/*
--===============================================================================================
Quality checks
--===============================================================================================
Script purpose:
conduct a quality checks to validate the integrity, consistency, and accuracy of the gold layer
These checks ensure:
-unique surrogate keys in dimension tables.
-referential integrity between fact and dimension tables
-validation of relationship in the data model for analytical purposes. 
--===============================================================================================
*/
--===============================================================================================
--Checking 'gold.dim_customers'
--===============================================================================================
--Check for uniqueness of customer key in gold.dim_customers
--Expectation: no results
SELECT 
  customer_key,
  COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

--===============================================================================================
  --Checking 'gold.fact_sales'
--===============================================================================================
  --Check the data model connectivity between fact nd dimension
  --Foreign key integrity(dimensions)
SELECT * FROM gold_fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL

--===============================================================================================
--Checking 'gold.product_key'
--===============================================================================================
--Check for uniqiueness of product key in gold.dim.products
--Expections: no resulsts
SELECT 
  product_key,
  COUNT(*) AS duplicate_count
FROM gold.dim.products
GROUP BY product_key
HAVING COUNT(*) > 1:
