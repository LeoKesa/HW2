/*
DB Assignment 2
Leonidas Kesaris
9/23/2024
*/

-- //////////////////////////////////////////////Problem 1////////////////////////////////////////////////////

-- uses the restaurant database in which the tables for each CSV file are located
use restaurant; 

-- calculates average price of food for each restaurant
select restaurants.restID,restaurants.name,avg(foods.price) AS AVG_Food_price
from restaurants

-- joins to indicate food items offered at each restaurant
join serves on restaurants.restID = serves.restID

-- joins to acquire price for each food item 
join foods on serves.foodID = foods.foodID

-- Groups the results by restaurant ID and restaurant name to show average food item price per each unique restaurant
GROUP BY restaurants.restID, restaurants.name;

-- ///////////////////////////start of Problem 2 ////////////////////////////////
use restaurant;

-- Selects restaurant name, restID and the maximum price of the food served and gives it the alias of Max_price for use in the table
select restaurants.restID,restaurants.name,MAX(foods.price) AS Max_price
from restaurants

join serves on restaurants.restID = serves.restID

-- Joins the foods table with the serves table via food ID to to aquire the price of each food item 
join foods on serves.foodID = foods.foodID

-- Groups the resulting output by restaurant ID and restaurant name with Max_price matching each unique restaurant
GROUP BY restaurants.restID, restaurants.name;

-- ///////////////////////////////////////////Problem 3 /////////////////////////////////////////
use restaurant;

-- selects restaurants ID, name and counts the number of food types served at each restaurant which is given the alias Num_Rest_Food_Types
select restaurants.restID,restaurants.name,count(foods.type) AS Num_Rest_Food_Types
from restaurants

-- links restaurants table and servers giving access to food items served by restaurants
join serves on restaurants.restID = serves.restID

-- links serves table with the foods table enabling retrieval of food type
join foods on serves.foodID = foods.foodID

-- Allows the count() to count each restaurant individually instead of having the Num_Rest_Food_Types value simply total all food types. 
GROUP BY restaurants.RestID, restaurants.name;

-- ////////////////////////////////////////////////Problem 4////////////////////////////////////////////////////////////////
use restaurant;

-- Calculates the average price of the food for each restaraunt the chef works. The resulting value is given alias avg_price
select chefs.chefID,chefs.name, AVG(foods.price) AS avg_price
from chefs

join works on chefs.chefID = works.chefID

-- Enables access to food items at specific restaurants chefs work 
join serves on works.restID = serves.restID

-- Enables retrieval the prices of food items at specific restaurants
join foods on serves.foodID = foods.foodID

-- groups by chef ID and chef name in order to calculate average food price is per each individual chef 
group by chefs.chefID, chefs.name;

-- ////////////////////////////////////////Problem 5/////////////////////////////////////////////////
use restaurant;

-- Calculates the average price of food at said restaurant in the alias AVG_price
select restaurants.name, AVG(foods.price) AS AVG_Price
from restaurants

-- Gives access to each restaurant's food items
Join serves on restaurants.restID = serves.restID

-- Allows retrieval of prices for the food items of each restaurant
join foods on serves.foodID = foods.foodID

-- groups by restaurant ID and name to maintain average price for individual restaurants. 
group by restaurants.restID, restaurants.name

-- Descending order so the highest value is given.
order by AVG_Price DESC

-- Restricts output to 1 value to ensure only the highest value for average price is given along with the restaurant's name. 
LIMIT 1;

-- ///////////////////////////////////////// Extra Credit ///////////////////////////////////////////////////////////////////
use restaurant;

-- Selects chef name, average price of each food item served at chef restaurant, and the restaurant's name. 
-- Group_Concat combines the different names of restraunts which each chef works accounting for multiple restaurants.
select chefs.name, AVG(foods.price) AS AVG_price, group_concat(DISTINCT restaurants.name) AS restaurants
From chefs

JOIN works on chefs.chefID = works.chefID

-- Aquires food items from restaurants
JOIN serves on works.restID = serves.restID 

-- Enables retrieval of the food price
JOIN foods on serves.foodID = foods.foodID

-- Enables retrieval of restaurant names
JOIN restaurants on works.restID = restaurants.restID

-- Groups results of the query by chefID and chefs names to calculate average food price per chef
GROUP BY chefs.chefID

-- Orders the results by average food price in descending order to only show the chef with the highest average food price
Order by AVG_price DESC
LIMIT 1;