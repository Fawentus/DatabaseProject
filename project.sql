-- удаление всего (TODO удалить этот блок)
/*
drop table pack_x_employee;
drop table employee;
drop table another;
drop table child;
drop table child_constant;
drop table group_inhabitants;
drop table pack;
drop table inhabitant;
*/

-- создание схемы
CREATE SCHEMA project;

SET SEARCH_PATH = project;

-- создание таблиц
CREATE TABLE INHABITANT(
    inhabitant_id serial PRIMARY KEY,
	real_name VARCHAR(100),
	type varchar(100) CHECK(type IN ('CHILD_CONSTANT', 'ANOTHER', 'EMPLOYEE'))
);

CREATE TABLE CHILD_CONSTANT(
    inhabitant_id INTEGER PRIMARY KEY REFERENCES INHABITANT(inhabitant_id),
	disease VARCHAR(100),
	status VARCHAR(100) CHECK(status IN ('NOT', 'WALKER', 'JUMPER')),
	set INTEGER CHECK(set > 0 AND set < 32)
);

CREATE TABLE PACK(
    pack_id serial PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	symbol VARCHAR(100)
);

CREATE TABLE GROUP_INHABITANTS(
    group_id serial PRIMARY KEY,
	name VARCHAR(100) NOT NULL
);

CREATE TABLE ANOTHER(
    inhabitant_id INTEGER PRIMARY KEY REFERENCES INHABITANT(inhabitant_id),
	group_id INTEGER REFERENCES GROUP_INHABITANTS(group_id),
	name VARCHAR(100) NOT NULL
);

CREATE TABLE CHILD(
    inhabitant_id INTEGER REFERENCES CHILD_CONSTANT(inhabitant_id),
	valid_from INTEGER CHECK(valid_from > 4 AND valid_from < 19),
	group_id INTEGER REFERENCES GROUP_INHABITANTS(group_id),
	pack_id INTEGER REFERENCES PACK(pack_id),
	name VARCHAR(100) NOT NULL,
	is_head_pack BOOLEAN DEFAULT FALSE,
	valid_to INTEGER CHECK(valid_to > 4 AND valid_to < 19),
	PRIMARY KEY (inhabitant_id, valid_from)
);

CREATE TABLE EMPLOYEE(
    inhabitant_id INTEGER REFERENCES INHABITANT(inhabitant_id),
	valid_from INTEGER CHECK(valid_from > 4 AND valid_from < 19),
	valid_set INTEGER CHECK(valid_set > 0 AND valid_set < 32),
	group_id INTEGER REFERENCES GROUP_INHABITANTS(group_id),
	name VARCHAR(100) NOT NULL,
	post VARCHAR(100) NOT NULL,
	valid_to INTEGER CHECK(valid_to > 4 AND valid_to < 19),
	PRIMARY KEY (inhabitant_id, valid_from, valid_set)
);

CREATE TABLE PACK_X_EMPLOYEE(
    inhabitant_id INTEGER REFERENCES INHABITANT(inhabitant_id),
	valid_from INTEGER CHECK(valid_from > 4 AND valid_from < 19),
	valid_set INTEGER CHECK(valid_set > 0 AND valid_set < 32),
	pack_id INTEGER REFERENCES PACK(pack_id),
	valid_to INTEGER CHECK(valid_to > 4 AND valid_to < 19),
	PRIMARY KEY (inhabitant_id, valid_from, valid_set, pack_id),
	FOREIGN KEY (inhabitant_id, valid_from, valid_set) REFERENCES EMPLOYEE(inhabitant_id, valid_from, valid_set)
);

-- заполнение данными
-- INHABITANT
INSERT INTO INHABITANT (real_name, type) VALUES ('Эрик Циммерман', 'CHILD_CONSTANT'); -- Курильщик
INSERT INTO INHABITANT (real_name, type) VALUES (NULL, 'CHILD_CONSTANT'); -- Слепой
INSERT INTO INHABITANT (real_name, type) VALUES (NULL, 'CHILD_CONSTANT'); -- Сфинкс
INSERT INTO INHABITANT (real_name, type) VALUES (NULL, 'CHILD_CONSTANT'); -- Рыжий
INSERT INTO INHABITANT (real_name, type) VALUES ('Роберт Кац', 'CHILD_CONSTANT'); -- Первый ?
INSERT INTO INHABITANT (real_name, type) VALUES (NULL, 'CHILD_CONSTANT'); -- Ромашка

