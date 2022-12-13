# Задание 1
### Описание
Моей любимой книгой в детстве был роман Мариам Петросян "Дом в котором".
Там очень много главных героев, я давно читала, но даже сейчас могу вспомнить персонажей 15 в подробностях, а второстепенных героев намного больше.
Попробую кратко описать сеттинг, чтобы было понятно, о чём данные, которые будут храниться в БД.

Основное место действия -- интернат для детей с ограниченными возможностями, они называют его Домом.
У всех детей разные заболевания, есть колясники, Неразумные (дети, отстающие в развитии), слепой, мальчик с 6 пальцами, безрукий, страдающий эпилепсией и многие другие.
Когда ребёнок попадает в Дом, у него появляется кличка, которая может со временем меняться, чаще всего так и происходит.
Настоящие имена детей мало кто знает, при прочтении становятся известны имена лишь некоторых обитателей Дома.

Все дети во времена основной сюжетной линии разделены на 5 групп, их ещё называют стаями: Первая(фазаны), Вторая(Крысы), Третья(Птицы), Четвёртая и Шестая(Псы).
Когда они были маленькими были ещё группы, например, Бандерлоги или Чумные дохляки. Затем дети из них распрделились по основным пяти группам.
Есть также информация про детей, живших при самом открытии Дома, а также про выпуск, предшествующий главным героям и про некоторые другие.

Помимо стай можно выделить группу работников Дома -- врачей, воспитателей, учителей, отдельно группу девочек (про них известно меньше), ещё есть люди из Наружности и из Изнанки.
Наружностью обитатели дома называют мир за пределами Дома.
Изнанка -- это обратная сторона Дома, грубо говоря некий потусторонний мир, другая вселенная.

В Изнанке живут люди, также туда могут попасть некоторые обитатели Дома.
Тех, кто может перемещаться в Изнанку по своему желанию называют Ходоками, а тех, кого туда забрасывает -- Прыгунами.

Книга заканчивается с выпуском главных героев из интерната, после чего Дом сносят.
Здесь много внимания уделяется вопросам, кто куда из ребят попал дальше.
Есть те, кто полностью перешли в Изнанку, есть Спящие, они в Изнанке, но их тело осталось в Доме (например, глава Дома позаботился о том, чтобы подобным образом 
перенесли всех Неразумных, ведь в Изнанке они просто маленькие дети и могут быть там счастливы), есть те, кто ушли в Наружность, кого-то забрали родители ещё до выпуска, некоторые уехали на автобусе.

Кажется, всё звучит довольно запутанно, но, надеюсь, общий смысл ясен.

### Версионность
Здесь есть данные, которые изменяются со временем, будем отсчитывать его таким образом: номер набора, где учится ребёнок и год обучения этого набора. Набор, о котором идёт речь в книге 31 по счёту. 32 набора уже нет и не будет, Дом снесли. У ребёнка номер набора никогда не меняется.

### Сущности
В основе будут обитатели Дома. Они делятся на детей, работников Дома и остальных (здесь будут родители детей, люди из Наружности и Изнанки -- они тоже обитатели Дома в некотором смысле).
Дети собираются в стаи, у каждой из которых есть воспитатели, учителя.
Также все обитатели Дома делятся на группы по своему местоположению.
Так, например, ребёнок может уехать в наружность, или
находиться в данный момент в Доме и быть частью Стаи, но в то же время прыгать в Изнанку (их называют Спящими),
или же это может быть просто житель Наружности.

# Задание 2

## Пункт a
Концептуальная модель:

