use [Uczelnia]
go

select '----------------------------------ZAD 9----------------------------------------------------------'

select * from Przedmiot_Student_BrakZaliczenia_view

/*
go
create view Przedmiot_Student_BrakZaliczenia_view as
select distinct
	Przedmiot.Nazwa,
	Student.Imie,
	Student.Nazwisko,
	'Brak Zaliczenia' as 'Zaliczenie'
	--isnull (Zaliczenie.Ocena,0) as Oceny
from 
przedmiot
inner join ProwadzacyPrzedmiot on ProwadzacyPrzedmiot.KodPrzedmiotu=Przedmiot.KodPrzedmiotu
inner join Zapisy on ProwadzacyPrzedmiot.IdPrzydzialu=Zapisy.IdPrzydzialu
inner join Student on Zapisy.NrIndeksu=Student.NrIndeksu
left join Zaliczenie on Zaliczenie.IdZapisu=Zapisy.IdZapisu
where ISNULL(Zaliczenie.Ocena,0) =0 
go
*/


select '----------------------------------ZAD 8----------------------------------------------------------'

select * from Studen_oceny_wiev
exec Student_oceny_proc 'Marcin Andrzejewski'

/*

go
alter proc Student_oceny_proc @Student varchar(71) as
select 
	Student,
	Ocena
from Studen_oceny_wiev
where Student = @Student

go
create view Studen_oceny_wiev as
select distinct 
	trim(Student.Imie)+' '+trim(Student.Nazwisko) as 'Student',
	Student.NrIndeksu,
	Zaliczenie.Ocena
from Student
left join Zapisy on Zapisy.NrIndeksu=Student.NrIndeksu
left join Zaliczenie on Zaliczenie.IdZapisu=Zapisy.IdZapisu
where Zaliczenie.Ocena not like 'null'
go
*/

select '----------------------------------ZAD 7----------------------------------------------------------'
exec Pracownik_przedmioty_proc 'Dr in¿. Andrzej Nowakowski'

/*
go
--lab1 zad7
alter proc Pracownik_przedmioty_proc @Pracownik varchar(92) 
as
select distinct
	[Nazwa Przedmiotu], Pracownik
from Przedmiot_Pracownik_nrGrupy_nazwaOddzialu_view
where Pracownik=@Pracownik
go
*/




select '----------------------------------ZAD 6----------------------------------------------------------'
select * from Student_Przedmioty_view
exec Student_przedmiot_proc 3

/*
--lab1 zad6
create proc Student_przedmiot_proc @indeks int 
as
select * from Student_Przedmioty_view
where Student_Przedmioty_view.NrIndeksu=@indeks
go

create view Student_Przedmioty_view as
select distinct trim(Student.Imie)+' '+trim(Student.Nazwisko) as 'Student',
	Student.NrIndeksu,
	Przedmiot.Nazwa as 'Nazwa Przedmiotu'
from Student
left join Zapisy on zapisy.NrIndeksu=Student.NrIndeksu
left join ProwadzacyPrzedmiot on ProwadzacyPrzedmiot.IdPrzydzialu=Zapisy.IdPrzydzialu
left join Przedmiot on ProwadzacyPrzedmiot.KodPrzedmiotu=Przedmiot.KodPrzedmiotu
where Przedmiot.Nazwa not like 'null'
go
*/


select '----------------------------------ZAD 5----------------------------------------------------------'
select * from Studen_Grupa_Oddzia³_wiev

/*
--lab1 zad5
create view Studen_Grupa_Oddzia³_wiev as
select 
	trim(Student.Imie)+' '+trim(Student.Nazwisko) as 'Student',
	Grupa.NrGrupy as 'Numer Oddzia³u',
	OddzialUczelni.Nazwa as 'Nazwa Oddzia³u Uczelni'
from Student 
left join Grupa on Student.IdGrupy=Grupa.IdGrupy
left join OddzialUczelni on Student.IdOddzialu=OddzialUczelni.IdOddzialu
go
*/


select '----------------------------------ZAD 4----------------------------------------------------------'
select * from Zaliczenie_Student_Przedmiot_Pracownie_view

/*
--lab1 zad4
create view Zaliczenie_Student_Przedmiot_Pracownie_view as
select Zaliczenie.Ocena,
	trim(Student.Imie)+' '+trim(Student.Nazwisko) as 'Student',
	Przedmiot.KodPrzedmiotu as 'Kod Przedmiotu',
	Przedmiot.nazwa as 'Nazwa Przedmiotu',
	trim(Pracownik.Tytul)+' '+trim(Pracownik.Imie)+' '+trim(Pracownik.Nazwisko) as 'Pracownik'
from Zaliczenie
left join Zapisy on Zaliczenie.IdZapisu=Zapisy.IdZapisu
left join Student on Student.NrIndeksu=Zapisy.NrIndeksu
left join ProwadzacyPrzedmiot on ProwadzacyPrzedmiot.IdPrzydzialu=Zapisy.IdPrzydzialu
left join Pracownik on Pracownik.IdPracownika=ProwadzacyPrzedmiot.IdPracownika
left join Przedmiot on ProwadzacyPrzedmiot.KodPrzedmiotu=Przedmiot.KodPrzedmiotu
go
*/



select '----------------------------------ZAD 3----------------------------------------------------------'
select * from Przedmiot_Pracownik_nrGrupy_nazwaOddzialu_view

/*
--lab1 zad3
create view Przedmiot_Pracownik_nrGrupy_nazwaOddzialu_view as
select Przedmiot.KodPrzedmiotu as 'Kod Przedmiotu',
	Przedmiot.Nazwa as 'Nazwa Przedmiotu', 
	Przedmiot.Semestr ,
	trim(Pracownik.Tytul)+' '+trim(Pracownik.Imie)+' '+trim(Pracownik.Nazwisko) as 'Pracownik',
	Grupa.NrGrupy as 'Numer Grupy',
	OddzialUczelni.Nazwa as 'Nazwa oddzia³u'
from Przedmiot
left join Pracownik
on Przedmiot.Opiekun=Pracownik.IdPracownika
left join OddzialUczelni
on Pracownik.IdOddzialu=OddzialUczelni.IdOddzialu
left join Grupa
on OddzialUczelni.IdOddzialu=Grupa.IdOddzialu
go
*/


select '----------------------------------ZAD 2----------------------------------------------------------'

select * from Przedmiot_Pracownik_view


--lab1 zad2
/*
go
alter view Przedmiot_Pracownik_view as
select Przedmiot.KodPrzedmiotu,
	Przedmiot.Nazwa as 'Nazwa Przedmiotu', 
	Przedmiot.Semestr ,
	trim(Pracownik.Tytul)+' '+trim(Pracownik.Imie)+' '+trim(Pracownik.Nazwisko) as 'Pracownik'
from Przedmiot
left join Pracownik
on Przedmiot.Opiekun=Pracownik.IdPracownika
go
*/


select '----------------------------------ZAD 1----------------------------------------------------------'

select * from Pracownik_Oddzial_view

/*
--lab1 zad1
CREATE view Pracownik_Oddzial_view as
select 
	trim(pracownik.Tytul)+' '+trim(Pracownik.Imie)+' '+trim(Pracownik.Nazwisko) as 'Pracownik', 
	Pracownik.PESEL, 
	OddzialUczelni.Nazwa as 'Nazwa Uczelni', 
	OddzialUczelni.Miasto as 'Miasto Uczelni'  from Pracownik 
left join OddzialUczelni
on Pracownik.IdOddzialu=OddzialUczelni.IdOddzialu
go
*/