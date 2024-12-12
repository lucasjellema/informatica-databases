MATCH (n)
DETACH DELETE n;

// Creëer nodes voor vriendinnen
CREATE (:Vriendin {naam: "Anna"});
CREATE (:Vriendin {naam: "Britt"});
CREATE (:Vriendin {naam: "Clara"});
CREATE (:Vriendin {naam: "Dana"});
CREATE (:Vriendin {naam: "Elsa"});

// Creëer nodes voor steden
CREATE (:Stad {naam: "Amsterdam"});
CREATE (:Stad {naam: "Rotterdam"});
CREATE (:Stad {naam: "Utrecht"});
CREATE (:Stad {naam: "Den Haag"});
CREATE (:Stad {naam: "Leiden"});
CREATE (:Stad {naam: "Maastricht"});
CREATE (:Stad {naam: "Eindhoven"});
CREATE (:Stad {naam: "Groningen"});

// Creëer relaties "bezoek aan" met properties vanaf en tot
MATCH (v:Vriendin {naam: "Anna"}), (s:Stad {naam: "Amsterdam"})
CREATE (v)-[:BEZOEK_AAN {vanaf: date("2023-10-08"), tot: date("2023-10-15")}]->(s);

MATCH (v:Vriendin {naam: "Clara"}), (s:Stad {naam: "Maastricht"})
CREATE (v)-[:BEZOEK_AAN {vanaf: date("2023-02-05"), tot: date("2023-02-08")}]->(s);

MATCH (v:Vriendin {naam: "Elsa"}), (s:Stad {naam: "Groningen"})
CREATE (v)-[:BEZOEK_AAN {vanaf: date("2023-03-12"), tot: date("2023-03-14")}]->(s);

MATCH (v:Vriendin {naam: "Anna"}), (s:Stad {naam: "Rotterdam"})
CREATE (v)-[:BEZOEK_AAN {vanaf: date("2023-04-01"), tot: date("2023-04-03")}]->(s);

MATCH (v:Vriendin {naam: "Britt"}), (s:Stad {naam: "Den Haag"})
CREATE (v)-[:BEZOEK_AAN {vanaf: date("2023-05-10"), tot: date("2023-05-12")}]->(s);

MATCH (v:Vriendin {naam: "Britt"}), (s:Stad {naam: "Utrecht"})
CREATE (v)-[:BEZOEK_AAN {vanaf: date("2023-06-15"), tot: date("2023-06-18")}]->(s);

MATCH (v:Vriendin {naam: "Anna"}), (s:Stad {naam: "Utrecht"})
CREATE (v)-[:BEZOEK_AAN {vanaf: date("2023-07-01"), tot: date("2023-07-04")}]->(s);

MATCH (v:Vriendin {naam: "Britt"}), (s:Stad {naam: "Rotterdam"})
CREATE (v)-[:BEZOEK_AAN {vanaf: date("2023-08-10"), tot: date("2023-08-12")}]->(s);

MATCH (v:Vriendin {naam: "Clara"}), (s:Stad {naam: "Utrecht"})
CREATE (v)-[:BEZOEK_AAN {vanaf: date("2023-09-01"), tot: date("2023-09-05")}]->(s);

MATCH (v:Vriendin {naam: "Clara"}), (s:Stad {naam: "Amsterdam"})
CREATE (v)-[:BEZOEK_AAN {vanaf: date("2023-10-10"), tot: date("2023-10-12")}]->(s);

MATCH (v:Vriendin {naam: "Dana"}), (s:Stad {naam: "Rotterdam"})
CREATE (v)-[:BEZOEK_AAN {vanaf: date("2023-11-01"), tot: date("2023-11-03")}]->(s);

MATCH (v:Vriendin {naam: "Dana"}), (s:Stad {naam: "Den Haag"})
CREATE (v)-[:BEZOEK_AAN {vanaf: date("2023-05-11"), tot: date("2023-05-13")}]->(s);

MATCH (v:Vriendin {naam: "Elsa"}), (s:Stad {naam: "Maastricht"})
CREATE (v)-[:BEZOEK_AAN {vanaf: date("2024-01-10"), tot: date("2024-01-12")}]->(s);

MATCH (v:Vriendin {naam: "Dana"}), (s:Stad {naam: "Utrecht"})
CREATE (v)-[:BEZOEK_AAN {vanaf: date("2024-02-05"), tot: date("2024-02-08")}]->(s);

MATCH (v:Vriendin {naam: "Dana"}), (s:Stad {naam: "Maastricht"})
CREATE (v)-[:BEZOEK_AAN {vanaf: date("2024-03-12"), tot: date("2024-03-15")}]->(s);

MATCH (v:Vriendin {naam: "Elsa"}), (s:Stad {naam: "Eindhoven"})
CREATE (v)-[:BEZOEK_AAN {vanaf: date("2024-04-10"), tot: date("2024-04-12")}]->(s);

MATCH (v:Vriendin {naam: "Britt"}), (s:Stad {naam: "Leiden"})
CREATE (v)-[:BEZOEK_AAN {vanaf: date("2024-05-15"), tot: date("2024-05-18")}]->(s);

MATCH (v:Vriendin {naam: "Elsa"}), (s:Stad {naam: "Leiden"})
CREATE (v)-[:BEZOEK_AAN {vanaf: date("2024-06-01"), tot: date("2024-06-03")}]->(s);

MATCH (v:Vriendin {naam: "Elsa"}), (s:Stad {naam: "Rotterdam"})
CREATE (v)-[:BEZOEK_AAN {vanaf: date("2024-07-01"), tot: date("2024-07-05")}]->(s);

MATCH (v:Vriendin {naam: "Clara"}), (s:Stad {naam: "Rotterdam"})
CREATE (v)-[:BEZOEK_AAN {vanaf: date("2024-08-10"), tot: date("2024-08-12")}]->(s);

MATCH (v:Vriendin {naam: "Anna"}), (s:Stad {naam: "Utrecht"})
CREATE (v)-[:BEZOEK_AAN {vanaf: date("2024-12-01"), tot: date("2024-12-08")}]->(s);
