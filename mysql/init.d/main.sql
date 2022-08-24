
CREATE DATABASE main;

GRANT ALL PRIVILEGES ON main.* TO 'user'@'%' with grant option;

GRANT SUPER ON *.* TO 'user'@'%';

USE main;

