


create database wawi;

use wawi;

---------------------------------------------------------------------------------------------------------------------------------------BRAND/MARKE
drop table if exists brand;
create table brand
	(B_Id integer primary key auto_increment,
	 B_Name varchar (50)
	);

insert into brand (B_Name)
	values ('SUKI');
insert into brand (B_Name)
	values ('Fischer');
insert into brand (B_Name)
	values ('TOX');
insert into brand (B_Name)
	values ('Spax');

---------------------------------------------------------------------------------------------------------------------------------------MITARBEITER
drop table if exists mitarbeiter;
create table mitarbeiter
	(Ma_Id integer primary key auto_increment,
	 Ma_Name varchar (50),
	 Ma_Vorname varchar (50),
	 Funktion varchar (100),
	 Ma_Email varchar (100),
	 Ma_Geb date
	);

alter table mitarbeiter add unique (Ma_Name, Ma_Vorname);

insert into mitarbeiter (Ma_Name, Ma_Vorname, Funktion, Ma_Email, Ma_Geb)
	values ('Forouhar', 'Nicole', 'CEO', 'forouhar@schraube4u.de', '1990-12-29');
insert into mitarbeiter (Ma_Name, Ma_Vorname, Funktion, Ma_Email, Ma_Geb)
	values ('Heldt', 'Stefan', 'Einkauf', 'heldt@schraube4u.de', '1985-11-25');
insert into mitarbeiter (Ma_Name, Ma_Vorname, Funktion, Ma_Email, Ma_Geb)
	values ('Leowald', 'Philipp', 'Verkauf', 'leowald@schraube4u.de', '1983-05-13');
insert into mitarbeiter (Ma_Name, Ma_Vorname, Funktion, Ma_Email, Ma_Geb)
	values ('Zielke', 'Torsten', 'Verkauf', 'zielke@schraube4u.de', '1983-05-13');
insert into mitarbeiter (Ma_Name, Ma_Vorname, Funktion, Ma_Email, Ma_Geb)
	values ('Hilger', 'Julia', 'Personal/Buchhaltung', 'hilger@schraube4u.de', '1991-07-21');
insert into mitarbeiter (Ma_Name, Ma_Vorname, Funktion, Ma_Email, Ma_Geb)
	values ('Giersemehl', 'Gerd', 'Webshop', 'giersemehl@schraube4u.de', '1985-11-28');
insert into mitarbeiter (Ma_Name, Ma_Vorname, Funktion, Ma_Email, Ma_Geb)
	values ('Juergens', 'Michael', 'Verkauf', 'juergens@schraube4u.de', '1980-01-15');

---------------------------------------------------------------------------------------------------------------------------------------KUNDE
drop table if exists kunde;
create table kunde
	(Kd_Id integer primary key auto_increment,
	 Kd_Name varchar (50),
	 Kd_Vorname varchar (50),
	 PLZ char (9),
	 Ort varchar (50),
	 Kd_Email varchar (100) unique
	);

insert into kunde (Kd_Name, Kd_Vorname, PLZ, Ort, Kd_Email)
	values ('Dolan', 'Phillip', '60599', 'Offenbach am Main', 'dolan@web.de');
insert into kunde (Kd_Name, Kd_Vorname, PLZ, Ort, Kd_Email)
	values ('Forouhar', 'Farhad', '45355', 'Essen', 'farifor@web.de');
insert into kunde (Kd_Name, Kd_Vorname, PLZ, Ort, Kd_Email)
	values ('Saaber', 'Marco', '45276', 'Essen', 'saaber@aol.com');
insert into kunde (Kd_Name, Kd_Vorname, PLZ, Ort, Kd_Email)
	values ('Reisser', 'Martin', '52062', 'Aachen', 'martin.reisser@gmail.com');
insert into kunde (Kd_Name, Kd_Vorname, PLZ, Ort, Kd_Email)
	values ('Knoten', 'Nicole', '45145', 'Essen', 'knotonium@protonmail.com');
insert into kunde (Kd_Name, Kd_Vorname, PLZ, Ort, Kd_Email)
	values ('Pietrucha', 'Gosia', '80331', 'Muenchen', 'pietrucha@gmx.de');
insert into kunde (Kd_Name, Kd_Vorname, PLZ, Ort, Kd_Email)
	values ('Leowald', 'Philipp', '46514', 'Schermbeck', 'baumdoktor@arcor.de');
insert into kunde (Kd_Name, Kd_Vorname, PLZ, Ort, Kd_Email)
	values ('Mueller', 'Kevin', '27472', 'Cuxhaven', 'kevinski@googlemail.com');
insert into kunde (Kd_Name, Kd_Vorname, PLZ, Ort, Kd_Email)
	values ('Knipprath', 'Sandra', '20095', 'Hamburg', 'knippsand@hotmail.com');
