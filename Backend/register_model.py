from app import db, ma

class Register(db.Model):
    id = db.Column(db.Integer,primary_key = True)
    username = db.Column(db.String(50),unique= True)
    email = db.Column(db.String(40), unique= True)
    firstname = db.Column(db.String(40))
    lastname = db.Column(db.String(40))
    password = db.Column(db.String(60))

    def __init__(self, username, email, firstname,lastname, password):
        self.username = username
        self.email = email
        self.firstname = firstname
        self.lastname = lastname
        self.password = password  
        
#Product Schema
class ProductSchemaRegister(ma.Schema):
    class Meta:
        fields= ('id', 'username', 'email', 'firstname','lastname', 'password')

#Init Schema
product_schema_register= ProductSchemaRegister()
products_schema_register= ProductSchemaRegister(many= True)