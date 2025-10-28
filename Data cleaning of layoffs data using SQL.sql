use gfg;
select *from layoffs;
-- 1. remove duplicates
-- 2.Standardize data
-- 3.Null values or blank values
-- 4.Remove any columns

create table layoffs_copy like layoffs;
select *from layoffs_copy;
insert layoffs_copy select *from layoffs;
select*from layoffs_copy;

select *from (select *,row_number() over(partition by company,location,industry,total_laid_off,
percentage_laid_off,date,stage,country,funds_raised_millions) as 'rownumber' from layoffs_copy)
as layoffs2;

select *from (select *,row_number() over(partition by company,location,industry,total_laid_off,
percentage_laid_off,date,stage,country,funds_raised_millions) as 'rownumber' from layoffs_copy)
as layoffs3;

with duplicate_cte as
( select *,row_number() over(partition by company,location,industry,total_laid_off,
percentage_laid_off,date,stage,country,funds_raised_millions) 
as 'rownumber'
from layoffs_copy )
select *from duplicate_cte;

CREATE TABLE `layoffs_copy2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
   `rownumber` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select*from layoffs_copy2;
insert into layoffs_copy2
select *,row_number() over(partition by company,location,industry,total_laid_off,
percentage_laid_off,date,stage,country,funds_raised_millions) 
as 'rownumber'
from layoffs_copy;
select*from layoffs_copy2;

delete from layoffs_copy2 where rownumber>1;

-- Standardizing data

select company, trim(company) from layoffs_copy;
update layoffs_copy2 
set company =trim(company);
select company from layoffs_copy;

select distinct industry from layoffs_copy;
update layoffs_copy
set industry='crypto'
where industry like 'crypto%';

select *from layoffs_copy;

select distinct location from layoffs_copy;
select distinct country from layoffs_copy order by 1;

update layoffs_copy
set country= trim(trailing '.' from country)
where country like 'united States%';
select distinct country from layoffs_copy order by 1;

select * from layoffs_copy;

select `date`,
str_to_date(`date`,'%m/%d/%Y')
from layoffs_copy;
select *from layoffs_copy;

update layoffs_copy
set `date`=str_to_date(`date`,'%m/%d/%Y');

select *from layoffs_copy;

 alter table layoffs_copy
modify column `date` DATE;

-- handling nullvalues

select * from layoffs_copy
where total_laid_off  is null and percentage_laid_off is null;

select distinct industry from layoffs_copy;
select * from layoffs_copy;

delete from layoffs_copy
where total_laid_off  is null and percentage_laid_off is null;

select *from layoffs_copy;

