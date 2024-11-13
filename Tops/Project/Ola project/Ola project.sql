CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    address VARCHAR(255)
);
CREATE TABLE `sandeep`.`driver` (
    driver_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    status ENUM('available', 'unavailable', 'reserved') DEFAULT 'available',
    service_type ENUM('regular', 'premium') DEFAULT 'regular'
);
CREATE TABLE `sandeep`. Vehicle (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    driver_id INT,
    vehicle_type VARCHAR(50) NOT NULL,
    model VARCHAR(100),
    quality_rating DECIMAL(2, 1),
    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id)
);
CREATE TABLE `sandeep`. Place (
    place_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
CREATE TABLE `sandeep`. Place_Distance (
    from_place_id INT,
    to_place_id INT,
    distance_km DECIMAL(5, 2),
    PRIMARY KEY (from_place_id, to_place_id),
    FOREIGN KEY (from_place_id) REFERENCES Place(place_id),
    FOREIGN KEY (to_place_id) REFERENCES Place(place_id)
);
CREATE TABLE `sandeep`. Trip (
    trip_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    driver_id INT,
    from_place_id INT,
    to_place_id INT,
    fare DECIMAL(10, 2),
    trip_status ENUM('completed', 'ongoing', 'cancelled') DEFAULT 'ongoing',
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id),
    FOREIGN KEY (from_place_id) REFERENCES Place(place_id),
    FOREIGN KEY (to_place_id) REFERENCES Place(place_id)
);
SELECT 
    pd.distance_km, 
    d.service_type, 
    CASE 
        WHEN d.service_type = 'regular' THEN pd.distance_km * 10 
        ELSE pd.distance_km * 15 
    END AS fare
FROM 
    Place_Distance pd
JOIN 
    Driver d ON d.driver_id = 1  -- Assume a specific driver
WHERE 
    pd.from_place_id = 1 AND pd.to_place_id = 2;
    SELECT 
    driver_id, name, status, service_type 
FROM 
    Driver 
WHERE 
    status = 'available';

SELECT 
    t.trip_id, c.name AS customer_name, d.name AS driver_name, 
    p1.name AS from_place, p2.name AS to_place, t.fare
FROM 
    Trip t
JOIN 
    Customer c ON t.customer_id = c.customer_id
JOIN 
    Driver d ON t.driver_id = d.driver_id
JOIN 
    Place p1 ON t.from_place_id = p1.place_id
JOIN 
    Place p2 ON t.to_place_id = p2.place_id
WHERE 
    t.trip_status = 'cancelled';




