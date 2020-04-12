import sys
import os
import signal

from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine

from props.login import LoginProps
from props.admin import AdminProps
from props.guest import GuestProps

os.environ['QT_QUICK_CONTROLS_STYLE'] = 'Material'

def start():
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()

    app.setOrganizationName('Aldian A')
    app.setOrganizationDomain('Perpustakaan')    

    engine.rootContext().setContextProperty('AdminProps', AdminProps)
    engine.rootContext().setContextProperty('LoginProps', LoginProps)
    engine.rootContext().setContextProperty('GuestProps', GuestProps)

    engine.load('view/main.qml')    
    engine.quit.connect(app.quit)

    signal.signal(signal.SIGINT, signal.SIG_DFL)    
    sys.exit(app.exec_())

if __name__ == '__main__':
    start()
