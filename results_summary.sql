create view results_summary as

select
 analysis_id,
 sum(rmse*case when model_id = 2 then 1 else 0 end) simple_regression,
 sum(rmse*case when model_id = 1 then 1 else 0 end) elastic_net,
 sum(rmse*case when model_id = 5 then 1 else 0 end) knn,
 sum(rmse*case when model_id = 3 then 1 else 0 end) random_forest,
 sum(rmse*case when model_id = 4 then 1 else 0 end) gbm_depth2,
 sum(rmse*case when model_id = 7 then 1 else 0 end) gbm_depth3
from model_results
group by analysis_id
order by analysis_id;