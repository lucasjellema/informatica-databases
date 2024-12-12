MATCH (n)
DETACH DELETE n;

// Create person nodes
CREATE (:Person {name: "Alice"});
CREATE (:Person {name: "Bob"});
CREATE (:Person {name: "Carol"});

// Create movie nodes
CREATE (:Movie {title: "Inception"});
CREATE (:Movie {title: "The Matrix"});
CREATE (:Movie {title: "Interstellar"});
CREATE (:Movie {title: "The Shawshank Redemption"});
CREATE (:Movie {title: "The Dark Knight"});

// Create relationships
MATCH (p:Person {name: "Alice"}), (m:Movie)
WHERE m.title IN ["Inception"]
CREATE (p)-[:LOVES]->(m);

MATCH (p:Person {name: "Bob"}), (m:Movie)
WHERE m.title IN ["Interstellar", "Inception"]
CREATE (p)-[:LOVES]->(m);

MATCH (p:Person {name: "Carol"}), (m:Movie)
WHERE m.title IN ["The Shawshank Redemption", "The Matrix", "Interstellar"]
CREATE (p)-[:LOVES]->(m);


