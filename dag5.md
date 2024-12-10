# Graaf en GraphDB
- [Graaf en GraphDB](#graaf-en-graphdb)
  - [Bruggen van Königsberg](#bruggen-van-königsberg)
  - [Overstappen](#overstappen)
  - [Familie](#familie)
  - [Analyse van Reistijden](#analyse-van-reistijden)
  - [](#)
    - [De Duckstad Stamboom](#de-duckstad-stamboom)
- [Introductie GraphDB - Neo4J](#introductie-graphdb---neo4j)

## Bruggen van Königsberg 

Deze graaf beschrijft de zeven bruggen van Königsberg:
```
 C __
/ \  \
 A -- D
\ /__/ 
 B
```

We weten al dat je niet in één pad alle bruggen precies één keer van aflopen. Alle knooppunten hebben een oneven aantal bruggen, dat zit ons in de weg. 




## Overstappen

Deze data beschrijft vluchten van A naar B en verder. Hoe vaak moet je overstappen om van A naar S te komen? NB: als je de data in een graaf zet kan je dat sneller zien.

Vlucht Van <=> Naar
A <=> B
B <=> C
C <=> E
C <=> P
P <=> Z
B <=> Z
E <=> W
W <=> P
Z <=> E
E <=> S
W <=> S
A <=> E

Tip: je kunt ChatGPT vragen ("kan je van deze data een mermaid graph maken?") om deze data om te zetten naar een formaat dat je in de editor https://mermaid.live/ kan plakken, dat er een plaatje van maakt.

## Familie
Deze comma separated data bevat personen en voor iedere persoon één van hun ouders:

```
persoon,kind van
Stella,
Bas,Anja
Zade
Jip,Eli
Katie,
Lara,Katie
Mirjam,Katie
Nadia,Katie
Otto,Nadia
Eli,Cynthia
Yuri,Vic
Ids,Eli
Pia,Nadia
Faye,Cynthia
Rob,Otto
Tijs,Stella
Anja,
Giri,Cynthia
Ursula,Tijs
Vic,Tijs
Cynthia,Anja
Dory,Bas
Willem,Vic
```

Kan je uit deze data bepalen wie de oma is van Giri?
En wie de kleinkinderen zijn van Tijs?

Als je deze data als graaf weergeeft zijn die vragen makkelijker te beantwoorden. Met ChatGPT heb ik de CSV data omgezet in Mermaid syntax:

```
graph TD
  Anja
  Katie
  Stella
  Zade
  Bas --> Anja
  Cynthia --> Anja
  Dory --> Bas
  Eli --> Cynthia
  Ids --> Eli
  Jip --> Eli
  Lara --> Katie
  Mirjam --> Katie
  Nadia --> Katie
  Otto --> Nadia
  Pia --> Nadia
  Rob --> Otto
  Tijs --> Stella
  Ursula --> Tijs
  Vic --> Tijs
  Willem --> Vic
  Yuri --> Vic
  Giri --> Cynthia
  Faye --> Cynthia
```

Kopieer en plak deze data in de Mermaid Live Editor: https://mermaid.live/.  Beantwoord nu deze twee vragen:

Kan je uit deze data bepalen wie de oma is van Giri?
En wie de kleinkinderen zijn van Tijs?

En doe er nog eentje:
wie zijn de kinderen van Nadia?

Je ziet dat het voor het beantwoorden van sommige vragen heel veel uitmaakt in wat voor vorm de data is gepresenteerd. Dezelfde data als CSV file is voor deze vragen veel minder toegankelijk dan deze data als graaf weergegeven. 


## Analyse van Reistijden

Deze matrix bevat de reistijden in minuten tussen verschillende locaties. Iedere reis kan je in beide richtingen maken.

| X   | UC  | UO  | BH  | DD  | SZ  | S   | SD  | B   | A   | HS  | H   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| UC  | X   |     |     |     |     |     |     |     |     |     |     |
| UO  | 4   | X   |     |     |     |     |     |     |     |     |     |
| BH  |     | 5   | X   |     |     |     |     |     |     |     |     |
| DD  |     |     | 3   | X   |     |     |     |     |     |     |     |
| SZ  |     |     |     | 6   | X   |     |     |     |     |     |     |
| S   |     |     |     |     | 2   | X   |     |     |     |     |     |
| SD  |     |     |     |     |     | 3   | X   |     |     |     |     |
| B   |     |     |     |     |     |     | 4   | X   |     |     |     |
| A   | 13  |     |     | 7   |     |     |     |     | X   |     |     |
| HS  |     | 10  |     |     |     |     |     |     |     | X   |     |
| H   |     |     |     |     |     |     |     | 5   | 12  | 3   | X   |

Wat is de reistijd van UC naar S?

Als je een graaf maakt van de data in deze matrix is ook het beantwoorden van deze vraag een stuk eenvoudiger.
Open de site: https://mermaid.live/ in een nieuw browser tab. 

Plak dan onderstaande data in de editor:

```
---
config:
  layout: fixed
---
flowchart TD
    UC["UC"] -- 4 --> UO["UO"]
    UO -- 5 --> BH["BH"]
    BH -- 3 --> DD["DD"]
    DD -- 6 --> SZ["SZ"]
    SZ -- 2 --> S["S"]
    S -- 3 --> SD["SD"]
    SD -- 4 --> B["B"]
    UC -- 13 --> A["A"]
    DD -- 7 --> A
    UO -- 10 --> HS["HS"]
    B -- 5 --> H["H"]
    A -- 12 --> H
    HS -- 3 --> H
    style UC stroke:#00C853,fill:#00C853
    style S stroke:#D50000,fill:#2962FF,color:#FFFFFF
```

Het diagram rechts toont een graaf. Hierin kan je de route van UC naar S vrij makkelijk vinden en de reistijd bepalen.

Op welke manieren kan je van UC naar A reizen? Wat is de snelste reis van UC naar A?

Waar staan eigenlijk deze afkortingen voor? (S, SZ, UC, A, H - kan je ze thuisbrengen? Tip: zie [extra informatie](https://www.ns.nl/rpx?ctx=arnu%7CfromStation%3D8400621%7CtoStation%3D8400567%7CplannedFromTime%3D2024-12-10T14%3A37%3A00%2B01%3A00%7CplannedArrivalTime%3D2024-12-10T14%3A56%3A00%2B01%3A00%7CexcludeHighSpeedTrains%3Dfalse%7CsearchForAccessibleTrip%3Dfalse%7ClocalTrainsOnly%3Dfalse%7CtravelAssistance%3Dfalse%7CtripSummaryHash%3D446193610))


##

Op deze site https://graphonline.top/en/ kan je een graph samenstellen en vervolgens ook analyseren.






Snelste route van A naar B in een graaf
Algoritme van Dijkstra

Lootje trekken als graaf (cirkel: a heeft b, b heeft c, c heeft a)


leuke visualisatie: https://flourish.studio/visualisations/network-charts/ 
https://gephi.org/gephi-lite/


Film of boek als graph
Treinverbindingen, vluchten, wegen 

Verbindingen kunnen kosten of opbrengsten hebben  (tijd, geld, ) of gewicht (belang)
Afstandenmatrix <=> graaf

Netwerk-algoritmes
kortste (minste paden, kleinste opgetelde afstand) en goedkooopste weg
vind cycle


Wereld van Marvel

Van tabel naar matrix naar graaf

Voetbaltrainers

Doolhof
Logikwiz
Opsporing :
persoon, plaats, van, tot => wie waren tegelijk op dezelfde plek?


Project


### De Duckstad Stamboom
De file [duckstad-familiy-tree-mermaid.txt](files/duckstad-familiy-tree-mermaid.txt) bevat een deel van de stamboom van Duckstad, in een formaat dat kan worden weergegeven door de Mermaid visualization tool. Bekijk de inhoud van deze file en probeer te begrijpen wat de data beschrijft. Bijvoorbeeld hoe de relatie is tussen Donald Duck en Kwik.  

Open de website https://mermaid.live/. Start een nieuwe visualisatie en copy & paste de inhoud van bovenstaande file. Bekijk de visualisatie. Ook dit is een graaf.


Play met Dijkstra's algoritme:
https://mikedombo.github.io/graphPlayground/

https://www.algorithmsvisualizer.com/


Paardensprong puzzel




B A S
E   A
T A D


https://mermaid.live/

graph TD


    %% Nodes en paardensprongen
    A1["B"] --> B3["A"]
    A1 --> C2["A"]
    
    A2["E"] --> C1["S"]
    A2 --> C3

    A3["T"] --> B1
    A3 --> C2

    B1["A"] --> A3
    B1 --> C3

    B3["A"] --> A1
    B3 --> C1

    C1["S"] --> A2
    C1 --> B3

    C2["A"] --> A1
    C2 --> A3

    C3["D"] --> A2
    C3 --> B1



# Introductie GraphDB - Neo4J 

Ga naar https://test-drive.neo4j.com/?auto-start=1&usecase=stackoverflow2 

https://test-drive.neo4j.com/?auto-start=1


Hoeveel kleinkinderen heeft opa?
Wie is overgrootmoeder van Joep?

Lootje trekken

Vind (kortste) route van Soest naar Apeldoorn in deze graaf 

Recommendation: 
vindt iedereen die dezelfde film(s) leuk vindt als ik, vind de andere films die zij leuk vinden en suggereer de meest populaire daarvan
ik -- houd van => film <= houdt van (zelfde) film -- Persoon --  houdt van => film (en niet <-  haat -- ik)



IMDb als graaf


MATCH (oomDagobert:Character {name: "Oom Dagobert"})-[:UNCLE_OF*]->(descendant)
RETURN descendant.name

MATCH (n) RETURN n LIMIT 25

MATCH (parent:Character)-[:FATHER_OF|MOTHER_OF]->(kwikDuck:Character {name: "Kwik Duck"})
RETURN parent.name


Grandmother
MATCH p=()-[r:MOTHER_OF*2..3]->() RETURN p LIMIT 25



Paardensprong

// Create nodes
CREATE (:Letter {id: "A1", value: "B"});
CREATE (:Letter {id: "A2", value: "E"});
CREATE (:Letter {id: "A3", value: "T"});
CREATE (:Letter {id: "B1", value: "A"});
CREATE (:Letter {id: "B3", value: "A"});
CREATE (:Letter {id: "C1", value: "S"});
CREATE (:Letter {id: "C2", value: "A"});
CREATE (:Letter {id: "C3", value: "D"});

// Create edges
MATCH (a:Letter {id: "A1"}), (b:Letter {id: "B3"}) CREATE (a)-[:KNIGHT_MOVE]->(b);
MATCH (a:Letter {id: "A1"}), (b:Letter {id: "C2"}) CREATE (a)-[:KNIGHT_MOVE]->(b);

MATCH (a:Letter {id: "A2"}), (b:Letter {id: "C1"}) CREATE (a)-[:KNIGHT_MOVE]->(b);
MATCH (a:Letter {id: "A2"}), (b:Letter {id: "C3"}) CREATE (a)-[:KNIGHT_MOVE]->(b);

MATCH (a:Letter {id: "A3"}), (b:Letter {id: "B1"}) CREATE (a)-[:KNIGHT_MOVE]->(b);
MATCH (a:Letter {id: "A3"}), (b:Letter {id: "C2"}) CREATE (a)-[:KNIGHT_MOVE]->(b);

MATCH (a:Letter {id: "B1"}), (b:Letter {id: "A3"}) CREATE (a)-[:KNIGHT_MOVE]->(b);
MATCH (a:Letter {id: "B1"}), (b:Letter {id: "C3"}) CREATE (a)-[:KNIGHT_MOVE]->(b);

MATCH (a:Letter {id: "B3"}), (b:Letter {id: "A1"}) CREATE (a)-[:KNIGHT_MOVE]->(b);
MATCH (a:Letter {id: "B3"}), (b:Letter {id: "C1"}) CREATE (a)-[:KNIGHT_MOVE]->(b);

MATCH (a:Letter {id: "C1"}), (b:Letter {id: "A2"}) CREATE (a)-[:KNIGHT_MOVE]->(b);
MATCH (a:Letter {id: "C1"}), (b:Letter {id: "B3"}) CREATE (a)-[:KNIGHT_MOVE]->(b);

MATCH (a:Letter {id: "C2"}), (b:Letter {id: "A1"}) CREATE (a)-[:KNIGHT_MOVE]->(b);
MATCH (a:Letter {id: "C2"}), (b:Letter {id: "A3"}) CREATE (a)-[:KNIGHT_MOVE]->(b);

MATCH (a:Letter {id: "C3"}), (b:Letter {id: "A2"}) CREATE (a)-[:KNIGHT_MOVE]->(b);
MATCH (a:Letter {id: "C3"}), (b:Letter {id: "B1"}) CREATE (a)-[:KNIGHT_MOVE]->(b);


MATCH (start:Letter)
CALL apoc.path.expandConfig(start, {
    relationshipFilter: "KNIGHT_MOVE>",
     uniqueness: 'NODE_PATH',
    minLevel: 7,
    maxLevel: 7,
    limit: 100000
}) YIELD path
WITH start.id AS startNode, path, [n IN nodes(path) | n.value] AS letters
RETURN startNode, reduce(word = "", letter IN letters | word + letter) AS word
ORDER BY startNode, word;
