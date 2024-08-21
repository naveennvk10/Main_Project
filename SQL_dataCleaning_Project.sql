use layoffs;

select * from layoffs;

create table layoffs_new
like layoffs;

insert into layoffs_new
select * from layoffs;

select *, row_number() over (partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country,
funds_raised_millions
 ) as row_num from layoffs_new;
 
CREATE TABLE `layoffs_new2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
 
insert into layoffs_new2
select *, row_number() over (partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country,
funds_raised_millions
 ) as row_num from layoffs_new;
 
select distinct country from layoffs_new2 order by 1;

update layoffs_new2
set country = 'United States'
where country like '%United States%';

select distinct industry from layoffs_new2 order by 1;

update layoffs_new2
set industry = 'Crypto'
where industry like '%Crypto%';

select * from layoffs_new2;

select * from layoffs_new2;

update layoffs_new2
set `date`=str_to_date(`date`,'%m/%d/%Y');




-- POPULATE NULL AND BLANK




select * from layoffs_new2
where industry is null or industry='';

select * from layoffs_new
where company='Airbnb';

select t1.industry, t2.industry
 from layoffs_new2 t1
join layoffs_new2 t2
on t1.company=t2.company
and t1.location=t2.location
where (t1.industry is null or t1.industry='')
and t2.industry is not null;

update layoffs_new2
set industry = null
where industry='';

update layoffs_new2 t1
join layoffs_new2 t2
on t1.company=t2.company
set t1.industry=t2.industry
where t1.industry is null
and t2.industry is not null;

select * from layoffs_new2 where industry is null or industry='';




-- DELETE UNWANTED NULL RECORDS




select * from layoffs_new2 where 
total_laid_off is null
and percentage_laid_off is null;

delete from layoffs_new2 where 
total_laid_off is null
and percentage_laid_off is null;

select * from layoffs_new2;



-- DROP UNWANTED COLUMN


Alter table layoffs_new2
drop column row_num;
