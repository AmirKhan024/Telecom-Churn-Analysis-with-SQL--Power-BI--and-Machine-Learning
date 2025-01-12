-- Customer churn analysis

-- schema
CREATE TABLE customerdata (
    Customer_ID VARCHAR(20) PRIMARY KEY,
    Gender VARCHAR(10),
    Age INT,
    Married VARCHAR(3),
    State VARCHAR(50),
    Number_of_Referrals INT,
    Tenure_in_Months INT,
    Value_Deal VARCHAR(50),
    Phone_Service VARCHAR(3),
    Multiple_Lines VARCHAR(3),
    Internet_Service VARCHAR(3),
    Internet_Type VARCHAR(50),
    Online_Security VARCHAR(3),
    Online_Backup VARCHAR(3),
    Device_Protection_Plan VARCHAR(3),
    Premium_Support VARCHAR(3),
    Streaming_TV VARCHAR(3),
    Streaming_Movies VARCHAR(3),
    Streaming_Music VARCHAR(3),
    Unlimited_Data VARCHAR(3),
    Contract VARCHAR(50),
    Paperless_Billing VARCHAR(3),
    Payment_Method VARCHAR(50),
    Monthly_Charge DECIMAL(10, 2),
    Total_Charges DECIMAL(10, 2),
    Total_Refunds DECIMAL(10, 2),
    Total_Extra_Data_Charges DECIMAL(10, 2),
    Total_Long_Distance_Charges DECIMAL(10, 2),
    Total_Revenue DECIMAL(10, 2),
    Customer_Status VARCHAR(20),
    Churn_Category VARCHAR(50),
    Churn_Reason VARCHAR(255)
);

select * from customerdata;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 1. Gender Distribution
SELECT 
    Gender,
    COUNT(gender) AS totalcount,
    ROUND(CONCAT((COUNT(Gender) / (SELECT 
                            COUNT(*)
                        FROM
                            customerdata)) * 100,
                    '%'),
            2) AS Pct
FROM
    customerdata
GROUP BY Gender;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 2. Contract Distribution
SELECT 
    Contract,
    COUNT(Contract) AS totalcount,
    ROUND(CONCAT((COUNT(Contract) / (SELECT 
                            COUNT(*)
                        FROM
                            customerdata)) * 100,
                    '%'),
            2) AS Pct
FROM
    customerdata
GROUP BY Contract
ORDER BY Pct DESC;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3. Total revenue
SELECT 
    Customer_Status,
    COUNT(Customer_Status) AS totalcount,
    ROUND(SUM(Total_Revenue), 2) AS Total_Revenue,
    CONCAT(ROUND((SUM(Total_Revenue) / (SELECT 
                            SUM(Total_Revenue)
                        FROM
                            customerdata)) * 100,
                    2),
            '%') AS Pct
FROM
    customerdata
GROUP BY Customer_Status
ORDER BY Pct DESC;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- State distribution

SELECT 
    State,
    COUNT(State) AS totalcount,
    CONCAT(ROUND((COUNT(state) / (SELECT 
                            COUNT(*)
                        FROM
                            customerdata)) * 100,
                    2),
            '%') AS Pct
FROM
    customerdata
GROUP BY State
ORDER BY Pct DESC;
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Check Nulls

