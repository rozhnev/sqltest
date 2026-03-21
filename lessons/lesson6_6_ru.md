---
title: "Применение рекурсивных CTE в SQL: Иерархические данные, BOM, организационные структуры"
description: "Изучите рекурсивные CTE в SQL для решения практических задач. Работа с иерархиями, структурами категорий, организационными графами, системами меню и поиском путей. Полное руководство с примерами."
keywords: "рекурсивные CTE, SQL иерархия, дерево категорий, BOM, организационная диаграмма, поиск пути, структура меню, рекурсивный запрос SQL, WITH RECURSIVE"
lang: "ru"
region: "RU, BY, KZ, UA"
---

# Урок 6.6: Применение рекурсивных CTE к реальным задачам

В предыдущем уроке мы изучили обычные (нерекурсивные) CTE — инструмент для организации и структурирования SQL запросов. Теперь переходим к мощнейшей их разновидности: **рекурсивные CTE**.

Рекурсивные CTE позволяют вам работать с иерархическими, древовидными и сетевыми структурами данных. Они решают множество реальных задач, которые традиционно требовали программного кода или сложных процедур.

<img src="/images/lessons/lesson6_6_recursive-cte.jpg" alt="Recursive CTE" width="100%">

## Что такое рекурсивный CTE?

**Рекурсивный CTE** — это CTE, который ссылается на себя, позволяя вам обходить иерархические структуры уровень за уровнем.

Структура рекурсивного CTE:

```sql
WITH RECURSIVE имя_cte AS (
    -- ЯКОРНЫЙ ЧЛЕН (базовый случай)
    SELECT ... 
    WHERE условие_якоря
    
    UNION ALL
    
    -- РЕКУРСИВНЫЙ ЧЛЕН (как перейти на следующий уровень)
    SELECT ...
    FROM имя_cte
    WHERE условие_остановки
)
SELECT * FROM имя_cte;
```

**Ключевые компоненты:**
1. **Якорный член** — начальная точка рекурсии (обычно корневые записи)
2. **UNION ALL** — объединяет результаты якоря и рекурсии
3. **Рекурсивный член** — как перейти с одного уровня на другой
4. **Условие остановки** — когда прекратить рекурсию

## Пример 1: Иерархия категорий

Один из наиболее распространённых применений — это работа с иерархией категорий в интернет-магазине.

**Структура таблицы:**
```sql
CREATE TABLE категории (
    category_id INT PRIMARY KEY,
    parent_id INT,
    name VARCHAR(100),
    FOREIGN KEY (parent_id) REFERENCES категории(category_id)
);

INSERT INTO категории VALUES
(1, NULL, 'Электроника'),
(2, 1, 'Компьютеры'),
(3, 1, 'Мобильные телефоны'),
(4, 2, 'Ноутбуки'),
(5, 2, 'Настольные ПК'),
(6, 4, 'Ноутбуки Dell'),
(7, 4, 'Ноутбуки HP'),
(8, 3, 'Смартфоны'),
(9, 3, 'Планшеты');
```

**Задача: Получить полную иерархию категорий от корня к листьям**

```sql
WITH RECURSIVE категория_иерархия AS (
    -- Якорный член: начинаем с корневых категорий
    SELECT
        category_id,
        parent_id,
        name,
        1 AS уровень,
        name AS полный_путь
    FROM
        категории
    WHERE
        parent_id IS NULL
    
    UNION ALL
    
    -- Рекурсивный член: добавляем дочерние категории
    SELECT
        к.category_id,
        к.parent_id,
        к.name,
        ки.уровень + 1,
        CONCAT(ки.полный_путь, ' → ', к.name)
    FROM
        категории к
    JOIN
        категория_иерархия ки ON к.parent_id = ки.category_id
)
SELECT
    category_id,
    REPEAT('  ', уровень - 1) AS отступ,
    name,
    уровень,
    полный_путь
FROM
    категория_иерархия
ORDER BY
    уровень,
    category_id;
```

