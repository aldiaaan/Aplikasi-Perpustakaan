from controllers.user import UserController
from controllers.book import BookController
from controllers.borrower import BorrowerController

def book_seed():    
    BookController.add_book({'author': 'Mark Sullivan', 'pages': '523', 'stock': '5', 'isbn': '978-1503943377', 'genres': 'History Fiction', 'location': 'Lt.4R2', 'title': 'Beneath a Scarlet Sky: A Novel', 'publisher': 'Lake Union Publishing', 'cover': '../assets/book-1.jpg', 'description': 'Pino Lella wants nothing to do with the war or the Nazis. He\xe2\x80\x99s a normal Italian teenager\xe2\x80\x94obsessed with music, food, and girls\xe2\x80\x94but his days of innocence are numbered. When his family home in Milan is destroyed by Allied bombs, Pino joins an underground railroad helping Jews escape over the Alps, and falls for Anna, a beautiful widow six years his senior.\r\n\r\nIn an attempt to protect him, Pino\xe2\x80\x99s parents force him to enlist as a German soldier\xe2\x80\x94a move they think will keep him out of combat. But after Pino is injured, he is recruited at the tender age of eighteen to become the personal driver for Adolf Hitler\xe2\x80\x99s left hand in Italy, General Hans Leyers, one of the Third Reich\xe2\x80\x99s most mysterious and powerful commanders.\r\n\r\nNow, with the opportunity to spy for the Allies inside the German High Command, Pino endures the horrors of the war and the Nazi occupation by fighting in secret, his courage bolstered by his love for Anna and for the life he dreams they will one day share.\r\n\r\nFans of All the Light We Cannot See, The Nightingale, and Unbroken will enjoy this riveting saga of history, suspense, and love.'})    
    BookController.add_book({'author': 'Lucinda Berry', 'pages': '293', 'stock': '9', 'isbn': '1542092922', 'genres': 'Psychological Horror Thriller', 'location': 'Lt.2R1', 'title': 'When She Returned', 'publisher': 'Thomas & Mercer', 'cover': '../assets/book-2.jpg', 'description': 'Kate Bennett vanished from a parking lot eleven years ago, leaving behind her husband and young daughter. When she shows up at a Montana gas station, clutching an infant and screaming for help, investigators believe she may have been abducted by a cult.\r\n\r\nKate\xe2\x80\x99s return flips her family\xe2\x80\x99s world upside down\xe2\x80\x94her husband is remarried, and her daughter barely remembers her. Kate herself doesn\xe2\x80\x99t look or act like she did before.\r\n\r\nWhile the family tries to help Kate reintegrate into society, they discover truths they\xe2\x80\x99ve been hiding from each other about their own relationships. But they aren\xe2\x80\x99t the only ones with secrets. As the family unravels what happened to Kate, a series of shocking revelations shows that Kate\xe2\x80\x99s return is more sinister than any of them could have imagined.'})    
    print('book seed done')

def user_seed():
    UserController.register_user({'phone': '082102080', 'address':'Jl.Pisang', 'profile_picture': '../assets/pasfoto-1.jpg', 'fullname': 'Hadi Yahya', 'username':'hadi', 'password': 'hadi99', 'role': 'admin'})
    UserController.register_user({'phone': '0821013123', 'address':'Jl.Manggis', 'profile_picture': '../assets/pasfoto-2.jpg', 'fullname': 'Aditya Hagi','username':'hagi', 'password': 'hagi99',  'role': 'guest'})
    UserController.register_user({'phone': '21312302080', 'address':'Jl.Kedondong', 'profile_picture': '../assets/pasfoto-3.jpg', 'fullname': 'Dinda A.','username':'dinda', 'password': 'dinda99',  'role': 'guest'})
    UserController.register_user({'phone': '0821123080', 'address':'Jl.Tomat', 'profile_picture': '../assets/pasfoto-4.jpg', 'fullname': 'Budi Baskoro','username':'budi', 'password': 'budi77',  'role': 'guest'})
    UserController.register_user({'phone': '0821123080', 'address':'Jl.Tomat', 'profile_picture': '../assets/pasfoto-5.jpg', 'fullname': 'Rania Putri','username':'rania', 'password': 'rania99',  'role': 'guest'})
    UserController.register_user({'phone': '0821123080', 'address':'Jl.Tomat', 'profile_picture': '../assets/pasfoto-6.png', 'fullname': 'Deva Alviana','username':'deva', 'password': 'deva99',  'role': 'guest'})
    UserController.register_user({'phone': '23213123', 'address':'Jl.Nangka', 'profile_picture': '../assets/pasfoto-7.jpg', 'fullname': 'Putri A.','username':'putri', 'password': 'putri99', 'role': 'guest'})

    print('user seed done')

def borrower_seed():    
    BorrowerController.add_borrower({'book_id': 'book_0000', 'user_id': 'user_0003', 'borrowed_at': '2020-03-02', 'return_at': '2020-03-09'})
    BorrowerController.add_borrower({'book_id': 'book_0001', 'user_id': 'user_0002', 'borrowed_at': '2020-03-05', 'return_at': '2020-03-12'})
    BorrowerController.add_borrower({'book_id': 'book_0000', 'user_id': 'user_0002', 'borrowed_at': '2020-03-05', 'return_at': '2020-03-12'})
    print('borrower seed done')

book_seed()
user_seed()
# borrower_seed()
