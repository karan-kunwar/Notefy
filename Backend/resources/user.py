from flask_restful import Resource
 
class user(Resource):
    def get(self):
        return {"message": "Hello, karan!"}
    def post(self):
        return {"message": "Hello, World!"}