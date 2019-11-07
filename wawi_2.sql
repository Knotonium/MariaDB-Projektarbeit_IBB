---------------------------------------------------------------------------------------------------------------------------------------JOIN
-- Zu welchen Marken gehören die Artikel?
select art.Art_Id, br.B_Name, art.Art_Name
	from artikel as art
	inner join brand as br
	on art.B_Id = br.B_Id;

-- Welche Positionen haben die Aufträge, welche Artikel haben die Positionen?
select art.Art_Name, pos.Pos_Anzahl, auf.A_Id, auf.A_Datum, auf.A_Status
	from position as pos
	inner join auftrag as auf
	on pos.A_Id = auf.A_Id
	inner join artikel as art
	on pos.Art_Id = art.Art_Id;

-- Welche Kunden haben Aufträge, wann wurde gezahlt?
select kun.Kd_Id, auf.A_Id, auf.Z_Datum, kun.Kd_Name
	from kunde as kun
	inner join auftrag as auf
	on auf.Kd_Id = kun.Kd_Id;

-- Welcher Kunde hat welchen Artikel Bestellt?
select art.Art_Name, pos.Pos_Anzahl, auf.A_Id, auf.A_Datum, auf.A_Status, 
		kun.Kd_Name, kun.Kd_Vorname
	from position as pos
	inner join auftrag as auf
	on pos.A_Id = auf.A_Id
	inner join artikel as art
	on pos.Art_Id = art.Art_Id
	inner join kunde as kun
	on auf.Kd_Id = kun.Kd_Id;

-- Welcher Kunde hat welchen Artikel Bestellt?
-- Welche Marken haben diese Artikel?
-- Welcher Mitarbeiter bearbeitet die Aufträge?
select art.Art_Name, pos.Pos_Anzahl, auf.A_Id, auf.A_Datum, auf.A_Status,
		mit.Ma_Name, kun.Kd_Name, kun.Kd_Vorname, bra.B_Name
	from position as pos
	inner join auftrag as auf
	on pos.A_Id = auf.A_Id
	inner join artikel as art
	on pos.Art_Id = art.Art_Id
	inner join kunde as kun
	on auf.Kd_Id = kun.Kd_Id
	inner join mitarbeiter as mit
	on auf.Ma_Id = mit.Ma_Id
	inner join brand as bra
	on art.B_Id = bra.B_Id
	order by auf.A_Id;

-- Welcher Kunde hat keinen Auftrag?
select auf.A_Id, kun.Kd_Id, kun.Kd_Name
	from kunde as kun
	left outer join auftrag as auf
	on kun.Kd_Id = auf.Kd_Id
	where auf.A_Id is NULL;

-- Eine einfache Subquery anstelle eines Joins.
-- Welche Kunden haben bereits Aufträge? Ohne Dubletten!
select kun.Kd_Id, kun.Kd_Name
	from kunde as kun
	where kun.Kd_Id in
		(select auf.Kd_Id
			from auftrag as auf);

---------------------------------------------------------------------------------------------------------------------------------------VIEW
-- Gesamtübersicht für Aufträge: Welche Positionen -> Welche Artikel -> Welche Brand? Welcher Kunde/Mitarbeiter?
drop view if exists showall;
create view showall as
	select art.Art_Name, pos.Pos_Anzahl, auf.A_Id, auf.A_Datum, auf.A_Status,
			mit.Ma_Name, kun.Kd_Name, kun.Kd_Vorname, bra.B_Name
		from position as pos
		inner join auftrag as auf
		on pos.A_Id = auf.A_Id
		inner join artikel as art
		on pos.Art_Id = art.Art_Id
		inner join kunde as kun
		on auf.Kd_Id = kun.Kd_Id
		inner join mitarbeiter as mit
		on auf.Ma_Id = mit.Ma_Id
		inner join brand as bra
		on art.B_Id = bra.B_Id; 

select * from showall order by A_Status;
select * from showall where A_Status = 'offen';
select Art_Name, A_Datum, Kd_Vorname, Kd_Name from showall where Kd_Name like 'K%';

-- Welcher Artikel hat welchen Umsatz?
drop view if exists umsatz_pro_art;
create view umsatz_pro_art as
	select art.Art_Id, sum(pos.Pos_Preis) as Umsatz, art.Art_Name
		from position as pos
		right outer join artikel as art
		on pos.Art_Id = art.Art_Id
		group by pos.Art_Id;

select * from umsatz_pro_art order by Art_Id;
select * from umsatz_pro_art where Umsatz > 50;
select * from umsatz_pro_art where Umsatz is NULL;

-- Welcher Auftrag hat wie viele Positionen?
drop view if exists position_pro_auf;
create view position_pro_auf as
	select pos.A_Id, count(pos.Pos_Id) as Pos_pro_A, auf.Kd_Id, kun.Kd_Vorname, kun.Kd_Name, kun.Kd_Email
		from position as pos
		inner join auftrag as auf
		on pos.A_Id = auf.A_Id
		inner join kunde as kun
		on auf.Kd_Id = kun.Kd_Id
		group by pos.A_Id;

select * from position_pro_auf where Pos_pro_A = 1;
select * from position_pro_auf order by Pos_pro_A;

---------------------------------------------------------------------------------------------------------------------------------------PROZEDUR
drop procedure if exists p_welcher_auftrag_hat_ma;

