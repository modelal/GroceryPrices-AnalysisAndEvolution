-- Average Product Price in 2023
SELECT avg(product_price) as preciomedio 
FROM supermercados.precios_2023;

-- Average Unit Price by Year and Product
SELECT 
    YEAR(date) as year_pr, 
    product_code, 
    AVG(unit_price)
FROM pedidos
WHERE product_code IS NOT NULL
GROUP BY product_code, year_pr
ORDER BY product_code;

-- Orders Details with 2024 Prices Excluded
SELECT 
    date, 
    order_num, 
    categories.description, 
    category, 
    subcategory,
    units, 
    pedidos.price_eu AS price_order, 
    unit_price AS price_now
FROM pedidos
JOIN categories ON pedidos.product_code = categories.product_code
JOIN precios_2024 ON categories.product_code = precios_2024.product_code
WHERE pedidos.product_code IS NOT NULL AND YEAR(date) != 2024
ORDER BY pedidos.order_num;

-- Orders Details with Price Difference from 2024
SELECT 
    date, 
    order_num, 
    categories.description, 
    category, 
    subcategory,
    units, 
    pedidos.price_eu AS price_order, 
    unit_price AS price_now,
    (precios_2024.price_eu - unit_price) AS dif
FROM pedidos
JOIN categories ON pedidos.product_code = categories.product_code
JOIN precios_2024 ON categories.product_code = precios_2024.product_code
WHERE pedidos.product_code IS NOT NULL AND YEAR(date) != 2024
ORDER BY dif DESC;

-- Average Unit Price by Year (Excluding 2024)
SELECT 
    YEAR(date) as year_pr, 
    AVG(unit_price) as pr
FROM pedidos
WHERE product_code IS NOT NULL
GROUP BY year_pr
HAVING year_pr != 2024
ORDER BY pr;

-- Average Unit Price per Product in 2018
SELECT 
    product_code, 
    AVG(unit_price) AS price_2018
FROM pedidos
WHERE product_code IS NOT NULL AND YEAR(date) = 2018
GROUP BY product_code;

-- Comparison of Prices Between 2023 and 2024
SELECT 
    categories.description, 
    categories.product_code, 
    category, 
    subcategory,
    precios_2023.product_price AS pr_23,
    precios_2024.price_eu AS pr_24
FROM categories
JOIN precios_2023 ON categories.product_code = precios_2023.product_code
JOIN precios_2024 ON categories.product_code = precios_2024.product_code;

-- Average Unit Price Analysis Across Multiple Years
SELECT 
    pedidos.product_code,
    AVG(CASE WHEN YEAR(date) = 2018 THEN unit_price ELSE NULL END) AS avg_price_2018,
    AVG(CASE WHEN YEAR(date) = 2019 THEN unit_price ELSE NULL END) AS avg_price_2019,
    AVG(CASE WHEN YEAR(date) = 2020 THEN unit_price ELSE NULL END) AS avg_price_2020,
    AVG(CASE WHEN YEAR(date) = 2021 THEN unit_price ELSE NULL END) AS avg_price_2021,
    AVG(CASE WHEN YEAR(date) = 2022 THEN unit_price ELSE NULL END) AS avg_price_2022,
    AVG(precios_2023.product_price) AS avg_price_2023
FROM pedidos
JOIN precios_2023 ON pedidos.product_code = precios_2023.product_code
WHERE pedidos.product_code IS NOT NULL
GROUP BY pedidos.product_code
ORDER BY pedidos.product_code;
