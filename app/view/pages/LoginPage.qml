import '../components'

import QtQuick 2.4
import QtQuick.Controls 2.14
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Layouts 1.14
import QtGraphicalEffects 1.12

Page {
  id: admin_form
  width: Screen.width
  height: Screen.height

  Connections {
    target: LoginProps
    onLoginCompleted: {  
      let _user = user[0]
      if (success && _user.role=== 'admin') {
        main_view.push('AdminPage.qml')
        login_failed.text = ''
      } else {
        login_failed.text = 'Unknown credential'
      }
    }
  }

  Image {
    source: '../assets/login_background.jpeg'
    fillMode: Image.PreserveAspectCrop     
    width: parent.width
  }
  Rectangle {
    id: control
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    width: 400
    layer.enabled: true
    layer.effect: ElevationEffect {
      elevation: 32
    }    
    ColumnLayout {
      width: control.width      
      height: control.height            
      ColumnLayout {
        Text {
          Layout.leftMargin: 18
          Layout.rightMargin: 22
          font.pointSize: 24
          Layout.bottomMargin: 52
          text: qsTr('Perpus')
        }
        Text {
          Layout.leftMargin: 18
          color: Qt.rgba(0, 0, 0, 0.54)
          text: qsTr('Username ')
          font.pointSize: 10
        }
        TextField {
          id: username
          Layout.leftMargin: 18
          Layout.rightMargin: 22
          Layout.fillWidth: true      
          Layout.bottomMargin: 22   
          placeholderText: 'Username'
        }
        Text {
          Layout.leftMargin: 18          
          text: qsTr('Password ')
          font.pointSize: 10          
          color: Qt.rgba(0, 0, 0, 0.54)          
        }
        TextField {
          id: password
          Layout.fillWidth: true    
          Layout.leftMargin: 18
          Layout.rightMargin: 22      
          Layout.bottomMargin: 32    
          echoMode: TextInput.Password 
          placeholderText: 'Password'
        }

        RowLayout {    
          Layout.leftMargin: 18          
          Layout.rightMargin: 22      
          Text {
            MouseArea {
              id: ma
              onPressed: {
                main_view.push('GuestPage.qml')
              }
              anchors.fill: parent
              hoverEnabled: true              
            }
            Layout.fillWidth: true
            font.pointSize: 10
            color: ma.containsMouse ? '#2196F3' : '#a0aec0'
            text: qsTr('<<< Guest View')            
          }
          Button {                      
            Layout.alignment: Qt.AlignRight
            Material.accent: Material.Blue
            Layout.preferredWidth: 80
            highlighted: true
            text: qsTr('LOGIN')
            onClicked: {              
              LoginProps.login(username.text, password.text)
            }
          }
        }                
        Text {
          id: login_failed          
          Layout.leftMargin: 18  
          Layout.rightMargin: 22  
          Layout.fillWidth: true 
          Layout.topMargin: 22
          visible: true
          color: Material.color(Material.Red)   
          text: ''       
        } 
      }
    }        
  }
}