-- EXPLORATORY DATA ANALYSIS

use layoffs;
select * from layoffs_new2;

select max(total_laid_off)
from layoffs_new2;

select max(total_laid_off), max(percentage_laid_off)
from layoffs_new2;

select * 
from layoffs_new2
where percentage_laid_off=1
order by total_laid_off desc;

select * 
from layoffs_new2
where percentage_laid_off=1
order by funds_raised_millions desc;

select company, sum(total_laid_off)
from layoffs_new2
group by company
order by 2 desc;

select min(`date`), max(`date`)
from layoffs_new2;

select industry, sum(total_laid_off)
from layoffs_new2
group by industry
order by 2 desc;

select country, sum(total_laid_off)
from layoffs_new2
group by country
order by 2 desc;

select year(`date`), sum(total_laid_off)
from layoffs_new2
group by year(`date`)
order by 1 desc;

select stage, sum(total_laid_off)
from layoffs_new2
group by stage
order by 2 desc;

-- ROLLING SUM (TOTAL LAY OFFS)


select substring(`date`,1,7) as `month`, sum(total_laid_off)
from layoffs_new2
where substring(`date`,1,7) is not null
group by `month`
order by 1;

with rolling_total as
(
select substring(`date`,1,7) as `month`, sum(total_laid_off) as total_off
from layoffs_new2
where substring(`date`,1,7) is not null
group by `month`
order by 1
)
select `month`, total_off, sum(total_off) over(order by `month`) as rolling
from rolling_total;



-- TOTAL LAID OFF RANKED PER YEAR TOP 5 COMPANIES



select company, sum(total_laid_off)
from layoffs_new2
group by company
order by 2 desc;

select company, year(`date`), sum(total_laid_off)
from layoffs_new2
group by company, year(`date`)
order by 3 desc;


with company_year(company, `year`, total_laid_off) as 
(
select company, year(`date`), sum(total_laid_off)
from layoffs_new2
group by company, year(`date`)
), company_year_ranking as(
select *, dense_rank() over(partition by `year` order by total_laid_off desc) as ranking
 from company_year
 where `year` is not null)
 select * from company_year_ranking
 where ranking<=5;
