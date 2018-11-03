use [Samochody]


create table Kierowca(
id_kierowca int not null primary key identity(1,1),
imie varchar(30) not null,
nazwisko varchar(30) not null
)

create table Kierowca_Samochod(
id_samochod int not null,
id_kierowca int not null
)

create table AwariaMechaniczna(
id_awariaM int not null primary key identity(1,1),
id_samochod int not null,
dataAwarii date not null,
cena float not null,
zdarzenie varchar(255) not null
)

create table AwariaBlacharska(
id_awariaB int not null primary key identity(1,1),
id_samochod int not null,
dataAwarii date not null,
cena float not null,
zdarzenie varchar(255) not null
)

create table Sprzedane(
id_sprzedane int not null primary key identity(1,1),
id_samochod int not null,
sprzedane bit not null
)

create table Zdarzenie(
id_zdarzenie int not null primary key identity(1,1),
id_samochod int not null,
id_czynnosc int not null,
km int not null,
dataZdarzenia date not null,
cena float not null,
)

create table Tankowanie(
id_tankowanie int not null primary key identity(1,1),
id_zdarzenie int not null,
litry float,
kW float
)

create table CzynnoœciWykonywaneCyklicznie(
id_czynnosc int not null primary key identity(1,1),
czynnosc varchar(20) not null
)

create table CzynnosciAutoCoDotyczy(
id int not null primary key identity(1,1),
id_samochod int not null,
id_czynnosc int not null,
czynnoscKM int,
czynnoscMiesiace int
)

create table Silnik(
id_silnik int not null primary key identity(1,1),
pojemnosc float,
rodzajPaliwa varchar(5) not null,
konieMechaniczne int not null
)

create table Model(
id_model int not null primary key identity(1,1),
Marka varchar(20) not null,
Model varchar(20) not null
)

create table Samochod(
id_samochod int not null primary key identity(1,1),
id_model int not null,
id_silnik int not null,
LPG bit not null,
Hybrydowy bit not null,
Elektryk bit not null
)

create table SpalanieSrednie(
id_spalanie int not null primary key identity(1,1),
id_samochod int not null,
spalanie float not null
)

go


alter table samochod add  nrRejestracyjny varchar(10) not null

alter table SpalanieSrednie
add foreign key (id_samochod) references Samochod (id_samochod)

alter table Kierowca_Samochod
add foreign key (id_samochod) references Samochod (id_samochod)

alter table Kierowca_Samochod
add foreign key (id_kierowca) references Kierowca (id_kierowca)

alter table Zdarzenie
add foreign key (id_samochod) references Samochod (id_samochod)

alter table Sprzedane
add foreign key (id_samochod) references Samochod (id_samochod)

alter table AwariaMechaniczna
add foreign key (id_samochod) references Samochod (id_samochod)

alter table AwariaBlacharska
add foreign key (id_samochod) references Samochod (id_samochod)

alter table Samochod
add foreign key (id_model) references Model (id_model)

alter table Samochod
add foreign key (id_silnik) references Silnik (id_silnik)

alter table Tankowanie 
add foreign key (id_zdarzenie) references Zdarzenie (id_zdarzenie)

alter table CzynnosciAutoCoDotyczy 
add foreign key (id_samochod) references Samochod (id_samochod)

alter table CzynnosciAutoCoDotyczy 
add foreign key (id_czynnosc) 
references CzynnoœciWykonywaneCyklicznie (id_czynnosc)

*
