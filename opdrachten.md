

## Introductie tabellen en aanlopop richting SQL

Groepsoefening:
- vier groepsleden (eventueel 2 of 3 kan ook)
- ieder groepslid krijgt een A4 met een dataverzameling: Films/Series, Acteurs, Casting/Rollen en Landen
- de opdracht: **wat is de hoofdstad van het land waar de acteur vandaan komt die in Film X rol Y speelt**
- (de deelnemers voeren gezamenlijk een soort SQL query uit; in pseudo code
```
select l.hoofdstad
from   films f 
       join
       cast c
       on f.id = c.film_id
       join 
       acteurs a
       on c.acteur_id = a.id
       join 
       landen l
       on a.land_id = l.id
where  f.titel = 'X'
and    c.rol = 'Y'       
```       
)
- aanvullende opdracht: **in welke films spelen acteurs afkomstig uit een land met een bevolking kleiner dan 5 miljoen? Geef ook de namen van de landen, van de acteurs en van de rollen**
- (de deelnemers voeren gezamenlijk een soort SQL query uit; in pseudo code
```
select f.titel
,      c.rol 
,      a.naam as "acteur"
,      l.naam as "land"
from   landen l
       join
       acteurs a
       on a.land_id = l.id
       join 
       cast c
       on c.acteur_id = a.id
       join 
       films f
       on f.id = c.film_id
where  l.bevolkingsomvang < 5000000       
```       
)


## Groepsoefening: Speel een SQL Query

- ieder groepslid heeft een rol: FROM, WHERE, SELECT, ORDER BY (en LIMIT/FETCH FIRST n ROWS ONLY - en GROUP BY??):
  - de deelnemer met FROM mag alleen de relevante vellen selecteren
  - de deelnemer met WHERE mag alleen relevante records selectered (uit de beschikbaar datasets nadat FROM klaar is)
  - de deelnemer met SELECT mag alleen velden selecteren (uit de records die WHERE heeft opgeleverd)
  - de deelnemer met ORDER BY en LIMIT mag de de records selecteren en het aantal beperken
- met dezelfde datatsets als in de vorige oefening: FILMS, ACTEURS, CAST, LANDEN
- voer als groep de volgende queries uit:
  - select naam, leeftijd from acteurs where geboortedatum > '15-09-1999' order by leeftijd, naam FETCH FIRST 3 ROWS ONLY
  - select a.naam as acteur from acteurs a join cast c on a.id = c.acteur.id where c.rol = 'Dracula' order by a.naam     
- - select a.naam as acteur, f.naam as film, f.jaar from acteurs a join cast c on a.id = c.acteur.id join films f on f.id = c.film_id where c.rol = 'Dracula' order by f.jaar, a.naam, f.naam    