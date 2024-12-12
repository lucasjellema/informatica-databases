MATCH (n)
DETACH DELETE n;
// Create nodes for all unique individuals
MERGE (anja:Person {name: "Anja"});
MERGE (katie:Person {name: "Katie"});
MERGE (stella:Person {name: "Stella"});
MERGE (zade:Person {name: "Zade"});
MERGE (bas:Person {name: "Bas"});
MERGE (cynthia:Person {name: "Cynthia"});
MERGE (dory:Person {name: "Dory"});
MERGE (eli:Person {name: "Eli"});
MERGE (ids:Person {name: "Ids"});
MERGE (jip:Person {name: "Jip"});
MERGE (lara:Person {name: "Lara"});
MERGE (mirjam:Person {name: "Mirjam"});
MERGE (nadia:Person {name: "Nadia"});
MERGE (otto:Person {name: "Otto"});
MERGE (pia:Person {name: "Pia"});
MERGE (rob:Person {name: "Rob"});
MERGE (tijs:Person {name: "Tijs"});
MERGE (ursula:Person {name: "Ursula"});
MERGE (vic:Person {name: "Vic"});
MERGE (willem:Person {name: "Willem"});
MERGE (yuri:Person {name: "Yuri"});
MERGE (giri:Person {name: "Giri"});
MERGE (faye:Person {name: "Faye"});

// Establish parent-child relationships
MATCH (anja:Person {name: "Anja"}), (bas:Person {name: "Bas"})
MERGE (bas)-[:CHILD_OF]->(anja);

MATCH (anja:Person {name: "Anja"}), (cynthia:Person {name: "Cynthia"})
MERGE (cynthia)-[:CHILD_OF]->(anja);

MATCH (bas:Person {name: "Bas"}), (dory:Person {name: "Dory"})
MERGE (dory)-[:CHILD_OF]->(bas);

MATCH (cynthia:Person {name: "Cynthia"}), (eli:Person {name: "Eli"})
MERGE (eli)-[:CHILD_OF]->(cynthia);

MATCH (eli:Person {name: "Eli"}), (ids:Person {name: "Ids"})
MERGE (ids)-[:CHILD_OF]->(eli);

MATCH (eli:Person {name: "Eli"}), (jip:Person {name: "Jip"})
MERGE (jip)-[:CHILD_OF]->(eli);

MATCH (katie:Person {name: "Katie"}), (lara:Person {name: "Lara"})
MERGE (lara)-[:CHILD_OF]->(katie);

MATCH (katie:Person {name: "Katie"}), (mirjam:Person {name: "Mirjam"})
MERGE (mirjam)-[:CHILD_OF]->(katie);

MATCH (katie:Person {name: "Katie"}), (nadia:Person {name: "Nadia"})
MERGE (nadia)-[:CHILD_OF]->(katie);

MATCH (nadia:Person {name: "Nadia"}), (otto:Person {name: "Otto"})
MERGE (otto)-[:CHILD_OF]->(nadia);

MATCH (nadia:Person {name: "Nadia"}), (pia:Person {name: "Pia"})
MERGE (pia)-[:CHILD_OF]->(nadia);

MATCH (otto:Person {name: "Otto"}), (rob:Person {name: "Rob"})
MERGE (rob)-[:CHILD_OF]->(otto);

MATCH (stella:Person {name: "Stella"}), (tijs:Person {name: "Tijs"})
MERGE (tijs)-[:CHILD_OF]->(stella);

MATCH (tijs:Person {name: "Tijs"}), (ursula:Person {name: "Ursula"})
MERGE (ursula)-[:CHILD_OF]->(tijs);

MATCH (tijs:Person {name: "Tijs"}), (vic:Person {name: "Vic"})
MERGE (vic)-[:CHILD_OF]->(tijs);

MATCH (vic:Person {name: "Vic"}), (willem:Person {name: "Willem"})
MERGE (willem)-[:CHILD_OF]->(vic);

MATCH (vic:Person {name: "Vic"}), (yuri:Person {name: "Yuri"})
MERGE (yuri)-[:CHILD_OF]->(vic);

MATCH (cynthia:Person {name: "Cynthia"}), (giri:Person {name: "Giri"})
MERGE (giri)-[:CHILD_OF]->(cynthia);

MATCH (cynthia:Person {name: "Cynthia"}), (faye:Person {name: "Faye"})
MERGE (faye)-[:CHILD_OF]->(cynthia);
