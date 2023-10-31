# Wolf Georg 4aDAC

### a)

select per_vname, per_nname, kute_start 
	from person_firma pf
	join buchung using (per_id)
    join kurstermin using (kute_id)
    where kur_id = 3
      and per_vortragender = 1;
      
### b)

select kur_bezeichnung Kurs, count(per_id) "Anzahl der Teilnehmer"
	from kurs
	join kurstermin using (kur_id)
    join buchung using (kute_id)
    join person_firma using (per_id)
    where per_vortragender = 1
    group by kur_id
    order by kur_id desc;
	
### c)

select concat(per_vname, ' ', per_nname) "Kursleiter",
	   kur_bezeichnung, 
	   DATE_FORMAT(kute_start, '%d-%m-%Y') Beginn
	from kurs
	join kurstermin using (kur_id)
    join person_firma on (vortragender_per_id = per_id);
    
### d)

select concat(per_vname, ' ', per_nname) Teilnehmer, kute_start 
	from person_firma pf
	join buchung using (per_id)
    join kurstermin using (kute_id)
    where kute_id = 3
      and per_vortragender = 1;
      
### e)

select count(per_id) "Anzahl Personen ohne Kursteilnahme"
	from person_firma
	where per_id<>all(select per_id from buchung)
      and per_geschlecht != "x";
    
### f)

select * from person_firma pf
	where not exists(
		select 1 from buchung 
			join kurstermin using (kute_id)
            where kur_id = 2
              and per_id = pf.per_id)
    and per_vortragender = 1
    and per_geschlecht != "x"
	order by per_id;

### g)

select kur_bezeichnung Kursbezeichnung, kupr_wert Preis from kurs
	join kurspreis using (kur_id)
    where kupr_bis > curdate()
      and (kupr_wert between 150 and 2000);
    
### h)

select * from person_firma
	where per_nname like '_a%'
      and per_geschlecht != "x";
    
### i)

select * from person_firma
	where per_nname like 'M%'
      and per_vname like '%a'
      and per_geschlecht != "x";

### j)

select kur_bezeichnung Kursbezeichnung,
	   kupr_wert Preis,
       kupr_bis "gültig bis"
	from kurs
	join kurspreis using (kur_id)
    where kur_id = 1
    order by kupr_bis;
    
### k)

select per_geschlecht Geschlecht,
	   per_nname Nachname,
       per_vname Vorname
	from person_firma
    where per_geschlecht != "x"
    order by per_geschlecht desc,
			 per_nname,
             per_vname;

### l)

select kur_bezeichnung Kurs,
	   kute_start Zeitraum
	from kurs
	join kurstermin using (kur_id)
    where (kute_start BETWEEN '2020-01-01' AND '2021-12-31');