INSERT INTO INHABITANT (real_name, type) VALUES (NULL, 'EMPLOYEE'); -- Чёрный Ральф
INSERT INTO INHABITANT (real_name, type) VALUES ('Геральд Ку', 'EMPLOYEE'); -- Акула
INSERT INTO INHABITANT (real_name, type) VALUES ('Альфред', 'EMPLOYEE'); -- Гомер
INSERT INTO INHABITANT (real_name, type) VALUES (NULL, 'EMPLOYEE'); -- Старик

INSERT INTO INHABITANT (real_name, type) VALUES (NULL, 'ANOTHER'); -- Русалка, она порождение Изнанки, но сама в Доме
INSERT INTO INHABITANT (real_name, type) VALUES (NULL, 'ANOTHER'); -- Серолиций
INSERT INTO INHABITANT (real_name, type) VALUES (NULL, 'ANOTHER'); -- Король ?
INSERT INTO INHABITANT (real_name, type) VALUES (NULL, 'ANOTHER'); -- Крыс ?
INSERT INTO INHABITANT (real_name, type) VALUES ('Грег Циммерман', 'ANOTHER'); -- Отец Курильщика

-- CHILD_CONSTANT
INSERT INTO CHILD_CONSTANT (inhabitant_id, disease, status, set) VALUES (1, 'Колясник', 'NOT', 31); -- Курильщик
INSERT INTO CHILD_CONSTANT (inhabitant_id, disease, status, set) VALUES (2, 'Слепой', 'WALKER', 31); -- Слепой
INSERT INTO CHILD_CONSTANT (inhabitant_id, disease, status, set) VALUES (3, 'Отсутствие обеих рук', 'JUMPER', 31); -- Сфинкс
INSERT INTO CHILD_CONSTANT (inhabitant_id, disease, status, set) VALUES (4, 'Проблемы со спиной', 'WALKER', 31); -- Рыжий
INSERT INTO CHILD_CONSTANT (inhabitant_id, disease, status, set) VALUES (5, 'Колясник', 'JUMPER', 1); -- Первый ?
INSERT INTO CHILD_CONSTANT (inhabitant_id, disease, status, set) VALUES (6, 'Эпилепсия', 'NOT', 29); -- Ромашка

-- PACK
INSERT INTO PACK (name, symbol) VALUES ('Первая', 'Фазан');
INSERT INTO PACK (name, symbol) VALUES ('Вторая', 'Крыса');
INSERT INTO PACK (name, symbol) VALUES ('Третья', 'Птица');
INSERT INTO PACK (name, symbol) VALUES ('Четвёртая', NULL);
INSERT INTO PACK (name, symbol) VALUES ('Шестая', 'Пёс');

-- GROUP_INHABITANTS
INSERT INTO GROUP_INHABITANTS (name) VALUES ('Наружность');
INSERT INTO GROUP_INHABITANTS (name) VALUES ('Дом');
INSERT INTO GROUP_INHABITANTS (name) VALUES ('Изнанка');
INSERT INTO GROUP_INHABITANTS (name) VALUES ('Лес');
INSERT INTO GROUP_INHABITANTS (name) VALUES ('Могильник');

-- ANOTHER
INSERT INTO ANOTHER (inhabitant_id, group_id, name) VALUES (11, 2, 'Русалка');
INSERT INTO ANOTHER (inhabitant_id, group_id, name) VALUES (12, 3, 'Серолиций');
INSERT INTO ANOTHER (inhabitant_id, group_id, name) VALUES (13, 3, 'Король');
INSERT INTO ANOTHER (inhabitant_id, group_id, name) VALUES (14, 3, 'Крыс');
INSERT INTO ANOTHER (inhabitant_id, group_id, name) VALUES (15, 1, 'Батя');

-- CHILD
INSERT INTO CHILD (inhabitant_id, valid_from, group_id, pack_id, name, valid_to) VALUES (1, 15, 2, 1, 'Курильщик', 16);
INSERT INTO CHILD (inhabitant_id, valid_from, group_id, pack_id, name, valid_to) VALUES (1, 16, 2, 4, 'Курильщик', 18);

INSERT INTO CHILD (inhabitant_id, valid_from, group_id, pack_id, name, valid_to) VALUES (2, 5, 2, 4, 'Слепой', 12);
INSERT INTO CHILD (inhabitant_id, valid_from, group_id, pack_id, name, valid_to, is_head_pack) VALUES (2, 12, 2, 4, 'Слепой', 18, TRUE);

