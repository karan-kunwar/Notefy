from flask import Flask, request, jsonify
from app import db, ma, app
from register_model import product_schema_register, products_schema_register, Register
import os
import random
import string


def generate_key():
    return ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(40))
##POST
@app.route('/register',methods = ['POST'])
def register_user():
    values = request.get_json(force=True)
    api_key = generate_key()
    username= values['username']
    email = values['email']
    firstname = values['firstname']
    lastname = values['lastname']
    password = values['password']

    new_user = Register(api_key, username, email, firstname,lastname, password)
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

##Adding Deleting
@app.route('/register/<id>',methods = ['DELETE'])
def delete_user(id):
    user = Register.query.get(id)
    db.session.delete(user)
    db.session.commit()
    return product_schema_register.jsonify(user)

##GET Single User
@app.route('/signin',methods = ['POST'])
def signin_user():
    values = request.get_json(force=True)
    password = values['password']
    user = Register.query.filter_by(username=values['username']).first()
    if user:
        if (user.password == password):
            return product_schema_register.jsonify(user)
        else:
            return {'message':'Password is incorrect'}, 400
    else:
        return {'message':"Username doesn't exist"}, 400

if __name__ == '__main__':
    app.run(debug=True)