**Результат:**
```
category_id | отступ | name                | уровень | полный_путь
1           |        | Электроника         | 1       | Электроника
2           |   | Компьютеры          | 2       | Электроника → Компьютеры
4           |       | Ноутбуки            | 3       | Электроника → Компьютеры → Ноутбуки
6           |           | Ноутбуки Dell       | 4       | Электроника → Компьютеры → Ноутбуки → Ноутбуки Dell
7           |           | Ноутбуки HP         | 4       | Электроника → Компьютеры → Ноутбуки → Ноутбуки HP
5           |       | Настольные ПК       | 3       | Электроника → Компьютеры → Настольные ПК
3           |   | Мобильные телефоны  | 2       | Электроника → Мобильные телефоны
8           |       | Смартфоны           | 3       | Электроника → Мобильные телефоны → Смартфоны
9           |       | Планшеты            | 3       | Электроника → Мобильные телефоны → Планшеты
```

**Что происходит:**
- Якорный член находит только `Электроника` (parent_id IS NULL)
- Рекурсивный член находит `Компьютеры` и `Мобильные телефоны` (дочерние для Электроники)
- Процесс повторяется, пока не будут найдены все листья

## Пример 2: Организационная диаграмма

Часто нужно вывести структуру компании с цепью управления.

**Структура таблицы:**
```sql
CREATE TABLE сотрудники (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100),
    manager_id INT,
    salary DECIMAL(10, 2),
    FOREIGN KEY (manager_id) REFERENCES сотрудники(employee_id)
);

INSERT INTO сотрудники VALUES
(1, 'Иван Петров', 'Генеральный директор', NULL, 150000),
(2, 'Анна Сидорова', 'Директор продаж', 1, 100000),
(3, 'Петр Иванов', 'Директор IT', 1, 120000),
(4, 'Мария Федорова', 'Менеджер продаж', 2, 60000),
(5, 'Алексей Смирнов', 'Менеджер продаж', 2, 60000),
(6, 'Сергей Волков', 'Ведущий разработчик', 3, 90000),
(7, 'Ольга Козлова', 'Разработчик', 6, 70000),
(8, 'Дмитрий Миронов', 'Разработчик', 6, 70000);
```

**Задача: Вывести организационную структуру с цепью подчинения**

```sql
WITH RECURSIVE org_chart AS (
    -- Якорь: Генеральный директор
    SELECT
        employee_id,
        name,
        position,
        manager_id,
        salary,
        1 AS уровень,
        name AS цепь_управления
    FROM
        сотрудники
    WHERE
        manager_id IS NULL
    
    UNION ALL
    
    -- Рекурсия: добавляем подчинённых
    SELECT
        с.employee_id,
        с.name,
        с.position,
        с.manager_id,
        с.salary,
        oc.уровень + 1,
        CONCAT(oc.цепь_управления, ' → ', с.name)
    FROM
        сотрудники с
    JOIN
        org_chart oc ON с.manager_id = oc.employee_id
    WHERE
        oc.уровень < 10  -- Защита от бесконечной рекурсии
)
SELECT
    employee_id,
    REPEAT('│ ', уровень - 1) AS иерархия,
    name,
    position,
    salary,
    цепь_управления
FROM
    org_chart
ORDER BY
    уровень,
    employee_id;
```

**Результат:**
```
employee_id | иерархия | name           | position              | salary | цепь_управления
1           |          | Иван Петров    | Генеральный директор  | 150000 | Иван Петров
2           | │        | Анна Сидорова  | Директор продаж       | 100000 | Иван Петров → Анна Сидорова
4           | │ │      | Мария Федорова | Менеджер продаж       | 60000  | Иван Петров → Анна Сидорова → Мария Федорова
5           | │ │      | Алексей Смирнов| Менеджер продаж       | 60000  | Иван Петров → Анна Сидорова → Алексей Смирнов
3           | │        | Петр Иванов    | Директор IT            | 120000 | Иван Петров → Петр Иванов
6           | │ │      | Сергей Волков | Ведущий разработчик   | 90000  | Иван Петров → Петр Иванов → Сергей Волков
7           | │ │ │    | Ольга Козлова | Разработчик           | 70000  | Иван Петров → Петр Иванов → Сергей Волков → Ольга Козлова
8           | │ │ │    | Дмитрий Миронов| Разработчик          | 70000  | Иван Петров → Петр Иванов → Сергей Волков → Дмитрий Миронов
```

