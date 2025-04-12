/*The code below is starter code to query one table or view 

For more information:
https://cloud.google.com/bigquery/docs/running-queries#queries 
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#sql_syntax*/

SELECT column_name1, 
  column_name2, 
  sum(column_name3) AS total_column_name3
FROM project.dataset.table
WHERE date_field >= '2025-01-01'
GROUP BY ALL;
