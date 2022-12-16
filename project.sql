-- Задание 3
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
	name VARCHAR(100) CHECK (name LIKE '(%)') -- названия мест всегда указывались в скобочках
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
	pack_id INTEGER REFERENCES PACK(pack_id),
	PRIMARY KEY (inhabitant_id, pack_id)
);

-- Задание 4
-- заполнение данными
-- INHABITANT
INSERT INTO INHABITANT (real_name, type) VALUES ('Эрик Циммерман', 'CHILD_CONSTANT');
INSERT INTO INHABITANT (type) VALUES ('CHILD_CONSTANT');
INSERT INTO INHABITANT (type) VALUES ('CHILD_CONSTANT');
INSERT INTO INHABITANT (type) VALUES ('CHILD_CONSTANT');
INSERT INTO INHABITANT (real_name, type) VALUES ('Роберт Кац', 'CHILD_CONSTANT');
INSERT INTO INHABITANT (type) VALUES ('CHILD_CONSTANT');

INSERT INTO INHABITANT (type) VALUES ('EMPLOYEE');
INSERT INTO INHABITANT (real_name, type) VALUES ('Геральд Ку', 'EMPLOYEE');
INSERT INTO INHABITANT (real_name, type) VALUES ('Альфред', 'EMPLOYEE');
INSERT INTO INHABITANT (type) VALUES ('EMPLOYEE');

INSERT INTO INHABITANT (type) VALUES ('ANOTHER');
INSERT INTO INHABITANT (type) VALUES ('ANOTHER');
INSERT INTO INHABITANT (type) VALUES ('ANOTHER');
INSERT INTO INHABITANT (type) VALUES ('ANOTHER');
INSERT INTO INHABITANT (real_name, type) VALUES ('Грег Циммерман', 'ANOTHER');

-- CHILD_CONSTANT
INSERT INTO CHILD_CONSTANT (inhabitant_id, disease, status, set) VALUES (1, 'Колясник', 'NOT', 31);
INSERT INTO CHILD_CONSTANT (inhabitant_id, disease, status, set) VALUES (2, 'Слепой', 'WALKER', 31);
INSERT INTO CHILD_CONSTANT (inhabitant_id, disease, status, set) VALUES (3, 'Отсутствие обеих рук', 'JUMPER', 31);
INSERT INTO CHILD_CONSTANT (inhabitant_id, disease, status, set) VALUES (4, 'Проблемы со спиной', 'WALKER', 31);
INSERT INTO CHILD_CONSTANT (inhabitant_id, disease, status, set) VALUES (5, 'Колясник', 'JUMPER', 1);
INSERT INTO CHILD_CONSTANT (inhabitant_id, disease, status, set) VALUES (6, 'Эпилепсия', 'NOT', 29);

-- PACK
INSERT INTO PACK (name, symbol) VALUES ('Первая', 'Фазан');
INSERT INTO PACK (name, symbol) VALUES ('Вторая', 'Крыса');
INSERT INTO PACK (name, symbol) VALUES ('Третья', 'Птица');
INSERT INTO PACK (name) VALUES ('Четвёртая');
INSERT INTO PACK (name, symbol) VALUES ('Шестая', 'Пес');

-- GROUP_INHABITANTS
INSERT INTO GROUP_INHABITANTS (name) VALUES ('(Наружность)');
INSERT INTO GROUP_INHABITANTS (name) VALUES ('(Дом)');
INSERT INTO GROUP_INHABITANTS (name) VALUES ('(Изнанка)');
INSERT INTO GROUP_INHABITANTS (name) VALUES ('(Лес)');
INSERT INTO GROUP_INHABITANTS (name) VALUES ('(Могильник)');

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
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, pack_id) VALUES (7, 3);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, pack_id) VALUES (7, 4);

INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, pack_id) VALUES (8, 1);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, pack_id) VALUES (8, 2);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, pack_id) VALUES (8, 3);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, pack_id) VALUES (8, 4);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, pack_id) VALUES (8, 5);

INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, pack_id) VALUES (9, 1);

INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, pack_id) VALUES (10, 1);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, pack_id) VALUES (10, 2);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, pack_id) VALUES (10, 3);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, pack_id) VALUES (10, 4);
INSERT INTO PACK_X_EMPLOYEE (inhabitant_id, pack_id) VALUES (10, 5);

-- Задание 5
-- INSERT
INSERT INTO INHABITANT (type) VALUES ('ANOTHER');
INSERT INTO ANOTHER (inhabitant_id, group_id, name) VALUES (16, 4, 'Ёжик');

INSERT INTO INHABITANT (type) VALUES ('CHILD_CONSTANT');
INSERT INTO CHILD_CONSTANT (inhabitant_id, disease, status, set) VALUES (17, 'Колясник', 'NOT', 1);

INSERT INTO INHABITANT (type) VALUES ('CHILD_CONSTANT');
INSERT INTO CHILD_CONSTANT (inhabitant_id, disease, status, set) VALUES (18, 'Неразумный', 'NOT', 20);
INSERT INTO CHILD (inhabitant_id, valid_from, group_id, pack_id, name, valid_to) VALUES (18, 5, 2, 3, 'Птенец', 7);
INSERT INTO CHILD (inhabitant_id, valid_from, group_id, pack_id, name, valid_to) VALUES (18, 9, 2, 3, 'Птенец', 15);
INSERT INTO CHILD (inhabitant_id, valid_from, group_id, pack_id, name, valid_to) VALUES (18, 17, 2, 3, 'Птенец', 18);

