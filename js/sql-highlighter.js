class SQLHighlighter {
    static keyWords = [
        'CREATE\\s+TEMPORARY\\s+TABLE', 'CREATE\\s+VIEW', 'CHARACTER\\s+SET', 'COLLATE', 'DEFAULT', 'UNIQUE',
        'SELECT\\s+DISTINCT', 'SELECT', 'FROM', 'WHERE', 'GROUP\\s+BY\\s+ROLLUP', 'GROUP\\s+BY',  'ORDER\\s+BY', 'AS', 'AND', 'OR', 'NOT', 'IN', 'EXISTS', 'BETWEEN', 'LIKE', 'IS\\s+NULL', 'IS\\s+NOT\\s+NULL', 'CASE', 'WHEN', 'THEN', 'ELSE', 'END', 'UNION', 'ALL', 'ANY', 'SOME', 'HAVING', 'LIMIT', 'OFFSET',
        'INSERT', 'UPDATE', 'DELETE', 'LEFT\\s+JOIN', 'RIGHT\\s+JOIN', 'INNER\\s+JOIN', 'FULL\\s+OUTER\\s+JOIN', 'OUTER\\s+JOIN', 'CROSS\\s+JOIN', 'JOIN', 'ON', 'USING', 'CREATE\\s+TABLE', 'ALTER\\s+TABLE', 'DROP\\s+TABLE', 'CREATE\\s+INDEX', 'DROP\\s+INDEX', 'PRIMARY\\s+KEY', 'FOREIGN\\s+KEY', 'REFERENCES',
        'ASC', 'DESC', 'DISTINCT', 'NULL', 'TRUE', 'FALSE', 'CUBE', 'GROUPING\\s+SETS', 'WITH\\s+ROLLUP', 'WITH\\s+CUBE', 'WITH\\s+GROUPING\\s+SETS', 'OVER', 'PARTITION\\s+BY', 'RANK', 'DENSE_RANK', 'ROW_NUMBER', 'NTILE', 'WITH\\s+RECURSIVE', 'WITH'
    ];
    static functions = ['COUNT', 'SUM', 'AVG', 'MIN', 'MAX', 'NOW', 'COALESCE', 'IFNULL', 'ISNULL', 'LENGTH', 'SUBSTRING', 'TRIM', 'ROUND', 'CAST', 'CONVERT', 'UPPER', 'LOWER', 'ABS', 'CEIL', 'CEILING', 'FLOOR', 'RAND', 'DATE', 'TIME', 'DATEDIFF', 'TIMESTAMPDIFF',
        'CONCAT', 'CONCAT_WS', 'REPLACE', 'REVERSE', 'LPAD', 'RPAD', 'LTRIM', 'RTRIM', 'LOCATE', 'POSITION', 'CHAR_LENGTH', 'CHARACTER_LENGTH', 'BIT_LENGTH', 'OCTET_LENGTH', 'FORMAT', 'EXTRACT', 'DATE_ADD', 'DATE_SUB', 'DATE_FORMAT','STRFTIME',
        'LEFT', 'RIGHT', 'MID', 'INSTR', 'STRCMP', 'REPEAT', 'WEEKDAY', 'WEEKOFYEAR', 'DAYOFMONTH', 'DAYOFWEEK', 'DAYOFYEAR', 'HOUR', 'MINUTE', 'SECOND', 'MONTHNAME', 'QUARTER', 'YEAR', 'POWER', 'POW', 'MOD', 'SIGN', 'SQRT', 'TRUNCATE', 'LOG', 'LOG10', 'LOG2', 'EXP', 'PI', 'RADIANS', 'DEGREES', 'GREATEST', 'LEAST',
        'SUBSTRING_INDEX', 'GROUPING', 'GROUP_CONCAT', 'JSON_EXTRACT', 'JSON_ARRAYAGG', 'JSON_OBJECTAGG', 'JSON_MERGE_PATCH', 'JSON_MERGE_PRESERVE', 'JSON_SET', 'JSON_REPLACE', 'JSON_REMOVE', 'JSON_KEYS', 'JSON_LENGTH', 'JSON_TYPE', 'JSON_VALID', 'MONTH','DAY', 'DATE_TRUNC'
    ];
    static constants = [
        'CURRENT_DATE', 'CURRENT_TIME', 'CURRENT_TIMESTAMP', 'LOCALTIME', 'LOCALTIMESTAMP', 'SYSDATE', 'UTC_DATE', 'UTC_TIME', 'UTC_TIMESTAMP', 'DAYNAME', 'DAYOFMONTH', 'DAYOFWEEK', 'DAYOFYEAR'//, 'HOUR', 'MINUTE', 'MONTHNAME', 'QUARTER', 'SECOND', 'WEEK', 'YEAR'
    ];
    static types = [
        'INT', 'INTEGER', 'SMALLINT', 'TINYINT', 'MEDIUMINT', 'BIGINT', 'DECIMAL', 'NUMERIC', 'FLOAT', 'DOUBLE', 'REAL', 'BIT', 'BOOLEAN', 'BOOL',
        'CHAR', 'VARCHAR', 'NCHAR', 'NVARCHAR', 'TEXT', 'TINYTEXT', 'MEDIUMTEXT', 'LONGTEXT',
        'BINARY', 'VARBINARY', 'BLOB', 'TINYBLOB', 'MEDIUMBLOB', 'LONGBLOB',
        'DATE', 'TIME', 'DATETIME', 'TIMESTAMP', 'YEAR', 'ENUM', 'SET', 'JSON', 'UUID', 'SERIAL', 'MONEY', 'XML', 'ARRAY'
    ];

    static extend({ keyWords = [], functions = [], constants = [], types = [] } = {}) {
        SQLHighlighter.keyWords = [...SQLHighlighter.keyWords, ...keyWords];
        SQLHighlighter.functions = [...SQLHighlighter.functions, ...functions];
        SQLHighlighter.constants = [...SQLHighlighter.constants, ...constants];
        SQLHighlighter.types = [...SQLHighlighter.types, ...types];
    }
    static getCodeBlocks() {
        return document.querySelectorAll('pre code');
    }
    static highlightCode(block) {
        console.log('highlightCode', block);
        if (block.classList.contains('language-sql')) {
            SQLHighlighter.highlightCodeSQL(block);
        } else {
            SQLHighlighter.highlightCodeCommon(block);
        }
    }
    static highlightCodeCommon(block) {

    }
    static highlightCodeSQL(block) {
        const keyWords = SQLHighlighter.keyWords;
        let html = block.innerHTML;

        // mask out comments and string literals so keyword/function/number
        // highlighting never touches them
        const comments = [];
        const strings = [];
        const tokenGuard = String.fromCharCode(1);
        const commentToken = tokenGuard + 'SQLCMT' + tokenGuard;
        const stringToken = tokenGuard + 'SQLSTR' + tokenGuard;
        html = html.replace(/(--[^\n]*|\/\*[\s\S]*?\*\/|'(?:[^'\\]|\\.|'')*'|"(?:[^"\\]|\\.|"")*")/g, (match) => {
            if (match.startsWith('-') || match.startsWith('/*')) {
                comments.push(match);
                return commentToken;
            }
            strings.push(match);
            return stringToken;
        });

        keyWords.forEach((word) => {
            // negative lookahead: skip matches already wrapped by a previous rule
            // (e.g. don't re-wrap "SELECT" inside "<span class="hljs-keyword">SELECT DISTINCT</span>")
            const regex = new RegExp(`\\b(${word})\\b(?![^<]*</span>)`, 'gi');
            html = html.replace(regex, (match, p1, offset) => {
                return `<span class="keyword">${p1}</span>`;
            });
        });
        const functions = SQLHighlighter.functions;
        functions.forEach((func) => {
            // negative lookahead: skip matches already wrapped by a previous rule
            // (e.g. don't re-wrap "SELECT" inside "<span class="hljs-keyword">SELECT DISTINCT</span>")
            // positive lookahead: only treat it as a function call if followed by '('
            const regex = new RegExp(`\\b(${func})\\b(?=\\s*\\()(?![^<]*</span>)`, 'gi');
            html = html.replace(regex, (match, p1, offset) => {
                return `<span class="built-in">${p1}</span>`;
            });
        });
        const constants = SQLHighlighter.constants;
        constants.forEach((constant) => {
            // negative lookahead: skip matches already wrapped by a previous rule
            // (e.g. don't re-wrap "SELECT" inside "<span class="hljs-keyword">SELECT DISTINCT</span>")
            const regex = new RegExp(`\\b(${constant})\\b(?![^<]*</span>)`, 'gi');
            html = html.replace(regex, (match, p1, offset) => {
                return `<span class="built-in">${p1}</span>`;
            });
        });
        const types = SQLHighlighter.types;
        types.forEach((type) => {
            // negative lookahead: skip matches already wrapped by a previous rule
            // (e.g. don't re-wrap "DATE" inside "<span class="built-in">DATE</span>(...)")
            const regex = new RegExp(`\\b(${type})\\b(?![^<]*</span>)`, 'gi');
            html = html.replace(regex, (match, p1, offset) => {
                return `<span class="type">${p1}</span>`;
            });
        });
        html = html.replace(new RegExp(`\\b(\\d+)\\b(?![^<]*</span>)`, 'gi'), (match, p1, offset) => {
            return `<span class="number">${p1}</span>`;
        });

        // restore strings and comments, in their original order, now wrapped for styling
        html = html.split(stringToken).map((part, i) => {
            return i === 0 ? part : `<span class="string">${strings[i - 1]}</span>${part}`;
        }).join('');
        html = html.split(commentToken).map((part, i) => {
            return i === 0 ? part : `<span class="comment">${comments[i - 1]}</span>${part}`;
        }).join('');

        block.innerHTML = html;
    }
    static highlightCodeBlocks() {
        const codeBlocks = SQLHighlighter.getCodeBlocks();
        codeBlocks.forEach((block) => {
            SQLHighlighter.highlightCode(block);
        });
    }
}
