drop procedure if exists external_record_count_by_day;
delimiter $$;
create procedure external_record_count_by_day(
  in start_date date,
  in end_date date,
  in sta_id int
)
begin
  select count(*) as record_qty, count(distinct script_id) as script_qty, date(created_at) as created_date
  from medicine_external_records
  where station_id = sta_id and created_at between start_date and end_date
  group by date(created_at);
end $$;

drop procedure if exists internal_record_count_by_day;
$$;
create procedure internal_record_count_by_day(
  in start_date date,
  in end_date date,
  in sta_id int
)
begin
  select count(*) as record_qty, count(distinct script_id) as script_qty, date(created_at) as created_date
  from medicine_internal_records
  where station_id = sta_id and created_at between start_date and end_date
  group by date(created_at);
end $$;

drop procedure if exists external_record_statistic;
$$;
create procedure external_record_statistic(
  in start_date date,
  in end_date date,
  in sta_id int
)
begin
  select sum(amount) as sum_amount, name, company, price 
  from medicine_external_records
  where station_id = sta_id and created_at between start_date and end_date
  group by name, company, price;
end $$;

drop procedure if exists internal_record_statistic;
$$;
create procedure internal_record_statistic(
  in start_date date,
  in end_date date,
  in sta_id int
)
begin
  select sum(amount) as sum_amount, name, company, price 
  from medicine_internal_records
  where station_id = sta_id and created_at between start_date and end_date
  group by name, company, price;
end $$;

drop procedure if exists external_record_detail_statistic;
$$;
create procedure external_record_detail_statistic(
  in start_date date,
  in end_date date,
  in med_name varchar(255),
  in com varchar(255),
  in p float,
  in sta_id int
)
begin
  select sum(amount) as sum_amount, date(created_at) as date_created
  from medicine_external_records
  where station_id = sta_id and name = med_name and company = com and price = p and created_at between start_date and end_date
  group by date(created_at);
end $$;

drop procedure if exists internal_record_detail_statistic;
$$;
create procedure internal_record_detail_statistic(
  in start_date date,
  in end_date date,
  in med_name varchar(255),
  in com varchar(255),
  in p float,
  in sta_id int
)
begin
  select sum(amount) as sum_amount, date(created_at_at) as date_created
  from medicine_internal_records
  where station_id = sta_id and name = med_name and company = com and price = p and created_at between start_date and end_date
  group by date(created_at);
end $$;

drop procedure if exists stock_record_sum_in_date;
$$;
create procedure stock_record_sum_in_date(
  in d date,
  in sta_id int
)
begin
  select sum(case  when typerecord = 1 then amount when typerecord = 2 then - amount else 0 end) as qty, noid, signid, sample_id, name, supplier_id
  from medicine_stock_records
  where station_id = sta_id and created_at < d
  group by noid, signid, sample_id, name, supplier_id;
end $$;

drop procedure if exists stock_record_sum_between;
$$;
create procedure stock_record_sum_between(
  in start_date datetime,
  in end_date datetime,
  in sta_id int
)
begin
  select sum(case when typerecord = 1 then amount when typerecord = 2 then - amount else 0 end) as qty, noid, signid, sample_id, date(created_at) as date
  from medicine_stock_records
  where station_id = sta_id and created_at between start_date and end_date
  group by noid, signid, sample_id, date(created_at);
end $$;
