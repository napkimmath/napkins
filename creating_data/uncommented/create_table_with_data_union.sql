/* 
This code inserts two rows into your table as you're creating it, using UNION ALL to bring in each record.
This took slightly more slot time (669 MS) than using STRUCT (608 MS).
https://github.com/napkimmath/building-blocks/blob/main/creating_data/create_table_with_data_struct.sql

CAUTION: If you run this more than 60 days after 2025-03-01 and you're using a BigQuery sandbox, 
your partitions may already be expired.

Click the SQL tab in the first link to see the starter code. Both links provide documentation:
https://cloud.google.com/bigquery/docs/tables#create_an_empty_table_with_a_schema_definition
https://cloud.google.com/bigquery/docs/reference/standard-sql/data-definition-language#create_table_statement
*/
CREATE OR REPLACE TABLE
  project.dataset.new_table 
  (integer_field INT64 OPTIONS (description = 'An INTEGER field'),
    array_field STRUCT < a STRING OPTIONS (description = 'A STRING field within an ARRAY'),
    b BOOL OPTIONS (description = 'A BOOLEAN field within an ARRAY') >,
    string_field string OPTIONS (description = 'A STRING field'),
    date_field date OPTIONS (description = 'A DATE field'),
    datetime_field datetime OPTIONS (description = 'A DATETIME field'),
    boolean_field boolean OPTIONS (description = 'A BOOLEAN field') )
PARTITION BY
  date_field 
OPTIONS ( expiration_timestamp = TIMESTAMP '2026-01-01 00:00:00 UTC',
    description = 'a table that expires in 2026',
    labels = [('test_table',
      'development'),
    ('empty',
      'testing')]) 
AS (
  SELECT
    1,
    STRUCT('sample1' AS a,
      TRUE AS b),
    'Sample String 1',
    DATE '2025-03-01',
    DATETIME '2025-03-01 12:00:00',
    TRUE
  UNION ALL
  SELECT
    2,
    STRUCT('sample2' AS a,
      FALSE AS b),
    'Sample String 2',
    DATE '2025-03-15',
    DATETIME '2025-03-15 18:30:00',
    FALSE 
) ;
