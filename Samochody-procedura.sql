
/*
delete Samochod
delete Sprzedane
delete model
delete Silnik
*/

update Sprzedane set sprzedane=1 where id_samochod=16

--exec dodajSamochod 2,'ON',200,'Nissan','Almera',1,1,0,'dw 12525'
exec dodajSamochod 1.5,'Pb',120,'Nissan','Almera',1,0,0,'DW529ut'

select * from PosiadaneSamochody

go
alter view PosiadaneSamochody as
select  S.id_samochod,M.Marka,M.Model,S.nrRejestracyjny,SI.rodzajPaliwa,SI.pojemnosc,SI.konieMechaniczne,S.LPG,S.Elektryk,S.Hybrydowy
		from Samochod S 
		left join Model M on S.id_model=M.id_model
		left join Silnik SI	on S.id_silnik=SI.id_silnik
		left join Sprzedane SP on SP.id_samochod=S.id_samochod
		where SP.sprzedane=0

go

select * from Sprzedane
select * from model
select * from Silnik
select * from Samochod


go
alter procedure dodajSamochod
@pojemnosc float,
@rodzajPaliwa varchar(5),
@konieMechaniczne int,
@marka varchar(20),
@model varchar(20),
@lpg bit,
@hybryda bit,
@elektryk bit,
@nrRejestracyjny varchar(10)
as

declare @iloscSilnikow int
declare @iloscModeli int
declare @iloscSamochod int
declare @iloscSprzedane int

declare @idSilnika int
declare @idModel int
declare @idSamochod int

BEGIN TRANSACTION
set @iloscSilnikow=(
	select count(*) from Silnik S 
		where S.pojemnosc=@pojemnosc 
			and S.rodzajPaliwa=@rodzajPaliwa 
			and S.konieMechaniczne=@konieMechaniczne)

set @iloscModeli=(
	select count(*) from model M 
		where M.Marka=@marka 
			and M.Model=@model)


if @iloscSilnikow=0
	begin
	insert into Silnik(pojemnosc,rodzajPaliwa,konieMechaniczne) 
				values(@pojemnosc,@rodzajPaliwa,@konieMechaniczne)
	end

set @idSilnika = (
	select top 1 id_silnik from Silnik S 
		where S.pojemnosc=@pojemnosc 
			and S.rodzajPaliwa=@rodzajPaliwa 
			and S.konieMechaniczne=@konieMechaniczne)


if @iloscModeli=0
	begin
	insert into Model(Marka,Model) 
		values (@marka,@model)
	end

set @idModel =(
	select top 1 M.id_model from Model M
		where M.Marka=@marka
			and M.Model=@model)

set @iloscSamochod =(
	select count(*) from Samochod 
		where id_model=@idModel
			and id_silnik=@idSilnika
			and LPG=@lpg
			and Hybrydowy=@hybryda
			and Elektryk=@elektryk
			and nrRejestracyjny=@nrRejestracyjny)

if @iloscSamochod=0
	begin
	insert into Samochod(id_model,id_silnik,LPG,Hybrydowy,Elektryk,nrRejestracyjny)
		values(@idModel,@idSilnika,@lpg,@hybryda,@elektryk,upper(replace( @nrRejestracyjny,' ','')))
	end
	
set @idSamochod=(
	select top 1 S.id_samochod from Samochod S
		where id_model=@idModel
			and id_silnik=@idSilnika
			and LPG=@lpg
			and Hybrydowy=@hybryda
			and Elektryk=@elektryk
			and nrRejestracyjny=@nrRejestracyjny)

set @iloscSprzedane=(
	select count(*) from Sprzedane
		where id_samochod=@idSamochod)

if @iloscSprzedane=0
	begin
	insert into Sprzedane(id_samochod,sprzedane) 
		values (@idSamochod,0)
	end
	
IF (@@ERROR <> 0)
	ROLLBACK TRANSACTION
COMMIT TRANSACTION

go
