from PyQt5.QtCore import QObject, pyqtSlot as Slot, pyqtSignal as Signal
from controllers.user import UserController

class _LoginProps(QObject):
    def __init__(self):
        QObject.__init__(self)
    
    # SIGNAL
    loginCompleted = Signal(bool, list, arguments=['success', 'user'])

    # SLOT
    @Slot(str, str)
    def login(self, username, password):
        (success, user) = UserController.auth_user({'username': username, 'password': password})     
        # tidak bisa mengirim dict langsung ke qml, harus dimasukin list dulu baru mau         
        self.loginCompleted.emit(success, [user])     
    
LoginProps = _LoginProps()