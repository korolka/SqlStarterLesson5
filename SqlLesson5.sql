--Завдання 1

--Створіть базу даних з ім'ям MyJoinsDB.

create database MyJoinsDB

use MyJoinsDB

--Завдання 2

--У цій базі даних створіть 3 таблиці,

--У 1-й таблиці містяться імена та номери телефонів співробітників компанії.

create table Personal
(
PersonalId smallint identity not null,
[Name] varchar(10) not null,
PhoneNumber char(12) not null check (PhoneNumber Like '([0-9][0-9][0-9])[0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)

alter table Personal
add constraint PK_PersonalID
primary key (PersonalId)

insert into Personal
([Name],PhoneNumber)
values
('Vlad','(066)2527143'),
('Andriy','(063)3574326'),
('Stepan', '(067)3452678')

--У 2-й таблиці містяться відомості про зарплату та посади співробітників: головний директор, менеджер, робітник.
create table PersonalWorkDetails
(
OwnDetailsId smallInt identity primary key not null,
Salary decimal(7) not null,
Position char(10) not null,
PersonalId smallint not null
)

alter table PersonalWorkDetails
add constraint FK_PersonalId
foreign key (personalId) references Personal(PersonalId)

insert into PersonalWorkDetails
(Salary,Position,PersonalId)
values
(3000,'director',2),
(500,'manager',1),
(250,'worker',3)

--У 3-й таблиці міститься інформація про сімейний стан, дату народження, та місце проживання.
create table PersonalOwnDetails
(
OwnDetailsId smallint Identity primary key not null,
MartialStatus char(15),
BirthDate Date not null,
AdressId smallint not null,
PersonalID smallint not null
)

alter table PersonalOwnDetails
add constraint FK_OwnDetailsPersonalId
foreign key (PersonalID) references Personal(PersonalID)


alter table PersonalOwnDetails
add constraint FK_AdressId
foreign key (AdressId) references Adress(AdressId)

insert into PersonalOwnDetails
(MartialStatus,BirthDate,AdressId,PersonalID)
values
('not married','02.08.2001',2,1),
('married','12.12.1994',1,2),
('not married','05.12.1992',3,3)

create table Adress
(
AdressId smallint identity primary key not null,
City char(15) not null,
Street char(25) not null,
Building char(4) not null
)

insert into adress 
(City , Street, Building)
values
('Kyiv','Berznakinska','12'),
('Kyiv', 'Trostanetska', '8'),
('Lviv', 'Tsentralna','12')
 
 select * from Personal
 select * from PersonalWorkDetails
 select * from PersonalOwnDetails
 select * from Adress

 truncate table PersonalOwnDetails
 drop table PersonalOwnDetails

-- Завдання 3

--Зробіть вибірку за допомогою JOIN's для таких завдань:

--1) Отримайте контактні дані співробітників (номери телефонів, місце проживання).

select PhoneNumber, AdressId
from Personal
join  PersonalOwnDetails
on Personal.PersonalId = PersonalOwnDetails.PersonalId

--2) Отримайте інформацію про дату народження всіх неодружених співробітників та їх номери.

select PhoneNumber, BirthDate
from Personal
join PersonalOwnDetails
on PersonalOwnDetails.PersonalId = Personal.PersonalId and PersonalOwnDetails.MartialStatus ='not married'

--3) Отримайте інформацію про всіх менеджерів компанії: дату народження та номер телефону.


select PhoneNumber, BirthDate
from Personal
join PersonalOwnDetails
on PersonalOwnDetails.PersonalId = Personal.PersonalId
join PersonalWorkDetails 
on PersonalWorkDetails.PersonalId = Personal.PersonalId and PersonalWorkDetails.Position = 'manager'