**Применение: Расчет бюджета подразделения**

```sql
WITH RECURSIVE org_chart AS (
    SELECT
        employee_id,
        name,
        position,
        salary,
        1 AS уровень
    FROM
        сотрудники
    WHERE
        manager_id IS NULL
    
    UNION ALL
    
    SELECT
        с.employee_id,
        с.name,
        с.position,
        с.salary,
        oc.уровень + 1
    FROM
        сотрудники с
    JOIN
        org_chart oc ON с.manager_id = oc.employee_id
)
SELECT
    name AS должность,
    COUNT(*) AS количество_сотрудников,
    SUM(salary) AS общая_зарплата,
    ROUND(AVG(salary), 2) AS средняя_зарплата
FROM
    org_chart
GROUP BY
    employee_id,
    name
ORDER BY
    SUM(salary) DESC;
```

## Пример 3: Bill of Materials (Список компонентов)

В производстве нужно знать, из каких компонентов состоит продукт.

**Структура таблицы:**
```sql
CREATE TABLE bom (
    product_id INT,
    component_id INT,
    quantity INT,
    PRIMARY KEY (product_id, component_id)
);

INSERT INTO bom VALUES
(1, 2, 1),      -- Ноутбук состоит из 1 материнской платы
(1, 3, 2),      -- и 2 палочек RAM
(1, 4, 1),      -- и 1 жёсткого диска
(2, 5, 1),      -- Материнская плата состоит из 1 чипсета
(2, 6, 20),     -- и 20 резисторов
(4, 7, 1);      -- Жёсткий диск состоит из 1 шпинделя
```

**Задача: Развернуть BOM до полного списка компонентов**

```sql
WITH RECURSIVE bom_expanded AS (
    -- Якорь: готовые товары (не используются как компоненты)
    SELECT
        product_id,
        product_id AS component_id,
        1 AS quantity,
        0 AS level,
        CAST(product_id AS CHAR(100)) AS path
    FROM
        (SELECT DISTINCT product_id FROM bom
         UNION
         SELECT DISTINCT component_id FROM bom) AS products
    
    UNION ALL
    
    -- Рекурсия: развернуть каждый компонент
    SELECT
        be.product_id,
        b.component_id,
        be.quantity * b.quantity,
        be.level + 1,
        CONCAT(be.path, ' → ', b.component_id)
    FROM
        bom_expanded be
    JOIN
        bom b ON be.component_id = b.product_id
    WHERE
        be.level < 10
)
SELECT
    product_id,
    component_id,
    quantity,
    level,
    path
FROM
    bom_expanded
WHERE
    level > 0
ORDER BY
    product_id,
    level,
    component_id;
```

## Пример 4: Структура меню (Menu Trees)

Интернет-магазины и веб-приложения часто имеют многоуровневые меню.

**Структура таблицы:**
```sql
CREATE TABLE menu (
    menu_id INT PRIMARY KEY,
    parent_menu_id INT,
    title VARCHAR(100),
    url VARCHAR(255),
    sort_order INT,
    FOREIGN KEY (parent_menu_id) REFERENCES menu(menu_id)
);

INSERT INTO menu VALUES
(1, NULL, 'Главная', '/', 1),
(2, NULL, 'Каталог', '/catalog', 2),
(3, NULL, 'О нас', '/about', 3),
(4, 2, 'Компьютеры', '/catalog/computers', 1),
(5, 2, 'Аксессуары', '/catalog/accessories', 2),
(6, 4, 'Ноутбуки', '/catalog/computers/laptops', 1),
(7, 4, 'Настольные ПК', '/catalog/computers/desktops', 2),
(8, 5, 'Мыши', '/catalog/accessories/mice', 1),
(9, 5, 'Клавиатуры', '/catalog/accessories/keyboards', 2),
(10, 3, 'История', '/about/history', 1),
(11, 3, 'Команда', '/about/team', 2);
```

**Задача: Вывести меню в формате дерева с отступами**

