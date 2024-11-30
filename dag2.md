# Create Table, Constraints, Transacties, Geavanceerde SQL met aggregatie

- [Create Table, Constraints, Transacties, Geavanceerde SQL met aggregatie](#create-table-constraints-transacties-geavanceerde-sql-met-aggregatie)
  - [Vul de survey in over de reisbewegingen in Woon-School-verkeer](#vul-de-survey-in-over-de-reisbewegingen-in-woon-school-verkeer)
  - [Run DuckDB en bouw IMDb](#run-duckdb-en-bouw-imdb)
  - [Data Manipulatie](#data-manipulatie)
    - [Dangling References / Weduwen en Wezen](#dangling-references--weduwen-en-wezen)
  - [Create Table](#create-table)
  - [Analyseer de Woon-School Reisverkeer Survey](#analyseer-de-woon-school-reisverkeer-survey)
  - [Create Table with Constraints](#create-table-with-constraints)
    - [NB: DuckDB beperking](#nb-duckdb-beperking)
  - [IMDb met Constraints](#imdb-met-constraints)
  - [Transacties, Commit en Rollback](#transacties-commit-en-rollback)
  - [Appendix/Solutions](#appendixsolutions)


## Vul de survey in over de reisbewegingen in Woon-School-verkeer

Ga naar : https://forms.office.com/e/a2my57Ydds  en vul de survey in. Je beantwoordt vijf vragen en dient de survey in. De resultaten worden verzameld in een Excel-file die we straks samen gaan analyseren met SQL.



## Run DuckDB en bouw IMDb 
Je kunt DuckDB eenvoudig draaien via de DuckDB WebShell (om een SQL database in a browser te starten) via deze link: https://shell.duckdb.org/.

Je kunt ook DuckDB eenvoudig installeren. Ga naar [duckdb.org/docs/installation](https://duckdb.org/docs/installation) en download de stable version, Command Line environment voor jouw Platform. De download bevat een executable file (duckdb.exe). Extraheer deze uit het archief en start deze file. 

Als de database is gestart, voer de volgende statements uit om de vier tabellen van de IMDb aan te maken en met data te laden:

```
CREATE TABLE imdb_countries AS
SELECT * FROM   read_csv_auto('https://raw.githubusercontent.com/lucasjellema/informatica-databases/main/imdb/countries.csv');
CREATE TABLE imdb_movies AS
SELECT * FROM read_csv_auto('https://raw.githubusercontent.com/lucasjellema/informatica-databases/main/imdb/movies.csv');
CREATE TABLE imdb_actors AS
SELECT * FROM read_csv_auto('https://raw.githubusercontent.com/lucasjellema/informatica-databases/main/imdb/actors.csv');
CREATE TABLE imdb_roles AS
SELECT * FROM read_csv_auto('https://raw.githubusercontent.com/lucasjellema/informatica-databases/main/imdb/roles.csv');
```

Type 
```
show tables;
```

om te kijken of de tabellen zijn aangemaakt.

Vervolgens, type 

```
desc imdb_actors;
```
om de tabel (definitie) te inspecteren - die is aangemaakt voor de file met actor records.

## Data Manipulatie

SQL statements gebruik je niet alleen om data te onderzoeken en op te vragen maar ook om data te manipuleren. Nieuwe records in tabellen toe te voegen of bestaande records te wijzigen of te verwijderen. Hieronder vind je van elk van deze operaties een voorbeeld dat je kan uitproberen.

Het toevoegen van nieuwe records gebeurt met een *INSERT* statement. In het statement geef je aan INTO welke tabel het record moet worden toegevoegd en van welke kolommen van de tabel je de waarden wil vastleggen. In dit voorbeeld wordt een nieuwe acteur toegevoegd in de tabel `IMDB_ACTORS`. Deze tabel kent pakweg 10 kolommen, maar we leggen slechts de waarden vast voor dit nieuwe acteur-record van drie kolommen: `identifier`, `Last Name` en `First Name`.

```
INSERT 
INTO   imdb_actors 
(identifier, "Last Name", "First Name")
VALUES 
(301,'Freeman', 'Norman')
;
```

Voer dit statement uit. Voer vervolgens een SQL query uit om te verifiëren of het nieuwe record is vastgelegd.

Het verwijderen van records uit tabellen doe je met `DELETE`. Als een `DELETE` actie uitvoert moet je aangeven uit welke tabel je één of meer records wilt verwijderen. Je kunt ook aangeven wélke records je wilt verwijderen. Geef je dat niet aan, dan worden álle records uit de tabel verwijderd.

Dit volgende statement verwijdert alle records uit tabel `IMDB_ACTORS` waarvoor geldt dat de waarde in de kolom `First Name` gelijk is aan *Darro*. Wat zou er gebeuren als er geen enkele acteur is met deze voornaam?

```
delete
from   imdb_actors a 
where  a."First Name" = 'Darro'
;
```
Voer het statement uit. Voer het statement nog een keer uit. 

Het wijzigen van bestaande records doe je met een `UPDATE` statement. Ook in dit statement geef je aan welke tabel je wilt aanspreken, welke wijziging in kolomwaarden je wilt doorvoeren (`SET`) en voor welke rijen dat moet gebeuren (`WHERE`).

Het volgende statement wijzigt de waarde in de kolom `Relationship Status` voor alle rijen die voldoen aan de voorwaarde `identifier = 206`. Hoeveel rijen denk je dat aan die voorwaarde voldoen?  

```
UPDATE imdb_actors 
SET    "Relationship Status" = 'Single'
WHERE  identifier = 206
;
```
Voer dit statement uit. Verifieer het resultaat met een `SELECT` query.

Een `UPDATE` statement kan meerdere rijen wijzigen. Het volgende statement verhuist alle acteurs met een referentie naar country 11 naar country 410. Dat zouden er heel veel kunnen zijn. Of geen één.

```
UPDATE imdb_actors a 
SET    "Country Reference" = 410
WHERE  "Country Reference" = 11
;
```

In een update statement kunnen meerdere kolommen in één keer worden gewijzigd. In het volgende voorbeeld worden met één statement zowel de *genre* aanduiding als de *Age Indication* aangepast, voor alle movie-records waar Genre nu *Horror* is.

Probeer dit statement uit:

```
UPDATE imdb_movies m 
SET    Genre = 'Scary' , "Age Indication" = 'PG-13'
WHERE  Genre = 'Horror'
;
```

### Dangling References / Weduwen en Wezen

Wat denk je van het idee om de *identifier* kolom van een record te wijzigen? Wat zijn de mogelijke problemen daarmee?

Verwijder het record voor de acteur met identifier gelijk aan *209*. Daarvoor schrijf je een `DELETE` statement zoals hierboven besproken. (delete from <tabel> where Identifier = ...)

Query nu alle rollen voor de films met identifiers 306 en 310. je kunt daarvoor het volgende statement gebruiken:

```
select m.title as movie
,      r.actorId
,      a."first name"||' '|| a."last name" as "actor"
,      r.character
from   imdb_movies m 
       join
       imdb_roles r
       on m.identifier = r.MovieId
       join 
       imdb_actors a
       on r.ActorId = a.identifier
where  m.identifier in (306, 310 )
;
```

Hoeveel records levert deze query op?

Kijk naar de volgende query. Vergelijk deze met de voorgaande. Hoeveel rijen verwacht je dat deze query zal opleveren?

Voer nu deze query uit. 

```
select m.title as movie
,      r.actorId
,      r.character
from   imdb_movies m 
       join
       imdb_roles r
       on m.identifier = r.MovieId
where  m.identifier in (306, 310 )
;
```

Kan je het resultaat verklaren? Weet je waar het verschil met de vorige query door wordt veroorzaakt?

Hint:

```
select m.title as movie
,      r.actorId
,      r.character
from   imdb_movies m 
       join
       imdb_roles r
       on m.identifier = r.MovieId
where  r.actorId = 209
;
```

Het verwijderen van een acteur die meerdere rollen op haar/zijn naam heeft staan zonder die rollen ook te verwijderen zorgt voor een probleem. De referentie van rol naar acteur klopt voor een aantal records niet meer. De joins in de SQL queries werken niet goed. Dit zou niet moeten kunnen gebeuren.
 

## Create Table

Gebruik ChatGPT om een `CREATE TABLE` commando te creëren voor de volgende dataset:

```
id,afkorting,naam
1,NL,Nederland
2,BE,België
3,FR,Frankrijk
4,DE,Duitsland
```

Voer het `CREATE TABLE` statement uit.

Vraag ChatGPT ook om de `INSERT` statements om deze data in de tabel te laden. En voer vervolgens die statements uit.

Voer nu een SQL query uit om alle landen op te halen uit de tabel die het woord *land* bevatten (`WHERE contains( <naam van de kolom>, 'land')`).

## Analyseer de Woon-School Reisverkeer Survey 

De verzamelde resultaten van de survey zijn te vinden in deze file: https://github.com/lucasjellema/informatica-databases/blob/main/survey/survey_results.csv .

Voer onderstaand statement uit om de resultaten van de survey over Woon-School-verkeer vanuit de ruwe data file te bekijken:
```
SELECT * 
FROM   read_csv_auto('https://raw.githubusercontent.com/lucasjellema/informatica-databases/refs/heads/main/survey/survey_results.csv')
;
```

Creëer een tabel om deze ruwe data in je DuckDB database vast te leggen:

```
create table survey_results 
( x1 varchar, x2 varchar, x3 varchar, x4 varchar, x5 varchar, x6 varchar
, voornaam varchar
, woonplaats varchar 
, reisafstand decimal(5,2) -- 5 cijfers, maximaal 2 achter de comma
, reistijd utinyint -- tussen 0 en 255
, vervoermiddel varchar
);
```

en gebruik dit statement om de data uit de csv file rechtstreeks in de tabel te laden:

```
insert into 
survey_results 
SELECT * 
FROM   read_csv('https://raw.githubusercontent.com/lucasjellema/informatica-databases/refs/heads/main/survey/survey_results.csv');
;
```

Analyseer de surveyresultaten en beantwoord de volgende vragen:

* Hoeveel surveys zijn er ingevuld?
* Hoeveel surveys zijn er per woonplaats ingevuld?
* Wat is de gemiddelde reisafstand?
* Wat is de gemiddelde reistijd?
* Wat is de meest genoemde woonplaats? Hint: [mode()](https://duckdb.org/docs/sql/functions/aggregates.html#modex)  
* Welke vervoermiddelen zijn in gebruik? Hoeveel van elk vervoermiddel?
* Wat zijn de top 3 vervoermiddelen?  Hint: `order by` en `limit`
* Wat is de langste reistijd? En wat is de langste reistijd per woonplaats?
* Wat is het aantal surveys voor de meest genoemde woonplaats? 
* Wat is de kortste reisafastand (per vervoermiddel)?

Als voorbeeld van de SQL syntax deze query:

```
select vervoermiddel
,      max(reistijd) as langste_reisafstand
from   survey_results
group
by     vervoermiddel
having count(voornaam) > 2
;
```  

Wat is de langste reistijd per vervoermiddel voor ieder vervoermiddel dat door tenminste drie survey-deelnemers is ingevuld.


## Create Table with Constraints

Kijk naar deze tabel definitie. Welke constraints zijn gedefinieerd voor deze tabel? Je zou tenminste zes expliciete constraints (primary, unique, foreign en check) moeten zien en nog een aantal impliciete constraints (data type, lengte/breedte kolom). Samen moeten deze constraints zorgen voor kwalitatief hoogwaardige data.

Voer het statement ook uit om de tabel aan te maken:
```
create table people
( id        int           primary key
, name      varchar(15)   not null unique check (length(name) <= 15)
, birthdate date          check (birthdate <= CURRENT_DATE() - INTERVAL 18 YEAR) 
, parent_id int           references people (id)
, city      varchar(50)   default 'Soest' check (NOT contains(upper(city), 'A'))  
)
```

Naar welke tabel verwijst (de foreign key op) kolom parent_id?

Dit statement maak een record aan in tabel *people*:

```
insert into people (id,name,birthdate) values (13, 'Donald Duck', DATE '1934-06-09');
```
Waar woont Donald Duck (volgens de data in de tabel)? Dit is het gevolg van de *default* die voor de *city* kolom is gedefinieerd.  


Wat gebeurt er met dit volgende insert statement:

```
insert into people (id,name,birthdate, parent_id) values (13, 'Donald John Trump', DATE '2046-06-14', 16);
```

Hoeveel aanpassingen moeten aan dit insert statement worden gedaan om het succesvol te maken?
* id moet uniek zijn
* birthdate moet tenminste 18 jaar in het verleden liggen
* parent_id moet verwijzen naar een bestaan (person) record in de PEOPLE tabel
* name moet niet langer zijn dan 15 karakters

Pas het statement aan en voer het uit. NB: Donald J. Trump is geboren in 1946 (op 14 juni). En oh ja: zijn woonplaats wordt Washington (niet Soest).

Hier is het aangepaste insert statement dat wel succesvol is:
```
insert into people (id,name,birthdate, parent_id) values (15, 'Donald J. Trump', DATE '1946-06-14', 13);
```

Wat denk je dat er gebeurt met het volgende statement:
```
delete from people where id = 13
```
Probeer het uit.

Als gevolg van het foreign key constraint mag een record alleen nog uit PEOPLE worden verwijderd als geen ander record ernaar verwijst.

Deze combinatie van statements zou het wel moeten doen:

```
delete from people where parent_id = 13; 
delete from people where id = 13;
```

### NB: DuckDB beperking 

Er zit een beperking in DuckDB die het updaten van een record in een primary of unique constraint erg lastig maakt. Dit is een tijdelijke beperking (hopelijk) en niet eentje die voor andere databases geldt.

In het voorgaande voorbeeld konden we dus niet doen:

```
update people set parent_id = null where parent_id = 13; 
delete from people where id = 13;
```

hoewel dat in standaard SQL een prima actie is. 


## IMDb met Constraints

Herstart DuckDB of verwijder de IMDb tabellen met deze statements:

```
drop TABLE imdb_countries;
drop TABLE imdb_movies;
drop TABLE imdb_actors;
drop TABLE imdb_roles;
```
maak nu de IMDb tabellen aan met de volgend statements:

```
create table imdb_countries
( id           int primary key
, name         varchar not null
, capital      varchar
, country_code varchar not null unique
, population   decimal(5,1)
, currency     varchar
, area         decimal(10,2)
)
;
```

```
create table imdb_actors
( id           int primary key
, first_name   varchar not null
, last_name    varchar not null
, country_id   int null references imdb_countries(id)
, birth_date   date
, birth_city   varchar
, city         varchar
, nick_name    varchar
, relationship_status varchar check (relationship_status in ('Single', 'Married', 'In a relationship'))
)
;
```

```
create table imdb_movies
( id             int primary key
, title          varchar not null
, genre          varchar not null
, duration       USMALLINT
, release_year   USMALLINT check (release_year between 1890 and 2030)
, description    varchar
, age_indication varchar check (age_indication in ('PG','PG-13','R','X',''))
, language       varchar
, director       varchar
)
;
```

```
create table imdb_roles
( movieid        int not null references imdb_movies (id)
, actorid        int not null references imdb_actors (id)
, character      varchar not null
, characterdescription    varchar
)
;
```

Laad data uit de cvs-files in deze tabellen met de volgende statements:

```
insert into imdb_countries 
( name
, id        
, capital     
, country_code
, population  
, currency    
, area   
)
SELECT *
FROM   read_csv('https://raw.githubusercontent.com/lucasjellema/informatica-databases/main/imdb/countries.csv');
;
```
```
insert into imdb_actors
( first_name   
, last_name    
, id
, country_id    
, birth_date   
, birth_city   
, city         
, nick_name    
, relationship_status 
)
select * 
from   read_csv('https://raw.githubusercontent.com/lucasjellema/informatica-databases/main/imdb/actors.csv');
```

```
insert into imdb_movies
( id             
, title          
, genre          
, description    
, duration       
, release_year   
, age_indication 
, language       
, director       
)
select * 
from   read_csv('https://raw.githubusercontent.com/lucasjellema/informatica-databases/main/imdb/movies.csv');
```
```
insert into imdb_roles
( movieid      
, actorid      
, character    
, characterdescription 
)
select * 
from   read_csv('https://raw.githubusercontent.com/lucasjellema/informatica-databases/main/imdb/roles.csv');
```

Alle data is nu geladen in de tabellen die we eerder hadden gedefinieerd - compleet met contraints. Nu zouden we niet meer een acteur kunnen verwijderen die nog in rollen zit of een land waar nog acteur records naar verwijzen. Laten we dat controleren: 

Probeer acteur met id == 209 weg te gooien

```
delete from imdb_actors
where  id = 209
;
```

Als je dit statement uitvoert krijg je een foutmelding die aangeeft *Constraint Error: Violates foreign key constraint because key "actorid: 209" is still referenced by a foreign key in a different table*. Er zijn records in IMDB_ROLES die de waarde 209 als ACTOR_ID hebben. Helaas, pindakaas!

Kan je de primary key wijzigen? Wat denk je? Probeer:

```
update imdb_countries
set    id = id * 2
;
```

Klopt je verwachting?


## Transacties, Commit en Rollback

Zie https://duckdb.org/docs/sql/statements/transactions 

Je kunt voordat je DML gaat doen een transactie starten:

```
 begin transaction;
```

Je kunt de transactie afronden en al je wijzigingen "atomair" laten vastleggen met:

```
commit;
```

Maar je kan ook besluiten een transactie geheel ongedaan te maken en alle aanpassingen te laten terugdraaien, met:

```
rollback;
```

Laten dat wat eens uitproberen.

Voer uit:
```
 begin transaction;
```

en nu:
```
update imdb_movies set duration = duration + 5;
```

en ook:
```
delete from imdb_movies where title like 'Stone%';
```

Kijk nu hoe de movies er bij staan:
```
select title, duration from imdb_movies;
```

En voer nu de rollback uit:

```
rollback;
```

En doe opnieuw de query:
```
select title, duration from imdb_movies;
```

De wijzigingen die eerder waren aangebracht zijn nu terugedraaid. De transactie is atomair ongedaan gemaakt.




## Appendix/Solutions

Het antwoord van ChatGPT om een tabel te maken voor de landen data:
```
CREATE TABLE country (
    id INT PRIMARY KEY,
    afkorting CHAR(2) NOT NULL,
    naam VARCHAR(50) NOT NULL
);
```
Insert the data into the table with this statement:

```
-- Insert the data
INSERT INTO country (id, afkorting, naam) 
VALUES 
(1, 'NL', 'Nederland');
INSERT INTO country (id, afkorting, naam) 
VALUES 
(2, 'BE', 'Belgie');
INSERT INTO country (id, afkorting, naam) 
VALUES 
(3, 'FR', 'Frankrijk');
INSERT INTO country (id, afkorting, naam) 
VALUES 
(4, 'DE', 'Duitsland');
```

Query all data:
```
select * from country;
```

Query alle landen met *land* in de naam
```
select * from country where contains (naam,'land');
```