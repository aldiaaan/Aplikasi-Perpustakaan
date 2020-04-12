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

Popup {  
  width: 800  
  modal: true
  focus: true 
  closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
  y: Math.round((Screen.height - height) / 2)
  x: Math.round((Screen.width - width) / 2)
  anchors.centerIn: Overlay.overlay 

  property string _id
  property string title
  property string cover
  property string author
  property string stock
  property string publisher
  property string description
  property string isbn
  property string location
  property string pages
  property string genres: ''
  property variant _genres: genres.split(' ')

  RowLayout {                   
    anchors.fill: parent
    ColumnLayout {
      // top margin to prevent weird border at top
      Layout.topMargin: 2 
      Layout.preferredWidth: 240
      Layout.maximumWidth: 240
      Layout.minimumWidth: 240
      Layout.alignment: Qt.AlignTop  
      Image {            
        id: preview
        Layout.alignment: Qt.AlignTop                     
        Layout.preferredHeight: 300 
        Layout.fillWidth: true
        source: cover
      }
      Button {
        text: qsTr('Borrow')              
        highlighted: true   
        Layout.fillWidth: true           
        Material.accent: Material.Blue  
        onClicked: {
          borrow_book.open()
        }  
      }       
      Text {
        color: Qt.rgba(0, 0, 0, 0.54)
        font.pixelSize: 12
        text: qsTr('*cover size is 240x300')
      }   
    }  
    ColumnLayout {
      Layout.leftMargin: 8
      Layout.topMargin: 4
      Layout.alignment: Qt.AlignTop
      RowLayout {        
        Layout.bottomMargin: 4
        Layout.fillWidth: true        
        Text {
          Layout.alignment: Qt.AlignTop
          Layout.preferredWidth: 100
          text: qsTr('Title')
        }
        Text {
          Layout.alignment: Qt.AlignTop
          text: qsTr(': ')
        }
        Text {
          Layout.fillWidth: true     
          text: title
          elide: Text.ElideRight
          Layout.maximumHeight: 16 * 4       
          wrapMode: Text.Wrap
          lineHeight: 1.25
        }
      }
      RowLayout {        
        Layout.topMargin: -4
        Layout.bottomMargin: 4
        Layout.fillWidth: true        
        Text {
          Layout.preferredWidth: 100
          text: qsTr('Author')
        }
        Text {
          Layout.alignment: Qt.AlignTop
          text: qsTr(': ')
        }
        Text {
          Layout.fillWidth: true     
          text: author
        }
      }
      RowLayout {        
        Layout.bottomMargin: 4
        Layout.fillWidth: true        
        Text {
          Layout.preferredWidth: 100
          text: qsTr('Pages')
        }
        Text {
          Layout.alignment: Qt.AlignTop
          text: qsTr(': ')
        }
        Text {
          Layout.fillWidth: true     
          text: pages
        }
      }      
      RowLayout {        
        Layout.bottomMargin: 4
        Layout.fillWidth: true        
        Text {
          Layout.preferredWidth: 100
          text: qsTr('Publisher')
        }
        Text {
          Layout.alignment: Qt.AlignTop
          text: qsTr(': ')
        }
        Text {
          Layout.fillWidth: true     
          text: publisher
        }
      }
      RowLayout {        
        Layout.bottomMargin: 4
        Layout.fillWidth: true        
        Text {
          Layout.preferredWidth: 100
          text: qsTr('ISBN')
        }
        Text {
          Layout.alignment: Qt.AlignTop
          text: qsTr(': ')
        }
        Text {
          Layout.fillWidth: true     
          text: isbn
        }
      }
      RowLayout {        
        Layout.bottomMargin: 4
        Layout.fillWidth: true        
        Text {
          Layout.preferredWidth: 100
          text: qsTr('Stock')
        }
        Text {
          Layout.alignment: Qt.AlignTop
          text: qsTr(': ')
        }
        Text {
          Layout.fillWidth: true     
          text: stock
        }
      }
      RowLayout {
        Layout.bottomMargin: 4
        Layout.fillWidth: true   
        Text {
          Layout.alignment: Qt.AlignTop
          Layout.preferredWidth: 100
          text: qsTr('Genre(s)')
        }
        Text {
          Layout.alignment: Qt.AlignTop
          text: qsTr(': ')
        }             
        RowLayout {
          Layout.preferredWidth: 400          
          Flow {      
            spacing: 4
            Layout.fillWidth: true                            
            Repeater {
              model: _genres
              Badge {
                title: modelData
              }
            }
          }                                                                           
        }
      }
      RowLayout {        
        Layout.fillWidth: true        
        Text {
          Layout.alignment: Qt.AlignTop
          Layout.preferredWidth: 100
          text: qsTr('Description')
        }
        Text {
          Layout.alignment: Qt.AlignTop
          text: qsTr(': ')
        }
        Text {
          Layout.fillWidth: true     
          elide: Text.ElideRight
          Layout.maximumHeight: 36 * 8
          wrapMode: Text.Wrap
          lineHeight: 1.25
          text: description
        }
      }
    }  
  }
}
