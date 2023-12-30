<?php
// Regexp expression to validate query string. If array empty - no query validation validation
$queryRegexValidator = [
     'queryMatch' => '/film_count/',
    //  'queryNotMatch' => '//',
];
$validJsonResult = '[
    {
        "headers": [
            {
                "header": "first_name",
                "pdo_type": 2
            },
            {
                "header": "last_name",
                "pdo_type": 2
            },
            {
                "header": "film_count",
                "pdo_type": 1
            }
        ],
        "data": [
            [
                "SCARLETT",
                "DAMON",
                36
            ],
            [
                "SANDRA",
                "KILMER",
                37
            ],
            [
                "MATTHEW",
                "CARREY",
                39
            ],
            [
                "MARY",
                "KEITEL",
                40
            ],
            [
                "WALTER",
                "TORN",
                41
            ],
            [
                "GINA",
                "DEGENERES",
                42
            ],
            [
                "SUSAN",
                "DAVIS",
                54
            ]
        ]
    }
]'; 