delimiter //
create procedure p_welcher_auftrag_hat_ma(p_Ma_Name varchar(50))
begin
select art.Art_Name, pos.Pos_Anzahl, auf.A_Id, auf.A_Datum, auf.A_Status,
		mit.Ma_Name, kun.Kd_Name, kun.Kd_Vorname, bra.B_Name
	from position as pos
	inner join auftrag as auf
	on pos.A_Id = auf.A_Id
	inner join artikel as art
	on pos.Art_Id = art.Art_Id
	inner join kunde as kun
	on auf.Kd_Id = kun.Kd_Id
	inner join mitarbeiter as mit
	on auf.Ma_Id = mit.Ma_Id
	inner join brand as bra
	on art.B_Id = bra.B_Id
	where mit.Ma_Name = p_Ma_Name;
end //
delimiter ;

select * from auftrag;
select * from mitarbeiter;
call p_welcher_auftrag_hat_ma('Zielke');

-- Gene Roddenberry erstellt telefonisch einen Auftrag.
-- Er weiß nicht, ob er schon Kunde bei uns war.
-- Mit dieser Prozedur können wir das schnell herausfinden.
-- Ist Gene Roddenberry noch kein Kunde, wird er als solcher neu erstellt.
-- Außerdem wird ein Auftrag mit der Kd_Id und dem aktuellem Datum angelegt.
drop procedure if exists p_new_kd_a;

delimiter //
create procedure p_new_kd_a(p_Kd_Vorname varchar(50), p_Kd_Name varchar(50))
begin
	declare kd_id_exists integer;
	
	select count(Kd_Id) from kunde
		where Kd_Vorname = p_Kd_Vorname and Kd_Name = p_Kd_Name into kd_id_exists;
	
	if (kd_id_exists = 0) then
		insert into kunde (Kd_Vorname, Kd_Name)
			values (p_Kd_Vorname, p_Kd_Name);
	end if;
	
	select Kd_Id from kunde
		where Kd_Vorname = p_Kd_Vorname and Kd_Name = p_Kd_Name into kd_id_exists;
		insert into auftrag (Kd_Id, A_Datum)
			values (kd_id_exists, curdate());
end //
delimiter ;


select * from kunde;
select * from auftrag;

start transaction;

call p_new_kd_a('Gene', 'Roddenberry');
call p_new_kd_a('Phillip', 'Dolan');

select * from kunde;
select * from auftrag;

rollback;

---------------------------------------------------------------------------------------------------------------------------------------TRIGGER
drop table if exists protokoll;

create table protokoll (
	p_id integer primary key auto_increment,
	p_wo varchar(200),
	p_wann datetime,
	p_was varchar(200)
) engine = innoDB;

drop procedure if exists p_write_prot;

delimiter //
create procedure p_write_prot (para_wo varchar(200), para_was varchar(200))
begin
	insert into protokoll (p_wo, p_wann, p_was)
		values (para_wo, now(), para_was);
end;
//
delimiter ;

drop trigger if exists tr_neuer_name;
delimiter //
create trigger tr_neuer_name after insert on mitarbeiter for each row
begin
	declare va_was varchar(200);
	set va_was = concat('Neuer Ma_Name: ', new.Ma_Vorname, ' ', new.Ma_Name);
	call p_write_prot('mitarbeiter', va_was);
end;
//
delimiter ;



drop trigger if exists tr_name_loeschen;
delimiter //
create trigger tr_name_loeschen after delete on mitarbeiter for each row
begin
	declare va_was varchar(200);
	set va_was = concat('Ma_Name geloescht: ', old.Ma_Vorname, ' ', old.Ma_Name);
	call p_write_prot('mitarbeiter', va_was);
end;
//
delimiter ;

drop trigger if exists tr_name_aendern;
delimiter //
create trigger tr_name_aendern after update on mitarbeiter for each row
begin
	declare va_was varchar(200);
	set va_was = concat('Ma_Name geaendert von: ', old.Ma_Vorname, ' ', old.Ma_Name);
	set va_was = concat(va_was, ' in: ', new.Ma_Vorname, ' ', new.Ma_Name);
	call p_write_prot('mitarbeiter', va_was);
end;
//
delimiter ;


select * from mitarbeiter;
start transaction;
update mitarbeiter set Ma_Name = 'Heldt', Ma_Vorname = 'Nicole' where Ma_Name = 'Forouhar' and Ma_Vorname = 'Nicole';
delete from mitarbeiter where Ma_Name = 'Heldt' and Ma_Vorname = 'Stefan';
insert into mitarbeiter (Ma_Name, Ma_Vorname) values ('Meier', 'Andrea');
select * from mitarbeiter;
select * from protokoll;
rollback;


drop trigger if exists tr_neuer_artikel;
delimiter //
create trigger tr_neuer_artikel after insert on artikel for each row
begin
	declare va_was varchar(200);
	set va_was = concat('Neuer Artikel: ', new.Art_Name, ' ', new.Art_Art);
	call p_write_prot('artikel', va_was);
end;
//
delimiter ;

select * from artikel;
start transaction;
insert into artikel (Art_Name, Art_Art) values ('Dichtung M6', 'Zubehoer');
insert into artikel (Art_Name, Art_Art) values ('Schraubenset', default);
select * from artikel;
select * from protokoll;
rollback;


