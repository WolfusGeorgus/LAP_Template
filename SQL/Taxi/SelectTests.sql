## Gesamte Ladezeit und Kosten beim Laden pro Auto in einem bestimmten Monat
select Kennzeichen, 
			sum(dauer) "Gesamt Ladezeit", 
			round(sum(Kosten_pro_kwh * Kwh), 2) "Gesamt Ladekosten" 
	from auto
	join auto_standort using (auto_id)
    join ladevorgang using (aust_id)
    join ladestation using (ladestation_id)
    where Beginn between "2023-10-01" and "2023-10-31"
    group by auto_id;
    
## Gesamte Ladezeit und Kosten beim Laden eines bestimmten Autos in einem bestimmten Monat
select Kennzeichen, 
			sum(dauer) "Gesamt Ladezeit", 
			round(sum(Kosten_pro_kwh * Kwh), 2) "Gesamt Ladekosten" 
	from auto
	join auto_standort using (auto_id)
    join ladevorgang using (aust_id)
    join ladestation using (ladestation_id)
    where Beginn between "2023-10-01" and "2023-10-31"
    and kennzeichen = 'EF345GH';
    
## Gesamte Ladezeit und Kosten pro Ladestation
## (In meinen Testdaten hat jeder Anbieter genau eine Station)
select anbieter.name, ladestation_id,
			sum(dauer) "Gesamt Ladezeit", 
			round(sum(Kosten_pro_kwh * Kwh), 2) "Gesamt Ladekosten" 
	from auto
	join auto_standort using (auto_id)
    join ladevorgang using (aust_id)
    join ladestation using (ladestation_id)
    join Anbieter using (anbieter_id)
    where Beginn between "2023-10-01" and "2023-10-31"
    group by anbieter.name, ladestation_id
    order by ladestation_id;
   
## Gesamte gefahrene und leer gefahrene KM pro Auto in einem bestimmten Monat
select Kennzeichen, 
	   sum(km_ende - km_beginn) "Anzahl gefahrene KM",
	   sum(ifnull((select km_beginn from fahrt 
				where fau_id = f.fau_id 
                  and km_beginn > f.km_ende 
				  limit 1), km_ende) - km_ende) "Anzahl leer gefahrene KM"
	from auto
	join Fahrer_auto using (auto_id)
    join fahrt f using (fau_id)   
	where Zeit_Beginn between "2023-10-01" and "2023-10-31"
    group by auto_id;
    
## Gesamte gefahrene und leer gefahrene KM pro Fahrer in einem bestimmten Monat
select Vorname, Nachname, group_concat(distinct Kennzeichen) "Gefahrene Autos",
	   sum(km_ende - km_beginn) "Anzahl gefahrene KM"
	from auto
	join Fahrer_auto using (auto_id)
    join fahrt f using (fau_id)   
    join Fahrer using (fahrer_id)
	where Zeit_Beginn between "2023-10-01" and "2023-10-31"
    group by fahrer_id;