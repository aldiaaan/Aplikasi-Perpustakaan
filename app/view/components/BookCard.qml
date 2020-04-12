import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Layouts 1.14

Item {
  id: card
  
  property string mode: 'admin'
  property int _width
  property int _height
  property string _id: ''
  property string title: ''
  property string cover: '../assets/placeholder.jpg'  
  property string author: 'Unknown'
  property string stock: '' 
  property string publisher: '' 
  property string description: '' 
  property string isbn: '' 
  property string location: '' 
  property string pages: ''  
  property string _genres: '' 
  property variant genres: _genres.split(' ')

  signal updateClick(string _id, string title, string cover, string author, string stock, string publisher, string description, string isbn, string location, variant _genres)
  signal click(string _id, string title, string cover, string author, string stock, string publisher, string description, string isbn, string location, variant _genres)
  signal deleteClick(string _id)

  Rectangle {        
    id: control
    width: card._width
    height: card._height     
    radius: 8
    layer.enabled: true
    layer.effect: ElevationEffect {
      elevation: 2
    }        

    MouseArea {    
      anchors.fill: parent
      onClicked: {              
        click(card._id, card.title, card.image, card.author, card.stock, card.publisher, card.description, card.isbn, card.location, card.pages)
      }      
    }    

    RowLayout {
      z: 10
      anchors.top: control.top
      anchors.right: control.right  
      anchors.rightMargin: 8
      anchors.topMargin: 8  
      visible: card.mode === 'admin'

      Rectangle {      
        id: delete_button
        width: 24
        height: 24
        radius: 4          
        color: Material.color(Material.Red)
        MouseArea {    
          anchors.fill: parent
          onClicked: {
            deleteClick(card._id)  
            delete_book.open()                    
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
            updateClick(card._id, card.title, card.cover, card.author, card.stock, card.publisher, card.description, card.isbn, card.location, card.pages)                                                    
            update_book.open()            
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
            

    ColumnLayout {
      width: control.width
      height: control.height
             
      Image {
        id: img                
        source: card.cover                    
        Layout.preferredHeight: control.height - 30
        Layout.fillWidth: true                            
        Layout.maximumWidth: control.width
      }

      Text {         
        id: card_title                       
        text: card.title
        elide: Text.ElideRight
        clip: true
        Layout.leftMargin: 6          
        Layout.preferredHeight: 30
        Layout.maximumWidth: control.width - 12
        Layout.alignment: Qt.AlignVCenter          
      }
    }    
  }
}