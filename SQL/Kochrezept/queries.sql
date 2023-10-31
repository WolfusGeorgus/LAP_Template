use Kochrezeptverwaltung;

show tables;

select * from zutaten;

select * from zubereitung;

select * from liste;

select * from rezept;

select * from mengeneinheit;

-- Anzahl Rezeptbeschreibungen zu Marmorkuchen
select r.name, count(zubereitung_id) 'Anzahl Zubereitungen'
	from rezept r, zubereitung z
    where r.rezept_id = z.rezept_id
      and r.name = 'Marmorkuchen';
      
-- Rezepte ohne Eier (Vegane Fritatten)
select * from rezept r
	where not exists (select z.rezept_id from zubereitung z, liste l, zutaten zu
						where z.rezept_id = r.rezept_id
                          and z.zubereitung_id = l.zubereitung_id
                          and zu.zutaten_id = l.zutaten_id
                          and zu.name = 'Eier');
       
-- Eine Marmorkuchenzubereitung
select r.name Rezept, z.text Zubereitung, GROUP_CONCAT( concat( zu.name, ' ', l.menge, ' ', me.lbez) SEPARATOR ', ') Zutat  from 
			rezept r, zubereitung z, liste l, zutaten zu, mengeneinheit me
			where z.rezept_id = r.rezept_id
			  and z.zubereitung_id = l.zubereitung_id
			  and zu.zutaten_id = l.zutaten_id
              and l.mengeneinheit_id = me.mengeneinheit_id
              and r.name = 'Marmorkuchen'
              group by z.zubereitung_id;
              #and z.zubereitung_id = 4;

-- Andere Art der Darstellung
select zu.name Zutat, me.lbez Mengeneinheit, l.menge Menge  from 
			rezept r, zubereitung z, liste l, zutaten zu, mengeneinheit me
			where z.rezept_id = r.rezept_id
			  and z.zubereitung_id = l.zubereitung_id
			  and zu.zutaten_id = l.zutaten_id
              and l.mengeneinheit_id = me.mengeneinheit_id
              and z.zubereitung_id = 4;
              