import './pages'

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Window 2.12

ApplicationWindow {
  id: main_window  
  Material.theme: Material.Light
  Material.accent: Material.Blue 

  title: 'Aplikasi Perpustakaan'  
  visible: true    
  width: Screen.width
  height: Screen.height   

  StackView {
    id: main_view
    initialItem: LoginPage {}
    anchors.fill: parent
  }
}