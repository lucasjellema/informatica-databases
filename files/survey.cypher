MATCH (n)
DETACH DELETE n;

// Create Person nodes
CREATE (:Person {id: "1", name: "Lucas"});
CREATE (:Person {id: "2", name: "Frank"});
CREATE (:Person {id: "3", name: "Bastiaan"});
CREATE (:Person {id: "4", name: "Joachim"});
CREATE (:Person {id: "5", name: "Tonio"});
CREATE (:Person {id: "6", name: "Camiel"});
CREATE (:Person {id: "7", name: "Kornelis"});
CREATE (:Person {id: "8", name: "Ferdinand"});
CREATE (:Person {id: "9", name: "Tiuri"});
CREATE (:Person {id: "10", name: "Jason"});
CREATE (:Person {id: "11", name: "Tobias"});
CREATE (:Person {id: "12", name: "Titus"});
CREATE (:Person {id: "13", name: "Roderick"});
CREATE (:Person {id: "14", name: "Tibor"});
CREATE (:Person {id: "15", name: "Luigi"});
CREATE (:Person {id: "16", name: "Delilah"});
CREATE (:Person {id: "17", name: "Naomi"});
CREATE (:Person {id: "18", name: "Cathryn"});
CREATE (:Person {id: "19", name: "Wouter"});
CREATE (:Person {id: "20", name: "Norbert"});

// Create Woonplaats nodes
CREATE (:Woonplaats {name: "Zoetermeer"});
CREATE (:Woonplaats {name: "Soest"});
CREATE (:Woonplaats {name: "Eemdijk"});
CREATE (:Woonplaats {name: "Baarn"});

// Create Vervoermiddel nodes
CREATE (:Vervoermiddel {type: "Auto"});
CREATE (:Vervoermiddel {type: "Fiets"});
CREATE (:Vervoermiddel {type: "eBike (inclusief Fatbike)"});
CREATE (:Vervoermiddel {type: "Scooter/Bromfiets"});

// Create relationships
// Create relationships for all survey responses
MATCH (p:Person {id: "1"}), (w:Woonplaats {name: "Zoetermeer"})
CREATE (p)-[:LIVES_IN]->(w);
MATCH (p:Person {id: "1"}), (v:Vervoermiddel {type: "Auto"})
CREATE (p)-[:USES {reistijd: 58, reisafstand: 75.3}]->(v);

MATCH (p:Person {id: "2"}), (w:Woonplaats {name: "Soest"})
CREATE (p)-[:LIVES_IN]->(w);
MATCH (p:Person {id: "2"}), (v:Vervoermiddel {type: "Fiets"})
CREATE (p)-[:USES {reistijd: 6, reisafstand: 1.5}]->(v);

MATCH (p:Person {id: "3"}), (w:Woonplaats {name: "Eemdijk"})
CREATE (p)-[:LIVES_IN]->(w);
MATCH (p:Person {id: "3"}), (v:Vervoermiddel {type: "eBike (inclusief Fatbike)"})
CREATE (p)-[:USES {reistijd: 30, reisafstand: 10.4}]->(v);

MATCH (p:Person {id: "4"}), (w:Woonplaats {name: "Soest"})
CREATE (p)-[:LIVES_IN]->(w);
MATCH (p:Person {id: "4"}), (v:Vervoermiddel {type: "eBike (inclusief Fatbike)"})
CREATE (p)-[:USES {reistijd: 10, reisafstand: 4}]->(v);

MATCH (p:Person {id: "5"}), (w:Woonplaats {name: "Soest"})
CREATE (p)-[:LIVES_IN]->(w);
MATCH (p:Person {id: "5"}), (v:Vervoermiddel {type: "Fiets"})
CREATE (p)-[:USES {reistijd: 20, reisafstand: 7.5}]->(v);

MATCH (p:Person {id: "6"}), (w:Woonplaats {name: "Baarn"})
CREATE (p)-[:LIVES_IN]->(w);
MATCH (p:Person {id: "6"}), (v:Vervoermiddel {type: "Scooter/Bromfiets"})
CREATE (p)-[:USES {reistijd: 17, reisafstand: 6}]->(v);

MATCH (p:Person {id: "7"}), (w:Woonplaats {name: "Soest"})
CREATE (p)-[:LIVES_IN]->(w);
MATCH (p:Person {id: "7"}), (v:Vervoermiddel {type: "Fiets"})
CREATE (p)-[:USES {reistijd: 5, reisafstand: 2}]->(v);

