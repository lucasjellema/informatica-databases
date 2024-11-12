
## Nadenkenm over data - verschillende soortenn, formaten, toepassingen

Toon plaatje met nullen en enen. 
- Wat is dat? (data)
- Wat voor data is dat? 

Toon Informatiebord op perron met de locatie-marker
- ken je dat type bord? wat voor informatie staat erop? heb je marker al eens gezien?
- wat duidt de marker aan?
- is dat nuttig (voor wie, wanneer; heb je er al eens gebruik van gemaakt?)
- welke informatie is nodig om die marker te kunnen tonen? wat gebeurt er achter de schermen om die informatie op het scherm te krijgen?
  - en wat als op het laatste moment de trein (verlaat is en) op een ander perron moet binnenkomen? 


## Introductie tabellen en aanlopop richting SQL

Groepsoefening:
- vier groepsleden (eventueel 2 of 3 kan ook)
- ieder groepslid krijgt een A4 met een dataverzameling: Films/Series, Acteurs, Casting/Rollen en Landen
- de opdracht: **wat is de hoofdstad van het land waar de acteur vandaan komt die in Film  Steelheart's Revenge de rol  Garrick Ironheart speelt**
- (de deelnemers voeren gezamenlijk een soort SQL query uit; in pseudo code
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

select c.capital
, c.name, a."first name", a."last name"
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
antwoord:
Aetherport (Terranova) - acteur: Talon Ironheart

- aanvullende opdracht: **in welke films spelen acteurs afkomstig uit een land met een bevolking kleiner dan 5 miljoen? Geef ook de namen van de landen, van de acteurs en van de rollen**
- (de deelnemers voeren gezamenlijk een soort SQL query uit; in pseudo code:)
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
antwoord: Flight of the Phoenix, Crimson Veil, The Last Ember, Frozen Sun  - vanwege acteurs uit Ardoria (land met 4.9M population)


- wat is de langste film met een acteur uit Lumora - en hoe lang is die ?
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
``` 
- wie is de jongste acteur met een rol in de kortste Science Fiction film - en uit welk land komt zij/hij? 

```
select a."first name"||' '|| a."last name" as "actor"
,      c.name as country
,      m.title as movie
,      m.duration
,      a."birth date"
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
where  m.genre = 'Science Fiction' 
order  
by     m.duration
,      a."birth date" desc
limit  1
;
```

films met meerdere single acteurs

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

films met jongste acteur

select a."first name"||' '|| a."last name" as "actor"
,      m.title as movie
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



Welke acteurs hebben een rol gespeeld van een “Agent” character?

select a."first name"||' '|| a."last name" as "actor"
,      r.character
from   imdb_roles r
       join 
       imdb_actors a
       on r.ActorId = a.identifier
where  r.character like 'Agent%'

- geavanceerd - met group by & max/sum/count, having, 



## Groepsoefening: Speel een SQL Query

- ieder groepslid heeft een rol: FROM, WHERE, SELECT, ORDER BY (en LIMIT/FETCH FIRST n ROWS ONLY - en GROUP BY??):
  - de deelnemer met FROM mag alleen de relevante vellen selecteren
  - de deelnemer met WHERE mag alleen relevante records selectered (uit de beschikbaar datasets nadat FROM klaar is)
  - de deelnemer met SELECT mag alleen velden selecteren (uit de records die WHERE heeft opgeleverd)
  - de deelnemer met ORDER BY en LIMIT mag de de records selecteren en het aantal beperken
- met dezelfde datatsets als in de vorige oefening: FILMS, ACTEURS, CAST, LANDEN
- voer als groep de volgende queries uit:
  - select a."last name", a."birth date" from imdb_actors a where a."birth date" > '1994-09-15' order by a."birth date" desc, a."last name" FETCH FIRST 3 ROWS ONLY
  - select a.naam as acteur from acteurs a join cast c on a.id = c.acteur.id where c.rol = 'Dracula' order by a.naam     
- - select a.naam as acteur, f.naam as film, f.jaar from acteurs a join cast c on a.id = c.acteur.id join films f on f.id = c.film_id where c.rol = 'Dracula' order by f.jaar, a.naam, f.naam    


# opdracht: vul ERD aan

vul de ontbrekende elementen in in een ERD-diagram
- namen van entiteiten en attributen
- namen van relaties 

# maak een ERD

Bekeuringen

* het strafbare feit (datum, tijd, type - fout parkeren, te hard rijden, bellen tijdens het rijden, tegen verkeerin rijden, door rood rijden, onder invloed rijden ), met voertuig, door persoon, ambtenaar 
* de bekeuring (voor dat feit: bedrag)
* persoon 

# Voorbeeld Database systemen

* GD
* NS
* Tennet - Eneco
* Albert Heijn



SQL in browser

https://sql.js.org/examples/GUI/index.html


SQL IDE
https://dbeaver.io/download/


## Execute SQL

Open DuckDB WebShell (om een SQL database in a browser te starten)

https://shell.duckdb.org/

Je kunt SQL queries uitvoeren tegen een CSV (of JSON of Parquet) file die via HTTP te benaderen is:
```
SELECT * 
FROM   read_csv_auto('https://raw.githubusercontent.com/lucasjellema/informatica-databases/main/imdb/movies.csv')
;
```

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

IMDb indexen 

COPY (SELECT * FROM imdb_actor_birthdate_index) TO 'imdb_actor_birthdate_index.csv' WITH (FORMAT CSV, DELIMITER ',');
.files download imdb_actor_birthdate_index.csv

``` 
create table imdb_actor_birthdate_index as
select a.identifier
,      a."Birth Date" birthdate
,      a."first name"||' '|| a."last name" as "name"
from   imdb_actors a
order
by     birthdate desc            
;
```  

``` 
create table imdb_actor_country_index as
select a.identifier
,      a."first name"||' '|| a."last name" as "name"
,      a."Country Reference" as country_id
from   imdb_actors a
order
by     country_id            
;
```  

COPY (SELECT * FROM imdb_actor_country_index) TO 'imdb_actor_country_index.csv' WITH (FORMAT CSV, DELIMITER ',');
.files download imdb_actor_country_index.csv


``` 
create table imdb_single_actors_index as
select a.identifier
from   imdb_actors a
where  a."Relationship Status" = 'Single'
order
by     a.identifier            
;
```  
COPY (SELECT * FROM imdb_single_actors_index) TO 'imdb_single_actors_index.csv' WITH (FORMAT CSV, DELIMITER ',');
.files download imdb_single_actors_index.csv



create table imdb_roles_by_character_index as
select r.actorId
,      r.movieId
,      r.character
from   imdb_roles r
order
by     r.character
;
COPY (SELECT * FROM imdb_roles_by_character_index) TO 'imdb_roles_by_character_index.csv' WITH (FORMAT CSV, DELIMITER ',');
.files download imdb_roles_by_character_index.csv


create table imdb_countries_by_population_index as
select c.identifier
,      c.name
,      c."Population (millions)" as population
from   imdb_countries c
order
by     population
;
COPY (SELECT * FROM imdb_countries_by_population_index) TO 'imdb_countries_by_population_index.csv' WITH (FORMAT CSV, DELIMITER ',');
.files download imdb_countries_by_population_index.csv



create table imdb_movies_by_genre_duration_index as
select m.Identifier
,      m.Title
,      m.Genre
,      m.Duration
from   imdb_movies m
order
by     genre, duration
;
COPY (SELECT * FROM imdb_movies_by_genre_duration_index) TO 'imdb_movies_by_genre_duration_index.csv' WITH (FORMAT CSV, DELIMITER ',');
.files download imdb_movies_by_genre_duration_index.csv



create table imdb_movies_by_duration_index as
select m.Identifier
,      m.Duration
from   imdb_movies m
order
by     duration
;
COPY (SELECT * FROM imdb_movies_by_duration_index) TO 'imdb_movies_by_duration_index.csv' WITH (FORMAT CSV, DELIMITER ',');
.files download imdb_movies_by_duration_index.csv




Je kunt een file toevoegen aan de DuckDB Shell - en daar vervolgens een tabel mee creëren of direct SQL tegen uitvoeren. Maak lokaal een file *landen.csv* met deze inhoud:
```
id,afkorting,naam
1,NL,Nederland
2,BE,België
3,FR,Frankrijk
4,DE,Duitsland
```

In DuckDB Shell type:
``` 
.files add
```

De browser opent de 'File Browser dialoog'. Selecteer de file *landen.csv*.

Type in de shell:
```
.files list
```

Als het goed is zie je nu onder andere de net toegevoegde file staan.

Voer nu dit statement uit:
```
select *
from   read_csv_auto('landen.csv')
order 
by     afkorting
;
```

De data in de lokale CSV file is overgedragen aan de DuckDB Web Shell en wordt daar nu (ook) als lokaal beschouwd. Je kunt nu ook een tabel creëren op basis van die data:
```
create table landen as select *
from   read_csv_auto('landen.csv')
;
```

en dan:

```
select *
from   landen
order 
by     afkorting
;
```
Zolang de DuckDB Web Shell sessie bestaat en tot je de file verwijdert en de tabel drop-ped is deze data beschikbaar.

Resultaat van query /inhoud tabel naar file schrijven

COPY (SELECT * FROM X WHERE Z) TO 'my_file.csv' WITH (FORMAT CSV, HEADER);





# Nieuwe SQL syntax

Is blauwbilgorgel een Nederlands woord?
Wie bepaalt wat een Nederlands woord is? (jullie kennen woorden die ik niet herken en andersom)
Is SELECT een SQL woord? En INSERT? Wat dacht je van MERGE? En CUBE, ROLLUP, CROSS JOIN en LEFT OUTER JOIN?
Wie bepaalt wat standaard SQL is? Wat maakt het uit?

Oude join syntax:

FROM A, B
where A.id = B.a_id

Nieuwe join syntax:
FROM A join B on (A.id = B.a_id)

Scheiding tussen de combinatie van tabellen en de logische filtering van de records. In de nieuwe syntax is de WHERE clause betekenisvoller - zonder de technische koppelcondities. En is de join zelf krachtiger geworden, vooral in situaties waar niet elk record gejoined kan worden.

Wat gebeurt hier:

select a.*
,      c.name
from   actors a
,      countries c
where  a."country reference" = c.id

als een acteur geen country reference heeft of een referentie waarvoor in table countries geen land gevonden kan worden?

alternatief:

select a.*
,      c.name
from   actors a
       left outer join 
,      countries c
       on  ( a."country reference" = c.id )

met alleen join doen de twee queries hetzelfde. Met de *left outer* krijgen we altijd de acteur (de linker kan van de join) en ook het land als het er is.

zie ook:

https://learnsql.com/blog/sql-joins-complete-guide/
https://learnsql.com/blog/illustrated-guide-sql-outer-join/
https://learnsql.com/blog/illustrated-guide-sql-cross-join-2/

In iedere sessie een geavanceerd stukje SQL

- GROUP BY SUM, MAX, COUNT, AVG; ROLLUP, CUBE?
- Types of Join - Outer Join
- Scalar Subquery, Common Table Expression, WITH
- MERGE
- View
- Macro
- Functions
- Data Dictionary
- Version Query / Flashback


## Database Aanpassingen

Regisseurs in eigen tabel ipv als kolom in Movies
Meerdere regisseurs voor een film
Acteurs die ook regisseur zijn
Oscar-nomimation flag - heeft film of acteur (of rol) een of meer Oscar-nominaties gekregen?
Countries - GDP 

## Onderscheid tussen Tabel en Record / Excel Sheet en Rij / Entiteit en Instantie

Neem twee boeken mee - twee exemplaren van hetzelfde boek. Toon het eerste boek. Wat zijn de eigenschappen? Hoe heet de tabel?
Toon het tweede boek. Zelfde eigenschappen. Of niet? Wat is het onderscheid tussen de twee?



## Data Modellering

Vertel een verhaal over een (zakelijke) situatie. Noem enkele zelfstandige naamwoorden - zowel voor entiteiten als voor attributen (tabellen en kolommen). Laat relaties blijken uit de samenhang van entiteiten. Laat leerlingen doorvragen.

laat leerlingen zelf tabellen bedenken, en kolommen en referenties en daar een tabel-structuur voor maken in hun schrift of in een tekstbestand.

Vertel het verhaal anders - nog een keer. Laat de leerlingen data vastleggen in hun tabellen (opschrijven in schrift/typen in text-files)
Laat queries uitvoeren tegen deze zelfvastgelegde data. 
Klopt de structuur? Kan je voor de volgende keer een verbetering bedenken?

Vertel het verhaal iets anders/iets uitgebreider. Hierdoor wordt nieuwe data toegevoegd. 
Doe de query nog een keer.

Laat zien hoe het er in SQL uitziet.



## Database

Hoe kies je er eentje?
Welke soorten zijn er?

Open Source/ Closed Source (proprietary, commercieel)/ Open Source als SaaS/Enterprise Service (commercieel, closed source addonms) (gratis game met extra accessores)

overwegingen:
functioneel
SQL? als niet, wat dan wel?
schaal/performance
kosten (CAPEX en OPEX)
veiligheid
standaarden 
volwassenheid
kennis/bronnen/"marktaandeel"
groen
waar (kan ik hem draaien)
interoperability - SDKs, client libraries, cloud-support, operating system support, container image?
hoe makkelijk om te gebruiken?
ACID




