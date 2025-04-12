/* The code below is starter code to query one table or view 

For more information:
https://cloud.google.com/bigquery/docs/running-queries#queries 
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#sql_syntax*/

/* your SELECT statement tells you WHAT you want to return
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#select_list
*/
SELECT column_name1, 
  column_name2, 
  sum(column_name3) AS total_column_name3
  
/*your FROM tells you WHERE you want to get the data
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#from_clause
format: project_name.dataset_name.table_name*/
FROM project.dataset.table
  
/*your WHERE tells you HOW you should filter the data
it uses the names in your original dataset, not any aliases you created in your select (like total_column_name3)
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#where_clause
*/
WHERE date_field >= '2025-01-01'

/*if you have an analytic function (like sum) you need to say how you're grouping your data aka the unique column combinations that have a sum
your output will have a grain of one row per however you group (in this case, one row per column_name1 and column_name2)
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#group_by_clause */
GROUP BY ALL
/* alternative 1: GROUP BY 1,2
alternative 2: GROUP BY column_name1, column_name2*/
