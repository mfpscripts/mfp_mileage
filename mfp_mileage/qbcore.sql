CREATE TABLE IF NOT EXISTS player_vehicles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    citizenid VARCHAR(50) NOT NULL,
    plate VARCHAR(50) NOT NULL UNIQUE,
    vehicle LONGTEXT NOT NULL,
    garage VARCHAR(50) DEFAULT 'pillboxgarage',
    fuel DOUBLE DEFAULT 100,
    engine DOUBLE DEFAULT 1000,
    body DOUBLE DEFAULT 1000,
    milage DOUBLE DEFAULT 0
);

-- or

ALTER TABLE player_vehicles ADD COLUMN milage DOUBLE DEFAULT 0;