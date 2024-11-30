# JSON en NoSQL Database

- [Data Formaten, Data Modellering, Advanced SQL](#data-formaten-data-modellering-advanced-sql)
  - [Data Analyse](#data-analyse)
  - [File Identificatie](#file-identificatie)
    - [Escape Room Style (Binair Tellen op je vingers)](#escape-room-style-binair-tellen-op-je-vingers)
    - [Nullen en Enen - van karakters, bytes en bits](#nullen-en-enen---van-karakters-bytes-en-bits)
- [Analyseer de Woon-School Reisverkeer Survey](#analyseer-de-woon-school-reisverkeer-survey)
- [Datamodellering](#datamodellering)
  - [Ticket-Shop](#ticket-shop)
  - [Maak een Datamodel voor Registratie van Health Metrics](#maak-een-datamodel-voor-registratie-van-health-metrics)
  - [GAME ON: Teken het Datamodel voor deze tabellen](#game-on-teken-het-datamodel-voor-deze-tabellen)
  - [Maak een praktijk-datamodel voor de praktijk](#maak-een-praktijk-datamodel-voor-de-praktijk)
  - [Interpreteer en completeer datamodel](#interpreteer-en-completeer-datamodel)
  - [Maak de Create Table scripts voor een data-model](#maak-de-create-table-scripts-voor-een-data-model)
- [Advanced SQL : Scalar Subquery en Common Table Expression (CTE)](#advanced-sql--scalar-subquery-en-common-table-expression-cte)
  - [Run DuckDB en bouw IMDb](#run-duckdb-en-bouw-imdb)
  - [Scalar Subquery](#scalar-subquery)
    - [Common Table Expression](#common-table-expression)
  - [Appendix](#appendix)
    - [Data Modellering Ticketshop](#data-modellering-ticketshop)
    - [Scalar Subquery en Common Table Expression](#scalar-subquery-en-common-table-expression)


## JSON

Kennismaken met data in JSON formaat. Een formaat dat je op heel veel plekken tegenkomt. Onder andere in de uitwisseling van data tussen web applicaties en de web servers.

### JSON in Web Applicaties

In veel web applicaties speelt JSON een belangrijke rol. Data wordt vaak in JSON formaat gedefinieerd in de web applicatie of in JSON format door de web applicatie uit een server (via een API) opgevraagd.

Voor een simpel voorbeeld, kijk naar file `dieren-app.html`. Open de file in je browser. Je ziet een lijstje dieren op een web pagina. Als je de inhoud van de file bekijkt dan zie je de definitie van het JSON data object met dier definities.

Download de file naar je computer. Open de file in een text editor. Verander de prijs van Bear van 800 naar 1900. Voeg een Dog object toe:
```
{ name: "Dog", species: "Canis lupus familiaris", price: 300 },
```

Sla de wijzigingen op. Open de file in een browser. Check of de aanpassingen in het data object zichtbaar zijn in de webpagina. 

Bonus:
Je kunt in de Browser Developer Tools naar de tab Console gaan. In de Console kan je de string `animals` typen. Je krijgt de waarde te zien van die variable: het JSON data object. Je kunt vervolgens de data bewerken in de console. Wijzig bijvoorbeeld *Lion* naar *Lioness* en druk op de knop *Refresh*. 

### Simpel JSON

Open https://jsonformatter.org/ - een website die helpt met werken met JSON documenten.

Klik op *Sample*. Een eenvoudig JSON document verschijnt. Wat kan je er over zeggen? Wat voor gegevens staan erin? Hoeveel employee records zijn er? Wat is de *firstName* van employee met waarde 3 voor *id*?

Klik op *View* boven het rechterkader. Selecteer *Tree* van het dropdownlijstje. Nu zie je de data op een nog wat overzichtelijker manier gepresenteerd. Klik door de nodes van de tree.

Pas de achternaam van *Tom* aan naar *Don*. 

Voeg een Employee record toe (in het linkerkader), voor een employee met id 6, voornaam John en achternaam Williams; deze employee heeft geen foto. Zorg dat het JSON document valide blijft. Klik op *Format/Beautify* en zie of het nieuwe record ook in de tree wordt getoond.

Je kunt zoekacties (queries) uitvoeren op de JSON data. Klik op het filter icoontje boven het rechterkader. Een popup verschijnt waarin je een query kan invoeren. Iedere query begint met @. Daarna gebruik je de namen van de properties en eventueel de index (volgnummer) binnen een collectie.

Probeer deze query, om alle employees te tonen: `@.employees.employee` 

Probeer deze query, om de voornaam van de eerste employee te achterhalen: `@.employees.employee[0].firstName` 

Ietsje complexer, om de achternaam te vinden van alle employees die Robert als voornaam hebben:
`@.employees.employee[?"firstName"=='Robert'].lastName`

En om alle voornamen te vinden: @.employees.employee[*].firstName

Voeg twee child records toe (in het linkerkader) voor de nieuwe employee met id 6. Deze records beschrijven zijn meest recente beoordelingen: 
```
waardering,toelichting,datum
goed,Harde werker,2024-12-08
gemiddeld,Er mag een tandje bij,2023-12-17
```

Tip: voeg eerst een extra property toe aan het employee record voor John Williams, voor de child-collection met beoordelingen `"beoordelingen" : []`. Voeg hier vervolgens de beoordelingen aan toe.

Druk op *Format / Beautify* en zie deze nodes in de tree verschijnen.

Je kunt alle beoordelingen van alle employees bekijken met: `@.employees.employee[*].beoordelingen`


### JSON communicatie achter Reisplanner

Open https://www.ns.nl/reisplanner in een browser. Je ziet de reisplanner van de Nederlandse Spoorwegen.

Vul een vertrekpunt in (bijvoorbeeld Soest Station) en een bestemming (bijvoorbeeld Utrecht CS). 

Open de Browser Development Tools. In de meeste browsers doe je dat met de toetscombinatie `CTRL Shift i`. Open de *Network* tab.

Druk op knop *Plannen*. Je ziet nu verschillende regels verschijnen in de *Network* tab. Klik op de regel met type *XHR* die start met *trips?fromStation*.

Onder *Response* zie je de data die de server heeft geantwoord aan jouw browser op de vraag om een reis te plannen tussen vertrek en bestemming. Deze data is in *JSON* formaat. 

Om makkelijker de data te inspecteren kan je deze naar een tool kopiëren. Klik ergens in het JSON document. Selecteer alle content - bijvoorbeeld met CTRL a. Kopieer de content naar de clipboard - CTRL c. 

Open de site https://jsonformatter.org/. Paste de JSON content van het clipboard in het linker kader (CTRL v).  

Je ziet nu de JSON data van ns.nl in een JSON formatter. Klik op de button *Validate* om te kijken of dit geldige JSON data is - data die volgens de afspraak is georganiseerd met de juiste `"{,:[}]` karakters.

Verwijder één `]` uit het document en druk opnieuw op `Validate`. Je ziet direct dat het document niet meer OK is. Maak je wijziging ongedaan.

Druk op *Format / Beautify* en zie deze nodes in het rechterkader verschijnen. Toon dit in Tree formaat.

In de tree zie je de *trips* node. Deze komt overeen met de set reisopties die de server aan je browser heeft teruggestuurd. Als je een *trip* node openklikt zie je de child node *legs*. Dit zijn de onderdelen van de reis - één of meer trajecten tussen steeds twee stations. 

Als je een *leg* node inspecteert zie je eigenschappen die met dit stuk van de reis te maken hebben: van waar naar waar, welke vertrektijd, welk soort vervoermiddel, de verwachte drukte, de reistijd en of er fietsen mee kunnen in de trein. Onder leg zitten child nodes *origin* en *destination* met gegevens over de stations.

Al deze data wordt in JavaScript in de browser gelezen, verwerkt en gebruikt om de informatie op het scherm te tonen voor de gebruiker.

Met deze zoekstring kan je achterhalen wat de naam is van het station aan het eind van de eerste stap in de eerste geadviseerde reis:
```
@.trips[0].legs[0].destination.name
```

Met `@.trips[0].legs[*].destination.name` achterhaal je alle stations waar je moet over- en uitstappen - voor de eerste reisoptie.

Met `@.trips[*].legs[*].destination.name` achterhaal je alle stations waar je moet over- en uitstappen - voor alle reisopties.

Achterhaal wat de eerste trip kost. Tip: er zijn een heleboel prijzen, afhankelijk van kortingskaarten, abonnementen etc. Probeer tenminste één prijs te achterhalen. Als je ze allemaal op een rijtje zet is het helemaal mooi. Hint: fares.

Met `@.trips[*].legs[*].destination.name

Het property *transfers* in een *trip* geeft het aantal overstappen aan (dit komt overeen met het aantal elementen in de *legs* collectie).

Met de filter-voorwaaree 
```
@.trips[?transfers==`0`].transfers
```
kan je zoeken naar de trips waar geen overstap bij nodig is. Je kunt ook zoeken met voorwaarden als `?transfers<`2`` en `?transfers<=`1``

## Introductie NoSQL Database MongoDB

Maak database met https://onecompiler.com/mongodb
Maak collection
Stop er een JSON document in
Doe de simpelste query
Generate nieuw JSON document https://json-generator.com/
en stop in DB

## Query Documenten in MongoDB

Vind informatie met verschillende, enigszins ingewikkelde queries

## Vergelijk SQL en NoSQL

IMDb in MongoDB





