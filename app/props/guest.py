from PyQt5.QtCore import QObject, pyqtSlot as Slot, pyqtSignal as Signal

from controllers.user import UserController
from controllers.book import BookController
from controllers.borrower import BorrowerController

class _GuestProps(QObject):
    def __init__(self):
        QObject.__init__(self)

    # SIGNAL
    searchCompleted = Signal(list, arguments=['books'])
    loginGuestCompleted = Signal(bool, list, arguments=[
        'success', 'user'])

    # SLOT
    @Slot()
    @Slot(str, str)
    def search_book(self, search_by='title', argument=''):
        query = {search_by: argument}
        books = BookController.search_book(query, logical='and', show_zero_stock=False)        
        self.searchCompleted.emit(books)

    @Slot()
    @Slot(str, str)
    def login_guest(self, username, password):
        (success, user) = UserController.auth_user({'username': username, 'password': password})         
        self.loginGuestCompleted.emit(success, [user])

    @Slot(str, str, str, str, str)
    def borrow(self, user_id, fullname, profile_picture, book_id, title):                
        # BorrowerController.add_borrower({'user_id': user_id, 'profile_picture': profile_picture, 'fullname': fullname, 'book_id': book_id, 'title': title})
        BorrowerController.add_borrower({'user_id': user_id, 'book_id': book_id})

GuestProps = _GuestProps()