-- Exploratory data analysis

select *from layoffs_copy;

select max(total_laid_off),max(percentage_laid_off) from layoffs_copy;

select company,sum(total_laid_off)
from layoffs_copy
group by company
order by 1 asc;

select industry,sum(total_laid_off)
from layoffs_copy
group by industry
order by 2 desc;

select country,sum(total_laid_off)
from layoffs_copy
group by country
order by 2 desc;

select `date`,sum(total_laid_off)
from layoffs_copy
group by `date`
order by 2 desc;

select year(`date`),sum(total_laid_off)
from layoffs_copy
group by year(`date`)
order by 1 desc;

select substring(`date`,1,7) as `month`,sum(total_laid_off) -- substring  value is from 6th letter and upto 2 letters
from layoffs_copy
where substring(`date`,1,7) is not null
group by month
order by 1;

select company ,year(`date`),sum(total_laid_off)
from layoffs_copy
group by company,year(`date`)
order by 3 desc;

with company_year(company, years, total_laid_off) as
(
select company ,year(`date`),sum(total_laid_off)
from layoffs_copy
group by company,year(`date`)
), company_year_rank as 
(select *,
Dense_rank() over (partition by years order by total_laid_off desc) as ranking
from company_year
where years is not null
)
select * from company_year_rank
where ranking<=5; 



