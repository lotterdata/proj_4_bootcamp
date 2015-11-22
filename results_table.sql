create table model_results(
analysis_id int references game_analyses,
model_id int references models,
RMSE float,
constraint pk_model_results primary key(analysis_id, model_id)
)

