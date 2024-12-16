MATCH (n)
DETACH DELETE n;

// Create the landmasses (nodes)
CREATE (:Landmass {name: 'A'}),
       (:Landmass {name: 'B'}),
       (:Landmass {name: 'C'}),
       (:Landmass {name: 'D'});

// Create the bridges (edges)
MATCH (a:Landmass {name: 'A'}), (b:Landmass {name: 'B'}), (c:Landmass {name: 'C'}), (d:Landmass {name: 'D'})
CREATE (a)-[:BRIDGE{naam:"br1"}]->(b),
       (a)-[:BRIDGE{naam:"br2"}]->(b),
       (a)-[:BRIDGE{naam:"br3"}]->(c),
       (a)-[:BRIDGE{naam:"br4"}]->(c),
       (a)-[:BRIDGE{naam:"br5"}]->(d),
       (b)-[:BRIDGE{naam:"br6"}]->(d),
       (c)-[:BRIDGE{naam:"br7"}]->(d);

// maak ook de omgekeerde verbindingen aangezien iedere brug in twee richtingen kan worden gelopen
MATCH (a)-[r:BRIDGE]->(b)
MERGE (b)-[:BRIDGE {naam: r.naam}]->(a);