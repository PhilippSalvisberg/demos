set serveroutput on size unlimited
begin
   <<print_tennis_products_sold_in_europe_2022>>
   for rec in (
      select r.country_region as region,
             p.prod_category,
             sum(s.amount_sold) as amount_sold
        from sales s
        join products p
          on p.prod_id = s.prod_id
        join customers cust
          on cust.cust_id = s.cust_id
        join times t
          on t.time_id = s.time_id
        join countries r
          on r.country_id = cust.country_id
       where calendar_year = 2022
       group by r.country_region,
                p.prod_category
       order by r.country_region,
                p.prod_category
   ) loop
      if rec.region = 'Europe' then
         if rec.prod_category = 'Tennis' then /* print only one line for demo purposes */
            sys.dbms_output.put_line('Amount: ' || rec.amount_sold);
         end if;
      end if;
   end loop print_tennis_products_sold_in_europe_2022;
end;
/