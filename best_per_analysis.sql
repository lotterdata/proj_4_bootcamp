create view best_per_analysis as 

select *
from model_results as t
where rmse = 
      (select min(rmse) from model_results as s where s.analysis_id = t.analysis_id)
order by analysis_id;