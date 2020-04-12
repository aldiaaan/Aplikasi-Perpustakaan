import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Layouts 1.14

Item {
  id: member_card    
  property bool details: false
  property int _width
  property int _height
  property string _id: '-'
  property string fullname: ''    
  property string username: ''
  property string password: ''  
  property string phone: ''
  property string address: ''
  property string role: ''
  property string profile_picture: ''   

  signal updateClick(string _id, string fullname, string username, string password, string phone, string address, string profile_picture, string role)
  signal deleteClick(string _id)  
   
  Rectangle {    
    id: control
    width: member_card._width
    height: member_card._height   
    radius: 4 
    layer.enabled: true
    layer.effect: ElevationEffect {
      elevation: 2
    }    
    RowLayout {
      z: 10
      anchors.bottom: control.bottom
      anchors.right: control.right  
      anchors.rightMargin: 8
      anchors.bottomMargin: 8        

      Rectangle {      
        id: delete_button
        width: 24
        height: 24
        radius: 4          
        color: Material.color(Material.Red)
        MouseArea {    
          anchors.fill: parent
          onClicked: {
            deleteClick(_id)
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
      Rectangle {      
        id: update_button
        width: 24
        height: 24                      
        radius: 4          
        color: Material.color(Material.Orange)
        MouseArea {    
          anchors.fill: parent
          onClicked: {                                
            updateClick(_id, fullname, username, password, phone, address, profile_picture, role)            
          }
        }
        Image {
          
          anchors.horizontalCenter: parent.horizontalCenter        
          anchors.verticalCenter: parent.verticalCenter                
          height: 18
          width: 18
          source: "../assets/icons/edit.svg"
        }      
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
        RowLayout {                  
          Layout.fillWidth: true        
          Text {
            Layout.alignment: Qt.AlignTop
            Layout.preferredWidth: 70
            text: qsTr('Name')
          }
          Text {
            Layout.alignment: Qt.AlignTop
            text: qsTr(':')
          }
          Text {
            Layout.fillWidth: true     
            text: fullname
            color: role === 'admin' ? Material.color(Material.Red) : 'black'
            wrapMode: Text.Wrap                        
            elide: Text.ElideRight
            Layout.maximumHeight: 16 * 2
          }
        }   
        RowLayout {        
          Layout.bottomMargin: 4
          Layout.fillWidth: true        
          Text {
            Layout.alignment: Qt.AlignTop
            Layout.preferredWidth: 70
            text: qsTr('Address')
          }
          Text {
            Layout.alignment: Qt.AlignTop
            text: qsTr(':')
          }
          Text {
            Layout.fillWidth: true     
            text: address
            wrapMode: Text.Wrap
            elide: Text.ElideRight
            Layout.maximumHeight: 16 * 2                   
          }
        }
        RowLayout {        
          Layout.bottomMargin: 4
          Layout.fillWidth: true        
          Text {
            Layout.alignment: Qt.AlignTop
            Layout.preferredWidth: 70
            text: qsTr('Contact')
          }
          Text {
            Layout.alignment: Qt.AlignTop
            text: qsTr(':')
          }
          Text {
            Layout.fillWidth: true     
            text: phone
            wrapMode: Text.Wrap
            lineHeight: 1.125
          }
        }    
      }
    }
      
  }
  
}