```sql
WITH RECURSIVE menu_tree AS (
    -- Якорь: основные пункты меню
    SELECT
        menu_id,
        parent_menu_id,
        title,
        url,
        1 AS level,
        title AS breadcrumb
    FROM
        menu
    WHERE
        parent_menu_id IS NULL
    ORDER BY
        sort_order
    
    UNION ALL
    
    -- Рекурсия: подменю
    SELECT
        m.menu_id,
        m.parent_menu_id,
        m.title,
        m.url,
        mt.level + 1,
        CONCAT(mt.breadcrumb, ' > ', m.title)
    FROM
        menu m
    JOIN
        menu_tree mt ON m.parent_menu_id = mt.menu_id
)
SELECT
    menu_id,
    REPEAT('  ', level - 1) AS indent,
    title,
    url,
    breadcrumb
FROM
    menu_tree
ORDER BY
    level,
    menu_id;
```

**Результат:**
```
menu_id | indent | title            | url                          | breadcrumb
1       |        | Главная          | /                            | Главная
2       |        | Каталог          | /catalog                     | Каталог
4       |   | Компьютеры       | /catalog/computers           | Каталог > Компьютеры
6       |       | Ноутбуки         | /catalog/computers/laptops   | Каталог > Компьютеры > Ноутбуки
7       |       | Настольные ПК    | /catalog/computers/desktops  | Каталог > Компьютеры > Настольные ПК
5       |   | Аксессуары       | /catalog/accessories         | Каталог > Аксессуары
8       |       | Мыши             | /catalog/accessories/mice    | Каталог > Аксессуары > Мыши
9       |       | Клавиатуры       | /catalog/accessories/keyboards| Каталог > Аксессуары > Клавиатуры
3       |        | О нас            | /about                       | О нас
10      |   | История          | /about/history               | О нас > История
11      |   | Команда          | /about/team                  | О нас > Команда
```

## Пример 5: Поиск путей в графе

Рекурсивные CTE используются для поиска всех путей между двумя узлами в графе (например, маршруты в системе доставки).

**Структура таблицы:**
```sql
CREATE TABLE города (
    город_id INT PRIMARY KEY,
    название VARCHAR(100)
);

CREATE TABLE маршруты (
    from_city_id INT,
    to_city_id INT,
    расстояние INT,
    PRIMARY KEY (from_city_id, to_city_id),
    FOREIGN KEY (from_city_id) REFERENCES города(город_id),
    FOREIGN KEY (to_city_id) REFERENCES города(город_id)
);

INSERT INTO города VALUES (1, 'Москва'), (2, 'Тверь'), (3, 'Смоленск'), (4, 'Брянск');

INSERT INTO маршруты VALUES
(1, 2, 170),   -- Москва → Тверь
(2, 3, 220),   -- Тверь → Смоленск
(1, 4, 380),   -- Москва → Брянск
(4, 3, 250);   -- Брянск → Смоленск
```

**Задача: Найти все маршруты из Москвы в Смоленск**

```sql
WITH RECURSIVE маршруты_поиск AS (
    -- Якорь: начинаем из Москвы (город_id = 1)
    SELECT
        from_city_id,
        to_city_id,
        расстояние,
        1 AS хопы,
        CAST(to_city_id AS CHAR(1000)) AS путь,
        расстояние AS всего_расстояние
    FROM
        маршруты
    WHERE
        from_city_id = 1
    
    UNION ALL
    
    -- Рекурсия: продолжаем из каждого пункта назначения
    SELECT
        мп.from_city_id,
        м.to_city_id,
        м.расстояние,
        мп.хопы + 1,
        CONCAT(мп.путь, ',', м.to_city_id),
        мп.всего_расстояние + м.расстояние
    FROM
        маршруты_поиск мп
    JOIN
        маршруты м ON мп.to_city_id = м.from_city_id
    WHERE
        мп.хопы < 10  -- Предотвращение циклов
        AND мп.путь NOT LIKE CONCAT('%,', м.to_city_id, '%')  -- Избегаем циклов
)
SELECT
    from_city_id,
    to_city_id,
    хопы,
    путь,
    всего_расстояние,
    ROUND(всего_расстояние / хопы, 2) AS среднее_расстояние_между_городами
FROM
    маршруты_поиск
WHERE
    to_city_id = 3  -- Конечный пункт: Смоленск
ORDER BY
    хопы,
    всего_расстояние;
```

