
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

```
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