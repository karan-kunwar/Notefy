from flask import Flask, request, jsonify
from app import db, ma, app
from register_model import product_schema_register, products_schema_register, Register
import os

##POST
@app.route('/register',methods = ['POST'])
def register_user():
    username= request.json['username']
    email = request.json['email']
    firstname = request.json['firstname']
    lastname = request.json['lastname']
    password = request.json['password']

    new_user = Register(username, email, firstname,lastname, password)
    db.session.add(new_user)
    db.session.commit()
    return product_schema_register.jsonify(new_user)

##GET All 
@app.route('/register', methods = ['GET'])
def get_users():
    all_users = Register.query.all()
    result = products_schema_register.dump(all_users)
    return jsonify(result)

##GET Single User
@app.route('/register/<id>',methods = ['GET'])
def get_user(id):
    user = Register.query.get(id)
    return product_schema_register.jsonify(user)

if __name__ == '__main__':
    app.run(debug=True)