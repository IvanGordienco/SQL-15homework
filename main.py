import sqlite3
import json
from flask import Flask, jsonify
from function import connection_to_database

app = Flask(__name__)

@app.route('/animals/<ix>')
def get_animals_by_id(ix):
    connection = sqlite3.connect("animal.db")
    cursor = connection.cursor()
    query = f"""
                SELECT * 
                FROM animal_fin
                LEFT JOIN outcomes on outcomes.animal_id=animal_fin.animal_id
                WHERE animal_fin.id = {ix} 
    """
    cursor.execute(query)
    result = cursor.fetchmany()
    connection.close()

    if len(result) == 1:
        row = result[0]

        animals = {
            "age_upon_outcome": row[0],
            "animal_id": row[1],
            "type_id": row[2],
            "name": row[3],
            "breed_id": row[4],
            "date_of_birth": row[5],
            "outcome_id": row[6],
            "id": row[7],
            "outcome_subtype": row[8],
            "outcome_type": row[9],
            "outcome_month": row[10],
            "outcome_year": row[11]

        }
    else:
        animals = {}
    return jsonify(animals)


# @app.route('/animal/<id>')
# def animal(id):
#     query = f"""
#                 SELECT *
#                 FROM animal_fin
#                 LEFT JOIN outcomes on outcomes.animal_id=animal_fin.animal_id
#                 WHERE animal_fin.id = {id}
#     """
#     result = connection_to_database(query, "animal.db")
#     return jsonify(result)
#
#
# app.run(debug=True)