![](https://github.com/Fawentus/DatabaseProject/blob/main/DB1.png)

Работники Дома и дети будут версионными таблицами, поэтому у Обитателей с ними связь ко многим.

Каждый ребёнок в конкретный промежуток времени может быть только в одной стаи,
воспитателей и учителей у стаи может быть несколько. 

Стая может быть пуста, к примеру, Пятая. 

Работник может не относиться к конкретной стаи, например, врач, или же наоборот относиться к нескольким стаям одновременно, такое было с учителями.

Каждый обитатель Дома находится в одной из групп. Группы также могут не содержать людей одной из категорий, например, никто из работников Дома никогда не был в Изнанке.

## Пункт b
Логическая модель:

![](https://github.com/Fawentus/DatabaseProject/blob/main/DB2.png)

### Выбор нормальной формы
Выбрала 3НФ. Она получилась естественным образом после приведения во вторую нормальную форму.

### Выбор SCD
Выбрала SCD2, так как у нас нет никакой текущей версии, ощущение времени в романе довольно условно.

## Пункт c
Физические модели для сущностей:

### `INHABITANT` (Обитатель Дома):

<!DOCTYPE html>
<html>
<body>
	<table>
		<thead>
			<tr>
				<th>PK/FK</th>
				<th>Название<br></th>
				<th>Описание</th>
				<th>Тип данных</th>
				<th>Ограничение</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>PK</td>
				<td>inhabitant_id</td>
				<td>Id Обитателя</td>
				<td>INTEGER</td>
				<td>PRIMARY KEY</td>
			</tr>
			<tr>
				<td></td>
				<td>real_name</td>
				<td>Настоящее имя</td>
				<td>VARCHAR(100)</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>type</td>
				<td>Тип Обитателя: ребёнок, работник Дома или другой</td>
				<td>VARCHAR(100)</td>
				<td>CHECK(type IN ('CHILD_CONSTANT', 'ANOTHER', 'EMPLOYEE'))</td>
			</tr>
		</tbody>
	</table>
</body>
</html>

### `CHILD_CONSTANT` (Неизменяемые данные о ребёнке):

<!DOCTYPE html>
<html>
<body>
	<table>
		<thead>
			<tr>
				<th>PK/FK</th>
				<th>Название<br></th>
				<th>Описание</th>
				<th>Тип данных</th>
				<th>Ограничение</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>PK, FK</td>
				<td>inhabitant_id</td>
				<td>Id Обитателя</td>
				<td>INTEGER</td>
				<td>PRIMARY KEY, REFERENCES INHABITANT(inhabitant_id)</td>
			</tr>
			<tr>
				<td></td>
				<td>disease</td>
				<td>Болезнь ребёнка, её может и не быть</td>
				<td>VARCHAR(100)</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>status</td>
				<td>Способность перемещаться в Изнанку, её либо нет, либо человек Ходок, либо Прыгун</td>
				<td>VARCHAR(100)</td>
				<td>CHECK(status IN ('NOT', 'WALKER', 'JUMPER'))</td>
			</tr>
			<tr>
				<td></td>
				<td>set</td>
				<td>Номер набора, где учился ребёнок</td>
				<td>INTEGER</td>
				<td>CHECK(set > 0 AND set < 32)</td>
			</tr>
		</tbody>
	</table>
</body>
</html>

### `ANOTHER` (Другой):

<!DOCTYPE html>
<html>
<body>
	<table>
		<thead>
			<tr>
				<th>PK/FK</th>
				<th>Название<br></th>
				<th>Описание</th>
				<th>Тип данных</th>
				<th>Ограничение</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>PK, FK</td>
				<td>inhabitant_id</td>
				<td>Id Обитателя</td>
				<td>INTEGER</td>
				<td>PRIMARY KEY, REFERENCES INHABITANT(inhabitant_id)</td>
			</tr>
			<tr>
				<td>FK</td>
				<td>group_id</td>
				<td>Id группы</td>
				<td>INTEGER</td>
				<td>REFERENCES GROUP_INHABITANTS(group_id)</td>
			</tr>
			<tr>
				<td></td>
				<td>name</td>
				<td>Кличка</td>
				<td>VARCHAR(100)</td>
				<td>NOT NULL</td>
			</tr>
		</tbody>
	</table>
</body>
</html>

### `CHILD` (Ребёнок):

<!DOCTYPE html>
<html>
<body>
	<table>
		<thead>
			<tr>
				<th>PK/FK</th>
				<th>Название<br></th>
				<th>Описание</th>
				<th>Тип данных</th>
				<th>Ограничение</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>PK, FK</td>
				<td>inhabitant_id</td>
				<td>Id Обитателя</td>
				<td>INTEGER</td>
				<td>REFERENCES CHILD_CONSTANT(inhabitant_id)</td>
			</tr>
			<tr>
				<td>PK</td>
				<td>valid_from</td>
				<td>Возраст ребёнка, с которого эта запись валидна (включая)</td>
				<td>INTEGER</td>
				<td>CHECK(valid_from > 4 AND valid_from < 19)</td>
			</tr>
			<tr>
				<td>FK</td>
				<td>group_id</td>
				<td>Id группы</td>
				<td>INTEGER</td>
				<td>REFERENCES GROUP_INHABITANTS(group_id)</td>
			</tr>
			<tr>
				<td>FK</td>
				<td>pack_id</td>
				<td>Id стаи</td>
				<td>INTEGER</td>
				<td>REFERENCES PACK(pack_id)</td>
			</tr>
			<tr>
				<td></td>
				<td>name</td>
				<td>Кличка</td>
				<td>VARCHAR(100)</td>
				<td>NOT NULL</td>
			</tr>
			<tr>
				<td></td>
				<td>is_head_pack</td>
				<td>Является ли вожаком стаи</td>
				<td>BOOLEAN</td>
				<td>DEFAULT FALSE</td>
			</tr>
			<tr>
				<td></td>
				<td>valid_to</td>
				<td>Возраст ребёнка, до которого эта запись валидна (не включая)</td>
				<td>INTEGER</td>
				<td>CHECK(valid_to > 4 AND valid_to < 19)</td>
			</tr>
		</tbody>
	</table>
</body>
</html>

Дополнительно к этим ограничениям есть составной PRIMARY KEY:
`PRIMARY KEY (inhabitant_id, valid_from)`

### `EMPLOYEE` (Работник Дома):

<!DOCTYPE html>
<html>
<body>
	<table>
		<thead>
			<tr>
				<th>PK/FK</th>
				<th>Название<br></th>
				<th>Описание</th>
				<th>Тип данных</th>
				<th>Ограничение</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>PK, FK</td>
				<td>inhabitant_id</td>
				<td>Id Обитателя</td>
				<td>INTEGER</td>
				<td>REFERENCES INHABITANT(inhabitant_id)</td>
			</tr>
			<tr>
				<td>PK</td>
				<td>valid_from</td>
				<td>Возраст детей набора valid_set, с которого эта запись валидна (включая)</td>
				<td>INTEGER</td>
				<td>CHECK(valid_from > 4 AND valid_from < 19)</td>
			</tr>
			<tr>
				<td>PK</td>
				<td>valid_set</td>
				<td>Номер набора детей, для которого эта запись валидна</td>
				<td>INTEGER</td>
				<td>CHECK(valid_set > 0 AND valid_set < 32)</td>
			</tr>
			<tr>
				<td>FK</td>
				<td>group_id</td>
				<td>Id группы</td>
				<td>INTEGER</td>
				<td>REFERENCES GROUP_INHABITANTS(group_id)</td>
			</tr>
			<tr>
				<td></td>
				<td>name</td>
				<td>Кличка</td>
				<td>VARCHAR(100)</td>
				<td>NOT NULL</td>
			</tr>
			<tr>
				<td></td>
				<td>post</td>
				<td>Должность</td>
				<td>VARCHAR(100)</td>
				<td>NOT NULL</td>
			</tr>
			<tr>
				<td></td>
				<td>valid_to</td>
				<td>Возраст детей набора valid_set, до которого эта запись валидна (включая)</td>
				<td>INTEGER</td>
				<td>CHECK(valid_to > 4 AND valid_to < 19)</td>
			</tr>
		</tbody>
	</table>
</body>
</html>

Дополнительно к этим ограничениям есть составной PRIMARY KEY:
`PRIMARY KEY (inhabitant_id, valid_from, valid_set)`

### `PACK` (Стая):

<!DOCTYPE html>
<html>
<body>
	<table>
		<thead>
			<tr>
				<th>PK/FK</th>
				<th>Название<br></th>
				<th>Описание</th>
				<th>Тип данных</th>
				<th>Ограничение</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>PK</td>
				<td>pack_id</td>
				<td>Id стаи</td>
				<td>INTEGER</td>
				<td>PRIMARY KEY</td>
			</tr>
			<tr>
				<td></td>
				<td>name</td>
				<td>Название</td>
				<td>VARCHAR(100)</td>
				<td>NOT NULL</td>
			</tr>
			<tr>
				<td></td>
				<td>symbol</td>
				<td>Символ, его межет не быть</td>
				<td>VARCHAR(100)</td>
				<td></td>
			</tr>
		</tbody>
	</table>
</body>
</html>

### `PACK_X_EMPLOYEE` (Связь между стаями и работниками Дома):

<!DOCTYPE html>
<html>
<body>
	<table>
		<thead>
			<tr>
				<th>PK/FK</th>
				<th>Название<br></th>
				<th>Описание</th>
				<th>Тип данных</th>
				<th>Ограничение</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>PK, FK</td>
				<td>inhabitant_id</td>
				<td>Id Обитателя</td>
				<td>INTEGER</td>
				<td>REFERENCES INHABITANT(inhabitant_id)</td>
			</tr>
			<tr>
				<td>PK, FK</td>
				<td>pack_id</td>
				<td>Id стаи</td>
				<td>INTEGER</td>
				<td>REFERENCES PACK(pack_id)</td>
			</tr>
		</tbody>
	</table>
</body>
</html>

Дополнительно к этим ограничениям есть составной PRIMARY KEY:
`PRIMARY KEY (inhabitant_id, pack_id)`

### `GROUP_INHABITANTS` (Группа):

<!DOCTYPE html>
<html>
<body>
	<table>
		<thead>
			<tr>
				<th>PK/FK</th>
				<th>Название<br></th>
				<th>Описание</th>
				<th>Тип данных</th>
				<th>Ограничение</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>PK</td>
				<td>group_id</td>
				<td>Id группы</td>
				<td>INTEGER</td>
				<td>PRIMARY KEY</td>
			</tr>
			<tr>
				<td></td>
				<td>name</td>
				<td>Название</td>
				<td>VARCHAR(100)</td>
				<td>CHECK (name LIKE '(%)')</td>
			</tr>
		</tbody>
	</table>
</body>
</html>