-- SELECT
SELECT DISTINCT
    name,
    post
FROM EMPLOYEE;

SELECT *
FROM CHILD;

-- UPDATE
UPDATE ANOTHER
SET name='Суслик'
WHERE name='Ёжик';

UPDATE PACK
SET symbol='Пёс'
WHERE pack_id=5;

-- DELETE
DELETE FROM ANOTHER WHERE name='Суслик';
DELETE FROM INHABITANT WHERE inhabitant_id=16;

-- Задание 6
-- Запрос 1 (GROUP BY + HAVING)
-- В результате запроса для каждого типа INHABITANT будет выведено число известных нам настоящих имён, если их хотя бы 2
SELECT
    type,
    count(real_name)
FROM INHABITANT
GROUP BY type
HAVING count(real_name) >= 2;

-- Запрос 2 (ORDER BY)
-- В результате запроса будут выведены имена, должности и года выпуска из таблицы EMPLOYEE, которые будут отсортированы
-- по году выпуска детей (по убыванию), а при равенстве -- по имени (по возрастанию)
SELECT
    name,
    post,
    valid_set
FROM EMPLOYEE
ORDER BY valid_set DESC, name;

-- Запрос 3 (оконные функции)
-- В результате запроса для каждой записи данных ребёнка в таблице CHILD получим возраст, с которого нам известно про
-- него хоть что-то, результат внутри группы записей об одном и том же ребёнке отсортирован по возрасту, с которого
-- валидна запись (по возрастанию)
SELECT
    *,
    min(valid_from) OVER (partition by inhabitant_id order by valid_from) AS min_age
FROM CHILD;

-- Запрос 4 (оконные функции + ORDER BY)
-- В результате запроса получим по каждому году выпуска (отсортированы по возрастанию) список встречаемых диагнозов
-- (отсортированы по возрастанию для каждого года) и их колличество (оно будет нарастать внутри каждой группы)
SELECT
    set,
    disease,
    count(disease) OVER (PARTITION BY set ORDER BY disease) AS count_disease
FROM (SELECT DISTINCT
        set,
        disease
      FROM CHILD_CONSTANT) AS diseases
ORDER BY set;

-- Запрос 5 (GROUP BY + HAVING)
-- В результате запроса получим для каждого id из таблицы EMPLOYEE, сколько записей есть про этого человека, с учётом,
-- что эта запись относится к 31 году выпуска и их хотя бы 2
SELECT
    inhabitant_id,
    count(*)
FROM EMPLOYEE
WHERE valid_set = 31
GROUP BY inhabitant_id
HAVING count(*) >= 2;

-- Запрос 6 (GROUP BY + HAVING)
-- В результате запроса получим для каждого работника число стай, к которым он относится, при условии,
-- что он относится хотя бы к одной стае, но не ко всем сразу
SELECT
    EMPLOYEE_ID.inhabitant_id,
    count(pack_id)
FROM PACK_X_EMPLOYEE
RIGHT JOIN (SELECT
                inhabitant_id
            FROM EMPLOYEE
            GROUP BY inhabitant_id) AS EMPLOYEE_ID ON EMPLOYEE_ID.inhabitant_id=PACK_X_EMPLOYEE.inhabitant_id
GROUP BY EMPLOYEE_ID.inhabitant_id
HAVING count(pack_id) BETWEEN 1 AND
       (SELECT
            count(PACK.pack_id)
        FROM PACK)-1;

-- Запрос 7 (оконные функции)
-- В результате запроса получим интервалы разрывов в версионности у таблицы CHILD

SELECT
    inhabitant_id,
    prev_valid_to,
    valid_from
FROM (SELECT
          inhabitant_id,
          lag(valid_to) OVER (PARTITION BY inhabitant_id ORDER BY valid_from) AS prev_valid_to,
          valid_from
      FROM CHILD
     ) AS PREV
WHERE valid_from > prev_valid_to;

-- Запрос 8 (оконные функции)
-- В результате запроса получим интервалы разрывов в версионности у таблицы EMPLOYEE, отличается от прошлого запроса тем,
-- что у работников set также является версионым

SELECT
    inhabitant_id,
    prev_valid_set,
    valid_set,
    prev_valid_to,
    valid_from
FROM (SELECT
          inhabitant_id,
          valid_set,
          lag(valid_to) OVER (PARTITION BY inhabitant_id ORDER BY valid_set, valid_from) AS prev_valid_to,
          lag(valid_set) OVER (PARTITION BY inhabitant_id ORDER BY valid_set) AS prev_valid_set,
          valid_from
      FROM EMPLOYEE) AS PREV
WHERE (valid_set = prev_valid_set AND valid_from > prev_valid_to) OR
      (valid_set - prev_valid_set = 1 AND valid_from + 13 > prev_valid_to) OR
      (valid_set - prev_valid_set > 1);