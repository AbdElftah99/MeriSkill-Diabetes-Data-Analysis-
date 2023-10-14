select *
from diabetes
-----------------
--Data Exploration Before Cleaning
select AVG(Glucose)
from diabetes                    --120.89453125

select AVG(BloodPressure)
from diabetes                  
where BloodPressure <> 0         --69.10546875

select AVG(SkinThickness)
from diabetes                 
where SkinThickness <> 0         --29.1492537313433

select AVG(Insulin)
from diabetes 
where Insulin <> 0              --155.885496183206

select AVG(BMI)
from diabetes
where BMI <> 0                  --32.4546542553191

select AVG(Age)
from diabetes                  --33.2408854166667     
-------------------------------------------------
--Looking For Duplicates
select 
ROW_NUMBER() over(
				partition by Age,
				Pregnancies,
				Glucose,
				BloodPressure,
				SkinThickness,
				Insulin,
				BMI,
				DiabetesPedigreeFunction
				order by Age) as rownum
From diabetes
--There is no dublicates
-------------------------------------------------
--DATA Cleaning
select Glucose
from diabetes
where Glucose = 0            --5 Person

delete from diabetes
where Glucose = 0
--------------
select BloodPressure
from diabetes
where BloodPressure = 0      

update diabetes
set BloodPressure = 70
where BloodPressure =0
-------------------
select SkinThickness
from diabetes
where SkinThickness = 0 

update diabetes
set SkinThickness = 30
where SkinThickness =0
-------------------
select Insulin
from diabetes
where Insulin = 0 

update diabetes
set Insulin = 155
where Insulin =0
------------------
select BMI
from diabetes
where BMI = 0 

update diabetes
set BMI = 32
where BMI =0
--------------------------------------
--PregnancyClassification
alter table diabetes
add PregnancyClassification nvarchar(20)

update diabetes
set PregnancyClassification =
Case
	when Pregnancies = 0 then 'had not'
	When Pregnancies >= 1 and Pregnancies <=5 then 'Normal'
	When Pregnancies > 5 and Pregnancies <=10 and Age > 35 then 'High'
	When Pregnancies > 5 and Pregnancies <=10 and Age <= 35 then 'Very High'
	When Pregnancies > 10 and Pregnancies <=15 and Age > 45 then 'Very High'
	When Pregnancies > 10 and Pregnancies <=15 and Age <= 45 then 'Extremely High'
	END

select count(Age) , PregnancyClassification
from diabetes
group by PregnancyClassification
----------------------------------------------
--Result
Alter Table diabetes
add Result nvarchar(15)

update diabetes
Set Result =
Case
	When Outcome = 1 then 'diabetic'
	when Outcome = 0 then 'Non-diabetic'
	ELSE 'UnKown'
	ENd

select count(Age) , Result
from diabetes
group by Result
----------------------------------
--AGE
select * 
from diabetes

Alter Table diabetes
add AgeClassification nvarchar(20)

update diabetes
Set AgeClassification =
Case
	When Age >= 21 and Age <25 then 'Young'
	When Age >= 25 and Age <45 then 'Middle Age'
	When Age >= 45 and Age <= 60 then 'Elderly Age'
	When Age > 60 then 'Old'
	ELSE 'UnKown'
	END

