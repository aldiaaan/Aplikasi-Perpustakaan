from PyQt5.QtCore import QObject, pyqtSlot as Slot, pyqtSignal as Signal
from config.app_config import OVERDUE_FINES
from controllers.book import BookController
from controllers.borrower import BorrowerController
from controllers.user import UserController
from datetime import timedelta, date, datetime
import datetime as dt

class _AdminProps(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.last_query = {}
        self.borrower_query = {}
        self.member_query = {}
    
    def main_refresh(self):
        self.book_refresh()
        # self.borrower_refresh()

    #################################################
    ###             ADMIN MEMBER TABS             ###
    #################################################

    # SIGNAL
    searchMembersCompleted = Signal(list, arguments=['members'])

    # SLOT
    @Slot()
    @Slot(str, str)
    def search_members(self, search_by='fullname', argument=''):
        # print({search_by: argument})
        members = UserController.search_user({search_by: argument})  
        self.member_query = {search_by: argument}
        self.searchMembersCompleted.emit(members)
    
    @Slot(str, str, str, str, str, str)
    @Slot(str, str, str, str, str, str, str)    
    def create_member(self, fullname, username, password, profile_picture, phone, address,role='guest'):
        new_member = {
            'fullname': fullname,
            'username': username,
            'password': password,
            'address': address,
            'profile_picture': profile_picture,
            'phone': phone,
            'role': role
        }        
        UserController.register_user(new_member)
        self.refresh_members()

    @Slot(str, str, str, str, str, str, str)
    @Slot(str, str, str, str, str, str, str, str)    
    def update_member(self, _id, fullname, username, password, profile_picture, phone, address, role='guest'):
        new_member = {
            '_id': _id,
            'fullname': fullname,
            'username': username,
            'password': password,
            'address': address,
            'profile_picture': profile_picture,
            'phone': phone,
            'role': role
        }                
        UserController.update_user(new_member)
        self.refresh_members()

    @Slot(str)
    def delete_member(self, member_id):
        UserController.delete_user({'_id': member_id})   
        borrowers = BorrowerController.search_borrower({'user_id': member_id})
        for borrower in borrowers:
            print(borrower['_id'])
            print('--------')
            BorrowerController.delete_borrower({'_id': borrower['_id']})
        self.refresh_borrower()
        self.refresh_members()
        self.book_refresh()

    def refresh_members(self):
        members = UserController.search_user(self.member_query)
        self.searchMembersCompleted.emit(members)

    
    #################################################
    ###            ADMIN BORROWER TABS            ###
    #################################################

    # SIGNAL
    searchBorrowersCompleted = Signal(list, arguments=['borrowers'])
    searchLateBorrowersCompleted = Signal(list, arguments=['late_borrowers'])

    # SLOT
    @Slot()
    @Slot(str, str)
    def search_borrower(self, search_by='title', argument=''):                  
        _borrowers = BorrowerController.search_borrower({})   
        self.borrower_query = {'search_by':search_by, 'argument': argument}
        borrowers = []
        for borrower in _borrowers:
            book = BookController.get_book(borrower['book_id'])
            user = UserController.get_user(borrower['user_id'])             
            if (search_by == 'title' and argument.lower() not in book['title'].lower()) or (search_by == 'fullname' and argument.lower() not in user['fullname'].lower()):
                continue
            borrower['title'] = book['title']
            borrower['profile_picture'] = user['profile_picture']
            borrower['fullname'] = user['fullname']            
            borrowers.append(borrower)        
        self.searchBorrowersCompleted.emit(borrowers)
        self.search_late_borrower()   

    @Slot()
    def search_late_borrower(self):
        borrowers = BorrowerController.search_late()             
        for borrower in borrowers:
            book = BookController.get_book(borrower['book_id'])
            user = UserController.get_user(borrower['user_id'])  
            d1 = datetime.strptime(borrower['return_at'], '%Y-%m-%d').date()
            d2 = date.today()
            delta = (d2 - d1).days
            borrower['penalty'] = (delta / 7) * OVERDUE_FINES            
            borrower['title'] = book['title']
            borrower['profile_picture'] = user['profile_picture']
            borrower['fullname'] = user['fullname']                    
        self.searchLateBorrowersCompleted.emit(borrowers)

    @Slot()
    @Slot(str)
    def delete_borrower(self, borrower_id):
        BorrowerController.delete_borrower({'_id': borrower_id})
        self.refresh_borrower()
        self.search_late_borrower()           

    def refresh_borrower(self):
        self.search_borrower(self.borrower_query['search_by'], self.borrower_query['argument'])

    #################################################
    ###             ADMIN BOOK TABS               ###
    #################################################

    # SIGNAL
    searchBookCompleted = Signal(list, arguments=['books'])

    # SLOT
    @Slot()
    @Slot(str, str)
    def search_book(self, search_by='title', argument=''):
        query = {search_by: argument}
        
        books = BookController.search_book(query, show_zero_stock=True)        
        self.last_query = query
        self.searchBookCompleted.emit(books)

    # YOU CANT PASS JS OBJECT AS PYTHON DICT, PASSING THE KEY VALUE INSTEAD
    @Slot(str, str, str, str, str, str, str, str, str, str, list)
    def update_book(self, _id, title, cover, author, location, isbn, description, publisher, pages, stock, genres):                
        new_book = {
            '_id': _id,
            'title': title,
            'author': author,
            'pages': pages,
            'location': location,
            'isbn': isbn,
            'description': description,
            'publisher': publisher,
            'stock': stock,
            'cover': cover,
            'genres': " ".join(genres)
        }
        BookController.update_book(new_book)
        self.book_refresh()

    @Slot(str, str, str, str, str, str, str, str, str, list)
    def create_book(self, title, cover, author, location, isbn, description, publisher, pages, stock, genres):        
        new_book = {
            'title': title,
            'author': author,
            'pages': pages,
            'location': location,
            'isbn': isbn,
            'description': description,
            'publisher': publisher,
            'stock': stock,
            'cover': cover,
            'genres': " ".join(genres)  
        }        
        BookController.add_book(new_book)
        self.book_refresh()    

    @Slot(str)
    def delete_book(self, _id):
        BookController.remove_book({'_id': _id})
        self.book_refresh()

    def book_refresh(self):
        books = BookController.search_book(self.last_query, show_zero_stock=True)
        self.searchBookCompleted.emit(books)

AdminProps = _AdminProps()