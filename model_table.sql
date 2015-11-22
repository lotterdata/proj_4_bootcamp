/**
create table models(
id serial primary key,
model_name varchar(20),
results_file varchar(20),
remarks varchar(250)
)
**/

insert into models(model_name, results_file, remarks)
select 'simple regression', 'simple_regression.rds','regression on drawsum, range, and gap.sd';

insert into models(model_name, results_file, remarks)
select 'elastic net', 'elastic_net.rds','regression on numbers, flags, and gap.sd; 5-fold cv; alpha and lambda selected automatically';