insert into kunde (Kd_Name, Kd_Vorname, PLZ, Ort, Kd_Email)
	values ('Guttau', 'Martina', '65934', 'Frankfurt am Main', 'guttau@googlemail.com');
insert into kunde (Kd_Name, Kd_Vorname, PLZ, Ort, Kd_Email)
	values ('Ziegler', 'Sebastian', '35037', 'Marburg', 'ziegelbasti@web.de');
insert into kunde (Kd_Name, Kd_Vorname, PLZ, Ort, Kd_Email)
	values ('Kryzelewski', 'Bjoern', '66111', 'Saarbruecken', 'bambusbjoern@gmail.com');

---------------------------------------------------------------------------------------------------------------------------------------ARTIKEL
drop table if exists artikel;
create table artikel
	(Art_Id integer primary key auto_increment,
	 B_Id integer,
	 Art_Name varchar (100),
	 EAN char (13),
	 Art_Art varchar (100) default 'Eisenwaren',
	 Preis_EK decimal (6,2),
	 Preis_VK decimal (6,2),
	 Steuer decimal (4,2)
	);

alter table artikel add unique (EAN); 

alter table artikel add foreign key (B_Id)
	references brand (B_Id);

insert into artikel (EAN, Art_Name, Preis_EK, Preis_VK, Steuer, B_Id)
	values ('4032526105481', 'Suki Kreuz-Holzschrauben BASIC 4,5x50mm, XL-Pack', 3.48, 8.49, 19.00, 1);
insert into artikel (EAN, Art_Name, Preis_EK, Preis_VK, Steuer, B_Id)
	values ('4032526105482', 'Suki Torx-Holzschrauben BASIC 4,5x50mm, XL-Pack', 3.48, 8.49, 19.00, 1);
insert into artikel (EAN, Art_Name, Preis_EK, Preis_VK, Steuer, B_Id)
	values ('4032526105483', 'Suki Kreuz-Holzschrauben BASIC 4,5x50mm, L-Pack', 1.74, 4.49, 19.00, 1);
insert into artikel (EAN, Art_Name, Preis_EK, Preis_VK, Steuer, B_Id)
	values ('4032526105484', 'Suki Torx-Holzschrauben BASIC 4,5x50mm, L-Pack', 1.74, 4.49, 19.00, 1);
insert into artikel (EAN, Art_Name, Preis_EK, Preis_VK, Steuer, B_Id)
	values ('4032526105485', 'Suki Kreuz-Holzschrauben BASIC 4,5x50mm, M-Pack', 0.87, 2.49, 19.00, 1);
insert into artikel (EAN, Art_Name, Preis_EK, Preis_VK, Steuer, B_Id)
	values ('4032526105486', 'Suki Torx-Holzschrauben BASIC 4,5x50mm, M-Pack', 0.87, 2.49, 19.00, 1);
insert into artikel (EAN, Art_Name, Preis_EK, Preis_VK, Steuer, B_Id)
	values ('4032526105491', 'Spax-Universalschraube 4x50mm, XXL-Pack', 6.88, 14.49, 19.00, 4);
insert into artikel (EAN, Art_Name, Preis_EK, Preis_VK, Steuer, B_Id)
	values ('4032526105492', 'Spax-Universalschraube 5x80mm, XL-Pack', 3.88, 9.89, 19.00, 4);
insert into artikel (EAN, Art_Name, Preis_EK, Preis_VK, Steuer, B_Id)
	values ('4048962251340', 'fischer Torx-Betonschraube ULTRACUT FBS ll 8x55mm, L-Pack', 10.00, 23.95, 19.00, 2);
insert into artikel (EAN, Art_Name, Preis_EK, Preis_VK, Steuer, B_Id)
	values ('4048962251388', 'fischer Torx-Betonschraube ULTRACUT FBS ll 8x100mm, L-Pack', 14.00, 29.55, 19.00, 2);
insert into artikel (EAN, Art_Name, Preis_EK, Preis_VK, Steuer, B_Id)
	values ('4048962251401', 'fischer Torx-Betonschraube ULTRACUT FBS ll 8x130mm, L-Pack', 15.00, 32.50, 19.00, 2);
insert into artikel (EAN, Art_Name, Preis_EK, Preis_VK, Steuer, B_Id)
	values ('4049563023671', 'Tox Betonschraube Sumo Pro 1 M10x100x20 mm, M-Pack', 8.40, 20.79, 19.00, 3);
insert into artikel (EAN, Art_Name, Preis_EK, Preis_VK, Steuer, B_Id)
	values ('4049563023672', 'Tox Betonschraube Sumo Pro 1 M10x100x20 mm, L-Pack', 16.80, 39.49, 19.00, 3);