SELECT * FROM sandeep.driver;
INSERT INTO `sandeep`.`driver` (`driver_id`, `name`, `phone`, `status`, `service_type`) VALUES ('1', 'Ajay Kumar', '9812340987', 'Available', 'Premium');
INSERT INTO `sandeep`.`driver` (`driver_id`, `name`, `phone`, `status`, `service_type`) VALUES ('2', 'Priya Chawla', '9120987654', 'Not Available', '	Regular');
INSERT INTO `sandeep`.`driver` (`driver_id`, `name`, `phone`, `status`, `service_type`) VALUES ('3', 'Vipul Shah', '9876123450', 'Available', 'Premium');
INSERT INTO `sandeep`.`driver` (`driver_id`, `name`, `phone`, `status`, `service_type`) VALUES ('4', 'Nitin Joshi', '9109876123', 'Reserve', '	Regular');
INSERT INTO `sandeep`.`driver` (`driver_id`, `name`, `phone`, `status`, `service_type`) VALUES ('5', 'Arjun Rao', '9812345670', 'Not Available', 'Premium');
INSERT INTO `sandeep`.`driver` (`driver_id`, `name`, `phone`, `status`, `service_type`) VALUES ('6', 'Pooja Mishra', '9875432109', 'Available', '	Regular');
INSERT INTO `sandeep`.`driver` (`driver_id`, `name`, `phone`, `status`, `service_type`) VALUES ('7', 'Dhruv Pandey', '9123456781', 'Reserve', 'Premium');
INSERT INTO `sandeep`.`driver` (`driver_id`, `name`, `phone`, `status`, `service_type`) VALUES ('8', 'Ramesh Sinha', '9876541203', 'Available', '	Regular');
INSERT INTO `sandeep`.`driver` (`driver_id`, `name`, `phone`, `status`, `service_type`) VALUES ('9', 'Aarti Kulkarni', '9812345675', 'Not Available', 'Premium');
INSERT INTO `sandeep`.`driver` (`driver_id`, `name`, `phone`, `status`, `service_type`) VALUES ('11', 'Sachin Yadav', '9109872345', 'Available', '	Regular');
INSERT INTO `sandeep`.`driver` (`driver_id`, `name`, `phone`, `status`, `service_type`) VALUES ('10', 'Komal Jain', '9123459870', 'Reserve', 'Premium');
INSERT INTO `sandeep`.`driver` (`driver_id`, `name`, `phone`, `status`, `service_type`) VALUES ('12', 'Harish Gupta', '9876543012', 'Not Available', '	Regular');
INSERT INTO `sandeep`.`driver` (`driver_id`, `name`, `phone`, `status`, `service_type`) VALUES ('13', 'Neha Bansal', '9810987654', 'Available', 'Premium');
INSERT INTO `sandeep`.`driver` (`driver_id`, `name`, `phone`, `status`, `service_type`) VALUES ('14', 'Rajesh Patel', '9876543210', 'Available', '	Regular');
INSERT INTO `sandeep`.`driver` (`driver_id`, `name`, `phone`, `status`, `service_type`) VALUES ('15', 'Sandeep Verma', '9123456789', 'Not Available', 'Premium');
INSERT INTO `sandeep`.`driver` (`driver_id`, `name`, `phone`, `status`, `service_type`) VALUES ('16', 'Manisha Desai', '9812345678', 'Reserve', '	Regular');
INSERT INTO `sandeep`.`driver` (`driver_id`, `name`, `phone`, `status`, `service_type`) VALUES ('17', 'Arun Mehta', '9871234560', 'Available', 'Premium');
INSERT INTO `sandeep`.`driver` (`driver_id`, `name`, `phone`, `status`, `service_type`) VALUES ('18', 'Kavita Singh', '9109876543', 'Not Available', '	Regular');
INSERT INTO `sandeep`.`driver` (`driver_id`, `name`, `phone`, `status`, `service_type`) VALUES ('19', 'Rohit Sharma', '9123459876', 'Available', 'Premium');
INSERT INTO `sandeep`.`driver` (`driver_id`, `name`, `phone`, `status`, `service_type`) VALUES ('20', 'Sneha Tiwari', '9870987654', 'Reserve', '	Regular');

SELECT 
    d.name AS driver_name, v.vehicle_type, v.model, p.name AS location 
FROM 
    Driver d
JOIN 
    Vehicle v ON d.driver_id = v.driver_id
JOIN 
    Place p ON p.place_id IN (
        SELECT from_place_id FROM Place_Distance
    )
WHERE 
    d.status = 'available';
    
SELECT 
    t.trip_id, c.name AS customer_name, d.name AS driver_name, 
    p1.name AS from_place, p2.name AS to_place, t.fare
FROM 
    Trip t
JOIN 
    Customer c ON t.customer_id = c.customer_id
JOIN 
    Driver d ON t.driver_id = d.driver_id
JOIN 
    Place p1 ON t.from_place_id = p1.place_id
JOIN 
    Place p2 ON t.to_place_id = p2.place_id
WHERE 
    t.trip_status = 'ongoing';
    
SELECT 
    t.trip_id, c.name AS customer_name, d.name AS driver_name, 
    p1.name AS from_place, p2.name AS to_place, t.fare
FROM 
    Trip t
JOIN 
    Customer c ON t.customer_id = c.customer_id
JOIN 
    Driver d ON t.driver_id = d.driver_id
JOIN 
    Place p1 ON t.from_place_id = p1.place_id
JOIN 
    Place p2 ON t.to_place_id = p2.place_id
WHERE 
    t.trip_status = 'completed';
    



