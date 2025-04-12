/* 
While the view metadata shows the tags field as a string, 
it is actually an array and will have to be queried appropriately to use

Click the SQL tab in the first link to see the starter code. Both links provide documentation:
https://cloud.google.com/bigquery/docs/views#creating_a_view
https://cloud.google.com/bigquery/docs/reference/standard-sql/data-definition-language#create_view_statement
*/
CREATE OR REPLACE VIEW
  project.dataset.new_view 
  (integer_field OPTIONS (description = 'An INTEGER field'),
    array_field OPTIONS (description = 'An ARRAY field'),
    string_field OPTIONS (description = 'A STRING field'),
    date_field OPTIONS (description = 'A DATE field'),
    datetime_field OPTIONS (description = 'A DATETIME field'),
    boolean_field OPTIONS (description = 'A BOOLEAN field') ) OPTIONS ( expiration_timestamp = TIMESTAMP '2026-01-01 00:00:00 UTC',
    description = 'a view that expires in 2026',
    labels = [('test_view',
      'development')]) 
AS (
  SELECT
    1,
    STRUCT('sample1' AS a,
      TRUE AS b),
    'Sample String 1',
    DATE '2025-03-01',
    DATETIME '2025-03-01 12:00:00',
    TRUE 
  );
