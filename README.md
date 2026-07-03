#🍕 Pizza Runner — Order, Delivery & Revenue Analysis (SQL Case Study 2)
📌 Business Problem

Pizza Runner is a food delivery startup that wants to improve its operations using data analysis. The dataset contains messy, inconsistent, and incomplete records that need to be cleaned before analysis.

The goal of this project is to analyze:

Customer order behavior
Runner delivery performance
Delivery efficiency
Revenue from successful orders

This analysis helps improve decision-making and operational performance.

🎯 Project Objectives
Clean and standardize raw datasets
Analyze customer ordering patterns
Evaluate runner performance
Measure delivery speed and efficiency
Calculate revenue from successful deliveries
🧰 Tools Used
MySQL
SQL (Joins, Aggregations, CASE WHEN, Window Functions, Date Functions)
Data Cleaning Techniques
🧹 Data Cleaning Summary

Before analysis, the following cleaning steps were performed:

Removed duplicate records
Converted "null", empty strings, and "NaN" to SQL NULL
Standardized pickup time format
Converted distance to numeric (km)
Converted duration into numeric minutes
Created cleaned working tables for analysis
📊 Analysis Performed
🟢 Section A — Pizza Metrics

Business questions analyzed:

Total pizzas ordered
Unique customer orders
Successful deliveries
Pizza type distribution
Customer pizza preferences
Orders with extras and exclusions
Hourly order trends
Daily order trends
🟢 Section B — Runner Performance

Business questions analyzed:

Weekly runner registrations
Average pickup time per runner
Relationship between order size and preparation time
Average delivery distance per customer
Delivery time comparison (fastest vs slowest)
Average speed per runner
Delivery success rate per runner
🟢 Section D — Revenue Analysis

Business questions analyzed:

Standard ingredients per pizza
Revenue from successful deliveries
📈 Key Insights
Meat Lovers pizza was the most ordered item
Most orders were successfully delivered
Evening hours showed peak order activity
Runner speed and delivery efficiency varied across orders
Distance and duration directly impact delivery performance
Revenue is driven by successful completed deliveries
💡 Business Recommendations
Increase runner availability during peak hours
Improve delivery consistency across runners
Promote high-demand pizzas for better revenue
Reduce cancellations and delays to improve earnings
Standardize data collection to avoid null/dirty values
Use delivery KPIs for operational improvements
🚀 Next Steps
Build Power BI dashboard for real-time insights
Automate SQL reporting using views
Perform advanced delivery time prediction analysis
Move to next case study (Foodie-Fi / advanced SQL projects)
Improve data pipeline for real-world analytics workflow
📚 Resources
https://8weeksqlchallenge.com/case-study-2/
https://www.w3schools.com/sql/
https://sqlbolt.com/
https://mode.com/sql-tutorial/
https://leetcode.com/problemset/database/
🏁 Conclusion

This project demonstrates how SQL can be used to clean messy real-world datasets and generate meaningful business insights. By analyzing customer orders, delivery performance, and revenue data, we can improve operational efficiency, customer experience, and overall business decision-making.
