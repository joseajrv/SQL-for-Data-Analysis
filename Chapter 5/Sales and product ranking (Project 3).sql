-- Chapter 5 Project work (3)
-- Sales and product analysis project

/*	-- Scenario --- Study our best customers sales and best products

	Our business has a lot of customers and products.
	
	The CRM manager wants a list of all customers with name and email address by COUNTRY, RANKED by their total $ purchase 
	for the month of Dec 2013, the ranking is over country.																		Paul 

	And Now the Product manager wants a list of all product categories and products with prod name, cost ,listprice, sold $ 
	during the month of Nov 2013 RANKED by the total $ sold is grouped by Product Category										Student 

  *******************************************************************************************************

  Def:  Returns the rank of each row within the partition of a result set. 
		The rank of a row is one plus the number of ranks that come before the row in question
		Note: Where value is the same across rows int the group , then a rank can tie

*/

use [Chapter 3 - Sales (Keyed) ] ;			--<<<< Use chapter 3 sales database for this project


-- Ranked list of customer sales over country for Dec 2013

select 
	   geo.CountryRegionName
	  ,cust.CustomerKey
	  ,cust.LastName 
	  ,cust.FirstName
	  ,cust.EmailAddress	
	  ,sum([SalesAmount]) as TotalMthSales
	  ,RANK() OVER (PARTITION by [CountryRegionName] ORDER BY sum([SalesAmount]) DESC) as CustomerRank
from
	  [dbo].[OnlineSales] os inner join
	  [dbo].[Customer] cust ON os.CustomerKey = cust.CustomerKey and
											    os.OrderDate  between '2013-12-01' and '2013-12-31' inner join
	  [dbo].[Geography] geo ON cust.GeographyKey =  geo.GeographyKey 	
group by
       cust.CustomerKey
	  ,cust.LastName 
	  ,cust.FirstName
	  ,cust.EmailAddress
	  ,CountryRegionName



















