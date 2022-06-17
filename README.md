# Amazon_Vine_Analysis
For learning Big Data Tools from Module 16

## Project Overview
Analyzing Amazon reviews written by members of the paid Amazon Vine program. The Amazon Vine program is a service that allows manufacturers and publishers to receive reviews for their products. Companies like SellBy pay a small fee to Amazon and provide products to Amazon Vine members, who are then required to publish a review.We have access to approximately 50 datasets. Each one contains reviews of a specific product, from clothing apparel to wireless products. 
We have to pick one of these datasets and use PySpark to perform the ETL process to extract the dataset, transform the data, connect to an AWS RDS instance, and load the transformed data into pgAdmin. Using  PySpark, Pandas, or SQL to determine if there is any bias toward favorable reviews from Vine members in your dataset. 
Then, you’ll write a summary of the analysis to submit to the SellBy stakeholders.

## Resources
- Google colab, PySpark, postgresql, jupyter notebook, pdAdmin, AWS RDS

## Challenge Overview
Prerequisite:
1.  Download the Amazon_Reviews_ETL_starter_code.ipynb and challenge_schema.sql


## Deliverable 1:  Perform ETL on Amazon Product Reviews

Follow the instructions below and the numbered comments in the starter code to complete Deliverable 1.

1. From the Amazon Review datasets, pick a dataset that you would like to analyze. All the datasets have the same schema.
2. Create a new database with Amazon RDS just as you did in this module.
3. In pgAdmin, create a new database in your Amazon RDS server that you just create.
4. In pgAdmin, run a new query to create the tables for your new database using the code from the challenge_schema.sql file.
5. After you run the query, you should have the following four tables in your database: customers_table, products_table, review_id_table, and vine_table.
6. Download the Amazon_Reviews_ETL_starter_code.ipynb file, then upload the file as a Google Colab Notebook, and rename it Amazon_Reviews_ETL.
7. First extract one of the review datasets, then create a new DataFrame.
8. To create the customers_table, use the code in the Amazon_Reviews_ETL_starter_code.ipynb file and follow the steps below to aggregate the reviews by customer_id.
   a.   Use the groupby() function on the customer_id column of the DataFrame you created in Step 6.
   b.   Count all the customer ids using the agg() function by chaining it to the groupby() function. After you use this function, a new column will be created, 
        count(customer_id).
   c.   Rename the count(customer_id) column using the withColumnRenamed() function so it matches the schema for the customers_table in pgAdmin.   
9. To create the products_table, use the select() function to select the product_id and product_title, then drop duplicates with the drop_duplicates() function to retrieve only unique product_ids. 
10. To create the review_id_table, use the select() function to select the columns that are in the review_id_table in pgAdmin (as shown in the following image), and convert the review_date column to a date using the code snippet provided in the Amazon_Reviews_ETL_starter_code.ipynb file.
11. To create the vine_table, use the select() function to select only the columns that are in the vine_table in pgAdmin (as shown in the following image).
12. Load the DataFrames into pgAdmin
13. Make the connection to your AWS RDS instance.
14. Load the DataFrames that correspond to tables in pgAdmin.
15. In pgAdmin, run a query to check that the tables have been populated..

## Deliverable 2:  Determine Bias of Vine Reviews

Using PySpark, Pandas, or SQL, determine if there is any bias towards reviews that were written as part of the Vine program. 
For this analysis, you'll determine if having a paid Vine review makes a difference in the percentage of 5-star reviews.


1. Filter the data and create a new DataFrame or table to retrieve all the rows where the total_votes count is equal to or greater than 20 to pick reviews that are 
    more likely to be helpful and to avoid having division by zero errors later on.
2. Filter the new DataFrame or table created in Step 1 and create a new DataFrame or table to retrieve all the rows where the number of helpful_votes divided by 
    total_votes is equal to or greater than 50%.
3. Filter the DataFrame or table created in Step 2, and create a new DataFrame or table that retrieves all the rows where a review was written as part of the Vine 
    program (paid), vine == 'Y'.
4. Repeat Step 3, but this time retrieve all the rows where the review was not part of the Vine program (unpaid), vine == 'N'.
5. Determine the total number of reviews, the number of 5-star reviews, and the percentage of 5-star reviews for the two types of review (paid vs unpaid).


