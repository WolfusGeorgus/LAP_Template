use adresse;

insert into ort values (null, 'Graz'), (null, 'Eisenstadt');
insert into plz values (7000);
insert into plz_ort (plz_nr, ort_id) values (7000, 6);

select ort_name "Plz/Ort" from ort
	left outer join plz_ort using (ort_id)
 union   
select plz_nr from plz
	left outer join plz_ort using (plz_nr);
    
select * from ort where ort_id not in (select ort_id from plz_ort);

select * from ort where ort_id > any(select ort_id from plz_ort);

select *from ort where ort_id >= all(select ort_id from plz_ort);

select * from ort where ort_id <> all(select ort_id from plz_ort);

select str_name, ort_name, plz_nr from strasse 
	left join strasse_plz_ort using (str_id)
    left join plz_ort using (plor_id)
    left join plz using (plz_nr)
    left join ort using (ort_id)
union
select str_name, ort_name, plz_nr from ort 
    left join plz_ort using (ort_id)
    left join plz using (plz_nr)
	left join strasse_plz_ort using (plor_id)	
    left join strasse using (str_id);

select * from strasse
	where not exists (select 1 from strasse_plz_ort where strasse.str_id = str_id);
    
select * from strasse
	where str_id not in (select str_id from strasse_plz_ort);
    
    select * from strasse
	where str_id <>all(select str_id from strasse_plz_ort);
    
select * from strasse
	left join strasse_plz_ort using (str_id)
    where spo_id is null;





















































































































































































































































































