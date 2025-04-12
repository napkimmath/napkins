/*The code below is starter code to query two or more tables or views 

For more information:
https://cloud.google.com/bigquery/docs/running-queries#queries
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#sql_syntax
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#join_types*/

SELECT t1.column_name1, 
  t1.column_name2, 
  sum(t2.column_name3) AS total_column_name3
FROM project.dataset.table1 AS t1
INNER JOIN project.dataset.table2 AS t2
  ON t1.column_name1 = t2.column_name1 
  AND t1.date_field = t2.date_field
WHERE t1.date_field >= '2025-01-01'
  AND t2.date_field >= '2025-01-01'
GROUP BY ALL;
