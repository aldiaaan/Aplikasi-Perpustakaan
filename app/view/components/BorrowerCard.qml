import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Layouts 1.14

Item {
  id: borrower_card    
  property int _width
  property int _height  
  property string _id: ''
  property string borrowing: '-'  
  property string fullname: '-'  
  property string return_at: '--/--/----'
  property string profile_picture: '../assets/placeholder_profile.jpeg'      
  
  signal deleteClick(string _id)

  Rectangle {    
    id: control
    width: borrower_card._width
    height: borrower_card._height   
    radius: 4 
    layer.enabled: true
    layer.effect: ElevationEffect {
      elevation: 2
    }    
    
    Rectangle {      
      id: delete_button
      anchors.right: parent.right
      anchors.bottom: parent.bottom
      anchors.bottomMargin: 8
      anchors.rightMargin: 8
      width: 24
      height: 24
      radius: 4          
      color: Material.color(Material.Red)
      MouseArea {    
        anchors.fill: parent
        onClicked: {          
          deleteClick(borrower_card._id)  
          delete_borrower.open()                    
        }
      }
      Image {
        anchors.horizontalCenter: parent.horizontalCenter        
        anchors.verticalCenter: parent.verticalCenter                
        height: 18
        width: 18
        source: "../assets/icons/delete.svg"
      }      
    }
    RowLayout {      
      anchors.fill: parent       
      Image {
        source: profile_picture
        Layout.margins: 6
        Layout.preferredWidth: control.width * 0.3
        Layout.preferredHeight: control.height - 18
      }      
      ColumnLayout {        
        Layout.topMargin: 8
        Layout.alignment: Qt.AlignTop
        Layout.fillWidth: true
        Layout.bottomMargin: 4  
        RowLayout {        
          Layout.bottomMargin: 4
          Layout.fillWidth: true    
          Text {
            Layout.alignment: Qt.AlignTop
            Layout.preferredWidth: 70
            text: qsTr('Peminjam')
          }
          Text {
            Layout.alignment: Qt.AlignTop
            text: qsTr(':')
          }
          Text {
            Layout.fillWidth: true     
            text: fullname
            wrapMode: Text.Wrap
            lineHeight: 1.125
          }
        }               
        RowLayout {        
          Layout.bottomMargin: 4
          Layout.fillWidth: true    
          Text {
            Layout.alignment: Qt.AlignTop
            Layout.preferredWidth: 70
            text: qsTr('Buku')
          }
          Text {
            Layout.alignment: Qt.AlignTop
            text: qsTr(':')
          }
          Text {
            Layout.fillWidth: true     
            text: borrowing                        
            elide: Text.ElideRight
            Layout.maximumHeight: 16 * 3.5       
            wrapMode: Text.Wrap         
          }
        } 
        RowLayout {        
          Layout.bottomMargin: 4
          Layout.fillWidth: true    
          Text {
            Layout.alignment: Qt.AlignTop
            Layout.preferredWidth: 70
            text: qsTr('Due')
          }
          Text {
            Layout.alignment: Qt.AlignTop
            text: qsTr(':')
          }
          Text {
            Layout.fillWidth: true     
            text: return_at
            wrapMode: Text.Wrap
            lineHeight: 1.125
          }
        } 
      }        
    }
      
  }
  
}
