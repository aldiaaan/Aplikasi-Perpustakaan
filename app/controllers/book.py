from core.controller import Controller
from models.book import Book as BookModel
from utils.utils import decode_dict

class _Book(Controller):
    def __init__(self, model):
        super().__init__(model)

    def add_book(self, book):
        self._model.insert(book)

    def get_book(self, id):
        return decode_dict(self._model.get_hash(id))

    def remove_book(self, query):        
        self._model.delete(query)
    
    def search_book(self, query, logical='or', strict=False, show_zero_stock=False):
        if not show_zero_stock:
            query['stock'] = lambda stock: int(stock) > 0                   
        return self._model.where(query, logical=logical, strict=strict)
    
    def update_book(self, book):
        self._model.update(book)

BookController = _Book(BookModel)