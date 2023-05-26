/*

Cleaning Data in SQL Queries

*/
-------------------------------------------------------------------------------------
#getting shape(count of rows and column of dataset)
select count(*) from crime;
select count(*) from information_schema.columns where table_name='crime';
-------------------------------------------------------------------------------------
#checking datatype
desc crime;
-------------------------------------------------------------------------------------
#removing unwanted column
alter table crime
drop column MyUnknownColumn;
-------------------------------------------------------------------------------------
#deleting rows
delete  
from crime
where Year=2008;
delete
from crime
where DISTRICT='TOTAL';
-------------------------------------------------------------------------------------
#1 what is the total crime of each state?
select STATE,sum(Rape+Kidnapping+Dowry_Deaths+Assault+Insult+Cruelty_by_HusbandorRelatives+Importation_of_Girls) Total_crime
from crime
group by STATE
order by Total_crime desc;
-------------------------------------------------------------------------------------
#2 what is the most popular crime of each state?
with a as(
select state, sum(Rape) Rape,sum(Kidnapping) Kidnapping,sum(Dowry_Deaths) Dowry_deaths,sum(Assault) Assault,sum(Insult) Insults,sum(Cruelty_by_HusbandorRelatives) Cruelty, sum(Importation_of_Girls) importation
from crime
group by state)
select state, case greatest(Rape,Kidnapping,Dowry_deaths,Assault,Insults,Cruelty,importation)
when rape then 'rape'
when kidnapping then 'kidnapping'
when Dowry_deaths then 'Dowry_deaths'
when importation then 'importation'
when Cruelty then 'Cruelty'
when Insults then 'Insults'
when Assault then 'Assault'
end crime
from a;
-------------------------------------------------------------------------------------
#3 what is the total crime each year?
select Year,sum(Rape+Kidnapping+Dowry_Deaths+Assault+Insult+Cruelty_by_HusbandorRelatives+Importation_of_Girls) Total_crime
from crime
group by Year
order by Total_crime desc;
-------------------------------------------------------------------------------------
#4 what is the total of each crime each year?
select Year, sum(Rape) Rape,sum(Kidnapping) Kidnapping,sum(Dowry_Deaths) Dowry_deaths,sum(Assault) Assault,sum(Insult) Insults,sum(Cruelty_by_HusbandorRelatives) Cruelty, sum(Importation_of_Girls) importation
from crime
group by Year;
-------------------------------------------------------------------------------------
#5 what is the popular crime each year?
with y as(
select Year, sum(Rape) Rape,sum(Kidnapping) Kidnapping,sum(Dowry_Deaths) Dowry_deaths,sum(Assault) Assault,sum(Insult) Insults,sum(Cruelty_by_HusbandorRelatives) Cruelty, sum(Importation_of_Girls) importation
from crime
group by state)
select Year, case greatest(Rape,Kidnapping,Dowry_deaths,Assault,Insults,Cruelty,importation)
when rape then 'rape'
when kidnapping then 'kidnapping'
when Dowry_deaths then 'Dowry_deaths'
when importation then 'importation'
when Cruelty then 'Cruelty'
when Insults then 'Insults'
when Assault then 'Assault'
end crime
from y;
-------------------------------------------------------------------------------------
#6 what is the sum of each crime for each state and year?
select state,year,sum(Rape) Rape,sum(Kidnapping) Kidnapping,sum(Dowry_Deaths) Dowry_deaths,sum(Assault) Assault,sum(Insult) Insults,sum(Cruelty_by_HusbandorRelatives) Cruelty, sum(Importation_of_Girls) importation
from crime
group by state,year
order by state;