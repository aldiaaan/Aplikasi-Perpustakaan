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

Page {
  width: Screen.width
  height: Screen.height
  header: ToolBar {    
    id: 'toolbar'
    layer.enabled: true
    RowLayout {
      anchors.fill: parent      
      Text {
        Layout.leftMargin: 20
        Layout.fillWidth: true
        text: qsTr('SMAN 99 - Library')
        font.weight: Font.Medium
        font.pointSize: 16
        color: 'white'
      }
      Text {
        Layout.rightMargin: 20
        text: qsTr('Hello, admin')        
        color: 'white'
      }      
    }
  } 

  QtObject {
    id: book_context
    property string book_id: ''
    property string book_title: ''
    property string book_image: ''
    property string book_author: ''
    property string book_location: ''
    property string book_isbn: ''
    property string book_description: ''
    property string book_publisher: ''
    property string book_stock: ''
    property string book_pages: ''
  }

  ColumnLayout {
    anchors.fill: parent
    TabBar {
      id: tab          
      Material.accent: 'white'
      background: Rectangle {        
        color: Material.color(Material.Indigo)     
      }           
      Layout.fillWidth: true     
      TabButton {              
        text: qsTr('BOOKS')       
        contentItem: Text {
          text: parent.text
          font: parent.font          
          color: 'white'
          opacity: tab.currentIndex == 0 ? 1.0 : 0.7
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
          elide: Text.ElideRight
        }
      }
      TabButton {              
        text: qsTr('BORROWER')         
        contentItem: Text {
          text: parent.text
          font: parent.font          
          color: 'white'
          opacity: tab.currentIndex == 1 ? 1.0 : 0.7
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
          elide: Text.ElideRight
        }
      }
      TabButton {              
        text: qsTr('MEMBERS')      
        contentItem: Text {
          text: parent.text
          font: parent.font          
          color: 'white'
          opacity: tab.currentIndex == 2 ? 1.0 : 0.7
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
          elide: Text.ElideRight
        }
      }
    }
    StackLayout {
      width: parent.width
      currentIndex: tab.currentIndex 
      AdminBook {}
      AdminBorrower {}
      AdminMember {}
    }
  }
}