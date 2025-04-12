/* 
This code inserts two rows into your table as you're creating it, using STRUCT to bring in each record.
This took slightly less slot time (609 MS) than using UNION ALL (669 MS).
https://github.com/napkimmath/building-blocks/blob/main/creating_data/create_table_with_data_union.sql

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
AS
SELECT
  *
FROM
  
--in this format, you unnest a comma separated list of each row you want to add
--format: UNNEST([row1, row2, ...])
  UNNEST([ 
  
--to create each row, you wrap a list of all the columns with STRUCT
--this first section represents row1
--format: STRUCT(row1_column1_value AS column_name1, row1_column2_value AS column_name2, ...)
  STRUCT( 1 AS integer_field,
      STRUCT('sample1' AS a,
        TRUE AS b) AS array_field,
      'Sample String 1' AS string_field,
      DATE '2025-03-01' AS date_field,
      DATETIME '2025-03-01 12:00:00' AS datetime_field,
      TRUE AS boolean_field ), 
  
--this second section represents row2
--format: STRUCT(row2_column1_value AS column_name1, row2_column2_value AS column_name2, ...)
  STRUCT( 2,
      STRUCT( 'sample2' AS a,
        FALSE AS b),
      'Sample String 2',
      DATE '2025-03-15',
      DATETIME '2025-03-15 18:30:00',
      FALSE )
  ]);

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

more information on arrays:
array type: https://cloud.google.com/bigquery/docs/reference/standard-sql/data-types#array_type
array literals: https://cloud.google.com/bigquery/docs/reference/standard-sql/lexical#array_literals
work with arrays: https://cloud.google.com/bigquery/docs/arrays

unnest: https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#unnest_operator
*/