Using PySpark
1. Create a new Google Colab Notebook, and name it Vine_Review_Analysis.
2. Extract the dataset you used in Deliverable 1.
3. Recreate the vine_table, and perform your analysis using the steps above.
4. Export your Vine_Review_Analysis_PySpark.ipynb Google Colab Notebook as an ipynb file, and save it to your Amazon_Vine_Analysis GitHub repository.

Using Pandas
1. From pgAdmin, export the vine_table as a CSV file, and save it to your Amazon_Vine_Analysis GitHub repository.
2. Create a new Jupyter Notebook, and name it Vine_Review_Analysis.ipynb.
3. Read in the vine_table.csv file as a DataFrame, and perform your analysis using the steps above.
4. Save your Vine_Review_Analysis_Pandas.ipynb file to your Amazon_Vine_Analysis GitHub repository.

Using SQL in pgAdmin

1. From your AWS database, export the vine_table as a CSV file and save it to your Amazon_Vine_Analysis GitHub repository.
2. In pgAdmin, create a new database that is not linked to your AWS RDS instance. This way, you don’t have to keep incurring charges while connected to your AWS RDS 
    instance.
3. Create a new SQL file and name it Vine_Review_Analysis.sql.
4. Recreate the vine_table using the schema provided in the challenge_schema.sql file.
5. Import the vine_table.csv file into the table, and perform your analysis using the steps above.
6. Save all your SQL queries to the Vine_Review_Analysis_SQL.sql file, then add it to your Amazon_Vine_Analysis GitHub repository.


## Amazon_Vine_Analysis Results
  - Total Vine reviews and Non Vine reviews
    ![image_name](https://github.com/raneymjohnGit/Amazon_Vine_Analysis/blob/main/Resources/Total_Reviews.png)
 
  - Total 5 star Vine reviews and Total 5 star Non Vine reviews
    ![image_name](https://github.com/raneymjohnGit/Amazon_Vine_Analysis/blob/main/Resources/PercentageReviews.png)

  - Percentage for 5 star Vine reviews and Percentage for 5 star Non Vine reviews
    ![image_name](https://github.com/raneymjohnGit/Amazon_Vine_Analysis/blob/main/Resources/FiveStarReviews.png)

## Amazon_Vine_Analysis Summary

1.  Based on the analysis, we can safely conclude that there is NO positivity bias for reviews in the Vine program. The percentage of 5 star Vine and 5 star non 
    Vine reviews are the same.
2.  If we look at the other stars they are equally distributed for the Vine reviews that have a total count greater than 1

    SELECT TOTAL_PAID_COUNT, 
       TOTAL_PAID_LOW_STAR_COUNT, 
	   CAST(TOTAL_PAID_LOW_STAR_COUNT AS FLOAT)/ CAST(TOTAL_PAID_COUNT AS FLOAT) * 100 AS TOTAL_PAID_LOW_STAR_PERCENTAGE,
	   TOTAL_PAID_MEDIUM_STAR_COUNT, 
	   CAST(TOTAL_PAID_MEDIUM_STAR_COUNT AS FLOAT)/ CAST(TOTAL_PAID_COUNT AS FLOAT) * 100 AS TOTAL_PAID_MEDIUM_STAR_PERCENTAGE,
	   TOTAL_PAID_5_STAR_COUNT, 
	   CAST(TOTAL_PAID_5_STAR_COUNT AS FLOAT)/ CAST(TOTAL_PAID_COUNT AS FLOAT) * 100 AS TOTAL_PAID_5_STAR_PERCENTAGE
	FROM ( SELECT COUNT(*) AS TOTAL_PAID_COUNT, 
				 SUM(CASE WHEN STAR_RATING in (1,2) THEN 1 ELSE 0 END) AS TOTAL_PAID_LOW_STAR_COUNT,
		  		 SUM(CASE WHEN STAR_RATING in (3,4) THEN 1 ELSE 0 END) AS TOTAL_PAID_MEDIUM_STAR_COUNT,
		  		SUM(CASE WHEN STAR_RATING in (5) THEN 1 ELSE 0 END) AS TOTAL_PAID_5_STAR_COUNT
		   FROM ( SELECT * FROM VINE_TABLE 
					WHERE TOTAL_VOTES >= 1
					  AND CAST(HELPFUL_VOTES AS FLOAT) /CAST(TOTAL_VOTES AS FLOAT) * 100 >= 50
	                  AND VINE = 'Y') A ) B;

    ![image_name](https://github.com/raneymjohnGit/Amazon_Vine_Analysis/blob/main/Resources/Additonal_Analysis.png)