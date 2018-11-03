

select M.Marka,M.Model,I.rodzajPaliwa,I.pojemnosc,I.konieMechaniczne,S.LPG,S.Elektryk,S.Hybrydowy
		from Samochod S full join Model M 
		on S.id_model=M.id_model
		full join Silnik I
		on M.id_silnik=I.id_silnik



go

alter procedure dodajSamochod
@pojemnosc float,
@rodzajPaliwa varchar(5),
@konieMechaniczne int,
@marka varchar(20),
@model varchar(20),
@lpg bit,
@hybryda bit,
@elektryk bit
as

declare @iloscSilnikow int
declare @iloscModeli int
declare @iloscSamochod int
declare @idSilnika int
declare @idModel int

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
	insert into Model(Marka,Model,id_silnik) 
		values (@marka,@model,@idSilnika)
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
			and Elektryk=@elektryk)

if @iloscSamochod=0
	begin
	insert into Samochod(id_model,id_silnik,LPG,Hybrydowy,Elektryk)
		values(@idModel,@idSilnika,@lpg,@hybryda,@elektryk)
	end
	


go

--exec dodajSamochod 2,'ON',300,'Clio','Renault'
select * from model
select * from Silnik