SELECT 
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Customer_ID_Null_Count,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_Null_Count,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_Null_Count,
    SUM(CASE WHEN Married IS NULL THEN 1 ELSE 0 END) AS Married_Null_Count,
    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS State_Null_Count,
    SUM(CASE WHEN Number_of_Referrals IS NULL THEN 1 ELSE 0 END) AS Number_of_Referrals_Null_Count,
    SUM(CASE WHEN Tenure_in_Months IS NULL THEN 1 ELSE 0 END) AS Tenure_in_Months_Null_Count,
    SUM(CASE WHEN Value_Deal IS NULL THEN 1 ELSE 0 END) AS Value_Deal_Null_Count,
    SUM(CASE WHEN Phone_Service IS NULL THEN 1 ELSE 0 END) AS Phone_Service_Null_Count,
    SUM(CASE WHEN Multiple_Lines IS NULL THEN 1 ELSE 0 END) AS Multiple_Lines_Null_Count,
    SUM(CASE WHEN Internet_Service IS NULL THEN 1 ELSE 0 END) AS Internet_Service_Null_Count,
    SUM(CASE WHEN Internet_Type IS NULL THEN 1 ELSE 0 END) AS Internet_Type_Null_Count,
    SUM(CASE WHEN Online_Security IS NULL THEN 1 ELSE 0 END) AS Online_Security_Null_Count,
    SUM(CASE WHEN Online_Backup IS NULL THEN 1 ELSE 0 END) AS Online_Backup_Null_Count,
    SUM(CASE WHEN Device_Protection_Plan IS NULL THEN 1 ELSE 0 END) AS Device_Protection_Plan_Null_Count,
    SUM(CASE WHEN Premium_Support IS NULL THEN 1 ELSE 0 END) AS Premium_Support_Null_Count,
    SUM(CASE WHEN Streaming_TV IS NULL THEN 1 ELSE 0 END) AS Streaming_TV_Null_Count,
    SUM(CASE WHEN Streaming_Movies IS NULL THEN 1 ELSE 0 END) AS Streaming_Movies_Null_Count,
    SUM(CASE WHEN Streaming_Music IS NULL THEN 1 ELSE 0 END) AS Streaming_Music_Null_Count,
    SUM(CASE WHEN Unlimited_Data IS NULL THEN 1 ELSE 0 END) AS Unlimited_Data_Null_Count,
    SUM(CASE WHEN Contract IS NULL THEN 1 ELSE 0 END) AS Contract_Null_Count,
    SUM(CASE WHEN Paperless_Billing IS NULL THEN 1 ELSE 0 END) AS Paperless_Billing_Null_Count,
    SUM(CASE WHEN Payment_Method IS NULL THEN 1 ELSE 0 END) AS Payment_Method_Null_Count,
    SUM(CASE WHEN Monthly_Charge IS NULL THEN 1 ELSE 0 END) AS Monthly_Charge_Null_Count,
    SUM(CASE WHEN Total_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Charges_Null_Count,
    SUM(CASE WHEN Total_Refunds IS NULL THEN 1 ELSE 0 END) AS Total_Refunds_Null_Count,
    SUM(CASE WHEN Total_Extra_Data_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Extra_Data_Charges_Null_Count,
    SUM(CASE WHEN Total_Long_Distance_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Long_Distance_Charges_Null_Count,
    SUM(CASE WHEN Total_Revenue IS NULL THEN 1 ELSE 0 END) AS Total_Revenue_Null_Count,
    SUM(CASE WHEN Customer_Status IS NULL THEN 1 ELSE 0 END) AS Customer_Status_Null_Count,
    SUM(CASE WHEN Churn_Category IS NULL THEN 1 ELSE 0 END) AS Churn_Category_Null_Count,
    SUM(CASE WHEN Churn_Reason IS NULL THEN 1 ELSE 0 END) AS Churn_Reason_Null_Count
FROM customerdata;


-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove null and insert the new data into new table

CREATE TABLE clean_table AS
SELECT 
    Customer_ID,
    Gender,
    Age,
    Married,
    State,
    Number_of_Referrals,
    Tenure_in_Months,
    IFNULL(Value_Deal, 'None') AS Value_Deal,
    Phone_Service,
    IFNULL(Multiple_Lines, 'No') AS Multiple_Lines,
    Internet_Service,
    IFNULL(Internet_Type, 'None') AS Internet_Type,
    IFNULL(Online_Security, 'No') AS Online_Security,
    IFNULL(Online_Backup, 'No') AS Online_Backup,
    IFNULL(Device_Protection_Plan, 'No') AS Device_Protection_Plan,
    IFNULL(Premium_Support, 'No') AS Premium_Support,
    IFNULL(Streaming_TV, 'No') AS Streaming_TV,
    IFNULL(Streaming_Movies, 'No') AS Streaming_Movies,
    IFNULL(Streaming_Music, 'No') AS Streaming_Music,
    IFNULL(Unlimited_Data, 'No') AS Unlimited_Data,
    Contract,
    Paperless_Billing,
    Payment_Method,
    Monthly_Charge,
    Total_Charges,
    Total_Refunds,
    Total_Extra_Data_Charges,
    Total_Long_Distance_Charges,
    Total_Revenue,
    Customer_Status,
    IFNULL(Churn_Category, 'Others') AS Churn_Category,
    IFNULL(Churn_Reason, 'Others') AS Churn_Reason
FROM customerdata;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Create View for Power BI

create view v_Churndata as 
select * from clean_table where Customer_Status IN ('Churned','Stayed');

create view v_Joindata as 
select * from clean_table where Customer_Status = 'Joined';