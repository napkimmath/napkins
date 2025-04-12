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
      'development'),('empty','testing')])
  
--then you use AS and then write the query to SELECT the data you want in the table below
--the parentheses are optional, I prefer them to help me separate out different sections
AS (
  
--in this format, each row is represented by separate queries, combined using a UNION ALL
--format: query1 UNION ALL query2 UNION ALL query3 ...
--this block represents row1
  SELECT
    1,
    STRUCT('sample1' AS a,
      TRUE AS b),
    'Sample String 1',
    DATE '2025-03-01',
    DATETIME '2025-03-01 12:00:00',
    TRUE

--use a union all between each "row"
  UNION ALL

--this block represents row2
  SELECT
    2,
    STRUCT('sample2' AS a,
      FALSE AS b),
    'Sample String 2',
    DATE '2025-03-15',
    DATETIME '2025-03-15 18:30:00',
    FALSE 
  ) ;

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

UNION ALL: https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#union_example
*/
