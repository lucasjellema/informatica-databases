MATCH (n)
DETACH DELETE n;

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

