from core.model import Model

class User(Model):
    def __init__(self, id_digits=4):
        super().__init__(id_digits=id_digits)