CREATE DATABASE IF NOT EXISTS `expense_tracker`;

USE `expense_tracker`;

CREATE TABLE `users`(
`uid` INT PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR(20) NOT NULL,
`last_name` VARCHAR(20) NOT NULL,
`email` VARCHAR(40) NOT NULL,
`password` VARCHAR(60) NOT NULL,
`phone_number` VARCHAR(10) 
-- constraint CK_MyTable_PhoneNumber check (`phone_number` like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
) AUTO_INCREMENT = 1;

INSERT INTO `users`
VALUE
(1,"John","Doe","johndoe@email.com","$2a$10$pMjmFGJdvQXFYH00R.n86.FP2Z/PYt7DW4Erov2M2VwnlbWFjrFOq",null);

CREATE TABLE `expenses`(
`expense_id` INT PRIMARY KEY AUTO_INCREMENT,
`title` VARCHAR(40) NOT NULL,
`amount` DOUBLE NOT NULL,
`expense_date` DATE NOT NULL,
`category` ENUM('food','entertainment','health','travel','others') NOT NULL,
`user_id` INT,

FOREIGN KEY (`user_id`) REFERENCES `users`(`uid`)
) AUTO_INCREMENT = 1;

INSERT INTO `expenses`
VALUE
(1,"Press '+' button to add new expenses",1500,'2023-10-13','entertainment',1),
(2,"Slide left to remove a expense",2500,'2023-10-13','others',1),
(3,"Medicines",2500,'2022-10-13','health',1),
(4,"Netflix Subscription",1235.44,'2022-10-13','entertainment',1),
(5,"Family Trip",3000,'2021-10-13','travel',1),
(6,"Groceries",1500,'2021-10-13','food',1),
(7,"House stuff",3500,'2020-10-13','others',1)
;

SELECT * FROM users;
select * from expenses;

-- DROP DATABASE expense_tracker;