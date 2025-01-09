USE data_science_assessment;
SHOW TABLES;
DESCRIBE country;
DESCRIBE city;
DESCRIBE customer;

USE data_science_assessment;

SELECT city
    country.country_name AS country_name,
    city.city_name AS city_name,
    customer.customer_name AS customer_name
FROM 
    data_science_assessment.country AS country
LEFT JOIN 
    data_science_assessment.city AS city ON country.country_id = city.country_id
LEFT JOIN 
    data_science_assessment.customer AS customer ON city.city_id = customer.city_id
ORDER BY 
    country.country_name, city.city_name, customer.customer_name;

show tables;

USE data_science_assessment;

SELECT 
    country.country_name AS country_name,
    city.city_name AS city_name,
    customer.customer_name AS customer_name
FROM 
    data_science_assessment.country AS country
INNER JOIN 
    data_science_assessment.city AS city ON country.country_id = city.country_id
LEFT JOIN 
    data_science_assessment.customer AS customer ON city.city_id = customer.city_id
ORDER BY 
    country.country_name, city.city_name, customer.customer_name;