insert into artikel (EAN, Art_Name, Preis_EK, Preis_VK, Steuer, B_Id)
	values ('4049563023673', 'Tox Betonschraube Sumo Pro 1 M10x100x20 mm, XL-Pack', 33.60, 78.89, 19.00, 3);

---------------------------------------------------------------------------------------------------------------------------------------AUFTRAG
drop table if exists auftrag;
create table auftrag
	(A_Id integer primary key auto_increment,
	 Kd_Id integer,
	 Ma_Id integer,
	 A_Datum date,
	 A_Status enum ('offen', 'bezahlt', 'versendet', 'storniert', 'retoure') default 'offen',
	 Z_Ziel date,
	 Z_Datum date,
	 Z_Art varchar (50),
	 Marktplatz varchar (50)
	);

alter table auftrag add foreign key (Kd_Id)
	references kunde (Kd_Id)
	on delete cascade;

alter table auftrag add foreign key (Ma_Id)
	references mitarbeiter (Ma_Id)
	on delete set NULL;

insert into auftrag (A_Datum, A_Status, Kd_Id, Ma_Id, Z_Ziel, Z_Datum, Z_Art, Marktplatz)
	values ('2019-10-21', 3, 3, 4, '2019-11-04', '2019-10-21', 'klarna', 'schraube4u.de');
insert into auftrag (A_Datum, Kd_Id, Ma_Id, Z_Ziel, Z_Datum, Z_Art, Marktplatz)
	values ('2019-10-22', 1, 4, '2019-11-05', NULL, 'Ueberweisung', 'schraube4u.de');
insert into auftrag (A_Datum, A_Status, Kd_Id, Ma_Id, Z_Ziel, Z_Datum, Z_Art, Marktplatz)
	values ('2019-10-22', 2, 2, 3, '2019-11-05', '2019-10-22', 'PayPal', 'schraube4u.de');
insert into auftrag (A_Datum, A_Status, Kd_Id, Ma_Id, Z_Ziel, Z_Datum, Z_Art, Marktplatz)
	values ('2019-10-22', 2, 9, 4, '2019-11-05', '2019-10-22', 'PayPal', 'ebay');
insert into auftrag (A_Datum, A_Status, Kd_Id, Ma_Id, Z_Ziel, Z_Datum, Z_Art, Marktplatz)
	values ('2019-10-22', 2, 5, 4, '2019-11-05', '2019-10-22', 'PayPal', 'ebay');
insert into auftrag (A_Datum, A_Status, Kd_Id, Ma_Id, Z_Ziel, Z_Datum, Z_Art, Marktplatz)
	values ('2019-10-23', 2, 11, 4, '2019-11-06', '2019-10-23', 'PayPal', 'ebay');
insert into auftrag (A_Datum, Kd_Id, Ma_Id, Z_Ziel, Z_Datum, Z_Art, Marktplatz)
	values ('2019-10-23', 12, 4, '2019-11-06', NULL, 'Ueberweisung', 'schraube4u.de');
insert into auftrag (A_Datum, A_Status, Kd_Id, Ma_Id, Z_Ziel, Z_Datum, Z_Art, Marktplatz)
	values ('2019-10-23', 2, 5, 3, '2019-11-06', '2019-10-23', 'klarna', 'schraube4u.de');
insert into auftrag (A_Datum, A_Status, Kd_Id, Ma_Id, Z_Ziel, Z_Datum, Z_Art, Marktplatz)
	values ('2019-10-24',2, 1, 7, '2019-11-07', '2019-10-24', 'PayPal', 'ebay');
insert into auftrag (A_Datum, A_Status, Kd_Id, Ma_Id, Z_Ziel, Z_Datum, Z_Art, Marktplatz)
	values ('2019-10-24', 2, 5, 7, '2019-11-07', '2019-10-24', 'PayPal', 'ebay');

---------------------------------------------------------------------------------------------------------------------------------------POSITION
drop table if exists position;
create table position
	(Pos_Id integer primary key auto_increment,
	 A_Id integer,
	 Art_Id integer,
	 Pos_Anzahl integer,
	 Pos_Preis decimal (6,2)
	);

alter table position add foreign key (A_Id)
	references auftrag (A_Id)
	on delete cascade;

insert into position (A_Id, Art_Id, Pos_Anzahl, Pos_Preis)
	values (1, 1, 2, 16.98);

insert into position (A_Id, Art_Id, Pos_Anzahl, Pos_Preis)
	values (2, 3, 1, 4.49);
insert into position (A_Id, Art_Id, Pos_Anzahl, Pos_Preis)
	values (2, 10, 1, 29.55);

