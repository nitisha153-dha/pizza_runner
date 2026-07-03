

🍕 Pizza Runner — Order, Delivery & Revenue Analysis (SQL Case Study 2)
📌 Business Problem

Pizza Runner is a food delivery startup that wants to improve its operations using data analysis.
However, the dataset is messy and contains:

Missing values
Inconsistent formats
Duplicate records
Text-based numeric fields

The goal is to clean the data and generate meaningful business insights from:

Customer orders
Runner deliveries
Revenue performance
🎯 Project Objectives
Clean and standardize raw datasets
Analyze customer ordering behavior
Evaluate delivery performance
Measure delivery efficiency
Calculate revenue from successful deliveries
🧰 Tools Used
MySQL
SQL Techniques:
JOINs
GROUP BY
CASE WHEN
Window Functions
Date & Time Functions
String Functions
Data Cleaning
🧹 Data Cleaning Summary

Before analysis, the following cleaning steps were performed:

Removed duplicate records
Converted 'null', empty strings, and 'NaN' to NULL
Standardized pickup time values
Converted distance into numeric format (km)
Converted duration into integer minutes
Created cleaned tables for analysis
📊 Analysis Performed
🟢 Section A — Pizza Metrics
Total pizzas ordered
Unique customer orders
Successful deliveries
Count of each pizza type delivered
Customer pizza preferences
Orders with extras and exclusions
Hourly order trends
Daily order trends
🟢 Section B — Runner Performance
Weekly runner registrations
Average pickup time per runner
Relationship between order size and preparation time
Average delivery distance per customer
Fastest vs slowest delivery comparison
Average speed per runner
Delivery success rate
🟢 Section C — Revenue Analysis
Standard ingredients per pizza
Revenue generated from successful deliveries
📈 Key Insights
Meat Lovers pizza was the most ordered item
Most orders were successfully delivered
Peak ordering happens in the evening
Delivery speed varies across runners
Distance and duration affect delivery performance
Revenue depends on successful deliveries
💡 Business Recommendations
Improve staffing during peak hours
Optimize runner delivery efficiency
Promote high-demand pizzas
Reduce delivery delays and cancellations
Improve data quality and standardization
Use KPIs for performance tracking
🚀 Next Steps
Build Power BI dashboard for insights visualization
Automate SQL reporting using views
Perform advanced delivery time analysis
Move to next case study (Foodie-Fi or similar SQL project)
Create end-to-end analytics portfolio
📚 Resources
https://8weeksqlchallenge.com/case-study-2/
https://www.w3schools.com/sql/
https://sqlbolt.com/
https://mode.com/sql-tutorial/
https://leetcode.com/problemset/database/
🏁 Conclusion

This project demonstrates how SQL can transform messy real-world data into meaningful business insights.
It covers data cleaning, transformation, analysis, and reporting to improve decision-making in a food delivery system.
