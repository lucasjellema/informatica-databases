MATCH (n)
DETACH DELETE n;

MERGE (UC:Station {name: "UC"});
MERGE (UO:Station {name: "UO"});
MERGE (BH:Station {name: "BH"});
MERGE (DD:Station {name: "DD"});
MERGE (SZ:Station {name: "SZ"});
MERGE (S:Station {name: "S"});
MERGE (SD:Station {name: "SD"});
MERGE (B:Station {name: "B"});
MERGE (A:Station {name: "A"});
MERGE (HS:Station {name: "HS"});
MERGE (H:Station {name: "H"});

MATCH (UC:Station {name: "UC"}), (UO:Station {name: "UO"})
MERGE (UC)-[:spoor {reistijd: 4}]->(UO);

MATCH (UO:Station {name: "UO"}), (BH:Station {name: "BH"})
MERGE (UO)-[:spoor {reistijd: 5}]->(BH);

MATCH (BH:Station {name: "BH"}), (DD:Station {name: "DD"})
MERGE (BH)-[:spoor {reistijd: 3}]->(DD);

MATCH (DD:Station {name: "DD"}), (SZ:Station {name: "SZ"})
MERGE (DD)-[:spoor {reistijd: 6}]->(SZ);

MATCH (SZ:Station {name: "SZ"}), (S:Station {name: "S"})
MERGE (SZ)-[:spoor {reistijd: 2}]->(S);

MATCH (S:Station {name: "S"}), (SD:Station {name: "SD"})
MERGE (S)-[:spoor {reistijd: 3}]->(SD);

MATCH (SD:Station {name: "SD"}), (B:Station {name: "B"})
MERGE (SD)-[:spoor {reistijd: 4}]->(B);

MATCH (UC:Station {name: "UC"}), (A:Station {name: "A"})
MERGE (UC)-[:spoor {reistijd: 13}]->(A);

MATCH (DD:Station {name: "DD"}), (A:Station {name: "A"})
MERGE (DD)-[:spoor {reistijd: 7}]->(A);

MATCH (UO:Station {name: "UO"}), (HS:Station {name: "HS"})
MERGE (UO)-[:spoor {reistijd: 10}]->(HS);

MATCH (B:Station {name: "B"}), (H:Station {name: "H"})
MERGE (B)-[:spoor {reistijd: 5}]->(H);

MATCH (A:Station {name: "A"}), (H:Station {name: "H"})
MERGE (A)-[:spoor {reistijd: 12}]->(H);

MATCH (HS:Station {name: "HS"}), (H:Station {name: "H"})
MERGE (HS)-[:spoor {reistijd: 3}]->(H);

// create the reverse connections - every spoor is bidirectional
MATCH (a)-[r:spoor]->(b)
MERGE (b)-[:spoor {reistijd: r.reistijd}]->(a);
