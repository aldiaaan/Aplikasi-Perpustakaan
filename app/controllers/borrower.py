from core.controller import Controller
from models.borrower import Borrower as BorrowerModel
from controllers.user import UserController
from controllers.book import BookController
from datetime import timedelta, date, datetime
import datetime as dt
# from utils import decode_dict

class _Borrower(Controller):
    def __init__(self, model):
        super().__init__(model)

    def add_borrower(self, context):
        # print(context)
        if UserController.is_exist(context['user_id']) and BookController.is_exist(context['book_id']):
            context['borrowed_at'] = str(date.today())
            context['return_at'] = str(date.today() + timedelta(days=7))
            book = BookController.search_book({'_id': context['book_id']})[0]                        
            book['stock'] = int(book['stock']) - 1
            BookController.update_book(book)
            self._model.insert(context)
        else:
            print('user_id or book_id doesnt exist, failed to create...')
    
    def _is_late(self, return_at):
        return datetime.strptime(return_at, '%Y-%m-%d').date() < date.today()

    def delete_borrower(self, query):
        borrower = self._model.where(query)[0]
        book_id = borrower['book_id']        
        book = BookController.search_book({'_id': book_id})[0]   
        book['stock'] = int(book['stock']) + 1
        BookController.update_book(book)
        self._model.delete(query)

    def search_borrower(self, query):
        return self._model.where(query)

    def search_late(self):        
        return self._model.where({'return_at': self._is_late})        

BorrowerController = _Borrower(BorrowerModel)
