/**
create table game_analyses(
id serial primary key,
game varchar(30) references game_info,
prize varchar(10),
restriction varchar(50),
granularity float default 1.0
)
**/




insert into game_analyses(game,prize,restriction, granularity)
select 'fl_fantasy_5', 'prize4', 'winners5 > 0', 0.5;

insert into game_analyses(game,prize,restriction, granularity)
select 'fl_fantasy_5', 'prize3', 'winners5 > 0', 0.5;

insert into game_analyses(game,prize,restriction)
select 'nj_cash_5', 'prize3', '1 = 1';

insert into game_analyses(game,prize,restriction)
select 'nj_cash_5', 'prize4', '1 = 1';

insert into game_analyses(game,prize,restriction, granularity)
select 'pa_cash_5', 'prize3', '1 = 1', 0.5;

insert into game_analyses(game,prize,restriction, granularity)
select 'pa_cash_5', 'prize4', '1 = 1', 0.5;

insert into game_analyses(game,prize,restriction)
select 'nc_cash_5', 'prize3', '1 = 1';

insert into game_analyses(game,prize,restriction)
select 'nc_cash_5', 'prize4', '1 = 1';

insert into game_analyses(game,prize,restriction)
select 'tx_cash_5', 'prize3', '1 = 1';

insert into game_analyses(game,prize,restriction)
select 'tx_cash_5', 'prize4', 'winners5 = 0';

insert into game_analyses(game,prize,restriction)
select 'tx_cash_5', 'prize4', 'winners5 > 0';

insert into game_analyses(game,prize,restriction)
select 'or_megabucks', 'prize4', '1 = 1';

insert into game_analyses(game,prize,restriction)
select 'tn_cash', 'prize40', '1=1';

insert into game_analyses(game,prize,restriction)
select 'tn_cash', 'prize31', '1=1';











