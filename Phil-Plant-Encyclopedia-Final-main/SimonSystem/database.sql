CREATE DATABASE IF NOT EXISTS `philippine_plants_encyclopedia` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE `philippine_plants_encyclopedia`;

DROP TABLE IF EXISTS plants;

DROP TABLE IF EXISTS municipalities;

DROP TABLE IF EXISTS provinces;

DROP TABLE IF EXISTS regions;

DROP TABLE IF EXISTS admin_users;

CREATE TABLE regions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE provinces (
    id INT AUTO_INCREMENT PRIMARY KEY,
    region_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    FOREIGN KEY (region_id) REFERENCES regions (id) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE municipalities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    province_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    FOREIGN KEY (province_id) REFERENCES provinces (id) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE plants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    common_name VARCHAR(255) NOT NULL,
    scientific_name VARCHAR(255) NOT NULL,
    description TEXT,
    habitat TEXT,
    uses TEXT,
    conservation TEXT
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE plant_municipalities (
    plant_id INT NOT NULL,
    municipality_id INT NOT NULL,
    PRIMARY KEY (plant_id, municipality_id),
    FOREIGN KEY (plant_id) REFERENCES plants (id) ON DELETE CASCADE,
    FOREIGN KEY (municipality_id) REFERENCES municipalities (id) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE plant_photos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plant_id INT NOT NULL,
    filename VARCHAR(255) NOT NULL,
    FOREIGN KEY (plant_id) REFERENCES plants (id) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE admin_users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Region seed data
INSERT INTO
    regions (id, name)
VALUES (
        1,
        'Bangsamoro Autonomous Region in Muslim Mindanao'
    );

INSERT INTO regions (id, name) VALUES (2, 'Bicol Region');

INSERT INTO regions (id, name) VALUES (3, 'Cagayan Valley');

INSERT INTO regions (id, name) VALUES (4, 'Calabarzon');

INSERT INTO regions (id, name) VALUES (5, 'Caraga');

INSERT INTO regions (id, name) VALUES (6, 'Central Luzon');

INSERT INTO regions (id, name) VALUES (7, 'Central Visayas');

INSERT INTO
    regions (id, name)
VALUES (
        8,
        'Cordillera Administrative Region'
    );

INSERT INTO regions (id, name) VALUES (9, 'Davao Region');

INSERT INTO regions (id, name) VALUES (10, 'Eastern Visayas');

INSERT INTO regions (id, name) VALUES (11, 'Ilocos Region');

INSERT INTO regions (id, name) VALUES (12, 'Mimaropa');

INSERT INTO
    regions (id, name)
VALUES (13, 'National Capital Region');

INSERT INTO regions (id, name) VALUES (14, 'Negros Island Region');

INSERT INTO regions (id, name) VALUES (15, 'Northern Mindanao');

INSERT INTO regions (id, name) VALUES (16, 'SOCCSKSARGEN');

INSERT INTO regions (id, name) VALUES (17, 'Western Visayas');

INSERT INTO regions (id, name) VALUES (18, 'Zamboanga Peninsula');

-- Province seed data
INSERT INTO provinces (id, region_id, name) VALUES (1, 8, 'Abra');

INSERT INTO
    provinces (id, region_id, name)
VALUES (2, 5, 'Agusan del Norte');

INSERT INTO
    provinces (id, region_id, name)
VALUES (3, 5, 'Agusan del Sur');

INSERT INTO provinces (id, region_id, name) VALUES (4, 17, 'Aklan');

INSERT INTO provinces (id, region_id, name) VALUES (5, 2, 'Albay');

INSERT INTO
    provinces (id, region_id, name)
VALUES (6, 17, 'Antique');

INSERT INTO provinces (id, region_id, name) VALUES (7, 8, 'Apayao');

INSERT INTO provinces (id, region_id, name) VALUES (8, 6, 'Aurora');

INSERT INTO provinces (id, region_id, name) VALUES (9, 1, 'Basilan');

INSERT INTO provinces (id, region_id, name) VALUES (10, 6, 'Bataan');

INSERT INTO
    provinces (id, region_id, name)
VALUES (11, 3, 'Batanes');

INSERT INTO
    provinces (id, region_id, name)
VALUES (12, 4, 'Batangas');

INSERT INTO
    provinces (id, region_id, name)
VALUES (13, 8, 'Benguet');

INSERT INTO
    provinces (id, region_id, name)
VALUES (14, 10, 'Biliran');

INSERT INTO provinces (id, region_id, name) VALUES (15, 7, 'Bohol');

INSERT INTO
    provinces (id, region_id, name)
VALUES (16, 15, 'Bukidnon');

INSERT INTO
    provinces (id, region_id, name)
VALUES (17, 6, 'Bulacan');

INSERT INTO
    provinces (id, region_id, name)
VALUES (18, 3, 'Cagayan');

INSERT INTO
    provinces (id, region_id, name)
VALUES (19, 2, 'Camarines Norte');

INSERT INTO
    provinces (id, region_id, name)
VALUES (20, 2, 'Camarines Sur');

INSERT INTO
    provinces (id, region_id, name)
VALUES (21, 15, 'Camiguin');

INSERT INTO provinces (id, region_id, name) VALUES (22, 17, 'Capiz');

INSERT INTO
    provinces (id, region_id, name)
VALUES (23, 2, 'Catanduanes');

INSERT INTO provinces (id, region_id, name) VALUES (24, 4, 'Cavite');

INSERT INTO provinces (id, region_id, name) VALUES (25, 7, 'Cebu');

INSERT INTO
    provinces (id, region_id, name)
VALUES (26, 16, 'Cotabato');

INSERT INTO
    provinces (id, region_id, name)
VALUES (27, 9, 'Davao de Oro');

INSERT INTO
    provinces (id, region_id, name)
VALUES (28, 9, 'Davao del Norte');

INSERT INTO
    provinces (id, region_id, name)
VALUES (29, 9, 'Davao del Sur');

INSERT INTO
    provinces (id, region_id, name)
VALUES (30, 9, 'Davao Occidental');

INSERT INTO
    provinces (id, region_id, name)
VALUES (31, 9, 'Davao Oriental');

INSERT INTO
    provinces (id, region_id, name)
VALUES (32, 5, 'Dinagat Islands');

INSERT INTO
    provinces (id, region_id, name)
VALUES (33, 10, 'Eastern Samar');

INSERT INTO
    provinces (id, region_id, name)
VALUES (34, 17, 'Guimaras');

INSERT INTO provinces (id, region_id, name) VALUES (35, 8, 'Ifugao');

INSERT INTO
    provinces (id, region_id, name)
VALUES (36, 11, 'Ilocos Norte');

INSERT INTO
    provinces (id, region_id, name)
VALUES (37, 11, 'Ilocos Sur');

INSERT INTO
    provinces (id, region_id, name)
VALUES (38, 17, 'Iloilo');

INSERT INTO
    provinces (id, region_id, name)
VALUES (39, 3, 'Isabela');

INSERT INTO
    provinces (id, region_id, name)
VALUES (40, 8, 'Kalinga');

INSERT INTO
    provinces (id, region_id, name)
VALUES (41, 11, 'La Union');

INSERT INTO provinces (id, region_id, name) VALUES (42, 4, 'Laguna');

INSERT INTO
    provinces (id, region_id, name)
VALUES (43, 15, 'Lanao del Norte');

INSERT INTO
    provinces (id, region_id, name)
VALUES (44, 1, 'Lanao del Sur');

INSERT INTO provinces (id, region_id, name) VALUES (45, 10, 'Leyte');

INSERT INTO
    provinces (id, region_id, name)
VALUES (
        46,
        1,
        'Maguindanao del Norte'
    );

INSERT INTO
    provinces (id, region_id, name)
VALUES (47, 1, 'Maguindanao del Sur');

INSERT INTO
    provinces (id, region_id, name)
VALUES (48, 12, 'Marinduque');

INSERT INTO
    provinces (id, region_id, name)
VALUES (49, 2, 'Masbate');

INSERT INTO
    provinces (id, region_id, name)
VALUES (50, 15, 'Misamis Occidental');

INSERT INTO
    provinces (id, region_id, name)
VALUES (51, 15, 'Misamis Oriental');

INSERT INTO
    provinces (id, region_id, name)
VALUES (52, 8, 'Mountain Province');

INSERT INTO
    provinces (id, region_id, name)
VALUES (53, 14, 'Negros Occidental');

INSERT INTO
    provinces (id, region_id, name)
VALUES (54, 14, 'Negros Oriental');

INSERT INTO
    provinces (id, region_id, name)
VALUES (55, 10, 'Northern Samar');

INSERT INTO
    provinces (id, region_id, name)
VALUES (56, 6, 'Nueva Ecija');

INSERT INTO
    provinces (id, region_id, name)
VALUES (57, 3, 'Nueva Vizcaya');

INSERT INTO
    provinces (id, region_id, name)
VALUES (58, 12, 'Occidental Mindoro');

INSERT INTO
    provinces (id, region_id, name)
VALUES (59, 12, 'Oriental Mindoro');

INSERT INTO
    provinces (id, region_id, name)
VALUES (60, 12, 'Palawan');

INSERT INTO
    provinces (id, region_id, name)
VALUES (61, 6, 'Pampanga');

INSERT INTO
    provinces (id, region_id, name)
VALUES (62, 11, 'Pangasinan');

INSERT INTO provinces (id, region_id, name) VALUES (63, 4, 'Quezon');

INSERT INTO
    provinces (id, region_id, name)
VALUES (64, 3, 'Quirino');

INSERT INTO provinces (id, region_id, name) VALUES (65, 4, 'Rizal');

INSERT INTO
    provinces (id, region_id, name)
VALUES (66, 12, 'Romblon');

INSERT INTO provinces (id, region_id, name) VALUES (67, 10, 'Samar');

INSERT INTO
    provinces (id, region_id, name)
VALUES (68, 16, 'Sarangani');

INSERT INTO
    provinces (id, region_id, name)
VALUES (69, 14, 'Siquijor');

INSERT INTO
    provinces (id, region_id, name)
VALUES (70, 2, 'Sorsogon');

INSERT INTO
    provinces (id, region_id, name)
VALUES (71, 16, 'South Cotabato');

INSERT INTO
    provinces (id, region_id, name)
VALUES (72, 10, 'Southern Leyte');

INSERT INTO
    provinces (id, region_id, name)
VALUES (73, 16, 'Sultan Kudarat');

INSERT INTO provinces (id, region_id, name) VALUES (74, 18, 'Sulu');

INSERT INTO
    provinces (id, region_id, name)
VALUES (75, 5, 'Surigao del Norte');

INSERT INTO
    provinces (id, region_id, name)
VALUES (76, 5, 'Surigao del Sur');

INSERT INTO provinces (id, region_id, name) VALUES (77, 6, 'Tarlac');

INSERT INTO
    provinces (id, region_id, name)
VALUES (78, 1, 'Tawi-Tawi');

INSERT INTO
    provinces (id, region_id, name)
VALUES (79, 6, 'Zambales');

INSERT INTO
    provinces (id, region_id, name)
VALUES (80, 18, 'Zamboanga del Norte');

INSERT INTO
    provinces (id, region_id, name)
VALUES (81, 18, 'Zamboanga del Sur');

INSERT INTO
    provinces (id, region_id, name)
VALUES (82, 18, 'Zamboanga Sibugay');

INSERT INTO
    provinces (id, region_id, name)
VALUES (83, 13, 'Metro Manila');

-- Municipality seed data
INSERT INTO
    municipalities (id, province_id, name)
VALUES (1, 1, 'Bangued†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (2, 1, 'Boliney');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (3, 1, 'Bucay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (4, 1, 'Bucloc');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (5, 1, 'Daguioman');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (6, 1, 'Danglas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (7, 1, 'Dolores');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (8, 1, 'La Paz');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (9, 1, 'Lacub');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (10, 1, 'Lagangilang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (11, 1, 'Lagayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (12, 1, 'Langiden');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (13, 1, 'Licuan-Baay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (14, 1, 'Luba');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (15, 1, 'Malibcong');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (16, 1, 'Manabo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (17, 1, 'Peñarrubia');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (18, 1, 'Pidigan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (19, 1, 'Pilar');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (20, 1, 'Sallapadan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (21, 1, 'San Isidro');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (22, 1, 'San Juan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (23, 1, 'San Quintin');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (24, 1, 'Tayum');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (25, 1, 'Tineg');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (26, 1, 'Tubo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (27, 1, 'Villaviciosa');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (28, 2, 'Buenavista');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (29, 2, 'Butuan†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (30, 2, 'Cabadbaran');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (31, 2, 'Carmen');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (32, 2, 'Jabonga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (33, 2, 'Kitcharao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (34, 2, 'Las Nieves');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (35, 2, 'Magallanes');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (36, 2, 'Nasipit');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        37,
        2,
        'Remedios T. Romualdez'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (38, 2, 'Santiago');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (39, 2, 'Tubay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (40, 3, 'Bayugan†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (41, 3, 'Bunawan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (42, 3, 'Esperanza');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (43, 3, 'La Paz');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (44, 3, 'Loreto');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (45, 3, 'Prosperidad');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (46, 3, 'Rosario');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (47, 3, 'San Francisco');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (48, 3, 'San Luis');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (49, 3, 'Santa Josefa');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (50, 3, 'Sibagat');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (51, 3, 'Talacogon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (52, 3, 'Trento');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (53, 3, 'Veruela');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (54, 4, 'Altavas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (55, 4, 'Balete');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (56, 4, 'Banga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (57, 4, 'Batan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (58, 4, 'Buruanga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (59, 4, 'Ibajay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (60, 4, 'Kalibo†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (61, 4, 'Lezo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (62, 4, 'Libacao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (63, 4, 'Madalag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (64, 4, 'Makato');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (65, 4, 'Malay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (66, 4, 'Malinao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (67, 4, 'Nabas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (68, 4, 'New Washington');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (69, 4, 'Numancia');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (70, 4, 'Tangalan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (71, 5, 'Bacacay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (72, 5, 'Camalig');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (73, 5, 'Daraga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (74, 5, 'Guinobatan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (75, 5, 'Jovellar');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (76, 5, 'Legazpi†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (77, 5, 'Libon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (78, 5, 'Ligao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (79, 5, 'Malilipot');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (80, 5, 'Malinao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (81, 5, 'Manito');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (82, 5, 'Oas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (83, 5, 'Pio Duran');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (84, 5, 'Polangui');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (85, 5, 'Rapu-Rapu');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (86, 5, 'Santo Domingo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (87, 5, 'Tabaco');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (88, 5, 'Tiwi');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (89, 6, 'Anini-y');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (90, 6, 'Barbaza');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (91, 6, 'Belison');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (92, 6, 'Bugasong');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (93, 6, 'Caluya');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (94, 6, 'Culasi');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (95, 6, 'Hamtic');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (96, 6, 'Laua-an');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (97, 6, 'Libertad');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (98, 6, 'Pandan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (99, 6, 'Patnongon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        100,
        6,
        'San Jose de Buenavista†'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (101, 6, 'San Remigio');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (102, 6, 'Sebaste');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (103, 6, 'Sibalom');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (104, 6, 'Tibiao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (105, 6, 'Tobias Fornier');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (106, 6, 'Valderrama');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (107, 7, 'Calanasan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (108, 7, 'Conner†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (109, 7, 'Flora');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (110, 7, 'Kabugao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (111, 7, 'Luna');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (112, 7, 'Pudtol');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (113, 7, 'Santa Marcela');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (114, 8, 'Baler');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (115, 8, 'Casiguran');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (116, 8, 'Dilasag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (117, 8, 'Dinalungan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (118, 8, 'Dingalan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (119, 8, 'Dipaculao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (120, 8, 'Maria Aurora†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (121, 8, 'San Luis');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (122, 9, 'Akbar');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (123, 9, 'Al-Barka');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (124, 9, 'Hadji Mohammad Ajul');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (125, 9, 'Hadji Muhtamad');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (126, 9, 'Isabela†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (127, 9, 'Lamitan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (128, 9, 'Lantawan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (129, 9, 'Maluso');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (130, 9, 'Sumisip');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (131, 9, 'Tabuan-Lasa');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (132, 9, 'Tipo-Tipo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (133, 9, 'Tuburan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (134, 9, 'Ungkaya Pukan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (135, 10, 'Abucay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (136, 10, 'Bagac');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (137, 10, 'Balanga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (138, 10, 'Dinalupihan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (139, 10, 'Hermosa');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (140, 10, 'Limay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (141, 10, 'Mariveles†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (142, 10, 'Morong');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (143, 10, 'Orani');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (144, 10, 'Orion');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (145, 10, 'Pilar');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (146, 10, 'Samal');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (147, 11, 'Basco†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (148, 11, 'Itbayat');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (149, 11, 'Ivana');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (150, 11, 'Mahatao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (151, 11, 'Sabtang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (152, 11, 'Uyugan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (153, 12, 'Agoncillo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (154, 12, 'Alitagtag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (155, 12, 'Balayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (156, 12, 'Balete');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (157, 12, 'Batangas City');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (158, 12, 'Bauan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (159, 12, 'Calaca');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (160, 12, 'Calatagan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (161, 12, 'Cuenca');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (162, 12, 'Ibaan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (163, 12, 'Laurel');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (164, 12, 'Lemery');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (165, 12, 'Lian');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (166, 12, 'Lipa†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (167, 12, 'Lobo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (168, 12, 'Mabini');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (169, 12, 'Malvar');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (170, 12, 'Mataasnakahoy');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (171, 12, 'Nasugbu');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (172, 12, 'Padre Garcia');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (173, 12, 'Rosario');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (174, 12, 'San Jose');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (175, 12, 'San Juan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (176, 12, 'San Luis');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (177, 12, 'San Nicolas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (178, 12, 'San Pascual');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (179, 12, 'Santa Teresita');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (180, 12, 'Santo Tomas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (181, 12, 'Taal');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (182, 12, 'Talisay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (183, 12, 'Tanauan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (184, 12, 'Taysan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (185, 12, 'Tingloy');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (186, 12, 'Tuy');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (187, 13, 'Atok');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (188, 13, 'Baguio');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (189, 13, 'Bakun');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (190, 13, 'Bokod');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (191, 13, 'Buguias');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (192, 13, 'Itogon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (193, 13, 'Kabayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (194, 13, 'Kapangan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (195, 13, 'Kibungan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (196, 13, 'La Trinidad');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (197, 13, 'Mankayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (198, 13, 'Sablan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (199, 13, 'Tuba');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (200, 13, 'Tublay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (201, 14, 'Almeria');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (202, 14, 'Biliran');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (203, 14, 'Cabucgayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (204, 14, 'Caibiran');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (205, 14, 'Culaba');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (206, 14, 'Kawayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (207, 14, 'Maripipi');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (208, 14, 'Naval†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (209, 15, 'Alburquerque');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (210, 15, 'Alicia');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (211, 15, 'Anda');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (212, 15, 'Antequera');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (213, 15, 'Baclayon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (214, 15, 'Balilihan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (215, 15, 'Batuan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (216, 15, 'Bien Unido');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (217, 15, 'Bilar');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (218, 15, 'Buenavista');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (219, 15, 'Calape');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (220, 15, 'Candijay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (221, 15, 'Carmen');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (222, 15, 'Catigbian');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (223, 15, 'Clarin');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (224, 15, 'Corella');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (225, 15, 'Cortes');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (226, 15, 'Dagohoy');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (227, 15, 'Danao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (228, 15, 'Dauis');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (229, 15, 'Dimiao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (230, 15, 'Duero');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (231, 15, 'Garcia Hernandez');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (232, 15, 'Getafe');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (233, 15, 'Guindulman');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (234, 15, 'Inabanga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (235, 15, 'Jagna');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (236, 15, 'Lila');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (237, 15, 'Loay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (238, 15, 'Loboc');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (239, 15, 'Loon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (240, 15, 'Mabini');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (241, 15, 'Maribojoc');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (242, 15, 'Panglao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (243, 15, 'Pilar');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        244,
        15,
        'President Carlos P. Garcia'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (245, 15, 'Sagbayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (246, 15, 'San Isidro');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (247, 15, 'San Miguel');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (248, 15, 'Sevilla');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (249, 15, 'Sierra Bullones');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (250, 15, 'Sikatuna');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (251, 15, 'Tagbilaran†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (252, 15, 'Talibon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (253, 15, 'Trinidad');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (254, 15, 'Tubigon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (255, 15, 'Ubay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (256, 15, 'Valencia');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (257, 16, 'Baungon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (258, 16, 'Cabanglasan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (259, 16, 'Damulog');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (260, 16, 'Dangcagan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (261, 16, 'Don Carlos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (262, 16, 'Impasugong');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (263, 16, 'Kadingilan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (264, 16, 'Kalilangan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (265, 16, 'Kibawe');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (266, 16, 'Kitaotao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (267, 16, 'Lantapan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (268, 16, 'Libona');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (269, 16, 'Malaybalay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (270, 16, 'Malitbog');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (271, 16, 'Manolo Fortich');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (272, 16, 'Maramag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (273, 16, 'Pangantucan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (274, 16, 'Quezon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (275, 16, 'San Fernando');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (276, 16, 'Sumilao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (277, 16, 'Talakag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (278, 16, 'Valencia†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (279, 17, 'Angat');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (280, 17, 'Balagtas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (281, 17, 'Baliwag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (282, 17, 'Bocaue');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (283, 17, 'Bulakan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (284, 17, 'Bustos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (285, 17, 'Calumpit');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        286,
        17,
        'Doña Remedios Trinidad'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (287, 17, 'Guiguinto');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (288, 17, 'Hagonoy');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (289, 17, 'Malolos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (290, 17, 'Marilao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (291, 17, 'Meycauayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (292, 17, 'Norzagaray');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (293, 17, 'Obando');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (294, 17, 'Pandi');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (295, 17, 'Paombong');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (296, 17, 'Plaridel');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (297, 17, 'Pulilan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (298, 17, 'San Ildefonso');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        299,
        17,
        'San Jose del Monte†'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (300, 17, 'San Miguel');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (301, 17, 'San Rafael');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (302, 17, 'Santa Maria');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (303, 18, 'Abulug');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (304, 18, 'Alcala');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (305, 18, 'Allacapan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (306, 18, 'Amulung');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (307, 18, 'Aparri');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (308, 18, 'Baggao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (309, 18, 'Ballesteros');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (310, 18, 'Buguey');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (311, 18, 'Calayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (312, 18, 'Camalaniugan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (313, 18, 'Claveria');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (314, 18, 'Enrile');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (315, 18, 'Gattaran');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (316, 18, 'Gonzaga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (317, 18, 'Iguig');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (318, 18, 'Lal-lo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (319, 18, 'Lasam');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (320, 18, 'Pamplona');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (321, 18, 'Peñablanca');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (322, 18, 'Piat');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (323, 18, 'Rizal');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (324, 18, 'Sanchez-Mira');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (325, 18, 'Santa Ana');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (326, 18, 'Santa Praxedes');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (327, 18, 'Santa Teresita');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (328, 18, 'Santo Niño');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (329, 18, 'Solana');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (330, 18, 'Tuao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (331, 18, 'Tuguegarao†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (332, 19, 'Basud');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (333, 19, 'Capalonga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (334, 19, 'Daet†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (335, 19, 'Jose Panganiban');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (336, 19, 'Labo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (337, 19, 'Mercedes');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (338, 19, 'Paracale');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (339, 19, 'San Lorenzo Ruiz');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (340, 19, 'San Vicente');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (341, 19, 'Santa Elena');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (342, 19, 'Talisay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (343, 19, 'Vinzons');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (344, 20, 'Baao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (345, 20, 'Balatan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (346, 20, 'Bato');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (347, 20, 'Bombon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (348, 20, 'Buhi');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (349, 20, 'Bula');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (350, 20, 'Cabusao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (351, 20, 'Calabanga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (352, 20, 'Camaligan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (353, 20, 'Canaman');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (354, 20, 'Caramoan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (355, 20, 'Del Gallego');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (356, 20, 'Gainza');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (357, 20, 'Garchitorena');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (358, 20, 'Goa');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (359, 20, 'Iriga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (360, 20, 'Lagonoy');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (361, 20, 'Libmanan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (362, 20, 'Lupi');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (363, 20, 'Magarao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (364, 20, 'Milaor');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (365, 20, 'Minalabac');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (366, 20, 'Nabua');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (367, 20, 'Naga†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (368, 20, 'Ocampo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (369, 20, 'Pamplona');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (370, 20, 'Pasacao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (371, 20, 'Pili');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (372, 20, 'Presentacion');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (373, 20, 'Ragay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (374, 20, 'Sagñay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (375, 20, 'San Fernando');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (376, 20, 'San Jose');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (377, 20, 'Sipocot');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (378, 20, 'Siruma');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (379, 20, 'Tigaon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (380, 20, 'Tinambac');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (381, 21, 'Catarman');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (382, 21, 'Guinsiliban');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (383, 21, 'Mahinog');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (384, 21, 'Mambajao†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (385, 21, 'Sagay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (386, 22, 'Cuartero');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (387, 22, 'Dao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (388, 22, 'Dumalag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (389, 22, 'Dumarao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (390, 22, 'Ivisan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (391, 22, 'Jamindan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (392, 22, 'Ma-ayon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (393, 22, 'Mambusao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (394, 22, 'Panay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (395, 22, 'Panitan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (396, 22, 'Pilar');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (397, 22, 'Pontevedra');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (398, 22, 'President Roxas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (399, 22, 'Roxas†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (400, 22, 'Sapian');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (401, 22, 'Sigma');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (402, 22, 'Tapaz');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (403, 23, 'Bagamanoc');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (404, 23, 'Baras');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (405, 23, 'Bato');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (406, 23, 'Caramoran');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (407, 23, 'Gigmoto');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (408, 23, 'Pandan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (409, 23, 'Panganiban');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (410, 23, 'San Andres');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (411, 23, 'San Miguel');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (412, 23, 'Viga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (413, 23, 'Virac†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (414, 24, 'Alfonso');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (415, 24, 'Amadeo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (416, 24, 'Bacoor');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (417, 24, 'Carmona');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (418, 24, 'Cavite City');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (419, 24, 'Dasmariñas†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        420,
        24,
        'General Emilio Aguinaldo'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        421,
        24,
        'General Mariano Alvarez'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (422, 24, 'General Trias');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (423, 24, 'Imus');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (424, 24, 'Indang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (425, 24, 'Kawit');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (426, 24, 'Magallanes');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (427, 24, 'Maragondon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (428, 24, 'Mendez');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (429, 24, 'Naic');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (430, 24, 'Noveleta');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (431, 24, 'Rosario');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (432, 24, 'Silang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (433, 24, 'Tagaytay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (434, 24, 'Tanza');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (435, 24, 'Ternate');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (436, 24, 'Trece Martires');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (437, 25, 'Alcantara');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (438, 25, 'Alcoy');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (439, 25, 'Alegria');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (440, 25, 'Aloguinsan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (441, 25, 'Argao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (442, 25, 'Asturias');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (443, 25, 'Badian');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (444, 25, 'Balamban');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (445, 25, 'Bantayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (446, 25, 'Barili');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (447, 25, 'Bogo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (448, 25, 'Boljoon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (449, 25, 'Borbon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (450, 25, 'Carcar');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (451, 25, 'Carmen');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (452, 25, 'Catmon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (453, 25, 'Cebu City†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (454, 25, 'Compostela');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (455, 25, 'Consolacion');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (456, 25, 'Cordova');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (457, 25, 'Daanbantayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (458, 25, 'Dalaguete');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (459, 25, 'Danao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (460, 25, 'Dumanjug');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (461, 25, 'Ginatilan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (462, 25, 'Lapu-Lapu');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (463, 25, 'Liloan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (464, 25, 'Madridejos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (465, 25, 'Malabuyoc');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (466, 25, 'Mandaue');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (467, 25, 'Medellin');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (468, 25, 'Minglanilla');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (469, 25, 'Moalboal');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (470, 25, 'Naga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (471, 25, 'Oslob');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (472, 25, 'Pilar');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (473, 25, 'Pinamungajan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (474, 25, 'Poro');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (475, 25, 'Ronda');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (476, 25, 'Samboan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (477, 25, 'San Fernando');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (478, 25, 'San Francisco');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (479, 25, 'San Remigio');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (480, 25, 'Santa Fe');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (481, 25, 'Santander');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (482, 25, 'Sibonga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (483, 25, 'Sogod');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (484, 25, 'Tabogon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (485, 25, 'Tabuelan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (486, 25, 'Talisay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (487, 25, 'Toledo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (488, 25, 'Tuburan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (489, 25, 'Tudela');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (490, 26, 'Alamada');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (491, 26, 'Aleosan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (492, 26, 'Antipas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (493, 26, 'Arakan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (494, 26, 'Banisilan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (495, 26, 'Carmen');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (496, 26, 'Kabacan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (497, 26, 'Kadayangan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (498, 26, 'Kapalawan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (499, 26, 'Kidapawan†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (500, 26, 'Libungan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (501, 26, 'Ligawasan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (502, 26, 'M''lang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (503, 26, 'Magpet');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (504, 26, 'Makilala');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (505, 26, 'Malidegao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (506, 26, 'Matalam');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (507, 26, 'Midsayap');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (508, 26, 'Nabalawag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (509, 26, 'Old Kaabakan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (510, 26, 'Pahamuddin');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (511, 26, 'Pigcawayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (512, 26, 'Pikit');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (513, 26, 'President Roxas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (514, 26, 'Tugunan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (515, 26, 'Tulunan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (516, 27, 'Compostela');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (517, 27, 'Laak');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (518, 27, 'Mabini');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (519, 27, 'Maco');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (520, 27, 'Maragusan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (521, 27, 'Mawab');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (522, 27, 'Monkayo†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (523, 27, 'Montevista');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (524, 27, 'Nabunturan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (525, 27, 'New Bataan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (526, 27, 'Pantukan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (527, 28, 'Asuncion');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (528, 28, 'Braulio E. Dujali');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (529, 28, 'Carmen');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (530, 28, 'Kapalong');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (531, 28, 'New Corella');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (532, 28, 'Panabo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (533, 28, 'Samal');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (534, 28, 'Santo Tomas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (535, 28, 'Sawata');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (536, 28, 'Tagum†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (537, 28, 'Talaingod');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (538, 29, 'Bansalan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (539, 29, 'Davao City†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (540, 29, 'Digos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (541, 29, 'Hagonoy');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (542, 29, 'Kiblawan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (543, 29, 'Magsaysay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (544, 29, 'Malalag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (545, 29, 'Matanao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (546, 29, 'Padada');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (547, 29, 'Santa Cruz');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (548, 29, 'Sulop');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (549, 30, 'Don Marcelino');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (550, 30, 'Jose Abad Santos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (551, 30, 'Malita†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (552, 30, 'Santa Maria');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (553, 30, 'Sarangani');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (554, 31, 'Baganga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (555, 31, 'Banaybanay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (556, 31, 'Boston');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (557, 31, 'Caraga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (558, 31, 'Cateel');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (559, 31, 'Governor Generoso');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (560, 31, 'Lupon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (561, 31, 'Manay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (562, 31, 'Mati†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (563, 31, 'San Isidro');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (564, 31, 'Tarragona');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (565, 32, 'Basilisa†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (566, 32, 'Cagdianao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (567, 32, 'Dinagat');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (568, 32, 'Libjo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (569, 32, 'Loreto');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (570, 32, 'San Jose');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (571, 32, 'Tubajon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (572, 33, 'Arteche');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (573, 33, 'Balangiga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (574, 33, 'Balangkayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (575, 33, 'Borongan†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (576, 33, 'Can-avid');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (577, 33, 'Dolores');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (578, 33, 'General MacArthur');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (579, 33, 'Giporlos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (580, 33, 'Guiuan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (581, 33, 'Hernani');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (582, 33, 'Jipapad');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (583, 33, 'Lawaan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (584, 33, 'Llorente');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (585, 33, 'Maslog');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (586, 33, 'Maydolong');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (587, 33, 'Mercedes');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (588, 33, 'Oras');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (589, 33, 'Quinapondan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (590, 33, 'Salcedo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (591, 33, 'San Julian');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (592, 33, 'San Policarpo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (593, 33, 'Sulat');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (594, 33, 'Taft');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (595, 34, 'Buenavista†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (596, 34, 'Jordan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (597, 34, 'Nueva Valencia');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (598, 34, 'San Lorenzo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (599, 34, 'Sibunag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (600, 35, 'Aguinaldo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (601, 35, 'Alfonso Lista†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (602, 35, 'Asipulo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (603, 35, 'Banaue');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (604, 35, 'Hingyon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (605, 35, 'Hungduan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (606, 35, 'Kiangan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (607, 35, 'Lagawe');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (608, 35, 'Lamut');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (609, 35, 'Mayoyao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (610, 35, 'Tinoc');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (611, 36, 'Adams');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (612, 36, 'Bacarra');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (613, 36, 'Badoc');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (614, 36, 'Bangui');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (615, 36, 'Banna');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (616, 36, 'Batac');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (617, 36, 'Burgos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (618, 36, 'Carasi');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (619, 36, 'Currimao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (620, 36, 'Dingras');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (621, 36, 'Dumalneg');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (622, 36, 'Laoag†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (623, 36, 'Marcos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (624, 36, 'Nueva Era');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (625, 36, 'Pagudpud');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (626, 36, 'Paoay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (627, 36, 'Pasuquin');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (628, 36, 'Piddig');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (629, 36, 'Pinili');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (630, 36, 'San Nicolas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (631, 36, 'Sarrat');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (632, 36, 'Solsona');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (633, 36, 'Vintar');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (634, 37, 'Alilem');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (635, 37, 'Banayoyo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (636, 37, 'Bantay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (637, 37, 'Burgos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (638, 37, 'Cabugao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (639, 37, 'Candon†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (640, 37, 'Caoayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (641, 37, 'Cervantes');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (642, 37, 'Galimuyod');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (643, 37, 'Gregorio del Pilar');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (644, 37, 'Lidlidda');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (645, 37, 'Magsingal');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (646, 37, 'Nagbukel');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (647, 37, 'Narvacan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (648, 37, 'Quirino');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (649, 37, 'Salcedo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (650, 37, 'San Emilio');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (651, 37, 'San Esteban');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (652, 37, 'San Ildefonso');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (653, 37, 'San Juan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (654, 37, 'San Vicente');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (655, 37, 'Santa Catalina');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (656, 37, 'Santa Cruz');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (657, 37, 'Santa Lucia');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (658, 37, 'Santa Maria');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (659, 37, 'Santa');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (660, 37, 'Santiago');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (661, 37, 'Santo Domingo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (662, 37, 'Sigay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (663, 37, 'Sinait');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (664, 37, 'Sugpon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (665, 37, 'Suyo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (666, 37, 'Tagudin');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (667, 37, 'Vigan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (668, 38, 'Ajuy');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (669, 38, 'Alimodian');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (670, 38, 'Anilao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (671, 38, 'Badiangan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (672, 38, 'Balasan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (673, 38, 'Banate');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (674, 38, 'Barotac Nuevo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (675, 38, 'Barotac Viejo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (676, 38, 'Batad');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (677, 38, 'Bingawan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (678, 38, 'Cabatuan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (679, 38, 'Calinog');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (680, 38, 'Carles');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (681, 38, 'Concepcion');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (682, 38, 'Dingle');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (683, 38, 'Dueñas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (684, 38, 'Dumangas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (685, 38, 'Estancia');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (686, 38, 'Guimbal');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (687, 38, 'Igbaras');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (688, 38, 'Iloilo City†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (689, 38, 'Janiuay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (690, 38, 'Lambunao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (691, 38, 'Leganes');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (692, 38, 'Lemery');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (693, 38, 'Leon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (694, 38, 'Maasin');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (695, 38, 'Miagao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (696, 38, 'Mina');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (697, 38, 'New Lucena');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (698, 38, 'Oton');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (699, 38, 'Passi');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (700, 38, 'Pavia');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (701, 38, 'Pototan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (702, 38, 'San Dionisio');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (703, 38, 'San Enrique');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (704, 38, 'San Joaquin');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (705, 38, 'San Miguel');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (706, 38, 'San Rafael');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (707, 38, 'Santa Barbara');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (708, 38, 'Sara');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (709, 38, 'Tigbauan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (710, 38, 'Tubungan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (711, 38, 'Zarraga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (712, 39, 'Alicia');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (713, 39, 'Angadanan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (714, 39, 'Aurora');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (715, 39, 'Benito Soliven');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (716, 39, 'Burgos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (717, 39, 'Cabagan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (718, 39, 'Cabatuan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (719, 39, 'Cauayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (720, 39, 'Cordon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (721, 39, 'Delfin Albano');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (722, 39, 'Dinapigue');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (723, 39, 'Divilacan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (724, 39, 'Echague');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (725, 39, 'Gamu');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (726, 39, 'Ilagan†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (727, 39, 'Jones');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (728, 39, 'Luna');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (729, 39, 'Maconacon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (730, 39, 'Mallig');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (731, 39, 'Naguilian');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (732, 39, 'Palanan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (733, 39, 'Quezon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (734, 39, 'Quirino');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (735, 39, 'Ramon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (736, 39, 'Reina Mercedes');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (737, 39, 'Roxas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (738, 39, 'San Agustin');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (739, 39, 'San Guillermo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (740, 39, 'San Isidro');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (741, 39, 'San Manuel');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (742, 39, 'San Mariano');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (743, 39, 'San Mateo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (744, 39, 'San Pablo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (745, 39, 'Santa Maria');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (746, 39, 'Santiago');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (747, 39, 'Santo Tomas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (748, 39, 'Tumauini');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (749, 40, 'Balbalan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (750, 40, 'Lubuagan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (751, 40, 'Pasil');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (752, 40, 'Pinukpuk');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (753, 40, 'Rizal');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (754, 40, 'Tabuk†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (755, 40, 'Tanudan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (756, 40, 'Tinglayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (757, 41, 'Agoo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (758, 41, 'Aringay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (759, 41, 'Bacnotan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (760, 41, 'Bagulin');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (761, 41, 'Balaoan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (762, 41, 'Bangar');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (763, 41, 'Bauang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (764, 41, 'Burgos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (765, 41, 'Caba');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (766, 41, 'Luna');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (767, 41, 'Naguilian');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (768, 41, 'Pugo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (769, 41, 'Rosario');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (770, 41, 'San Fernando†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (771, 41, 'San Gabriel');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (772, 41, 'San Juan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (773, 41, 'Santo Tomas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (774, 41, 'Santol');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (775, 41, 'Sudipen');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (776, 41, 'Tubao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (777, 42, 'Alaminos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (778, 42, 'Bay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (779, 42, 'Biñan†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (780, 42, 'Cabuyao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (781, 42, 'Calamba');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (782, 42, 'Calauan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (783, 42, 'Cavinti');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (784, 42, 'Famy');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (785, 42, 'Kalayaan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (786, 42, 'Liliw');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (787, 42, 'Los Baños');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (788, 42, 'Luisiana');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (789, 42, 'Lumban');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (790, 42, 'Mabitac');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (791, 42, 'Magdalena');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (792, 42, 'Majayjay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (793, 42, 'Nagcarlan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (794, 42, 'Paete');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (795, 42, 'Pagsanjan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (796, 42, 'Pakil');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (797, 42, 'Pangil');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (798, 42, 'Pila');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (799, 42, 'Rizal');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (800, 42, 'San Pablo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (801, 42, 'San Pedro');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (802, 42, 'Santa Cruz');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (803, 42, 'Santa Maria');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (804, 42, 'Santa Rosa');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (805, 42, 'Siniloan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (806, 42, 'Victoria');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (807, 43, 'Bacolod');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (808, 43, 'Balo-i');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (809, 43, 'Baroy');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (810, 43, 'Iligan†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (811, 43, 'Kapatagan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (812, 43, 'Kauswagan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (813, 43, 'Kolambugan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (814, 43, 'Lala');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (815, 43, 'Linamon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (816, 43, 'Magsaysay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (817, 43, 'Maigo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (818, 43, 'Matungao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (819, 43, 'Munai');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (820, 43, 'Nunungan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (821, 43, 'Pantao Ragat');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (822, 43, 'Pantar');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (823, 43, 'Poona Piagapo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (824, 43, 'Salvador');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (825, 43, 'Sapad');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        826,
        43,
        'Sultan Naga Dimaporo'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (827, 43, 'Tagoloan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (828, 43, 'Tangcal');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (829, 43, 'Tubod');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (830, 44, 'Amai Manabilang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (831, 44, 'Bacolod-Kalawi');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (832, 44, 'Balabagan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (833, 44, 'Balindong');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (834, 44, 'Bayang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (835, 44, 'Binidayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (836, 44, 'Buadiposo-Buntong');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (837, 44, 'Bubong');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (838, 44, 'Butig');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (839, 44, 'Calanogas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (840, 44, 'Ditsaan-Ramain');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (841, 44, 'Ganassi');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (842, 44, 'Kapai');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (843, 44, 'Kapatagan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (844, 44, 'Lumba-Bayabao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (845, 44, 'Lumbaca-Unayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (846, 44, 'Lumbatan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (847, 44, 'Lumbayanague');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (848, 44, 'Madalum');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (849, 44, 'Madamba');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (850, 44, 'Maguing');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (851, 44, 'Malabang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (852, 44, 'Marantao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (853, 44, 'Marawi†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (854, 44, 'Marogong');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (855, 44, 'Masiu');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (856, 44, 'Mulondo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (857, 44, 'Pagayawan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (858, 44, 'Piagapo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (859, 44, 'Picong');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (860, 44, 'Poona Bayabao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (861, 44, 'Pualas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (862, 44, 'Saguiaran');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (863, 44, 'Sultan Dumalondong');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (864, 44, 'Tagoloan II');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (865, 44, 'Tamparan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (866, 44, 'Taraka');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (867, 44, 'Tubaran');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (868, 44, 'Tugaya');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (869, 44, 'Wao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (870, 45, 'Abuyog');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (871, 45, 'Alangalang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (872, 45, 'Albuera');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (873, 45, 'Babatngon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (874, 45, 'Barugo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (875, 45, 'Bato');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (876, 45, 'Baybay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (877, 45, 'Burauen');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (878, 45, 'Calubian');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (879, 45, 'Capoocan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (880, 45, 'Carigara');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (881, 45, 'Dagami');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (882, 45, 'Dulag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (883, 45, 'Hilongos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (884, 45, 'Hindang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (885, 45, 'Inopacan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (886, 45, 'Isabel');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (887, 45, 'Jaro');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (888, 45, 'Javier');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (889, 45, 'Julita');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (890, 45, 'Kananga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (891, 45, 'La Paz');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (892, 45, 'Leyte');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (893, 45, 'MacArthur');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (894, 45, 'Mahaplag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (895, 45, 'Matag-ob');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (896, 45, 'Matalom');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (897, 45, 'Mayorga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (898, 45, 'Merida');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (899, 45, 'Ormoc');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (900, 45, 'Palo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (901, 45, 'Palompon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (902, 45, 'Pastrana');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (903, 45, 'San Isidro');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (904, 45, 'San Miguel');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (905, 45, 'Santa Fe');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (906, 45, 'Tabango');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (907, 45, 'Tabontabon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (908, 45, 'Tacloban†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (909, 45, 'Tanauan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (910, 45, 'Tolosa');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (911, 45, 'Tunga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (912, 45, 'Villaba');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (913, 46, 'Barira');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (914, 46, 'Buldon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (915, 46, 'Cotabato City†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        916,
        46,
        'Datu Blah T. Sinsuat'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (917, 46, 'Datu Odin Sinsuat');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (918, 46, 'Kabuntalan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (919, 46, 'Matanog');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        920,
        46,
        'Northern Kabuntalan'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (921, 46, 'Parang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (922, 46, 'Sultan Kudarat');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (923, 46, 'Sultan Mastura');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (924, 46, 'Talitay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (925, 46, 'Upi');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (926, 47, 'Ampatuan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (927, 47, 'Buluan†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        928,
        47,
        'Datu Abdullah Sangki'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        929,
        47,
        'Datu Anggal Midtimbang'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        930,
        47,
        'Datu Hoffer Ampatuan'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (931, 47, 'Datu Montawal');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (932, 47, 'Datu Paglas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (933, 47, 'Datu Piang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (934, 47, 'Datu Salibo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        935,
        47,
        'Datu Saudi Ampatuan'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (936, 47, 'Datu Unsay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        937,
        47,
        'General Salipada K. Pendatun'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (938, 47, 'Guindulungan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (939, 47, 'Mamasapano');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (940, 47, 'Mangudadatu');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (941, 47, 'Pagalungan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (942, 47, 'Paglat');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (943, 47, 'Pandag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (944, 47, 'Rajah Buayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (945, 47, 'Shariff Aguak');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        946,
        47,
        'Shariff Saydona Mustapha'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (947, 47, 'South Upi');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (948, 47, 'Sultan sa Barongis');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (949, 47, 'Talayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (950, 48, 'Boac†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (951, 48, 'Buenavista');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (952, 48, 'Gasan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (953, 48, 'Mogpog');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (954, 48, 'Santa Cruz');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (955, 48, 'Torrijos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (956, 49, 'Aroroy');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (957, 49, 'Baleno');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (958, 49, 'Balud');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (959, 49, 'Batuan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (960, 49, 'Cataingan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (961, 49, 'Cawayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (962, 49, 'Claveria');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (963, 49, 'Dimasalang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (964, 49, 'Esperanza');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (965, 49, 'Mandaon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (966, 49, 'Masbate City†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (967, 49, 'Milagros');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (968, 49, 'Mobo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (969, 49, 'Monreal');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (970, 49, 'Palanas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (971, 49, 'Pio V. Corpus');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (972, 49, 'Placer');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (973, 49, 'San Fernando');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (974, 49, 'San Jacinto');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (975, 49, 'San Pascual');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (976, 49, 'Uson');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (977, 83, 'Caloocan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (978, 83, 'Las Piñas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (979, 83, 'Makati');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (980, 83, 'Malabon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (981, 83, 'Mandaluyong');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (982, 83, 'Manila');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (983, 83, 'Marikina');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (984, 83, 'Muntinlupa');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (985, 83, 'Navotas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (986, 83, 'Parañaque');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (987, 83, 'Pasay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (988, 83, 'Pasig');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (989, 83, 'Pateros');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (990, 83, 'Quezon City‡');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (991, 83, 'San Juan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (992, 83, 'Taguig');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (993, 83, 'Valenzuela');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (994, 50, 'Aloran');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (995, 50, 'Baliangao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (996, 50, 'Bonifacio');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (997, 50, 'Calamba');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (998, 50, 'Clarin');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (999, 50, 'Concepcion');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1000, 50, 'Don Victoriano');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1001, 50, 'Jimenez');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1002, 50, 'Lopez Jaena');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1003, 50, 'Oroquieta');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1004, 50, 'Ozamiz†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1005, 50, 'Panaon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1006, 50, 'Plaridel');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1007, 50, 'Sapang Dalaga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1008, 50, 'Sinacaban');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1009, 50, 'Tangub');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1010, 50, 'Tudela');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1011, 51, 'Alubijid');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1012, 51, 'Balingasag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1013, 51, 'Balingoan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1014, 51, 'Binuangan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1015, 51, 'Cagayan de Oro†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1016, 51, 'Claveria');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1017, 51, 'El Salvador');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1018, 51, 'Gingoog');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1019, 51, 'Gitagum');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1020, 51, 'Initao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1021, 51, 'Jasaan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1022, 51, 'Kinoguitan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1023, 51, 'Lagonglong');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1024, 51, 'Laguindingan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1025, 51, 'Libertad');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1026, 51, 'Lugait');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1027, 51, 'Magsaysay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1028, 51, 'Manticao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1029, 51, 'Medina');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1030, 51, 'Naawan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1031, 51, 'Opol');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1032, 51, 'Salay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1033, 51, 'Sugbongcogon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1034, 51, 'Tagoloan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1035, 51, 'Talisayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1036, 51, 'Villanueva');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1037, 52, 'Barlig');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1038, 52, 'Bauko†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1039, 52, 'Besao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1040, 52, 'Bontoc');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1041, 52, 'Natonin');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1042, 52, 'Paracelis');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1043, 52, 'Sabangan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1044, 52, 'Sadanga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1045, 52, 'Sagada');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1046, 52, 'Tadian');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1047, 53, 'Bacolod†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1048, 53, 'Bago');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1049, 53, 'Binalbagan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1050, 53, 'Cadiz');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1051, 53, 'Calatrava');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1052, 53, 'Candoni');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1053, 53, 'Cauayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        1054,
        53,
        'Don Salvador Benedicto'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        1055,
        53,
        'Enrique B. Magalona'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1056, 53, 'Escalante');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1057, 53, 'Himamaylan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1058, 53, 'Hinigaran');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1059, 53, 'Hinoba-an');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1060, 53, 'Ilog');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1061, 53, 'Isabela');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1062, 53, 'Kabankalan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1063, 53, 'La Carlota');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1064, 53, 'La Castellana');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1065, 53, 'Manapla');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1066, 53, 'Moises Padilla');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1067, 53, 'Murcia');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1068, 53, 'Pontevedra');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1069, 53, 'Pulupandan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1070, 53, 'Sagay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1071, 53, 'San Carlos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1072, 53, 'San Enrique');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1073, 53, 'Silay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1074, 53, 'Sipalay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1075, 53, 'Talisay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1076, 53, 'Toboso');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1077, 53, 'Valladolid');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1078, 53, 'Victorias');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1079, 54, 'Amlan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1080, 54, 'Ayungon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1081, 54, 'Bacong');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1082, 54, 'Bais');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1083, 54, 'Basay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1084, 54, 'Bayawan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1085, 54, 'Bindoy');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1086, 54, 'Canlaon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1087, 54, 'Dauin');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1088, 54, 'Dumaguete†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1089, 54, 'Guihulngan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1090, 54, 'Jimalalud');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1091, 54, 'La Libertad');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1092, 54, 'Mabinay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1093, 54, 'Manjuyod');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1094, 54, 'Pamplona');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1095, 54, 'San Jose');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1096, 54, 'Santa Catalina');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1097, 54, 'Siaton');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1098, 54, 'Sibulan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1099, 54, 'Tanjay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1100, 54, 'Tayasan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1101, 54, 'Valencia');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1102, 54, 'Vallehermoso');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1103, 54, 'Zamboanguita');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1104, 55, 'Allen');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1105, 55, 'Biri');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1106, 55, 'Bobon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1107, 55, 'Capul');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1108, 55, 'Catarman†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1109, 55, 'Catubig');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1110, 55, 'Gamay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1111, 55, 'Laoang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1112, 55, 'Lapinig');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1113, 55, 'Las Navas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1114, 55, 'Lavezares');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1115, 55, 'Lope de Vega');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1116, 55, 'Mapanas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1117, 55, 'Mondragon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1118, 55, 'Palapag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1119, 55, 'Pambujan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1120, 55, 'Rosario');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1121, 55, 'San Antonio');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1122, 55, 'San Isidro');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1123, 55, 'San Jose');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1124, 55, 'San Roque');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1125, 55, 'San Vicente');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1126, 55, 'Silvino Lobos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1127, 55, 'Victoria');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1128, 56, 'Aliaga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1129, 56, 'Bongabon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1130, 56, 'Cabanatuan†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1131, 56, 'Cabiao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1132, 56, 'Carranglan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1133, 56, 'Cuyapo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1134, 56, 'Gabaldon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1135, 56, 'Gapan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        1136,
        56,
        'General Mamerto Natividad'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1137, 56, 'General Tinio');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1138, 56, 'Guimba');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1139, 56, 'Jaen');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1140, 56, 'Laur');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1141, 56, 'Licab');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1142, 56, 'Llanera');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1143, 56, 'Lupao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1144, 56, 'Muñoz');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1145, 56, 'Nampicuan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1146, 56, 'Palayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1147, 56, 'Pantabangan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1148, 56, 'Peñaranda');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1149, 56, 'Quezon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1150, 56, 'Rizal');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1151, 56, 'San Antonio');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1152, 56, 'San Isidro');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1153, 56, 'San Jose');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1154, 56, 'San Leonardo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1155, 56, 'Santa Rosa');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1156, 56, 'Santo Domingo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1157, 56, 'Talavera');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1158, 56, 'Talugtug');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1159, 56, 'Zaragoza');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1160, 57, 'Alfonso Castañeda');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1161, 57, 'Ambaguio');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1162, 57, 'Aritao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1163, 57, 'Bagabag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1164, 57, 'Bambang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1165, 57, 'Bayombong†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1166, 57, 'Diadi');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1167, 57, 'Dupax del Norte');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1168, 57, 'Dupax del Sur');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1169, 57, 'Kasibu');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1170, 57, 'Kayapa');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1171, 57, 'Quezon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1172, 57, 'Santa Fe');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1173, 57, 'Solano');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1174, 57, 'Villaverde');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1175, 58, 'Abra de Ilog');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1176, 58, 'Calintaan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1177, 58, 'Looc');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1178, 58, 'Lubang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1179, 58, 'Magsaysay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1180, 58, 'Mamburao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1181, 58, 'Paluan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1182, 58, 'Rizal');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1183, 58, 'Sablayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1184, 58, 'San Jose†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1185, 58, 'Santa Cruz');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1186, 59, 'Baco');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1187, 59, 'Bansud');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1188, 59, 'Bongabong');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1189, 59, 'Bulalacao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1190, 59, 'Calapan†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1191, 59, 'Gloria');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1192, 59, 'Mansalay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1193, 59, 'Naujan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1194, 59, 'Pinamalayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1195, 59, 'Pola');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1196, 59, 'Puerto Galera');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1197, 59, 'Roxas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1198, 59, 'San Teodoro');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1199, 59, 'Socorro');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1200, 59, 'Victoria');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1201, 60, 'Aborlan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1202, 60, 'Agutaya');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1203, 60, 'Araceli');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1204, 60, 'Balabac');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1205, 60, 'Bataraza');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1206, 60, 'Brooke''s Point');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1207, 60, 'Busuanga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1208, 60, 'Cagayancillo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1209, 60, 'Coron');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1210, 60, 'Culion');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1211, 60, 'Cuyo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1212, 60, 'Dumaran');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1213, 60, 'El Nido');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1214, 60, 'Kalayaan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1215, 60, 'Linapacan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1216, 60, 'Magsaysay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1217, 60, 'Narra');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1218, 60, 'Puerto Princesa†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1219, 60, 'Quezon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1220, 60, 'Rizal');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1221, 60, 'Roxas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1222, 60, 'San Vicente');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1223, 60, 'Sofronio Española');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1224, 60, 'Taytay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1225, 61, 'Angeles†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1226, 61, 'Apalit');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1227, 61, 'Arayat');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1228, 61, 'Bacolor');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1229, 61, 'Candaba');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1230, 61, 'Floridablanca');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1231, 61, 'Guagua');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1232, 61, 'Lubao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1233, 61, 'Mabalacat');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1234, 61, 'Macabebe');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1235, 61, 'Magalang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1236, 61, 'Masantol');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1237, 61, 'Mexico');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1238, 61, 'Minalin');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1239, 61, 'Porac');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1240, 61, 'San Fernando');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1241, 61, 'San Luis');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1242, 61, 'San Simon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1243, 61, 'Santa Ana');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1244, 61, 'Santa Rita');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1245, 61, 'Santo Tomas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1246, 61, 'Sasmuan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1247, 62, 'Agno');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1248, 62, 'Aguilar');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1249, 62, 'Alaminos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1250, 62, 'Alcala');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1251, 62, 'Anda');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1252, 62, 'Asingan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1253, 62, 'Balungao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1254, 62, 'Bani');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1255, 62, 'Basista');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1256, 62, 'Bautista');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1257, 62, 'Bayambang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1258, 62, 'Binalonan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1259, 62, 'Binmaley');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1260, 62, 'Bolinao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1261, 62, 'Bugallon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1262, 62, 'Burgos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1263, 62, 'Calasiao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1264, 62, 'Dagupan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1265, 62, 'Dasol');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1266, 62, 'Infanta');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1267, 62, 'Labrador');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1268, 62, 'Laoac');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1269, 62, 'Lingayen');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1270, 62, 'Mabini');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1271, 62, 'Malasiqui');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1272, 62, 'Manaoag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1273, 62, 'Mangaldan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1274, 62, 'Mangatarem');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1275, 62, 'Mapandan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1276, 62, 'Natividad');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1277, 62, 'Pozorrubio');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1278, 62, 'Rosales');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1279, 62, 'San Carlos†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1280, 62, 'San Fabian');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1281, 62, 'San Jacinto');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1282, 62, 'San Manuel');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1283, 62, 'San Nicolas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1284, 62, 'San Quintin');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1285, 62, 'Santa Barbara');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1286, 62, 'Santa Maria');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1287, 62, 'Santo Tomas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1288, 62, 'Sison');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1289, 62, 'Sual');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1290, 62, 'Tayug');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1291, 62, 'Umingan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1292, 62, 'Urbiztondo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1293, 62, 'Urdaneta');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1294, 62, 'Villasis');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1295, 63, 'Agdangan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1296, 63, 'Alabat');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1297, 63, 'Atimonan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1298, 63, 'Buenavista');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1299, 63, 'Burdeos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1300, 63, 'Calauag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1301, 63, 'Candelaria');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1302, 63, 'Catanauan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1303, 63, 'Dolores');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1304, 63, 'General Luna');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1305, 63, 'General Nakar');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1306, 63, 'Guinayangan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1307, 63, 'Gumaca');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1308, 63, 'Infanta');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1309, 63, 'Jomalig');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1310, 63, 'Lopez');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1311, 63, 'Lucban');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1312, 63, 'Lucena†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1313, 63, 'Macalelon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1314, 63, 'Mauban');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1315, 63, 'Mulanay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1316, 63, 'Padre Burgos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1317, 63, 'Pagbilao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1318, 63, 'Panukulan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1319, 63, 'Patnanungan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1320, 63, 'Perez');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1321, 63, 'Pitogo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1322, 63, 'Plaridel');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1323, 63, 'Polillo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1324, 63, 'Quezon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1325, 63, 'Real');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1326, 63, 'Sampaloc');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1327, 63, 'San Andres');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1328, 63, 'San Antonio');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1329, 63, 'San Francisco');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1330, 63, 'San Narciso');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1331, 63, 'Sariaya');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1332, 63, 'Tagkawayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1333, 63, 'Tayabas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1334, 63, 'Tiaong');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1335, 63, 'Unisan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1336, 64, 'Aglipay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1337, 64, 'Cabarroguis');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1338, 64, 'Diffun†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1339, 64, 'Maddela');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1340, 64, 'Nagtipunan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1341, 64, 'Saguday');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1342, 65, 'Angono');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1343, 65, 'Antipolo†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1344, 65, 'Baras');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1345, 65, 'Binangonan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1346, 65, 'Cainta');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1347, 65, 'Cardona');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1348, 65, 'Jalajala');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1349, 65, 'Morong');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1350, 65, 'Pililla');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1351, 65, 'Rodriguez');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1352, 65, 'San Mateo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1353, 65, 'Tanay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1354, 65, 'Taytay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1355, 65, 'Teresa');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1356, 66, 'Alcantara');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1357, 66, 'Banton');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1358, 66, 'Cajidiocan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1359, 66, 'Calatrava');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1360, 66, 'Concepcion');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1361, 66, 'Corcuera');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1362, 66, 'Ferrol');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1363, 66, 'Looc');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1364, 66, 'Magdiwang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1365, 66, 'Odiongan†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1366, 66, 'Romblon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1367, 66, 'San Agustin');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1368, 66, 'San Andres');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1369, 66, 'San Fernando');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1370, 66, 'San Jose');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1371, 66, 'Santa Fe');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1372, 66, 'Santa Maria');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1373, 67, 'Almagro');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1374, 67, 'Basey');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1375, 67, 'Calbayog†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1376, 67, 'Calbiga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1377, 67, 'Catbalogan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1378, 67, 'Daram');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1379, 67, 'Gandara');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1380, 67, 'Hinabangan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1381, 67, 'Jiabong');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1382, 67, 'Marabut');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1383, 67, 'Matuguinao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1384, 67, 'Motiong');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1385, 67, 'Pagsanghan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1386, 67, 'Paranas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1387, 67, 'Pinabacdao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1388, 67, 'San Jorge');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1389, 67, 'San Jose de Buan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1390, 67, 'San Sebastian');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1391, 67, 'Santa Margarita');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1392, 67, 'Santa Rita');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1393, 67, 'Santo Niño');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1394, 67, 'Tagapul-an');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1395, 67, 'Talalora');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1396, 67, 'Tarangnan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1397, 67, 'Villareal');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1398, 67, 'Zumarraga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1399, 68, 'Alabel');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1400, 68, 'Glan†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1401, 68, 'Kiamba');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1402, 68, 'Maasim');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1403, 68, 'Maitum');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1404, 68, 'Malapatan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1405, 68, 'Malungon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        1406,
        69,
        'Enrique Villanueva'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1407, 69, 'Larena');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1408, 69, 'Lazi');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1409, 69, 'Maria');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1410, 69, 'San Juan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1411, 69, 'Siquijor†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1412, 70, 'Barcelona');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1413, 70, 'Bulan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1414, 70, 'Bulusan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1415, 70, 'Casiguran');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1416, 70, 'Castilla');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1417, 70, 'Donsol');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1418, 70, 'Gubat');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1419, 70, 'Irosin');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1420, 70, 'Juban');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1421, 70, 'Magallanes');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1422, 70, 'Matnog');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1423, 70, 'Pilar');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1424, 70, 'Prieto Diaz');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1425, 70, 'Santa Magdalena');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1426, 70, 'Sorsogon City†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1427, 71, 'Banga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1428, 71, 'General Santos†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1429, 71, 'Koronadal');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1430, 71, 'Lake Sebu');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1431, 71, 'Norala');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1432, 71, 'Polomolok');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1433, 71, 'Santo Niño');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1434, 71, 'Surallah');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1435, 71, 'T''Boli');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1436, 71, 'Tampakan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1437, 71, 'Tantangan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1438, 71, 'Tupi');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1439, 72, 'Anahawan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1440, 72, 'Bontoc');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1441, 72, 'Hinunangan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1442, 72, 'Hinundayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1443, 72, 'Libagon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1444, 72, 'Liloan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1445, 72, 'Limasawa');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1446, 72, 'Maasin†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1447, 72, 'Macrohon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1448, 72, 'Malitbog');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1449, 72, 'Padre Burgos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1450, 72, 'Pintuyan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1451, 72, 'Saint Bernard');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1452, 72, 'San Francisco');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1453, 72, 'San Juan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1454, 72, 'San Ricardo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1455, 72, 'Silago');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1456, 72, 'Sogod');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1457, 72, 'Tomas Oppus');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1458, 73, 'Bagumbayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1459, 73, 'Columbio');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1460, 73, 'Esperanza');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1461, 73, 'Isulan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1462, 73, 'Kalamansig');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1463, 73, 'Lambayong');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1464, 73, 'Lebak');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1465, 73, 'Lutayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1466, 73, 'Palimbang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1467, 73, 'President Quirino');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        1468,
        73,
        'Senator Ninoy Aquino'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1469, 73, 'Tacurong†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1470, 74, 'Banguingui');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        1471,
        74,
        'Hadji Panglima Tahil'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1472, 74, 'Indanan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1473, 74, 'Jolo†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (
        1474,
        74,
        'Kalingalan Caluang'
    );

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1475, 74, 'Lugus');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1476, 74, 'Luuk');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1477, 74, 'Maimbung');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1478, 74, 'Omar');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1479, 74, 'Panamao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1480, 74, 'Pandami');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1481, 74, 'Panglima Estino');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1482, 74, 'Pangutaran');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1483, 74, 'Parang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1484, 74, 'Pata');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1485, 74, 'Patikul');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1486, 74, 'Siasi');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1487, 74, 'Talipao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1488, 74, 'Tapul');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1489, 75, 'Alegria');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1490, 75, 'Bacuag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1491, 75, 'Burgos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1492, 75, 'Claver');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1493, 75, 'Dapa');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1494, 75, 'Del Carmen');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1495, 75, 'General Luna');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1496, 75, 'Gigaquit');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1497, 75, 'Mainit');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1498, 75, 'Malimono');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1499, 75, 'Pilar');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1500, 75, 'Placer');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1501, 75, 'San Benito');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1502, 75, 'San Francisco');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1503, 75, 'San Isidro');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1504, 75, 'Santa Monica');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1505, 75, 'Sison');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1506, 75, 'Socorro');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1507, 75, 'Surigao City†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1508, 75, 'Tagana-an');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1509, 75, 'Tubod');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1510, 76, 'Barobo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1511, 76, 'Bayabas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1512, 76, 'Bislig†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1513, 76, 'Cagwait');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1514, 76, 'Cantilan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1515, 76, 'Carmen');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1516, 76, 'Carrascal');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1517, 76, 'Cortes');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1518, 76, 'Hinatuan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1519, 76, 'Lanuza');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1520, 76, 'Lianga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1521, 76, 'Lingig');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1522, 76, 'Madrid');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1523, 76, 'Marihatag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1524, 76, 'San Agustin');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1525, 76, 'San Miguel');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1526, 76, 'Tagbina');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1527, 76, 'Tago');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1528, 76, 'Tandag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1529, 77, 'Anao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1530, 77, 'Bamban');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1531, 77, 'Camiling');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1532, 77, 'Capas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1533, 77, 'Concepcion');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1534, 77, 'Gerona');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1535, 77, 'La Paz');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1536, 77, 'Mayantoc');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1537, 77, 'Moncada');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1538, 77, 'Paniqui');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1539, 77, 'Pura');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1540, 77, 'Ramos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1541, 77, 'San Clemente');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1542, 77, 'San Jose');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1543, 77, 'San Manuel');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1544, 77, 'Santa Ignacia');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1545, 77, 'Tarlac City†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1546, 77, 'Victoria');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1547, 78, 'Bongao†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1548, 78, 'Languyan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1549, 78, 'Mapun');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1550, 78, 'Panglima Sugala');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1551, 78, 'Sapa-Sapa');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1552, 78, 'Sibutu');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1553, 78, 'Simunul');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1554, 78, 'Sitangkai');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1555, 78, 'South Ubian');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1556, 78, 'Tandubas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1557, 78, 'Turtle Islands');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1558, 79, 'Botolan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1559, 79, 'Cabangan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1560, 79, 'Candelaria');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1561, 79, 'Castillejos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1562, 79, 'Iba');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1563, 79, 'Masinloc');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1564, 79, 'Olongapo†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1565, 79, 'Palauig');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1566, 79, 'San Antonio');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1567, 79, 'San Felipe');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1568, 79, 'San Marcelino');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1569, 79, 'San Narciso');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1570, 79, 'Santa Cruz');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1571, 79, 'Subic');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1572, 80, 'Baliguian');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1573, 80, 'Dapitan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1574, 80, 'Dipolog†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1575, 80, 'Godod');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1576, 80, 'Gutalac');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1577, 80, 'Jose Dalman');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1578, 80, 'Kalawit');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1579, 80, 'Katipunan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1580, 80, 'La Libertad');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1581, 80, 'Labason');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1582, 80, 'Leon B. Postigo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1583, 80, 'Liloy');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1584, 80, 'Manukan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1585, 80, 'Mutia');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1586, 80, 'Piñan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1587, 80, 'Polanco');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1588, 80, 'Rizal');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1589, 80, 'Roxas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1590, 80, 'Salug');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1591, 80, 'Sergio Osmeña');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1592, 80, 'Siayan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1593, 80, 'Sibuco');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1594, 80, 'Sibutad');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1595, 80, 'Sindangan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1596, 80, 'Siocon');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1597, 80, 'Sirawai');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1598, 80, 'Tampilisan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1599, 81, 'Aurora');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1600, 81, 'Bayog');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1601, 81, 'Dimataling');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1602, 81, 'Dinas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1603, 81, 'Dumalinao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1604, 81, 'Dumingag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1605, 81, 'Guipos');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1606, 81, 'Josefina');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1607, 81, 'Kumalarang');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1608, 81, 'Labangan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1609, 81, 'Lakewood');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1610, 81, 'Lapuyan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1611, 81, 'Mahayag');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1612, 81, 'Margosatubig');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1613, 81, 'Midsalip');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1614, 81, 'Molave');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1615, 81, 'Pagadian');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1616, 81, 'Pitogo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1617, 81, 'Ramon Magsaysay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1618, 81, 'San Miguel');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1619, 81, 'San Pablo');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1620, 81, 'Sominot');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1621, 81, 'Tabina');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1622, 81, 'Tambulig');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1623, 81, 'Tigbao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1624, 81, 'Tukuran');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1625, 81, 'Vincenzo A. Sagun');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1626, 81, 'Zamboanga City†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1627, 82, 'Alicia');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1628, 82, 'Buug');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1629, 82, 'Diplahan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1630, 82, 'Imelda');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1631, 82, 'Ipil†');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1632, 82, 'Kabasalan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1633, 82, 'Mabuhay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1634, 82, 'Malangas');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1635, 82, 'Naga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1636, 82, 'Olutanga');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1637, 82, 'Payao');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1638, 82, 'Roseller Lim');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1639, 82, 'Siay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1640, 82, 'Talusan');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1641, 82, 'Titay');

INSERT INTO
    municipalities (id, province_id, name)
VALUES (1642, 82, 'Tungawan');

-- Sample plant data
INSERT INTO
    admin_users (username, password)
VALUES (
        'admin',
        '$2y$10$FMyU4b3SQ2nYOMUuFm4wWuxwtIy862iHpR53/U9S8Im9KJegXEI5C'
    );

INSERT INTO plants (id, common_name, scientific_name, description, habitat, uses, conservation)
VALUES
    (1, 'Sampaguita', 'Jasminum sambac', 'The national flower of the Philippines with fragrant white blossoms.', 'Grows in home gardens, parks, and roadside hedges in Metro Manila.', 'Used in leis, perfume, and religious offerings.', 'Not currently endangered but highly valued in cultural traditions.'),
    (2, 'Benguet pine', 'Pinus kesiya', 'Pine tree typically found in the highland forests of northern Luzon.', 'Prefers cool mountain slopes and forested highlands around Baguio.', 'Used for timber, landscaping, and erosion control.', 'Maintains stable populations in its native highlands.'),
    (3, 'Gumamela', 'Hibiscus rosa-sinensis', 'A popular flowering shrub with large colorful blooms seen across Cebu City.', 'Found in urban gardens, schools, and parks.', 'Used as an ornamental and in traditional herbal preparations.', 'Commonly cultivated and not endangered.'),
    (4, 'Waling-waling', 'Vanda sanderiana', 'A rare and iconic Philippine orchid native to Davao Region.', 'Grows in lowland and montane forests near Davao City.', 'Highly prized as an ornamental flower and cultural icon.', 'Endangered in the wild due to habitat loss and collection pressure.'),
    (5, 'Ylang-ylang', 'Cananga odorata', 'A fragrant tree cultivated in Puerto Princesa and Palawan.', 'Thrives in tropical lowland gardens and estate groves.', 'Used to extract essential oil for perfume and aromatherapy.', 'Not endangered, but best grown sustainably in protected areas.'),
    (6, 'Nipa palm', 'Nypa fruticans', 'A mangrove palm common in coastal estuaries near Zamboanga City.', 'Thrives in brackish water swamps and tidal river mouths.', 'Used for nipa shingles, sugar, and traditional crafts.', 'Locally abundant where mangrove habitat remains healthy.'),
    (7, 'Cacao', 'Theobroma cacao', 'A fruit tree cultivated in General Santos and nearby southern Mindanao areas.', 'Grows in humid lowland farms and agroforestry plantations.', 'Produces cocoa beans used for chocolate and local specialties.', 'Cultivated widely, with sustainable farming improving long-term prospects.'),
    (8, 'Narra', 'Pterocarpus indicus', 'The national tree of the Philippines prized for its golden hardwood and fragrant flowers.', 'Found in lowland rainforests, river valleys, and reforested plantations.', 'Used for furniture, boats, and musical instruments.', 'Vulnerable in the wild due to historic overharvesting.'),
    (9, 'Anahaw', 'Livistona rotundifolia', 'A fan palm with large glossy leaves and a strong cultural presence in the Philippines.', 'Grows in open forests and hillsides throughout Luzon and Mindoro.', 'Leaves are used for thatching, decorations, and ceremonial crafts.', 'Commonly cultivated and not currently threatened.'),
    (10, 'Kapok', 'Ceiba pentandra', 'A tall tropical tree producing light, buoyant fiber used as stuffing and insulation.', 'Thrives in lowland forests and riverine areas in southern Philippines.', 'Fiber is used for pillows, mattresses, and life jackets; seeds yield oil.', 'Common in cultivated and secondary forest stands.'),
    (11, 'Molave', 'Vitex parviflora', 'A hardwood tree with dense, termite-resistant timber valued for construction.', 'Occurs in dry forests and open lowland areas in Luzon and Visayas.', 'Used for furniture, posts, and traditional boat building.', 'Near threatened due to habitat loss and logging pressure.'),
    (12, 'Yakal', 'Shorea astylosa', 'A large dipterocarp tree with heavy, durable wood used in marine and structural work.', 'Found in primary dipterocarp forests in Palawan and Mindoro.', 'Valued for heavy construction, bridges, and flooring.', 'Endangered because of historic logging and slow regeneration.'),
    (13, 'Kamagong', 'Diospyros blancoi', 'An ironwood species with dark, dense lumber prized for carving and furniture.', 'Occurs in lowland forests and coastal hills of Visayas and Mindanao.', 'Used for fine furniture, carving, and tool handles.', 'Vulnerable in the wild and protected in some forest reserves.'),
    (14, 'Banaba', 'Lagerstroemia speciosa', 'A tree with clusters of pink to purple flowers and glossy leaves used in herbal teas.', 'Common in parks, roadsides, and secondary forests in Luzon.', 'Leaf extracts are used traditionally to support blood sugar health.', 'Cultivated widely and not currently at risk.'),
    (15, 'Bignay', 'Antidesma bunius', 'A small fruit-bearing tree producing tart red berries used in jams and wines.', 'Found in secondary forests, farms, and home gardens.', 'Fruit is used for preserves, juices, and folk medicine.', 'Common and widely cultivated in rural areas.'),
    (16, 'Malunggay', 'Moringa oleifera', 'A versatile tree known as the “miracle tree” for its nutritious leaves and pods.', 'Grows well in backyard gardens, dry areas, and agroforestry systems.', 'Leaves and pods are eaten as vegetables and used in traditional medicine.', 'Not endangered and frequently grown across the Philippines.'),
    (17, 'Talisay', 'Terminalia catappa', 'A shade tree with broad leaves and distinctive layered branches along beaches.', 'Thrives near coasts, riverbanks, and parks in tropical lowlands.', 'Leaves and bark are used for herbal remedies; tree provides shade and windbreaks.', 'Common in coastal towns and cultivated in urban areas.'),
    (18, 'Ipil-ipil', 'Leucaena leucocephala', 'A fast-growing leguminous tree used for fodder, green manure, and erosion control.', 'Common in grasslands, roadsides, and reforested areas throughout the Philippines.', 'Used for animal feed, soil improvement, and fuelwood.', 'Widespread and well established, though sometimes invasive.'),
    (19, 'Tindalo', 'Afzelia rhomboidea', 'A premium hardwood tree used for fine furniture and durable construction.', 'Occurs in lowland and hill forests in southern Luzon and Mindoro.', 'Highly prized for high-end cabinetry and interior finishes.', 'Near threatened due to overexploitation and habitat loss.'),
    (20, 'Kawayang tinik', 'Bambusa blumeana', 'A stout bamboo species used widely in construction and craftwork.', 'Grows naturally along riverbanks and in managed plantations.', 'Used for scaffolding, furniture, and traditional vessels.', 'Common in rural landscapes and sustainable plantations.'),
    (21, 'Calachuchi', 'Plumeria rubra', 'A fragrant flowering tree often planted near temples and homes.', 'Found in gardens, temples, and roadside landscapes throughout the country.', 'Flowers are used for garlands, incense, and ornamental crafts.', 'Common and widely planted in both urban and rural areas.'),
    (22, 'Nito', 'Lygodium circinnatum', 'A climbing fern with long, wiry fronds used in traditional basketry.', 'Thrives in shaded forests and secondary growth areas.', 'Fronds are woven into mats, baskets, and handicrafts.', 'Cultivated by communities and not currently threatened.'),
    (23, 'Palosapis', 'Anisoptera thurifera', 'A dipterocarp tree producing strong timber used in construction.', 'Found in lowland dipterocarp forests across Luzon and Visayas.', 'Wood is valued for house building, beams, and furniture.', 'Endangered in the wild because of logging and habitat conversion.'),
    (24, 'Akle', 'Artocarpus xanthocarpus', 'A fruit-bearing tree with large edible yellow fruits and distinctive leaves.', 'Grows in lowland rainforests and agroforestry plots.', 'Fruit is eaten fresh; wood is used for shelter and small craft.', 'Rare in the wild but sometimes cultivated in gardens.'),
    (25, 'Kataw', 'Calophyllum inophyllum', 'A coastal tree with glossy leaves and fragrant white flowers.', 'Thrives on sandy beaches and coastal margins.', 'Seed oil is used in traditional medicine, and wood is used for boat making.', 'Common in coastal ecosystems and protected areas.'),
    (26, 'Lipote', 'Diospyros maritima', 'A mangrove tree with small edible fruit and valuable dense wood.', 'Found in mangrove swamps and tidal estuaries.', 'Wood is used for small carvings; fruit is eaten by local communities.', 'Locally abundant where mangroves are healthy.'),
    (27, 'Mahogany', 'Swietenia macrophylla', 'A globally prized timber tree planted in Philippine plantations.', 'Cultivated extensively in reforestation and agroforestry areas.', 'Wood is used for furniture, cabinets, and decorative paneling.', 'Planted widely; wild populations are protected under international regulations.'),
    (28, 'Rain tree', 'Samanea saman', 'A large shade tree with a wide canopy often used in parks and roadsides.', 'Thrives in open lowlands, pasturelands, and urban parks.', 'Commonly planted for shade, fodder, and ornamental appeal.', 'Not threatened and commonly found in landscapes.'),
    (29, 'Lauan', 'Shorea spp.', 'A term for several dipterocarp species used widely in construction and plywood.', 'Found in lowland tropical forests and managed forest farms.', 'Used for doors, furniture, and building materials.', 'Some species are threatened due to logging, requiring sustainable sourcing.'),
    (30, 'Bakauan', 'Rhizophora spp.', 'A group of mangrove trees vital for coastal protection and nursery habitat.', 'Found in tidal mudflats and estuarine mangrove forests.', 'Roots stabilize shorelines and support fisheries; wood is used locally.', 'Protected in mangrove conservation areas and restored coastal sites.'),
    (31, 'Sampalok', 'Tamarindus indica', 'A fruit tree bearing sour pods used in cooking and traditional medicine.', 'Thrives in lowland farms, gardens, and roadside landscapes.', 'Pods are used in sour soups, sauces, and health drinks.', 'Cultivated widely and not currently threatened.'),
    (32, 'Guyabano', 'Annona muricata', 'A fruit tree with large green spiky fruits used in desserts and beverages.', 'Grows in home gardens and small orchards across the Philippines.', 'Fruit is eaten fresh or used in juices, smoothies, and desserts.', 'Commonly cultivated and grown for local markets.'),
    (33, 'Santol', 'Sandoricum koetjape', 'A fruit tree with round yellow fruits often eaten sour or sweetened.', 'Found in lowland orchards, farms, and home gardens.', 'Fruit is eaten fresh; rind is used for preserves and cooking.', 'Commonly cultivated and widely available.'),
    (34, 'Katmon', 'Dillenia philippinensis', 'A tree with large yellow fruit and glossy leaves growing in lowland forests.', 'Thrives in riverside forests and freshwater wetlands.', 'Fruit is used in local cuisine and preserves; leaves are used medicinally.', 'Less common in the wild but protected in some forest areas.'),
    (35, 'Atsuwete', 'Bixa orellana', 'A shrub producing red seeds used for natural dye and cooking color.', 'Common in backyard gardens and hedgerows.', 'Seeds are used as annatto coloring in food, cosmetics, and crafts.', 'Commonly cultivated and not endangered.'),
    (36, 'Sibucao', 'Pithecellobium dulce', 'A thorny tree with sweet-sour pods enjoyed as a snack.', 'Found in secondary forests, roadsides, and home gardens.', 'Fruit is eaten fresh; seeds are used in folk medicine.', 'Common and widely naturalized in rural areas.'),
    (37, 'Caimito', 'Chrysophyllum cainito', 'A tropical fruit tree with glossy foliage and star-shaped slices.', 'Grows in lowland gardens, orchards, and shaded farms.', 'Fruit is eaten fresh and used in desserts.', 'Common in home gardens and plantations.'),
    (38, 'Makahiya', 'Mimosa pudica', 'A sensitive plant that folds its leaves when touched.', 'Grows in shaded lawns, gardens, and waste areas.', 'Used as a curiosity plant and in traditional medicine.', 'Common and fast-spreading in disturbed areas.'),
    (39, 'Balete', 'Ficus balete', 'A majestic strangler fig with aerial roots that create dramatic forms.', 'Found in lowland forests, river valleys, and parks.', 'Cultural and ecological symbol; provides fruit for wildlife.', 'Locally abundant in protected forest reserves and sacred groves.'),
    (40, 'Dungon', 'Dipterocarpus grandiflorus', 'A tall dipterocarp tree with valuable heavy timber.', 'Occurs in lowland and hill dipterocarp forests.', 'Wood is used for construction, plywood, and heavy beams.', 'Vulnerable from logging and forest conversion.'),
    (41, 'Mangkono', 'Xanthostemon verdugonianus', 'A rare hardwood tree with extremely dense, dark timber.', 'Occurs in limestone forests and coastal hills of Palawan.', 'Used for specialty furniture and fine woodworking.', 'Critically endangered in the wild and protected by law.'),
    (42, 'Tanguile', 'Shorea polysperma', 'A dipterocarp tree used for high-quality lumber and furniture.', 'Grows in lowland dipterocarp forests of Luzon and nearby islands.', 'Valued for construction, joinery, and interior finishes.', 'Threatened by logging and habitat loss, so sustainable sourcing is crucial.'),
    (43, 'Batino', 'Alstonia scholaris', 'A fast-growing tree with white fragrant flowers used in traditional medicine.', 'Found in secondary forests, roadsides, and upland woodlands.', 'Bark and leaves are used to treat fever and respiratory ailments.', 'Common in landscape plantings and forest regrowth.'),
    (44, 'Coconut', 'Cocos nucifera', 'The iconic palm of the Philippines producing versatile fruit and fiber.', 'Thrives on sandy coastal soils and island beaches.', 'Every part is used: water, meat, oil, coir, and building materials.', 'Extensively cultivated with stable production in coastal provinces.'),
    (45, 'Lagundi', 'Vitex negundo', 'A medicinal shrub used in traditional remedies for cough and fever.', 'Grows in secondary forests, roadsides, and home gardens.', 'Leaves and stems are brewed into herbal teas and treatments.', 'Commonly cultivated and widely used in folk medicine.'),
    (46, 'Ampalaya', 'Momordica charantia', 'A climbing vine grown for its bitter edible fruit.', 'Grows on trellises, gardens, and vegetable plots.', 'Fruit is used in soups, salads, and herbal health preparations.', 'Popular in home gardening and common in markets.'),
    (47, 'Banana', 'Musa paradisiaca', 'A staple fruit crop with many local varieties grown in orchards.', 'Thrives in warm lowland areas, farms, and backyard plots.', 'Fruit is eaten fresh; leaves are used for wrapping food.', 'Cultivated widely and essential to Philippine agriculture.'),
    (48, 'Papaya', 'Carica papaya', 'A fast-growing fruit tree producing sweet orange fruit.', 'Common in gardens, farms, and small orchards.', 'Fruit, leaves, and seeds are used for food and traditional medicine.', 'Commonly cultivated and widely available.'),
    (49, 'Mango', 'Mangifera indica', 'The national fruit known for sweet, juicy flesh and fragrant aroma.', 'Grows in tropical orchards, farms, and backyard gardens.', 'Fruit is eaten fresh, made into shakes, dried fruit, and preserves.', 'Cultivated extensively and central to local fruit production.'),
    (50, 'Lanzones', 'Lansium domesticum', 'A fruit tree prized for clusters of sweet yellowish fruits.', 'Found in lowland orchards and home gardens in southern Philippines.', 'Fruit is eaten fresh and used in desserts.', 'Cultivated in fruit-producing regions and widely enjoyed.'),
    (51, 'Calamansi', 'Citrus microcarpa', 'A small citrus tree producing tart fruit used in cooking and drinks.', 'Grows in home gardens, farms, and hedges across the archipelago.', 'Fruit is used for juice, seasoning, and herbal remedies.', 'Commonly cultivated and commercially important.'),
    (52, 'Santan', 'Bougainvillea glabra', 'A flowering vine with vibrant bracts used for hedges and ornamentals.', 'Thrives in gardens, parks, and sunny walls.', 'Used for decorative landscaping and garden borders.', 'Commonly planted and not threatened.'),
    (53, 'Ube', 'Dioscorea alata', 'A purple yam cultivated for its sweet edible tubers.', 'Grows in upland farms and root crop gardens.', 'Tubers are used in desserts, pastries, and local delicacies.', 'Widely cultivated and important in Filipino cuisine.'),
    (54, 'Pandan', 'Pandanus amaryllifolius', 'A fragrant herb with long leaves used for cooking and scent.', 'Grows in shaded gardens and home yard beds.', 'Leaves flavor rice, desserts, and beverages.', 'Common in home gardens and not endangered.'),
    (55, 'Alugbati', 'Basella alba', 'A leafy green vine eaten as a vegetable in soups and stews.', 'Cultivated in gardens and vegetable plots throughout the islands.', 'Leaves are eaten fresh or cooked; stems are rich in vitamins.', 'Common and easy to grow in local kitchens.'),
    (56, 'Roselle', 'Hibiscus sabdariffa', 'A shrub grown for its tangy red calyces used in teas and jams.', 'Cultivated in farms and backyard gardens.', 'Calyces are made into beverages, jellies, and syrups.', 'Commonly grown and valued for its nutritious products.'),
    (57, 'Talahib', 'Saccharum spontaneum', 'A tall wild grass used in erosion control and traditional roofing.', 'Occurs in open fields, roadsides, and disturbed habitats.', 'Stalks are used for thatching, crafts, and livestock bedding.', 'Common across the countryside and not threatened.'),
    (58, 'Jabon', 'Anthocephalus cadamba', 'A fast-growing tropical tree used for timber and shade.', 'Grows in lowland forests and reforestation sites.', 'Used for light construction and pulpwood.', 'Common in plantations and secondary forests.'),
    (59, 'Coffee', 'Coffea arabica', 'Small tree cultivated for coffee beans in upland farms.', 'Thrives in cool, shaded highland areas.', 'Beans are roasted and brewed as coffee; economic crop.', 'Cultivated widely in mountainous regions.'),
    (60, 'Sea hibiscus', 'Hibiscus tiliaceus', 'A coastal shrub with yellow flowers used for shade and windbreaks.', 'Found along beaches and coastal margins.', 'Used for traditional cordage and shade trees.', 'Locally common along coasts.'),
    (61, 'Mangrove fern', 'Acrostichum aureum', 'A hardy fern found in mangrove swamps helping stabilize soils.', 'Thrives in brackish estuarine habitats.', 'Used in erosion control and ecological restoration.', 'Common where mangroves remain healthy.'),
    (62, 'Cinnamon', 'Cinnamomum verum', 'A small aromatic tree cultivated for its bark.', 'Grows in shaded garden plots and farms.', 'Bark used as a spice and traditional remedy.', 'Cultivated commercially and in home gardens.'),
    (63, 'Gmelina', 'Gmelina arborea', 'A fast-growing timber tree used for furniture and poles.', 'Found in reforestation and agroforestry plantations.', 'Wood used for furniture and plywood.', 'Widespread in plantation forestry.'),
    (64, 'Eucalyptus', 'Eucalyptus globulus', 'A tall aromatic tree planted for timber and windbreaks.', 'Thrives in drier upland sites and plantations.', 'Used for timber, fuelwood, and essential oils.', 'Planted extensively though non-native.'),
    (65, 'Acacia', 'Acacia mangium', 'A nitrogen-fixing tree used in reforestation and pulpwood.', 'Grows in disturbed sites and plantation forests.', 'Used for poles, charcoal, and soil improvement.', 'Common in plantation programs.'),
    (66, 'Coffee Robusta', 'Coffea canephora', 'Robust coffee species grown in lower altitude farms.', 'Grows in warm lowlands and shaded plantations.', 'Beans are used in blends and instant coffee.', 'Widely cultivated in some southern regions.'),
    (67, 'Tuba-tuba', 'Jatropha curcas', 'A small tree with seeds used for oil production and erosion control.', 'Found in marginal lands and hedgerows.', 'Oil can be used for biodiesel and soap making.', 'Cultivated in some agroforestry systems.'),
    (68, 'Kape Barako', 'Coffea liberica', 'A local coffee variety with bold flavor cultivated in lowlands.', 'Grows in lowland shaded farms and homesteads.', 'Valued for traditional coffee beverages and small-scale trade.', 'Less common than arabica and robusta.'),
    (69, 'Pili', 'Canarium ovatum', 'A nut-bearing tree with edible kernels used in confections.', 'Thrives in volcanic lowlands and orchards.', 'Kernels are roasted and sold as snacks; oil used in cooking.', 'Cultivated commercially in some provinces.'),
    (70, 'Bamboo (kawayang puso)', 'Bambusa vulgaris', 'A versatile bamboo species used in construction and crafts.', 'Grows along riverbanks, farms, and managed groves.', 'Used for building, furniture, and handicrafts.', 'Commonly planted and sustainably harvested.'),
    (71, 'Sundew', 'Drosera sp.', 'A carnivorous plant found in peat swamps and boggy areas.', 'Thrives in acidic, waterlogged habitats.', 'Valued by collectors and studied for ecology.', 'Some species are locally rare and habitat-dependent.'),
    (72, 'Rattan', 'Calamus spp.', 'A climbing palm used for furniture weaving and baskets.', 'Found in shaded lowland and montane forests.', 'Canes are harvested for furniture and handicrafts.', 'Sustainable harvesting is important to prevent decline.'),
    (73, 'Hagonoy', 'Microcos panicula', 'A shrub used in traditional medicine and coastal plantings.', 'Grows in secondary growth and coastal areas.', 'Used for medicinal baths and wound care in folk remedies.', 'Locally common and cultivated for herbal use.'),
    (74, 'Screw pine', 'Pandanus tectorius', 'A coastal plant with fibrous leaves used for weaving mats and thatch.', 'Found along beaches and coastal margins.', 'Leaves used for weaving and thatching.', 'Common in traditional coastal communities.'),
    (75, 'Kamansi', 'Pachyrhizus erosus', 'A tuberous vine grown for its edible root (jicama).', 'Cultivated in backyard gardens and small farms.', 'Root is eaten raw or cooked; crisp and mildly sweet.', 'Cultivated locally and not threatened.'),
    (76, 'Sawo', 'Manilkara zapota', 'A fruit tree producing sweet brown fruit enjoyed fresh.', 'Grows in home gardens and orchards in lowland areas.', 'Fruit eaten fresh; wood used locally.', 'Commonly cultivated and valued for fruit.'),
    (77, 'Chilte', 'Muntingia calabura', 'A fast-growing small tree producing sweet small red fruits.', 'Found in roadsides, parks, and secondary growth.', 'Fruit is eaten fresh and sold in markets.', 'Common and widely naturalized.'),
    (78, 'Santol baya', 'Sandoricum koetjape var.', 'A variety of santol with slightly different fruit characteristics.', 'Cultivated in orchards and home gardens.', 'Fruit eaten fresh or made into preserves.', 'Common in fruit-growing regions.'),
    (79, 'Tuba', 'Nypa fruticans', 'A mangrove palm tapped for sap used to make local wine and vinegar.', 'Found in mangrove swamps and estuaries.', 'Sap fermented to produce local beverages and vinegar.', 'Locally abundant where mangroves persist.'),
    (80, 'Tongkat Ali', 'Eurycoma longifolia', 'A tropical shrub valued for traditional medicinal roots.', 'Grows in lowland to hill forests under shade.', 'Roots used in herbal tonics; high cultural value.', 'Wild populations under pressure from overharvest.'),
    (81, 'Bamboo (kawayan)', 'Dendrocalamus asper', 'A large bamboo species used for construction and food shoots.', 'Found in plantations and natural groves.', 'Shoots are edible; culms used for building and handicrafts.', 'Cultivated extensively and managed sustainably in areas.'),
    (82, 'Mabolo', 'Diospyros blancoi var.', 'A fruit tree with soft, aromatic flesh and velvet skin.', 'Grows in lowland orchards and home gardens.', 'Fruit eaten fresh; wood sometimes used locally.', 'Cultivated regionally with stable local stocks.'),
    (83, 'Muntingia', 'Muntingia calabura', 'Also known as the Jamaican cherry; fast-growing fruiting tree.', 'Thrives in disturbed sites and gardens.', 'Fruit popular as snack; grows rapidly from seed.', 'Common and abundant in many localities.'),
    (84, 'Kalingag', 'Crotalaria spp.', 'A nitrogen-fixing shrub used in cover cropping and soil improvement.', 'Grows in open fields and fallow areas.', 'Used as green manure and for livestock forage.', 'Widely used in agroecological practices.'),
    (85, 'Guava', 'Psidium guajava', 'A fruit-bearing tree with aromatic, sweet-tart fruit.', 'Cultivated in home gardens and small orchards.', 'Fruit eaten fresh, made into jams and juices.', 'Common and widely cultivated.'),
    (86, 'Coconut (wild)', 'Cocos nucifera var. sylvestris', 'Wild or feral coconut populations on shorelines and islets.', 'Grows on beaches and small islands.', 'Used traditionally for copra and household uses.', 'Wild stands are common in many coastal areas.'),
    (87, 'Seed fern (cycad)', 'Cycas rumphii', 'A cycad species with ornamental value and slow growth.', 'Found in limestone areas and gardens.', 'Used as ornamental and cultural plant in landscaping.', 'Some populations are protected due to slow growth.'),
    (88, 'Kudzu', 'Pueraria montana', 'A fast-climbing vine used for erosion control and fodder in some areas.', 'Grows on hillsides, roadsides and disturbed slopes.', 'Used as green manure and animal feed; can be invasive.', 'Naturalized and sometimes managed due to invasiveness.'),
    (89, 'Betel nut', 'Areca catechu', 'A palm grown for its seeds chewed socially and culturally.', 'Thrives in lowland tropical gardens and plantations.', 'Nuts are chewed with betel leaf; important cultural use.', 'Cultivated in traditional agroforestry systems.'),
    (90, 'Camia', 'Hippeastrum spp.', 'A bulbous ornamental with showy flowers planted in gardens.', 'Grows in garden beds and shaded patios.', 'Ornamental value for landscaping and gifts.', 'Common in ornamental horticulture.'),
    (91, 'Powder-puff', 'Calliandra haematocephala', 'A flowering shrub with showy pink/red powder-puff blooms.', 'Found in gardens and parklands.', 'Used as ornamental and for attracting pollinators.', 'Common and cultivated widely.'),
    (92, 'Ampalaya tree (wild vine)', 'Momordica cochinchinensis', 'A wild relative of bitter melon with bright orange fruit.', 'Grows in forests and secondary growth.', 'Fruit and extracts used in traditional medicine.', 'Less common but present in native habitats.'),
    (93, 'Siksik', 'Piper betle', 'Betel leaf vine cultivated for ceremonial chewing with areca.', 'Grown in shaded garden plots and trellises.', 'Leaves are used culturally with betel nut.', 'Cultivated on small scale for local demand.'),
    (94, 'Nangka', 'Artocarpus heterophyllus', 'A large fruit tree producing jackfruit, used for food and shade.', 'Grows in home gardens and orchards.', 'Fruit eaten fresh or cooked; seeds roasted; wood used locally.', 'Commonly cultivated and economically important.'),
    (95, 'Buri', 'Corypha elata', 'A large palmate palm with large leaves used for weaving and thatching.', 'Found in coastal and riverine lowlands.', 'Leaves used for weaving mats, hats, and roofing.', 'Locally cultivated and harvested sustainably in some areas.'),
    (96, 'Ulaw', 'Ficus septica', 'A fig species with ecological importance supporting wildlife.', 'Found in secondary forests and riparian zones.', 'Fruits feed birds and bats; used in traditional medicine.', 'Common in regenerating forest stands.'),
    (97, 'Kokko', 'Syzygium cumini', 'Also known as Java plum; fruit tree with edible berries.', 'Grows in home gardens and small orchards.', 'Fruit eaten fresh and used for jams; leaves used medicinally.', 'Cultivated and naturalized in many areas.'),
    (98, 'Pita', 'Samanea saman var. saman', 'A large shade tree with nitrogen-fixing pods used for fodder.', 'Found in parks, roadsides, and grazing lands.', 'Pods are used as fodder; tree provides shade.', 'Commonly planted and valued in agroforestry.'),
    (99, 'Tangan-tangan', 'Ricinus communis', 'A quick-growing shrub used for ornamental and industrial oilseed.', 'Grows in disturbed areas and roadsides.', 'Seeds are a source of castor oil (industrial uses only).', 'Common and often self-seeding.'),
    (100, 'Tanglade', 'Pithecellobium saman', 'A local name variant for a widespread shade tree.', 'Thrives in urban parks and lowland pastures.', 'Used for shade and ornamental planting.', 'Common in town landscapes.'),
    (101, 'Tabon-tabon', 'Atuna racemosa', 'A coastal tree used traditionally in food preparation for flavoring.', 'Found in mangrove margins and coastal forests.', 'Used in local fish preservation and cooking methods.', 'Locally common in coastal provinces.'),
    (102, 'Tuba-tuba (medicinal)', 'Ricinus communis var. medicinalis', 'A medicinal variety used in folk remedies (external use).', 'Grows in disturbed ground and home gardens.', 'Used externally in traditional poultices and remedies.', 'Locally used but wild harvesting is common.'),
    (103, 'Kalamansi wild', 'Citrus hystrix', 'A wild citrus relative used for flavoring and medicine.', 'Found in secondary forest and hedgerows.', 'Leaves and fruits used in cooking and remedies.', 'Less common but maintained in some villages.'),
    (104, 'Aratiles', 'Muntingia calabura var. aratiles', 'A fast-fruiting tree with sweet edible berries.', 'Found along roadsides and in gardens.', 'Fruit popular as snack and sold locally.', 'Common and abundant.'),
    (105, 'Katurai', 'Spathodea campanulata', 'A flowering tree with showy orange blooms often used in ornamentals.', 'Grows in parks, schools, and avenues.', 'Used as ornamental for shade and floriculture.', 'Common in urban plantings.'),
    (106, 'Bayabas', 'Psidium guajava var. bayabas', 'A common guava variety used for jams and juices.', 'Cultivated in homestead gardens and small orchards.', 'Fruit processed into jams, juices, and confections.', 'Widely cultivated and frequently propagated.'),
    (107, 'Muntingia (wild form)', 'Muntingia calabura var. sylvestris', 'A wild form of the Jamaican cherry with edible fruits.', 'Found in secondary growth and disturbed lots.', 'Fruit eaten fresh; supports small wildlife populations.', 'Common and self-seeding in many localities.');

INSERT INTO plant_municipalities (plant_id, municipality_id)
VALUES
    (1, 982),
    (2, 188),
    (3, 453),
    (4, 539),
    (5, 1218),
    (6, 1626),
    (7, 1428),
    (8, 45),
    (9, 78),
    (10, 102),
    (11, 134),
    (12, 189),
    (13, 223),
    (14, 265),
    (15, 310),
    (16, 358),
    (17, 401),
    (18, 459),
    (19, 502),
    (20, 548),
    (21, 590),
    (22, 622),
    (23, 672),
    (24, 705),
    (25, 764),
    (26, 812),
    (27, 845),
    (28, 892),
    (29, 930),
    (30, 978),
    (31, 1015),
    (32, 1063),
    (33, 1101),
    (34, 1139),
    (35, 1188),
    (36, 1234),
    (37, 1270),
    (38, 1309),
    (39, 1340),
    (40, 1378),
    (41, 1405),
    (42, 1438),
    (43, 1471),
    (44, 1499),
    (45, 1526),
    (46, 1558),
    (47, 1589),
    (48, 1608),
    (49, 1619),
    (50, 1627),
    (51, 1630),
    (52, 1635),
    (53, 1640),
    (54, 1642),
    (55, 1599),
    (56, 1575),
    (57, 1560),
    (58, 1561),
    (59, 1562),
    (60, 1563),
    (61, 1564),
    (62, 1565),
    (63, 1566),
    (64, 1567),
    (65, 1568),
    (66, 1569),
    (67, 1570),
    (68, 1571),
    (69, 1572),
    (70, 1573),
    (71, 1574),
    (72, 1576),
    (73, 1577),
    (74, 1578),
    (75, 1579),
    (76, 1580),
    (77, 1581),
    (78, 1582),
    (79, 1583),
    (80, 1584),
    (81, 1585),
    (82, 1586),
    (83, 1587),
    (84, 1588),
    (85, 1589),
    (86, 1590),
    (87, 1591),
    (88, 1592),
    (89, 1593),
    (90, 1594),
    (91, 1595),
    (92, 1596),
    (93, 1597),
    (94, 1598),
    (95, 1599),
    (96, 1600),
    (97, 1601),
    (98, 1602),
    (99, 1603),
    (100, 1604),
    (101, 1605),
    (102, 1606),
    (103, 1607),
    (104, 1608),
    (105, 1609),
    (106, 1610),
    (107, 1611);

-- Seed plant_photos: one placeholder filename per plant (replace with real filenames as needed)
INSERT INTO plant_photos (id, plant_id, filename)
VALUES
    (1, 1, 'plant_1.jpg'),
    (2, 2, 'plant_2.jpg'),
    (3, 3, 'plant_3.jpg'),
    (4, 4, 'plant_4.jpg'),
    (5, 5, 'plant_5.jpg'),
    (6, 6, 'plant_6.jpg'),
    (7, 7, 'plant_7.jpg'),
    (8, 8, 'plant_8.jpg'),
    (9, 9, 'plant_9.jpg'),
    (10, 10, 'plant_10.jpg'),
    (11, 11, 'plant_11.jpg'),
    (12, 12, 'plant_12.jpg'),
    (13, 13, 'plant_13.jpg'),
    (14, 14, 'plant_14.jpg'),
    (15, 15, 'plant_15.jpg'),
    (16, 16, 'plant_16.jpg'),
    (17, 17, 'plant_17.jpg'),
    (18, 18, 'plant_18.jpg'),
    (19, 19, 'plant_19.jpg'),
    (20, 20, 'plant_20.jpg'),
    (21, 21, 'plant_21.jpg'),
    (22, 22, 'plant_22.jpg'),
    (23, 23, 'plant_23.jpg'),
    (24, 24, 'plant_24.jpg'),
    (25, 25, 'plant_25.jpg'),
    (26, 26, 'plant_26.jpg'),
    (27, 27, 'plant_27.jpg'),
    (28, 28, 'plant_28.jpg'),
    (29, 29, 'plant_29.jpg'),
    (30, 30, 'plant_30.jpg'),
    (31, 31, 'plant_31.jpg'),
    (32, 32, 'plant_32.jpg'),
    (33, 33, 'plant_33.jpg'),
    (34, 34, 'plant_34.jpg'),
    (35, 35, 'plant_35.jpg'),
    (36, 36, 'plant_36.jpg'),
    (37, 37, 'plant_37.jpg'),
    (38, 38, 'plant_38.jpg'),
    (39, 39, 'plant_39.jpg'),
    (40, 40, 'plant_40.jpg'),
    (41, 41, 'plant_41.jpg'),
    (42, 42, 'plant_42.jpg'),
    (43, 43, 'plant_43.jpg'),
    (44, 44, 'plant_44.jpg'),
    (45, 45, 'plant_45.jpg'),
    (46, 46, 'plant_46.jpg'),
    (47, 47, 'plant_47.jpg'),
    (48, 48, 'plant_48.jpg'),
    (49, 49, 'plant_49.jpg'),
    (50, 50, 'plant_50.jpg'),
    (51, 51, 'plant_51.jpg'),
    (52, 52, 'plant_52.jpg'),
    (53, 53, 'plant_53.jpg'),
    (54, 54, 'plant_54.jpg'),
    (55, 55, 'plant_55.jpg'),
    (56, 56, 'plant_56.jpg'),
    (57, 57, 'plant_57.jpg'),
    (58, 58, 'plant_58.jpg'),
    (59, 59, 'plant_59.jpg'),
    (60, 60, 'plant_60.jpg'),
    (61, 61, 'plant_61.jpg'),
    (62, 62, 'plant_62.jpg'),
    (63, 63, 'plant_63.jpg'),
    (64, 64, 'plant_64.jpg'),
    (65, 65, 'plant_65.jpg'),
    (66, 66, 'plant_66.jpg'),
    (67, 67, 'plant_67.jpg'),
    (68, 68, 'plant_68.jpg'),
    (69, 69, 'plant_69.jpg'),
    (70, 70, 'plant_70.jpg'),
    (71, 71, 'plant_71.jpg'),
    (72, 72, 'plant_72.jpg'),
    (73, 73, 'plant_73.jpg'),
    (74, 74, 'plant_74.jpg'),
    (75, 75, 'plant_75.jpg'),
    (76, 76, 'plant_76.jpg'),
    (77, 77, 'plant_77.jpg'),
    (78, 78, 'plant_78.jpg'),
    (79, 79, 'plant_79.jpg'),
    (80, 80, 'plant_80.jpg'),
    (81, 81, 'plant_81.jpg'),
    (82, 82, 'plant_82.jpg'),
    (83, 83, 'plant_83.jpg'),
    (84, 84, 'plant_84.jpg'),
    (85, 85, 'plant_85.jpg'),
    (86, 86, 'plant_86.jpg'),
    (87, 87, 'plant_87.jpg'),
    (88, 88, 'plant_88.jpg'),
    (89, 89, 'plant_89.jpg'),
    (90, 90, 'plant_90.jpg'),
    (91, 91, 'plant_91.jpg'),
    (92, 92, 'plant_92.jpg'),
    (93, 93, 'plant_93.jpg'),
    (94, 94, 'plant_94.jpg'),
    (95, 95, 'plant_95.jpg'),
    (96, 96, 'plant_96.jpg'),
    (97, 97, 'plant_97.jpg'),
    (98, 98, 'plant_98.jpg'),
    (99, 99, 'plant_99.jpg'),
    (100, 100, 'plant_100.jpg'),
    (101, 101, 'plant_101.jpg'),
    (102, 102, 'plant_102.jpg'),
    (103, 103, 'plant_103.jpg'),
    (104, 104, 'plant_104.jpg'),
    (105, 105, 'plant_105.jpg'),
    (106, 106, 'plant_106.jpg'),
    (107, 107, 'plant_107.jpg');