## Лучшие практики и оптимизация

### 1. Всегда определяйте условие остановки

Рекурсия без условия остановки приведёт к бесконечному циклу:

```sql
-- ❌ ПЛОХО: Может привести к бесконечной рекурсии
WITH RECURSIVE bad_recursion AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM bad_recursion
)
SELECT * FROM bad_recursion;

-- ✅ ХОРОШО: Условие остановки включено
WITH RECURSIVE good_recursion AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM good_recursion
    WHERE n < 1000
)
SELECT * FROM good_recursion;
```

### 2. Используйте UNION ALL вместо UNION

`UNION ALL` не удаляет дубликаты и работает быстрее:

```sql
-- ❌ Медленнее
WITH RECURSIVE cte AS (
    SELECT ...
    UNION  -- Удаляет дубликаты
    SELECT ...
)

-- ✅ Быстрее
WITH RECURSIVE cte AS (
    SELECT ...
    UNION ALL  -- Не удаляет дубликаты
    SELECT ...
)
```

### 3. Избегайте циклических ссылок

Используйте проверку пути для предотвращения циклов:

```sql
WITH RECURSIVE safe_recursion AS (
    SELECT
        id,
        parent_id,
        CAST(id AS CHAR(1000)) AS path
    FROM
        table_name
    WHERE
        parent_id IS NULL
    
    UNION ALL
    
    SELECT
        t.id,
        t.parent_id,
        CONCAT(sr.path, ',', t.id)
    FROM
        table_name t
    JOIN
        safe_recursion sr ON t.parent_id = sr.id
    WHERE
        sr.path NOT LIKE CONCAT('%,', t.id, '%')  -- Проверка цикла
        AND sr.path NOT LIKE CONCAT(t.id, ',%')
)
SELECT * FROM safe_recursion;
```

### 4. Ограничивайте глубину рекурсии

Явно ограничивайте максимальную глубину:

```sql
WITH RECURSIVE limited_recursion AS (
    SELECT
        id,
        parent_id,
        0 AS level
    FROM table_name
    WHERE parent_id IS NULL
    
    UNION ALL
    
    SELECT
        t.id,
        t.parent_id,
        lr.level + 1
    FROM
        table_name t
    JOIN
        limited_recursion lr ON t.parent_id = lr.id
    WHERE
        lr.level < 20  -- Максимум 20 уровней
)
SELECT * FROM limited_recursion;
```

## Таблица применения рекурсивных CTE

| Задача | Пример | Сложность |
|--------|--------|-----------|
| Иерархия категорий | Категории товаров в магазине | Низкая |
| Организационная диаграмма | Структура компании, цепь подчинения | Низкая |
| BOM (Bill of Materials) | Состав производимых товаров | Средняя |
| Структура меню | Навигационные деревья веб-сайтов | Низкая |
| Поиск путей | Маршруты доставки, граф связей | Высокая |
| Дерево комментариев | Вложенные комментарии в соцсетях | Средняя |
| Граф зависимостей | Проекты и подзадачи | Средняя |
| Трассировка происхождения | Откуда происходит материал | Средняя |

## Ключевые выводы

- **Рекурсивные CTE** — мощный инструмент для работы с иерархическими данными
- **Структура**: якорный член + рекурсивный член + условие остановки
- **Якорный член** определяет начальные строки
- **Рекурсивный член** добавляет новые строки на основе предыдущих
- **Условие остановки** предотвращает бесконечные циклы
- **Практические применения**: категории, организационные структуры, BOM, меню, поиск путей
- **Производительность**: Чем проще структура, тем быстрее выполнение
- **Альтернативы**: Можно использовать процедурный код, но рекурсивные CTE часто проще и понятнее

Рекурсивные CTE превращают сложные иерархические запросы из головоломки в понятный SQL. Это незаменимый инструмент для любого, кто работает с древовидными и сетевыми структурами данных.

В следующих уроках мы рассмотрим более продвинутые техники оптимизации и специализированные функции SQL.
