# JSON en NoSQL Database

- [JSON en NoSQL Database](#json-en-nosql-database)
  - [JSON](#json)
    - [JSON in Web Applicaties](#json-in-web-applicaties)
    - [Simpel JSON](#simpel-json)
    - [JSON communicatie achter Reisplanner](#json-communicatie-achter-reisplanner)
  - [Introductie NoSQL Database MongoDB](#introductie-nosql-database-mongodb)
  - [Query Documenten in MongoDB](#query-documenten-in-mongodb)
    - [Onderzoek Survey Results met MongoDB](#onderzoek-survey-results-met-mongodb)
  - [Vergelijk SQL en NoSQL](#vergelijk-sql-en-nosql)



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

Open de link https://onecompiler.com/mongodb. De site opent met een code editor die deze code bevat:
```
db.employees.insertMany([
  {empId: 1, name: 'Clark', dept: 'Sales' },
  {empId: 2, name: 'Dave', dept: 'Accounting' },
  {empId: 3, name: 'Ava', dept: 'Sales' }
]);

db.employees.find({dept: 'Sales'});
```

In deze oefenomgeving is al een database gestart. Die is beschikbaar via de variabele db. Deze code maakt in de database een collection aan die *employees* heet - een beetje vergelijkbaar met een tabel in een relationele database - en stopt ook direct drie JSON documenten in deze collectie. Vervolgens wordt een query uitgevoerd tegen deze collectie en worden alle documenten opgevraagd waarin de waarde van *dept* gelijk is aan *Sales* 

Druk op de knop *Run*. Onderaan de output zie je de twee documenten die voldoen aan de zoekvoorwaarde.

Voeg deze regels toe
```
db.employees.insertOne({empId: 7, name: 'John', dept: 'IT' })
db.employees.find({name: 'John'});
```
Druk op de knop *Run*. Onderaan de output zie je dat het net toegevoegd document wordt gevonden.

Voeg deze regels toe en druk weer op *Run*
```
db.employees.count()
db.employees.find()
```
Je ziet zowel het totaal aantal documenten als de lijst van alle documenten.

Voeg deze regels toe
```
db.employees.insertOne({employeeIdentifier: "XX", voornaam: 'Jochem', afdeling: 'Marketing', hobby:'sportvissen' })
db.employees.find()
```

Druk op *Run*. Je ziet nu iets dat in een relationele database absoluut niet zou werken: een document in de *employees* collectie met een afwijkende structuur. Kijk eens naar de namen van de properties! De NoSQL database kijkt alleen of er sprake is van een valide JSON document. En dat is het geval. De namen van properties en de waarden van properties zijn niet het probleem van de database.

Open de site https://json-generator.com/ . Deze site kan een JSON document genereren. Genereer een  nieuw JSON document. Copy het document naar het clipboard.

Terug in OneCompiler, voeg onderstaand fragment toe aan de code en vervang zoals aangegeven met de inhoud van het clipboard. 
```
db.employees.insertMany(
  < insert hier de output van de JSON Generator>
)
db.employees.find({},{name:1})
```
Druk op *Run*. Ook deze data wordt moeiteloos in dezelfde collection in de database vastgelegd en we kunnen een query uitvoeren over alle documenten, ook al zijn ze onderling best verschillend. Omdat alle documenten een *name* property hebben kunnen we prima de waarde van dat property vinden voor alle documenten.

Verwijderen van een document doe je in MongoDB met de *delete* functie op een collectie. Voeg deze regels toe:  

```
db.employees.count()
db.employees.deleteMany([dept: 'Sales'])
db.employees.count()
```

Begrijp je wat hier gebeurt? Weet je hoe je het document voor Jochem kan verwijderen?

## Query Documenten in MongoDB

Vind informatie met verschillende, enigszins ingewikkelde queries


### Onderzoek Survey Results met MongoDB

Open de link https://onecompiler.com/mongodb opnieuw. Vervang de inhoud van het text kader met:

```
const s= <vervang> 
db.survey.insertMany(s.Survey.Response  )
db.survey.find()
```
Vervang de string *<vervang>* met de inhoud van file [survey_results.json](survey/survey_results.json). Dat ziet dus ongeveer als volgt uit:

```
const s= const s = {
    "Survey": {
      "Response": [
        {
        ...
      ]
    }
}        
db.survey.insertMany(s.Survey.Response  )
db.survey.find()
```
Druk op *Run* om te zien of de data goed geladen is.

Nu kan je gaan zoeken, bijvoorbeeld op woonplaats of vervoermiddel. Voeg deze regels toe, onderaan:

```
print("Woonplaatsen van alle FIETS berijders")
db.survey.find({Vervoermiddel:"Fiets"},{Woonplaats:1})
print("Details voor Soestenaren")
db.survey.find({Woonplaats:"Soest"},{Reistijd:1, Vervoermiddel:1, Reisafstand:1})
```

Druk op *Run*.

Dit zou specifieke details moeten opleveren.





## Vergelijk SQL en NoSQL

IMDb in MongoDB