insert into position (A_Id, Art_Id, Pos_Anzahl, Pos_Preis)
	values (3, 14, 1, 78.89);
insert into position (A_Id, Art_Id, Pos_Anzahl, Pos_Preis)
	values (3, 8, 1, 9.89);
insert into position (A_Id, Art_Id, Pos_Anzahl, Pos_Preis)
	values (3, 4, 1, 4.49);

insert into position (A_Id, Art_Id, Pos_Anzahl, Pos_Preis)
	values (4, 3, 2, 8.98);
insert into position (A_Id, Art_Id, Pos_Anzahl, Pos_Preis)
	values (4, 1, 2, 16.98);

insert into position (A_Id, Art_Id, Pos_Anzahl, Pos_Preis)
	values (5, 12, 2, 20.79);

insert into position (A_Id, Art_Id, Pos_Anzahl, Pos_Preis)
	values (6, 2, 2, 16.98);
insert into position (A_Id, Art_Id, Pos_Anzahl, Pos_Preis)
	values (6, 4, 1, 4.49);
insert into position (A_Id, Art_Id, Pos_Anzahl, Pos_Preis)
	values (6, 12, 1, 20.79);
insert into position (A_Id, Art_Id, Pos_Anzahl, Pos_Preis)
	values (6, 9, 1, 23.95);

insert into position (A_Id, Art_Id, Pos_Anzahl, Pos_Preis)
	values (7, 5, 2, 4.98);
insert into position (A_Id, Art_Id, Pos_Anzahl, Pos_Preis)
	values (7, 7, 1, 14.49);

insert into position (A_Id, Art_Id, Pos_Anzahl, Pos_Preis)
	values (8, 3, 1, 4.49);
insert into position (A_Id, Art_Id, Pos_Anzahl, Pos_Preis)
	values (8, 11, 1, 32.50);

insert into position (A_Id, Art_Id, Pos_Anzahl, Pos_Preis)
	values (9, 10, 2, 59.10);

insert into position (A_Id, Art_Id, Pos_Anzahl, Pos_Preis)
	values (10, 2, 1, 8.49);
insert into position (A_Id, Art_Id, Pos_Anzahl, Pos_Preis)
	values (10, 13, 1, 39.49);

---------------------------------------------------------------------------------------------------------------------------------------BESTAND
drop table if exists bestand;
create table bestand
	(Best_Id integer primary key auto_increment,
	 Art_Id integer unique,
	 Best_Verf integer,
	 Best_Res integer,
	 Best_Ges integer
	);

alter table bestand add foreign key (Art_Id)
	references artikel (Art_Id);

insert into bestand (Art_Id, Best_Verf, Best_Res, Best_Ges)
	values (1, 0, 0, 0);
insert into bestand (Art_Id, Best_Verf, Best_Res, Best_Ges)
	values (2, 0, 0, 0);
insert into bestand (Art_Id, Best_Verf, Best_Res, Best_Ges)
	values (3, 0, 0, 0);
insert into bestand (Art_Id, Best_Verf, Best_Res, Best_Ges)
	values (4, 0, 0, 0);
insert into bestand (Art_Id, Best_Verf, Best_Res, Best_Ges)
	values (5, 0, 0, 0);
insert into bestand (Art_Id, Best_Verf, Best_Res, Best_Ges)
	values (6, 0, 0, 0);
insert into bestand (Art_Id, Best_Verf, Best_Res, Best_Ges)
	values (7, 0, 0, 0);
insert into bestand (Art_Id, Best_Verf, Best_Res, Best_Ges)
	values (8, 0, 0, 0);
insert into bestand (Art_Id, Best_Verf, Best_Res, Best_Ges)
	values (9, 0, 0, 0);
insert into bestand (Art_Id, Best_Verf, Best_Res, Best_Ges)
	values (10, 0, 0, 0);
insert into bestand (Art_Id, Best_Verf, Best_Res, Best_Ges)
	values (11, 0, 0, 0);
insert into bestand (Art_Id, Best_Verf, Best_Res, Best_Ges)
	values (12, 0, 0, 0);
insert into bestand (Art_Id, Best_Verf, Best_Res, Best_Ges)
	values (13, 0, 0, 0);
insert into bestand (Art_Id, Best_Verf, Best_Res, Best_Ges)
	values (14, 0, 0, 0);

---------------------------------------------------------------------------------------------------------------------------------------LIEFERSCHEIN/RECHNUNG
drop table if exists lr;
create table lr
	(LR_Id integer primary key auto_increment,
	 A_Id integer,
	 Ma_Id integer,
	 LR_Datum date,
	 Z_Summe decimal (6,2)
	);

insert into lr (A_Id, Ma_Id, LR_Datum, Z_Summe)
	values (1, 4, '2019-10-22', 16.98);
