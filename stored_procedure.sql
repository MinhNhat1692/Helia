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
  select sum(amount) as sum_amount, date(created_at) as date_created
  from medicine_internal_records
  where station_id = sta_id and name = med_name and company = com and price = p and created_at between start_date and end_date
  group by date(created_at);
end $$;

drop procedure if exists stock_records_statistic;
$$;
create procedure stock_records_statistic(
  in sta_id int
)
begin
  select sum(case when typerecord = 1 then amount when typerecord = 2 then - amount else 0 end) as qty, sample_id, name
  from medicine_stock_records
  where station_id = sta_id
  group by sample_id, name;
end $$;

drop procedure if exists stock_records_detail_statistic;
$$;
create procedure stock_records_detail_statistic(
  in n varchar(255),
  in sam_id int,
  in sta_id int

)
begin
  select sum(case when typerecord = 1 then amount when typerecord = 2 then - amount else 0 end) as qty, noid, signid
  from medicine_stock_records
  where station_id = sta_id and sample_id = sam_id and name = n
  group by noid, signid;
end $$;

drop procedure if exists stock_record_sum_in_date;
$$;
create procedure stock_record_sum_in_date(
  in d date,
  in med_name varchar(255),
  in sam_id int,
  in no_id varchar(255),
  in sign_id varchar(255),
  in sta_id int
)
begin
  select sum(case when typerecord = 1 then amount when typerecord = 2 then - amount else 0 end) as qty, noid, signid, sample_id, name
  from medicine_stock_records
  where station_id = sta_id and created_at < d and name = med_name and sample_id = sam_id and noid = no_id and signid = sign_id;
end $$;

drop procedure if exists stock_record_sum_between;
$$;
create procedure stock_record_sum_between(
  in start_date datetime,
  in end_date datetime,
  in med_name varchar(255),
  in sam_id int,
  in no_id varchar(255),
  in sign_id varchar(255),
  in sta_id int
)
begin
  select sum(case when typerecord = 1 then amount when typerecord = 2 then - amount else 0  end) as qty, noid, signid, sample_id, name, date(created_at)
  from medicine_stock_records
  where station_id = sta_id and name = med_name and sample_id = sam_id and noid = no_id and signid = sign_id and created_at between start_date and end_date
  group by date(created_at) ;
end $$;

drop procedure if exists bill_in_sum_up;
$$;
create procedure bill_in_sum_up(
  in start_date datetime,
  in end_date   datetime,
  in sta_id int
)
begin
  select sum(tpayout) as qty, supplier_id, supplier
  from medicine_bill_ins
  where station_id = sta_id and created_at between start_date and end_date
  group by supplier_id, supplier;
end $$;

drop procedure if exists bill_record_sum_up;
$$;
create procedure bill_record_sum_up(
  in start_date datetime,
  in end_date datetime,
  in sup varchar(255),
  in sup_id int,
  in sta_id int
)
begin
  select sum(qty) as sum_qty, sum(qty * price) as sum_payment, sample_id
  from medicine_bill_records
  where station_id = sta_id and created_at between start_date and end_date
  and bill_id in (select id from medicine_bill_ins where supplier_id = sup_id and supplier = sup)
  group by sample_id;
end $$;

drop procedure if exists stock_records_statistic_by_sample_and_supllier;
$$;
create procedure stock_records_statistic_by_sample_and_supllier(
  in start_date datetime,
  in end_date datetime,
  in sup varchar(255),
  in sup_id int,
  in sam varchar(255),
  in sam_id int,
  in sta_id int
)
begin
  select sum(amount) as qty, date(created_at) as date_in, supplier_id, name
  from medicine_stock_records
  where station_id = sta_id and typerecord = 1 and created_at between start_date and end_date
    and supplier = sup and supplier_id = sup_id and name = sam and sample_id = sam_id
  group by date(created_at);
end $$;

drop procedure if exists internal_records_by_sample;
$$;
create procedure internal_records_by_sample(
  in start_date datetime,
  in end_date datetime,
  in sta_id int
)
begin
  select sum(tpayment) as sale, date(created_at) as date_sale, sample_id, name
  from medicine_internal_records
  where station_id = sta_id and created_at between start_date and end_date and status = 1
  group by date(created_at), sample_id, name;
end $$;

drop procedure if exists bill_record_origin_price;
$$;
create procedure bill_record_origin_price(
  in start_date datetime,
  in end_date datetime,
  in sta_id int
)
begin
  select sum(qty * price) as tprice, date(created_at), sample_id, name
  from medicine_bill_records
  where station_id = sta_id and created_at between start_date and end_date
  group by date(created_at), sample_id, name;
end $$;

drop procedure if exists order_map_stat;
$$;
create procedure order_map_stat(
  in start_date datetime,
  in end_date datetime,
  in sta_id int
)
begin
  select sum(case when tpayout is null then tpayment else tpayout end) as t_income, count(*) as no,date(created_at), service_id, sername
  from order_maps
  where station_id = sta_id and created_at between start_date and end_date and status = 3
  group by date(created_at), service_id, sername;
end $$;

drop procedure if exists medicine_sale;
$$;
create procedure medicine_sale(
  in start_date datetime,
  in end_date datetime,
  in sta_id int
)
begin
  select date(ir.created_at), sum(case when ir.discount irs not null then ir.amount * ir.price - ir.discount else ir.amount * ir.price end) as t_sale, sum(ir.amount * (br.price * br.qty - br.discount) / br.qty) as t_in
  from medicine_internal_records as ir
    join medicine_bill_records as br
    on ir.noid = br.noid and ir.signid = br.signid and ir.name = br.name
  where ir.created_at between start_date and end_date and ir.station_id = sta_id
  group by date(ir.created_at);
end $$;

drop procedure if exists services_sale;
$$;
create procedure services_sale(
  in start_date datetime,
  in end_date datetime,
  in sta_id int
)
begin
  select date(created_at), sum(tpayout) as t_sale
  from order_maps
  where created_at between start_date and end_date and station_id = sta_id
  group by date(created_at);
end $$;