INSERT INTO CHILD (inhabitant_id, valid_from, group_id, pack_id, name, valid_to) VALUES (3, 6, 2, 4, 'Кузнечик', 10);
INSERT INTO CHILD (inhabitant_id, valid_from, group_id, pack_id, name, valid_to) VALUES (3, 10, 3, 4, 'Кузнечик', 13);
INSERT INTO CHILD (inhabitant_id, valid_from, group_id, pack_id, name, valid_to) VALUES (3, 13, 2, 4, 'Сфинкс', 18);

INSERT INTO CHILD (inhabitant_id, valid_from, group_id, pack_id, name, valid_to) VALUES (4, 5, 5, 4, 'Смерть', 12);
INSERT INTO CHILD (inhabitant_id, valid_from, group_id, pack_id, name, valid_to, is_head_pack) VALUES (4, 12, 2, 2, 'Рыжий', 18, TRUE);

INSERT INTO CHILD (inhabitant_id, valid_from, group_id, pack_id, name, valid_to) VALUES (5, 5, 2, 1, 'Первый', 18);

INSERT INTO CHILD (inhabitant_id, valid_from, group_id, pack_id, name, valid_to) VALUES (6, 12, 2, 3, 'Ромашка', 16);
INSERT INTO CHILD (inhabitant_id, valid_from, group_id, pack_id, name, valid_to) VALUES (6, 16, 4, 3, 'Нюхач', 18);

-- EMPLOYEE
INSERT INTO EMPLOYEE (inhabitant_id, valid_from, valid_set, group_id, name, post, valid_to) VALUES (7, 12, 30, 2, 'Чёрный Ральф', 'Воспитатель' , 18);
INSERT INTO EMPLOYEE (inhabitant_id, valid_from, valid_set, group_id, name, post, valid_to) VALUES (7, 5, 31, 2, 'Чёрный Ральф', 'Воспитатель' , 14);
INSERT INTO EMPLOYEE (inhabitant_id, valid_from, valid_set, group_id, name, post, valid_to) VALUES (7, 17, 31, 2, 'Ральф Р', 'Воспитатель' , 18);

INSERT INTO EMPLOYEE (inhabitant_id, valid_from, valid_set, group_id, name, post, valid_to) VALUES (8, 6, 30, 2, 'Акула', 'Директор' , 18);

INSERT INTO EMPLOYEE (inhabitant_id, valid_from, valid_set, group_id, name, post, valid_to) VALUES (9, 12, 31, 2, 'Гомер', 'Воспитатель' , 18);

INSERT INTO EMPLOYEE (inhabitant_id, valid_from, valid_set, group_id, name, post, valid_to) VALUES (10, 12, 29, 2, 'Старик', 'Директор' , 18);
INSERT INTO EMPLOYEE (inhabitant_id, valid_from, valid_set, group_id, name, post, valid_to) VALUES (10, 5, 30, 2, 'Старик', 'Директор' , 18);
INSERT INTO EMPLOYEE (inhabitant_id, valid_from, valid_set, group_id, name, post, valid_to) VALUES (10, 16, 31, 2, 'Старик', 'Учитель' , 18);

-- PACK_X_EMPLOYEE
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (7, 12, 30, 3, 18);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (7, 5, 31, 3, 14);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (7, 17, 31, 3, 18);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (7, 12, 30, 4, 18);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (7, 5, 31, 4, 14);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (7, 17, 31, 4, 18);

INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (8, 6, 30, 1, 18);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (8, 6, 30, 2, 18);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (8, 6, 30, 3, 18);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (8, 6, 30, 4, 18);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (8, 6, 30, 5, 18);

INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (9, 12, 31, 1, 18);

INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (10, 12, 29, 1, 18);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (10, 12, 29, 2, 18);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (10, 12, 29, 3, 18);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (10, 12, 29, 4, 18);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (10, 12, 29, 5, 18);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (10, 5, 30, 1, 18);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (10, 5, 30, 2, 18);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (10, 5, 30, 3, 18);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (10, 5, 30, 4, 18);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (10, 5, 30, 5, 18);

INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (10, 16, 31, 1, 18);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, valid_from, valid_set, pack_id, valid_to) VALUES (10, 16, 31, 3, 18);

