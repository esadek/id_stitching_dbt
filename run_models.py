from os import system
from sqlalchemy import create_engine


db = create_engine("dialect+driver://username:password@host:port/database")

system("dbt run --exclude check_edges; dbt compile --select check_edges")

with open("target/compiled/id_stitching/models/check_edges.sql") as file:
    query = file.read()

while db.execute(query).first()["count"]:
    system("dbt run --select id_graph")
