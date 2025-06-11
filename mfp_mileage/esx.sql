-- ownedvehicle & usedcardealertable

CREATE TABLE IF NOT EXISTS `owned_vehicles` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `owner` VARCHAR(64) NOT NULL,
    `plate` VARCHAR(10) NOT NULL,
    `vehicle` TEXT NOT NULL,
    `state` TEXT NOT NULL,
    `milage` DOUBLE NOT NULL DEFAULT 0
);

-- or

ALTER TABLE `owned_vehicles`
ADD COLUMN IF NOT EXISTS `milage` DOUBLE NOT NULL DEFAULT 0;