import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Layouts 1.14

Item {
  property string fullname: ''
  property int penalty: 0
  property string title: ''
  property string return_date: ''

  Rectangle {
    height: parent.height
    width: parent.width      
    border.color: '#e5e5e5'
    border.width: 1
    RowLayout {  
      anchors.fill: parent          
      ColumnLayout {   
        clip:true     
        Layout.preferredWidth: 80           
        Layout.alignment: Qt.AlignVCenter                  
        Text {          
          Layout.leftMargin: 12   
          Layout.rightMargin: 12     
          text: fullname
          color: Qt.rgba(0, 0, 0, 0.87)
        }
        Text {          
          Layout.leftMargin: 12
          Layout.rightMargin: 12
          Layout.fillWidth: true
          text: title
          color: Qt.rgba(0, 0, 0, 0.54)
          font.pointSize: 10
        }
      }
      Text {        
        Layout.rightMargin: 12
        Layout.leftMargin: 12
        text: `Rp. ${penalty}`
      }
    }
           
  }
}