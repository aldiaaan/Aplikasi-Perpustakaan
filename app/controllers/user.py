from core.controller import Controller
from models.user import User as UserModel
from utils.utils import decode_dict

class _User(Controller):
    def __init__(self, model):
        super().__init__(model)
    
    def register_user(self, user):
        self._model.insert(user)
    
    def get_user(self, id):
        return decode_dict(self._model.get_hash(id))

    def auth_user(self, user_context):                       
        users = self._model.where(user_context, 'and', strict=True)
        if (len(users)) > 0:
            return (True, users[0])
        else:
            return (False, None)    

    def delete_user(self, query):
        self._model.delete(query)

    def search_user(self, query, logical='or'):
        return self._model.where(query, logical)
    
    def update_user(self, user):
        self._model.update(user)

UserController = _User(UserModel)