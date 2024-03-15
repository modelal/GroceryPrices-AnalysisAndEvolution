SELECT avg(product_price) as preciomedio FROM supermercados.precios_2023;


SELECT YEAR(date)  as year_pr, product_code, AVG(unit_price) 
 FROM pedidos
 WHERE product_code IS NOT NULL
 GROUP BY product_code, year_pr
 ORDER BY product_code;
 -- QUIERO UNA TABLA QUE SEA EL AÑO Y ABAJO EL AVG PRICE 
 
 SELECT date , order_num, categories.description, category, subcategory,
	units, pedidos.price_eu, unit_price AS price_order, precios_2024.price_eu AS price_now
 FROM pedidos
	JOIN categories
		ON pedidos.product_code = categories.product_code
	JOIN precios_2024
		ON categories.product_code = precios_2024.product_code
 WHERE pedidos.product_code IS NOT NULL AND YEAR(date) != 2024;
 
 --
  SELECT date , order_num, categories.description, category, subcategory,
	units, pedidos.price_eu, unit_price AS price_order, precios_2024.price_eu AS price_now,
    (precios_2024.price_eu - unit_price) AS dif
 FROM pedidos
	JOIN categories
		ON pedidos.product_code = categories.product_code
	JOIN precios_2024
		ON categories.product_code = precios_2024.product_code
 WHERE pedidos.product_code IS NOT NULL AND YEAR(date) != 2024
 ORDER BY dif DESC;
 
 
 
 
 
  SELECT YEAR(date)  as year_pr,
	AVG(unit_price) as pr
 FROM pedidos
 WHERE product_code IS NOT NULL
 GROUP BY  year_pr
	HAVING year_pr != 2024
 ORDER BY pr ;
 
 
 
 -- CODIGOS Y PRECIOS DE 2018
 SELECT product_code, AVG(unit_price) AS price_2018
 FROM pedidos
 WHERE product_code IS NOT NULL AND YEAR(date) = 2022
 GROUP BY product_code;
 
  SELECT product_code, AVG(unit_price) AS price_2019
 FROM pedidos
 WHERE product_code IS NOT NULL AND YEAR(date) = 2019
 GROUP BY product_code;
 
   SELECT product_code, AVG(unit_price) AS price_2020
 FROM pedidos
 WHERE product_code IS NOT NULL AND YEAR(date) = 2020
 GROUP BY product_code;
 
-- Analisis por categoria /subcategoria y precios query ok -----
SELECT  categories.description, categories.product_code, category, subcategory,
		precios_2023.product_price AS pr_23,
        precios_2024.price_eu AS pr_24
FROM categories
	JOIN precios_2023
		ON categories.product_code = precios_2023.product_code
	JOIN precios_2024
		ON categories.product_code = precios_2024.product_code;
        
-- ------------------PRECIOS PRD -CODIGOS POR AÑO -----------------OK------AÑADIR JOIN 2024------
SELECT 
    pedidos.product_code,
    AVG(CASE WHEN YEAR(date) = 2018 THEN unit_price ELSE NULL END) AS avg_price_2018,
    AVG(CASE WHEN YEAR(date) = 2019 THEN unit_price ELSE NULL END) AS avg_price_2019,
    AVG(CASE WHEN YEAR(date) = 2020 THEN unit_price ELSE NULL END) AS avg_price_2020,
    AVG(CASE WHEN YEAR(date) = 2021 THEN unit_price ELSE NULL END) AS avg_price_2021,
    AVG(CASE WHEN YEAR(date) = 2022 THEN unit_price ELSE NULL END) AS avg_price_2022,
    AVG(precios_2023.product_price) AS avg_price_2023
FROM pedidos
	JOIN precios_2023
		ON pedidos.product_code = precios_2023.product_code
WHERE pedidos.product_code IS NOT NULL
GROUP BY product_code
ORDER BY product_code;
-- ------------------------------------------------------------