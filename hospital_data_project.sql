DROP TABLE IF EXISTS Hospital_Data;

CREATE TABLE Hospital_Data(
hospital_id SERIAL,
hospital_name VARCHAR(100),
location VARCHAR(50),
department VARCHAR(50),
doctors_count INT,
patients_count INT,
admission_date DATE,
discharge_date DATE,
medical_expenses NUMERIC(10,2)
);

SELECT * FROM Hospital_Data;

COPY Hospital_Data(hospital_name,location,department,doctors_count,patients_count,admission_date,discharge_date,medical_expenses)
FROM 'C:\Program Files\PostgreSQL\14\Hospital_Data.CSV'
CSV HEADER;

--write an sql query to find the total number of patients across all hospitals
SELECT SUM (patients_count) AS total_patients
FROM Hospital_Data;

--retrieves the average count of doctors available in each hospital
SELECT hospital_name,
AVG(doctors_count) AS average_doctors
FROM Hospital_Data
GROUP BY hospital_name;

--find the top 3 hospital departmetns that have the highest number of patients
SELECT * FROM Hospital_Data ORDER BY department DESC LIMIT 3;

--identify the hospital that recorded the highest medical expenses
SELECT MAX(medical_expenses) AS highest_medical_expenses FROM Hospital_Data;

--calculate the average medical expenses per day for each hospital
SELECT AVG(medical_expenses) AS avg_medical_expenses
FROM Hospital_Data;

--find the patient with the longest stay by calculating the difference between discharge date and admission date
SELECT hospital_name,location,department,admission_date,discharge_date,
   (discharge_date-admission_date) AS longest_stay_date
   FROM Hospital_Data ORDER BY longest_stay_date DESC LIMIT 1;

--count the total number of patients treated in each city
SELECT location AS city,
SUM(patients_count) AS total_patient
FROM Hospital_Data
GROUP BY location;

--calculate the average number of days patients spend in each department
SELECT department,admission_date,discharge_date,
   (discharge_date-admission_date) AS longest_stay_date
   FROM Hospital_Data ORDER BY longest_stay_date;

--find the department with the least number of patients
SELECT department,
SUM (patients_count) AS total_patient
FROM Hospital_Data
GROUP BY department
ORDER BY total_patient ASC LIMIT 2;

--group the data by month and calculation the total medical expenses for each month
SELECT EXTRACT(YEAR FROM admission_date) AS year,
       EXTRACT(MONTH FROM admission_date) AS month,
	SUM(medical_expenses) AS total_expenses
FROM Hospital_Data
GROUP BY year,month
ORDER BY year,month;
	
	
	



