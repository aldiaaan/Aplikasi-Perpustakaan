import '../components'
import '../components/admin'

import QtQuick 2.4
import QtQuick.Controls 2.14
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Layouts 1.14
import QtGraphicalEffects 1.12
import QtQuick.Dialogs 1.0
import Qt.labs.calendar 1.0


Popup {  
  property string mode: ''
  property string _id: ''
  property string fullname: ''
  property string username: ''
  property string password: ''
  property string phone: ''
  property string address: ''
  property string role: ''
  property string profile_picture: '../assets/placeholder.jpg'
  

  id: control
  FileDialog {
    id: file_dialog
    title: "Upload Book Cover"
    folder: shortcuts.home
    onAccepted: {                                 
      preview.source = file_dialog.fileUrl
    }
  }

  onAboutToShow: {    
    // Force reload
    if (control.mode === 'update') {      
      preview.source = profile_picture
    }
  }

  width: 800  
  modal: true
  focus: true 
  closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
  y: Math.round((Screen.height - height) / 2)
  x: Math.round((Screen.width - width) / 2)
  anchors.centerIn: Overlay.overlay
  RowLayout {                   
    anchors.fill: parent
    ColumnLayout {
      // top margin to prevent weird border at top
      Layout.topMargin: 2 
      Layout.preferredWidth: 240
      Layout.maximumWidth: 240
      Layout.alignment: Qt.AlignTop  
      Image {            
        id: preview
        Layout.alignment: Qt.AlignTop                     
        Layout.preferredHeight: 300 
        Layout.fillWidth: true
        source: profile_picture               
      }
      Button {
        text: qsTr('UPLOAD PHOTO')                      
        Layout.fillWidth: true   
        onClicked: {
          file_dialog.visible = true
        }  
      }       
      Text {
        color: Qt.rgba(0, 0, 0, 0.54)
        font.pixelSize: 12
        text: qsTr('*photo size is 240x300')
      }   
    }
    
    ColumnLayout {
      Layout.fillWidth: true           
      ColumnLayout {   
        Layout.leftMargin: 8  
        Layout.rightMargin: 4  
        Layout.topMargin: 4
        Layout.alignment: Qt.AlignTop      
        RowLayout {
          Layout.bottomMargin: 4
          Layout.fillWidth: true                            
          ColumnLayout {
            Layout.preferredWidth: 500
            Layout.fillWidth: true
            Layout.bottomMargin: 4
            Text {
              color: Qt.rgba(0, 0, 0, 0.54)
              font.pixelSize: 12
              text: qsTr('Name')
              font.weight: Font.ExtraLight
              Layout.bottomMargin: -5
            }
            TextField {
              id: fullname_field
              Layout.fillWidth: true  
              text: fullname
              placeholderTextColor: Qt.rgba(0, 0, 0, 0.54)          
              placeholderText: qsTr('Full Name')
            }
          }
          // ColumnLayout {
          //   Layout.leftMargin: 8
          //   Text {
          //     color: Qt.rgba(0, 0, 0, 0.54)
          //     font.pixelSize: 12
          //     text: qsTr('Umur')
          //     font.weight: Font.ExtraLight
          //     Layout.bottomMargin: -5
          //   }
          //   TextField {                               
          //     placeholderTextColor: Qt.rgba(0, 0, 0, 0.54)          
          //     placeholderText: qsTr('Umur')
          //   }
          // }            
        }
        RowLayout {
          Layout.bottomMargin: 4
          Layout.fillWidth: true
          ColumnLayout {
            Text {            
              color: Qt.rgba(0, 0, 0, 0.54)
              font.pixelSize: 12
              text: qsTr('Username')
              font.weight: Font.ExtraLight
              Layout.bottomMargin: -5
            }
            TextField {
              id: username_field
              Layout.fillWidth: true  
              text: username
              placeholderTextColor: Qt.rgba(0, 0, 0, 0.54)          
              placeholderText: qsTr('Username')
            }
          } 
          ColumnLayout {
            Layout.leftMargin: 8
            Text {
              color: Qt.rgba(0, 0, 0, 0.54)
              font.pixelSize: 12
              text: qsTr('Password')
              font.weight: Font.ExtraLight
              Layout.bottomMargin: -5
            }
            TextField {     
              id: password_field
              Layout.fillWidth: true  
              text: password
              // echoMode: TextInput.Password          
              placeholderTextColor: Qt.rgba(0, 0, 0, 0.54)          
              placeholderText: qsTr('Password')
            }
          }            
        }
        RowLayout {
          Layout.bottomMargin: 4
          Layout.fillWidth: true
          ColumnLayout {
            Text {
              color: Qt.rgba(0, 0, 0, 0.54)
              font.pixelSize: 12
              text: qsTr('Alamat')
              font.weight: Font.ExtraLight
              Layout.bottomMargin: -5
            }
            TextField {
              id: address_field
              Layout.fillWidth: true  
              text: address
              placeholderTextColor: Qt.rgba(0, 0, 0, 0.54)          
              placeholderText: qsTr('Alamat')
            }
          } 
          ColumnLayout {
            Layout.leftMargin: 8
            Text {
              color: Qt.rgba(0, 0, 0, 0.54)
              font.pixelSize: 12
              text: qsTr('No. Telepon')
              font.weight: Font.ExtraLight
              Layout.bottomMargin: -5
            }
            TextField {     
              Layout.fillWidth: true  
              id: phone_field          
              text: phone
              placeholderTextColor: Qt.rgba(0, 0, 0, 0.54)          
              placeholderText: qsTr('No. Telepon')
            }
          }            
        }      
      }
      ColumnLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true        
      } 
      Button {
        Layout.alignment: Qt.AlignRight
        highlighted: true   
        Material.accent: Material.Green          
        text: mode === 'update' ? qsTr('UPDATE MEMBER') : qsTr('ADD MEMBER')
        onClicked: {
          if (mode !== 'update') {
            AdminProps.create_member(fullname_field.text, username_field.text, password_field.text, preview.source, phone_field.text, address_field.text)
          } else {            
            AdminProps.update_member(_id, fullname_field.text, username_field.text, password_field.text, preview.source, phone_field.text, address_field.text, role)
          }          
          control.close()
        }   
      }
    }       
  }
} 