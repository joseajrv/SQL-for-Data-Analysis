-- Chapter 5 Project work (1)

-- Web analytics dashboard data extract project

/*	-- Scenario --- Web analytics dashboard data extract project

 Marketing department has requested a data set to display in a data visualization (dashboard)
 and they require, the following metrics (measures) to populate the dashboard ...

	1:	Pageviews vs bounce rate by day/date			(Student)	<<<<<<<<		Bounce = The percent of visits that are single-page only (i.e. people who visit one page and leave). 
	
		2:	Pageviews vs bounce rate by week				(Paul)		**			See next/prev	
	
	3:  Pageviews vs bounce rate by month				(Student)	<<<<<<<<		Pageviews = The total number of pages people visited on your website

		4:	Avg session duration New visitor by week		(Paul)		**			See next
	4a:	Avg session duration Returning visitor by week 	(Student)   <<<<<<<<		Session duration = The average length of visitors’ sessions (in seconds)
	
		5:	Sessions vs avg Pages/Session by week			(Paul)		**		    Sessions = The number of times visitors are actively engaged on your website
																					Pages/Sessions = The average number of pages viewed during a session on your website
	
	6:	New users vs Pageviews by week					(Student)	<<<<<<<<		New users = See full detail below in New Users explanation
	
  *******************************************************************************************************

*/

--	2:	Pageviews by week									(Paul)		

		select
			 cal.YearNum
			,cal.WeekNumYear
			,sum(pa.[PageViews]) as [PageViews] 
			,avg(pa.BounceRatePct) as AvgBounceRatePct
		from
			[dbo].[PageAnalysis] pa inner join
			[dbo].[Calendar] cal on pa.DateKey = cal.DateKey
		group by
			 cal.YearNum
			,cal.WeekNumYear
		order by 
			 cal.YearNum
			,cal.WeekNumYear

--	4:	Avg session duration New visitor by week			(Paul)		

	select
		 year([DateKey]) as YearNum
		,datepart(week,[DateKey]) as WeekNum
		,avg(datediff(millisecond,0,AvgSessionDuration))/1000 as  AvgSessionDuration		-- Use Datediff here to calculate the seconds as we cannot just use numeri functions on time data types
		,count(va.[UserTypeKey]) as WeeklyNewVisitor
	from
		[dbo].[VisitorAnalysis] va inner join
		[dbo].[UserType] ut on va.UserTypeKey = ut.UserTypeKey and
												ut.UserType = 'New Visitor'
	group by
		 year([DateKey]) 
		,datepart(week,[DateKey]) 
	order by 
		 year([DateKey]) 
		,datepart(week,[DateKey]) 

--	5:	Sessions vs avg Pages/Session by week				(Paul)		

	select
		 year([DateKey]) as YearNum
		,datepart(week,[DateKey]) as WeekNum
		,sum([Sessions]) as Sessions
		,cast(avg([PagesSession]) as decimal(18,2)) as AvgPagesSession			
	from
		[dbo].[VisitorAnalysis] va
	group by
		 year([DateKey]) 
		,datepart(week,[DateKey])
	order by 
		 year([DateKey]) 
		,datepart(week,[DateKey])

/*

A summary of Google analytics terms...


Sessions:		
		The number of times visitors are actively engaged on your website. 
		Generally speaking, every visitor has at least one “session” when they visit your site, but they could have multiple depending on the circumstances.

Users: 
		The number of visitors that have at least one session on your website. 
		This number is more accurate in telling you how many “individual” people visited your website.

Pageviews: 
		The total number of pages people visited on your website. 
		Assuming you have multiple pages on your website, you’ll want this number to be higher than the number of sessions.

Pages per Session: 
		The average number of pages viewed during a session on your website. 
		More pages per session means that users are more engaged and exploring more of your site.

Average Session Duration: 
		The average length of visitors’ sessions. 
		Again, longer sessions indicate that users are more engaged.

Bounce Rate: 
		The percent of visits that are single-page only (i.e. people who visit one page and leave). 
		Usually a high bounce rate is a sign that people are leaving your site (or a certain page) because they aren’t finding what they are looking for.

Percent of New Sessions: 
		An average percentage of first-time visitors on your website. 
		Ideally, a good website will have a solid mix of new and returning visitors.

New Users :	  The number of unique visitors that have at least one session on your website 
			  this is determined in many ways e.g. No cookie on the user PC for this site, or browser cache cleared
			  or the user returned but on a different device, hence new users is possibly fraught with error, I prefer
			  returning visitor as it shows that a user is really interested or very curious about your site offering.
			  Of course this is all open to interpretation of the audience 	

*/