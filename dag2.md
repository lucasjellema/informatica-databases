# Create Table, Constraints, Transacties, Geavanceerde SQL met aggregatie

## Vul de survey in over de reisbewegingen in Woon-School-verkeer

Ga naar : https://forms.office.com/e/a2my57Ydds  en vul de survey in. Je beantwoordt vijf vragen en dient de survey in. De resultaten worden verzameld in een Excel-file die we straks samen gaan analyseren met SQL.



## Run DuckDB en bouw IMBd 
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
UPDATE
imdb_actors 
SET "Relationship Status" = 'Single'
WHERE identifier = 206
;
```
Voer dit statement uit. Verifieer het resultaat met een `SELECT` query.

Een `UPDATE` statement kan meerdere rijen wijzigen. Het volgende statement verhuist alle acteurs met een referentie naar country 11 naar country 410. Dat zouden er heel veel kunnen zijn. Of geen één.

```
UPDATE
imdb_actors a 
SET "Country Reference" = 410
WHERE "Country Reference" = 11
;
```

In een update statement kunnen meerdere kolommen in één keer worden gewijzigd. In het volgende voorbeeld worden met één statement zowel de *genre* aanduiding als de *Age Indication* aangepast, voor alle movie-records waar Genre nu *Horror* is.

Probeer dit statement uit:

```
UPDATE
imdb_movies m 
SET Genre = 'Scary' , "Age Indication" = 'PG-13'
WHERE Genre = 'Horror'
;
```

### Dangling References / Weduwen en Wezen

Wat denk je van het idee om de *identifier* kolom van een record te wijzigen? Wat zijn de mogelijke problemen daarmee?

Verwijder het record voor de acteur met identifier gelijk aan 209. Daarvoor schrijf je een `DELETE` statement zoals hierboven besproken. (delete from <tabel> where Identifier = ...)

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
( x1 varchar, x2 varchar, x3 varchar, x4 varchar, x5 varchar
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