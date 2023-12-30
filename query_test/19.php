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
                "header": "film_count",
                "pdo_type": 1
            }
        ],
        "data": [
            [
                35
            ]
        ]
    }
]'; 