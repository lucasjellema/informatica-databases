# Introductie SQL met DuckDB Shell

- [Introductie SQL met DuckDB Shell](#introductie-sql-met-duckdb-shell)
  - [Run DuckDB in je browser](#run-duckdb-in-je-browser)
  - [Creëer de IMDb Database in DuckDB](#creëer-de-imdb-database-in-duckdb)
  - [IMDb Queries in DuckDB](#imdb-queries-in-duckdb)
  - [Werken met files](#werken-met-files)
  - [Aanvullende en geavanceerde query-opdrachten](#aanvullende-en-geavanceerde-query-opdrachten)
    - [Welke acteurs hebben een rol gespeeld van een “Agent” character?](#welke-acteurs-hebben-een-rol-gespeeld-van-een-agent-character)
    - [Wat zijn de films met de jongste acteur?](#wat-zijn-de-films-met-de-jongste-acteur)
    - [Wat is de langste film met een acteur uit Lumora - en hoe lang is die ?](#wat-is-de-langste-film-met-een-acteur-uit-lumora---en-hoe-lang-is-die-)
    - [Alle films met meerdere "single" acteurs](#alle-films-met-meerdere-single-acteurs)
  - [Data Manipulatie](#data-manipulatie)
    - [Dangling References / Weduwen en Wezen](#dangling-references--weduwen-en-wezen)


In deze opdrachten ga je SQL commando's uitvoeren tegen een database. In dit geval: DuckDB - een moderne open source database, vanuit Nederland ontstaan. Erg populair, lichtgewicht en heel goed met applicaties te integreren. Je vindt meer gegevens over DuckDB op de website https://duckdb.org/. De documentatie voor DuckDB is hier beschikbaar: https://duckdb.org/docs/.

## Run DuckDB in je browser 
Er is een implementatie gemaakt van DuckDB in WASM (Web Assembly). Deze implementatie kan helemaal standalone draaien in je browser. Je start de database via een URL; de eerste keer dat je dat doet in een browser wordt de code naar je browser geladen - dat duurt een paar seconden. Iedere volgende keer wordt de DuckDB code vanuit de cache gebruik en start de database aanzienlijk sneller. 

Open DuckDB WebShell (om een SQL database in a browser te starten) via deze link: https://shell.duckdb.org/

Je kunt SQL queries uitvoeren tegen een CSV (of JSON of Parquet) file die via HTTP te benaderen is. Voer onderstaand statement uit:
```
SELECT * 
FROM   read_csv_auto('https://raw.githubusercontent.com/lucasjellema/informatica-databases/main/imdb/movies.csv')
;
```

## Creëer de IMDb Database in DuckDB

Voer dit commando uit om een tabel te creëren in de DuckDB instantie in je browser:
```
CREATE TABLE imdb_countries AS
SELECT * 
FROM   read_csv_auto('https://raw.githubusercontent.com/lucasjellema/informatica-databases/main/imdb/countries.csv')
;
```

Om te zien of de tabel goed is gecreëerd en de data is geladen, run dit commando
```
select *
from   imdb_countries;
```

Voer de volgende statements uit om ook de andere drie tabellen aan te maken en met data te laden:

```
CREATE TABLE imdb_movies AS
SELECT * FROM read_csv_auto('https://raw.githubusercontent.com/lucasjellema/informatica-databases/main/imdb/movies.csv');
CREATE TABLE imdb_actors AS
SELECT * FROM read_csv_auto('https://raw.githubusercontent.com/lucasjellema/informatica-databases/main/imdb/actors.csv');
CREATE TABLE imdb_roles AS
SELECT * FROM read_csv_auto('https://raw.githubusercontent.com/lucasjellema/informatica-databases/main/imdb/roles.csv');
```

## IMDb Queries in DuckDB 

We hebben eerder enkele zoekvragen uitgevoerd tegen de data van (de fictieve) IMDb dataset. We hebben gesproken over de SQL statements die deze zoekvraag in een relationele database kunnen uitvoeren. Laten we dat nu eens gaan proberen.

De eerste zoekvraag: "wat is de hoofdstad van het land waar de acteur vandaan komt die in Film "Steelheart's Revenge" de rol "Garrick Ironheart" speelt". Hier is het SQL statement dat deze zoekvraag tegen de IMDb tabellen kan uitvoeren:

```
select c.capital
from   imdb_movies m 
       join
       imdb_roles r
       on m.identifier = r.MovieId
       join 
       imdb_actors a
       on r.ActorId = a.identifier
       join 
       imdb_countries c
       on a."country reference" = c.identifier
where  m.title = 'Steelheart''s Revenge'
and    r.character = 'Garrick Ironheart'      
; 
```       

Voer de query uit en controleer het resultaat. 

De tweede zoekvraag: "in welke film(s) spelen acteurs afkomstig uit een land met een bevolking kleiner dan 5 miljoen? ". Ook deze vraag hebben we vertaald in een SQL query. Die ziet er als volgt uit:

```
select m.title as "movie title"
from   imdb_countries c
       join 
       imdb_actors a
       on a."country reference" = c.identifier       
       join
       imdb_roles r
       on r.ActorId = a.identifier
       join 
       imdb_movies m 
       on m.identifier = r.MovieId
where  c."Population (millions)"  < 5       
;
```  

Het is ook wel interessant om te weten om welke acteurs in welke rollen het gaat. En uit welk land die acteurs afkomstig zijn (een land met minder dan 5 miljoen inwoners in elk geval).

Breid de voorgaande query uit, zodat ook deze extra informatie wordt opgeleverd.

```
select m.title as "movie title"
,      r.character 
,      a."first name"||' '|| a."last name" as "actor"
,      c.name as "country"
from   imdb_countries c
       join 
       imdb_actors a
       on a."country reference" = c.identifier       
       join
       imdb_roles r
       on r.ActorId = a.identifier
       join 
       imdb_movies m 
       on m.identifier = r.MovieId
where  c."Population (millions)"  < 5       
;
```  

## Werken met files

Je hebt al gezien hoe tabellen kunnen worden gecreëerd op basis van een file (die via een URL aangeduid zijn). Je kunt ook het resultaat van een query naar een file schrijven. En van die file weer een tabel maken, als je dat graag zou willen. Je kunt de file ook downloaden - bijvoorbeeld als CSV-bestand dat je bijvoorbeeld in Excel kan laden.

Stel dat je een file wilt maken met alle films, acteurs en namen van de characters voor acteurs uit Eldoria. Maak eerst de SQL query die deze gegevens ophaalt. Begin bijvoorbeeld met de volende query die we eerder hebben gebruikt om gegevens op te halen over acteurs uit een land met minder dan 5 miljoen inwoners. Met een kleine aanpassing kan je de gegevens opvragen voor acteurs uit Eldoria.

```
select m.title as "movie title"
,      r.character 
,      a."first name"||' '|| a."last name" as "actor"
,      c.name as "country"
from   imdb_countries c
       join 
       imdb_actors a
       on a."country reference" = c.identifier       
       join
       imdb_roles r
       on r.ActorId = a.identifier
       join 
       imdb_movies m 
       on m.identifier = r.MovieId
where  c."Population (millions)"  < 5       
;
```    

Om de gegevens die jouw query ophalen naar een file weg te schrijven, gebruik je het `COPY` commando in DuckDB. Met:

```
COPY (<query>) TO '<filenaam>' WITH (FORMAT CSV, DELIMITER ',');
```

schrijf je de resultaten van de query naar een file met de aangegeven naam. Bijvoorbeeld:

```
COPY ( select a.identifier
,      a."Birth Date" birthdate
,      a."first name"||' '|| a."last name" as "name"
from   imdb_actors a
order
by     birthdate desc   ) TO 'actors_birthdates.csv' WITH (FORMAT CSV, DELIMITER ',');
```

Met het commando
```
.files list
```

kan je een lijst opvragen van alle files die DuckDB kent. Je kan zien of de file `actors_birthdates.csv` inderdaad succesvol is aangemaakt. En je kunt de file downloaden naar je computer, met: `.files download <filenaam>`

```
.files download actors_birthdates.csv
```

Schrijf nu de films met acteurs uit Eldoria naar een CSV file -inclusief film titel, character name en acteur naam. Noem de file `eldoria-movie-base.csv`. 

Download deze file naar je computer en open de file in een text editor of Excel. 

Het feit dat je query-resultaten uit de database kan downloaden en naar je eigen tools kan brengen is voor fictieve filmdata in een database met 50 records niet zo bijzonder en nuttig. Maar stel dat dit een serieuze database met relevante gegevens zou zijn waar je betekenisvolle analyses op wil uitvoeren - dan is het toch wel fijn dat je data op deze manier kan query-en en kan downloaden.


## Aanvullende en geavanceerde query-opdrachten

Probeer onderstaande vragen zelf te beantwoorden met een SQL query. Kom je er niet uit, kijk dan naar de aangeboden oplossing, en probeer die uit te voeren:

### Welke acteurs hebben een rol gespeeld van een “Agent” character?

Begin met een simpele join tussen IMDB_ROLES en IMDB_ACTORS om de gegevens van acteurs die rollen spelen te kunnen opvragen:
```
select a."first name"||' '|| a."last name" as "actor"
,      r.character
from   imdb_roles r
       join 
       imdb_actors a
       on r.ActorId = a.identifier
;
```

Je kan dezelfde uitvraag doen met een andere syntax:

```
select a."first name"||' '|| a."last name" as "actor"
,      r.character
from   imdb_roles r
,      imdb_actors a
where  r.ActorId = a.identifier
;
```

Voeg dan de filter-voorwaarde toe in een where-clause:

```
select a."first name"||' '|| a."last name" as "actor"
,      r.character
from   imdb_roles r
       join 
       imdb_actors a
       on r.ActorId = a.identifier
where  r.character like 'Agent%'
;
```


### Wat zijn de films met de jongste acteur?

Begin met een simpele join tussen IMDB_MOVIES, IMDB_ROLES en IMDB_ACTORS om de gegevens van acteurs die rollen spelen te kunnen opvragen:
```
select a."first name"||' '|| a."last name" as "actor"
,      m.title as movie
,      r.character
,      a."birth date"
from   imdb_movies m 
       join
       imdb_roles r
       on m.identifier = r.MovieId
       join 
       imdb_actors a
       on r.ActorId = a.identifier
;
```

Sorteer de gegevens op volgorde van birthdate van de acteur en laat maximaal vijf records teruggeven:

```
select a."first name"||' '|| a."last name" as "actor"
,      m.title as movie
,      r.character
,      a."birth date"
from   imdb_movies m 
       join
       imdb_roles r
       on m.identifier = r.MovieId
       join 
       imdb_actors a
       on r.ActorId = a.identifier
order  
by     a."birth date" desc
limit  5
;
```

Je kan kijken of alle vijf resultaten van dezelfde acteur zijn; als dat zo is moet je de regel `LIMIT 5` misschien aanpassen met een grotere waarde. Een alternatief is om eerst de identifier te achterhalen van de jongste acteur en vervolgens op die identifier te filteren.  

```
select a."first name"||' '|| a."last name" as "actor"
,      m.title as movie
,      r.character
,      a."birth date"
from   imdb_movies m 
       join
       imdb_roles r
       on m.identifier = r.MovieId
       join 
       imdb_actors a
       on r.ActorId = a.identifier
where  r.actorId = <identifier van jongste acteur>
;
```

Er is zelfs een manier - die heet Scalar Subquery - om de identifier van de jongste acteur op te halen als onderdeel van de query:

```
select a."first name"||' '|| a."last name" as "actor"
,      m.title as movie
,      r.character
,      a."birth date"
from   imdb_movies m 
       join
       imdb_roles r
       on m.identifier = r.MovieId
       join 
       imdb_actors a
       on r.ActorId = a.identifier
where  r.actorId = (select identifier
                    from   imdb_actors
                    order
                    by     "birth date" desc
                    limit 1)
;
```

Op de plek van de identifier zetten we een query tussen haakjes. Het resultaat van die query wordt gebruikt als een soort variabele. Om dit te laten slagen moet de subquery precies één resultaat opleveren. Daarom wordt deze "scalar" subquery genoemd: scalar betekent enkelvoudig: één waarde in één dimensie. 


### Wat is de langste film met een acteur uit Lumora - en hoe lang is die ?

Eerst zoeken we naar alle films en landen waaruit ze acteurs hebben spelen in rollen:

```
select m.title 
,      m.duration
,      c.Name as country
from   imdb_movies m 
       join
       imdb_roles r
       on m.identifier = r.MovieId
       join 
       imdb_actors a
       on r.ActorId = a.identifier
       join 
       imdb_countries c
       on a."country reference" = c.identifier
;
``` 

Dan gaan we filteren op het land (Lumora) en sorteren op duration (langste eerste) en bewaren we alleen het eerste record: 

```
select m.title
,      m.duration
from   imdb_movies m 
       join
       imdb_roles r
       on m.identifier = r.MovieId
       join 
       imdb_actors a
       on r.ActorId = a.identifier
       join 
       imdb_countries c
       on a."country reference" = c.identifier
where  c.name = 'Lumora'
order  
by     m.duration  desc
limit  1
;
``` 

### Alle films met meerdere "single" acteurs

Het om acteurs met de relationship status gelijk aan *Single*. En dan zoeken we naar films waar meerdere van deze acteurs in spelen. We kunnen de zoekvraag een beetje omschrijven naar: films met twee rollen van acteurs die allebei single zijn. In SQL uitgedrukt zou dat er als volgt kunnen uitzien:

```
select distinct 
       m.title
,      a1.identifier actor1
,      a2.identifier actor2
from   imdb_movies m
       join
       imdb_roles r
       on m.identifier = r.MovieId
       join 
       imdb_actors a1
       on r.ActorId = a1.identifier
       join 
       imdb_roles r2
       on m.identifier = r2.MovieId
       join imdb_actors a2
       on r2.ActorId = a2.identifier
where  a1."Relationship Status" = 'Single'
and    a2."Relationship Status" = 'Single'
and    a1.identifier != a2.identifier
```

Films worden twee keer met rollen gekoppeld in direct dus twee keer met acteurs. We filteren op acteurs die Single zijn. En we moeten worden dat we niet per ongeluk twee keer dezelfde rol en acteur te pakken hebben, anders zou iedere film met één Single acteur worden gevonden.


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

### Dangling References / Weduwen en Wezen

Wat denk je van het idee om de *identifier* kolom van een record te wijzigen? Wat zijn de mogelijke problemen daarmee?

Verwijder het record voor de acteur met identifier gelijk aan 209. Daarvoor schrijf je een `DELETE` statement zoals hierboven besproken.

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

 