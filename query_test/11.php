<?php
$queryRegexValidator = ''; // Regexp expression to validate query string. If empty - no query validation validation
$validJsonResult = '[
    {
        "headers": [
            {
                "header": "actor_id",
                "pdo_type": 1
            },
            {
                "header": "first_name",
                "pdo_type": 2
            },
            {
                "header": "last_name",
                "pdo_type": 2
            },
            {
                "header": "last_update",
                "pdo_type": 2
            }
        ],
        "data": [
            [
                81,
                "SCARLETT",
                "DAMON",
                "2006-02-15 04:34:33"
            ],
            [
                124,
                "SCARLETT",
                "BENING",
                "2006-02-15 04:34:33"
            ]
        ]
    }
]'; 