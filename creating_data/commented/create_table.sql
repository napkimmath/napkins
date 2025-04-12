/* 
The code below creates an empty table with the specific structure listed below

Click the SQL tab to see the starter code, and to find more information
https://cloud.google.com/bigquery/docs/tables#create_an_empty_table_with_a_schema_definition
https://cloud.google.com/bigquery/docs/reference/standard-sql/data-definition-language#create_table_statement
*/

-- when I'm iterating, I generally use create or replace (instead of just create) to create a table
--CAUTION: if you do use "or replace", make sure you're not replacing an existing table that you want to keep
--as it won't keep anything - metadata OR data
CREATE OR REPLACE TABLE
  
--where you want your new table to go, including the name.
--format: project_name.dataset_name.table_name
  project.dataset.new_table 
  
--list all column names within parenthesis separated by commas
--options are optional, but I include them so others can undestand my data without going to a separate data dictionary
--format: (field1 type OPTIONS (description='description'), field2 type OPTIONS (description='description'))
  (integer_field INT64 OPTIONS (description = 'An INTEGER field'),
    array_field STRUCT < a STRING OPTIONS (description = 'A STRING field within an ARRAY'),
    b BOOL OPTIONS (description = 'A BOOLEAN field within an ARRAY') >,
    string_field string OPTIONS (description = 'A STRING field'),
    date_field date OPTIONS (description = 'A DATE field'),
    datetime_field datetime OPTIONS (description = 'A DATETIME field'),
    boolean_field boolean OPTIONS (description = 'A BOOLEAN field') )
  
--if you have a date field I recommend using it as a partition. if a query uses a filter on the partitioned column, 
--you will only scan the partitions that match the filter and skip the remaining partitions (saving processing time and $$)
PARTITION BY
  date_field 
  
--any additional options are then added, I recomment at least the table description
--format: OPTIONS (option1 = value, option2 = value)
OPTIONS ( expiration_timestamp = TIMESTAMP '2026-01-01 00:00:00 UTC',
    description = 'a table that expires in 2026',
    labels = [('test_table',
      'development'),('empty','testing')]
  );

/* 
more specific information for pieces included above

create table syntax: https://cloud.google.com/bigquery/docs/reference/standard-sql/data-definition-language#syntax_2
table path syntax: https://cloud.google.com/bigquery/docs/reference/standard-sql/data-definition-language#table_path
columns: https://cloud.google.com/bigquery/docs/reference/standard-sql/data-definition-language#column_name_and_column_schema
column options: https://cloud.google.com/bigquery/docs/reference/standard-sql/data-definition-language#column_option_list
partitions: https://cloud.google.com/bigquery/docs/partitioned-tables
partition expressions: https://cloud.google.com/bigquery/docs/reference/standard-sql/data-definition-language#partition_expression
table options: https://cloud.google.com/bigquery/docs/reference/standard-sql/data-definition-language#table_option_list

if you are dealing with a large table, in addition to a partition you can also use clusters:
https://cloud.google.com/bigquery/docs/reference/standard-sql/data-definition-language#clustering_column_list
*/
