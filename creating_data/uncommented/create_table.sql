/* 
The code below creates an empty table with the specific structure listed below

Click the SQL tab to see the starter code, and to find more information
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
  date_field OPTIONS ( expiration_timestamp = TIMESTAMP '2026-01-01 00:00:00 UTC',
    description = 'a table that expires in 2026',
    labels = [('test_table',
      'development'),
    ('empty',
      'testing')] );
