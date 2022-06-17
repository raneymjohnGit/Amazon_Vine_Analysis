-- Select the vine_table data
SELECT * FROM VINE_TABLE;

-- Create a dataset  for total_votes >= 20
SELECT * FROM VINE_TABLE WHERE TOTAL_VOTES >= 20;

-- Create a new dataset or table to retrieve all the rows where the number of helpful_votes divided by total_votes is equal to or greater than 50%.
SELECT * FROM VINE_TABLE  A
WHERE TOTAL_VOTES >= 20
AND CAST(HELPFUL_VOTES AS FLOAT) /CAST(TOTAL_VOTES AS FLOAT) * 100 >= 50;


--Create a new Dataset or table that retrieves all the rows where a review was written as part of the Vine program (paid), vine == 'Y'.
SELECT * FROM VINE_TABLE 
WHERE TOTAL_VOTES >= 20
AND CAST(HELPFUL_VOTES AS FLOAT) /CAST(TOTAL_VOTES AS FLOAT) * 100 >= 50
AND VINE = 'Y';

--Create a new Dataset or table that retrieves all the rows where a review was written as not part of the Vine program (paid), vine == 'N'.
SELECT * FROM VINE_TABLE 
WHERE TOTAL_VOTES >= 20
AND CAST(HELPFUL_VOTES AS FLOAT) /CAST(TOTAL_VOTES AS FLOAT) * 100 >= 50
AND VINE = 'N';


--Determine the total number of reviews, the number of 5-star reviews, and the percentage of 5-star reviews for paid 

SELECT TOTAL_PAID_COUNT, 
       TOTAL_PAID_5_STAR_COUNT, 
	   CAST(TOTAL_PAID_5_STAR_COUNT AS FLOAT)/ CAST(TOTAL_PAID_COUNT AS FLOAT) * 100  AS TOTAL_PAID_5_STAR_PERCENTAGE 
	FROM ( SELECT COUNT(*) AS TOTAL_PAID_COUNT, 
				 SUM(CASE WHEN STAR_RATING = 5 THEN 1 ELSE 0 END) AS TOTAL_PAID_5_STAR_COUNT
		   FROM ( SELECT * FROM VINE_TABLE 
					WHERE TOTAL_VOTES >= 20
					  AND CAST(HELPFUL_VOTES AS FLOAT) /CAST(TOTAL_VOTES AS FLOAT) * 100 >= 50
	                  AND VINE = 'Y') A ) B;
	

--Determine the total number of reviews, the number of 5-star reviews, and the percentage of 5-star reviews for UNpaid 

SELECT TOTAL_UNPAID_COUNT, 
       TOTAL_UNPAID_5_STAR_COUNT, 
	   CAST(TOTAL_UNPAID_5_STAR_COUNT AS FLOAT)/ CAST(TOTAL_UNPAID_COUNT AS FLOAT) * 100 AS TOTAL_UNPAID_5_STAR_PERCENTAGE 
	FROM ( SELECT COUNT(*) AS TOTAL_UNPAID_COUNT, 
				 SUM(CASE WHEN STAR_RATING = 5 THEN 1 ELSE 0 END) AS TOTAL_UNPAID_5_STAR_COUNT
		   FROM ( SELECT * FROM VINE_TABLE 
					WHERE TOTAL_VOTES >= 20
					  AND CAST(HELPFUL_VOTES AS FLOAT) /CAST(TOTAL_VOTES AS FLOAT) * 100 >= 50
	                  AND VINE = 'N') A ) B;

-- Additional Analysis

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