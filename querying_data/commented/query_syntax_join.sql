/*The code below is starter code to query two or more tables or views 

For more information:
https://cloud.google.com/bigquery/docs/running-queries#queries
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#sql_syntax
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#join_types*/


/* your SELECT statement tells you WHAT you want to return
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#select_list
*/
SELECT t1.column_name1, 
  t1.column_name2, 
  sum(t2.column_name3) AS total_column_name3

/*your FROM tells you WHERE you want to get the data
since you have two tables, you want to alias them with AS so that when you reference them,
  your query knows what table you're referring to
  
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#from_clause
  
format: project_name.dataset_name.table_name*/
FROM project.dataset.table1 AS t1
  
/*a join combines two or more tables/views into one.
an INNER JOIN means that the value must be in both tables, 
  a LEFT JOIN means that the value must be in table1 but doesn't have to be in table2 (similarly RIGHT JOIN with table2)
  an OUTER JOIN means that the value could be in either table1 or table2

you first specify WHAT table you're joining to and HOW you're joining (INNER, LEFT, etc)
  and then specify WHAT columns or conditions you're using to join
  
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#join_types*/
INNER JOIN project.dataset.table2 AS t2
  ON t1.column_name1 = t2.column_name1 
  AND t1.date_field = t2.date_field
  /*alternative if all the columns in the join have the same name: using(column_name1, date_field) */

/*your WHERE tells you HOW you should filter the data
it uses the names in your original dataset, not any aliases you created in your select (like total_column_name3)
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#where_clause
*/
WHERE t1.date_field >= '2025-01-01'
  AND t2.date_field >= '2025-01-01'

/*if you have an analytic function (like sum) you need to say how you're grouping your data aka the unique column combinations that have a sum
your output will have a grain of one row per however you group (in this case, one row per column_name1 and column_name2)
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#group_by_clause */
GROUP BY ALL
/* alternative 1: GROUP BY 1,2
alternative 2: GROUP BY t1.column_name1, t1.column_name2*/
