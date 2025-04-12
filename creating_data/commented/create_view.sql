/* 
While the view metadata shows the tags field as a string, 
it is actually an array and will have to be queried appropriately to use

Click the SQL tab in the first link to see the starter code. Both links provide documentation:
https://cloud.google.com/bigquery/docs/views#creating_a_view
https://cloud.google.com/bigquery/docs/reference/standard-sql/data-definition-language#create_view_statement
*/

-- when I'm iterating, I generally use create or replace (instead of just create) to create a view
--CAUTION: if you do use "or replace", make sure you're not replacing an existing view that you want to keep
--as it won't keep anything - metadata OR data
CREATE OR REPLACE VIEW

--where you want your new view to go, including the name.
--format: project_name.dataset_name.view_name
  project.dataset.new_view 

--list all column names within parenthesis separated by commas
--the data type is inherited from the query to create the view, it doesn't need to be stated
--options are optional, but I include them so others can undestand my data without going to a separate data dictionary
--format: (field1 OPTIONS (description='description'), field2 OPTIONS (description='description'))  
  (integer_field OPTIONS (description = 'An INTEGER field'),
    array_field OPTIONS (description = 'An ARRAY field'),
    string_field OPTIONS (description = 'A STRING field'),
    date_field OPTIONS (description = 'A DATE field'),
    datetime_field OPTIONS (description = 'A DATETIME field'),
    boolean_field OPTIONS (description = 'A BOOLEAN field') ) 
  
--any additional options are then added, I recomment at least the view description
--format: OPTIONS (option1 = value, option2 = value) 
  OPTIONS ( expiration_timestamp = TIMESTAMP '2026-01-01 00:00:00 UTC',
    description = 'a view that expires in 2026',
    labels = [('test_view',
      'development')]) 
  
  --then you use AS and then write the query to SELECT the data you want in the view below
  --you'd normally use a query pulling data from another table, I'm inserting fake data for illustrative purposes
  AS (

  --your query to pull back your data goes here
  SELECT
    1,
    STRUCT('sample1' AS a,
      TRUE AS b),
    'Sample String 1',
    DATE '2025-03-01',
    DATETIME '2025-03-01 12:00:00',
    TRUE
 );

/* 
more specific information for pieces included above

create view syntax: https://cloud.google.com/bigquery/docs/reference/standard-sql/data-definition-language#create_view_statement
table path syntax: https://cloud.google.com/bigquery/docs/reference/standard-sql/data-definition-language#table_path
columns: https://cloud.google.com/bigquery/docs/reference/standard-sql/data-definition-language#view_column_name_list
column options: https://cloud.google.com/bigquery/docs/reference/standard-sql/data-definition-language#view_column_option_list
view options: https://cloud.google.com/bigquery/docs/reference/standard-sql/data-definition-language#view_option_list
*/
