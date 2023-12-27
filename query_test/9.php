<?php
$queryRegexValidator = '/^((?!join).)*$/i'; // not contains join 
$validJsonResult = '[
    {
        "headers": [
            {
                "header": "address",
                "pdo_type": 2
            },
            {
                "header": "postal_code",
                "pdo_type": 2
            }
        ],
        "data": [
            [
                "1497 Yuzhou Drive",
                "3433"
            ],
            [
                "548 Uruapan Street",
                "35653"
            ]
        ]
    }
]';