MATCH (p:Person {id: "8"}), (w:Woonplaats {name: "Soest"})
CREATE (p)-[:LIVES_IN]->(w);
MATCH (p:Person {id: "8"}), (v:Vervoermiddel {type: "Fiets"})
CREATE (p)-[:USES {reistijd: 9, reisafstand: 2}]->(v);

MATCH (p:Person {id: "9"}), (w:Woonplaats {name: "Baarn"})
CREATE (p)-[:LIVES_IN]->(w);
MATCH (p:Person {id: "9"}), (v:Vervoermiddel {type: "Fiets"})
CREATE (p)-[:USES {reistijd: 7, reisafstand: 2.7}]->(v);

MATCH (p:Person {id: "10"}), (w:Woonplaats {name: "Soest"})
CREATE (p)-[:LIVES_IN]->(w);
MATCH (p:Person {id: "10"}), (v:Vervoermiddel {type: "Scooter/Bromfiets"})
CREATE (p)-[:USES {reistijd: 12, reisafstand: 4.8}]->(v);

MATCH (p:Person {id: "11"}), (w:Woonplaats {name: "Soest"})
CREATE (p)-[:LIVES_IN]->(w);
MATCH (p:Person {id: "11"}), (v:Vervoermiddel {type: "Fiets"})
CREATE (p)-[:USES {reistijd: 12, reisafstand: 3.7}]->(v);

MATCH (p:Person {id: "12"}), (w:Woonplaats {name: "Soest"})
CREATE (p)-[:LIVES_IN]->(w);
MATCH (p:Person {id: "12"}), (v:Vervoermiddel {type: "Fiets"})
CREATE (p)-[:USES {reistijd: 5, reisafstand: 1}]->(v);

MATCH (p:Person {id: "13"}), (w:Woonplaats {name: "Soest"})
CREATE (p)-[:LIVES_IN]->(w);
MATCH (p:Person {id: "13"}), (v:Vervoermiddel {type: "Fiets"})
CREATE (p)-[:USES {reistijd: 22, reisafstand: 5}]->(v);

MATCH (p:Person {id: "14"}), (w:Woonplaats {name: "Soest"})
CREATE (p)-[:LIVES_IN]->(w);
MATCH (p:Person {id: "14"}), (v:Vervoermiddel {type: "Scooter/Bromfiets"})
CREATE (p)-[:USES {reistijd: 5, reisafstand: 3.6}]->(v);

MATCH (p:Person {id: "15"}), (w:Woonplaats {name: "Soest"})
CREATE (p)-[:LIVES_IN]->(w);
MATCH (p:Person {id: "15"}), (v:Vervoermiddel {type: "Fiets"})
CREATE (p)-[:USES {reistijd: 8, reisafstand: 2.5}]->(v);

MATCH (p:Person {id: "16"}), (w:Woonplaats {name: "Soest"})
CREATE (p)-[:LIVES_IN]->(w);
MATCH (p:Person {id: "16"}), (v:Vervoermiddel {type: "Scooter/Bromfiets"})
CREATE (p)-[:USES {reistijd: 10, reisafstand: 2.7}]->(v);

MATCH (p:Person {id: "17"}), (w:Woonplaats {name: "Baarn"})
CREATE (p)-[:LIVES_IN]->(w);
MATCH (p:Person {id: "17"}), (v:Vervoermiddel {type: "Fiets"})
CREATE (p)-[:USES {reistijd: 18, reisafstand: 3.9}]->(v);

MATCH (p:Person {id: "18"}), (w:Woonplaats {name: "Soest"})
CREATE (p)-[:LIVES_IN]->(w);
MATCH (p:Person {id: "18"}), (v:Vervoermiddel {type: "Fiets"})
CREATE (p)-[:USES {reistijd: 15, reisafstand: 0}]->(v);

MATCH (p:Person {id: "19"}), (w:Woonplaats {name: "Baarn"})
CREATE (p)-[:LIVES_IN]->(w);
MATCH (p:Person {id: "19"}), (v:Vervoermiddel {type: "Fiets"})
CREATE (p)-[:USES {reistijd: 9, reisafstand: 2.8}]->(v);

MATCH (p:Person {id: "20"}), (w:Woonplaats {name: "Baarn"})
CREATE (p)-[:LIVES_IN]->(w);
MATCH (p:Person {id: "20"}), (v:Vervoermiddel {type: "Fiets"})
CREATE (p)-[:USES {reistijd: 13, reisafstand: 3.5}]->(v);
