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
  id: control
  property string mode: 'create'
  width: 800  
  modal: true
  focus: true 
  closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
  y: Math.round((Screen.height - height) / 2)
  x: Math.round((Screen.width - width) / 2)
  anchors.centerIn: Overlay.overlay   

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
      preview.source = book_context.cover
    }
  }

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
        source: '../assets/placeholder.jpg'                      
      }
      Button {
        text: qsTr('UPLOAD COVER')                      
        Layout.fillWidth: true                   
        onClicked: {
          file_dialog.visible = true
        }  
      }       
      Text {
        color: Qt.rgba(0, 0, 0, 0.54)
        font.pixelSize: 12
        text: qsTr('*cover size is 240x300')
      }   

    }    
    ScrollView {
      Layout.maximumHeight: 580      
      Layout.alignment: Qt.AlignTop
      Layout.leftMargin: 8      
      Layout.fillWidth: true 
      clip: true
      ColumnLayout {                        
        ColumnLayout {
          Layout.preferredWidth: 500
          Layout.fillWidth: true
          Layout.bottomMargin: 4
          Text {
            color: Qt.rgba(0, 0, 0, 0.54)
            font.pixelSize: 12
            text: qsTr('Title')
            font.weight: Font.ExtraLight
            Layout.bottomMargin: -5
          }
          TextField {
            id: title
            Layout.fillWidth: true  
            text: control.mode === 'update' ? book_context.title : '';            
            placeholderTextColor: Qt.rgba(0, 0, 0, 0.54)          
            placeholderText: qsTr('Book Title')
          }
        }
        ColumnLayout {
          Layout.bottomMargin: 4
          Text {
            color: Qt.rgba(0, 0, 0, 0.54)
            font.pixelSize: 12
            text: qsTr('Author')
            font.weight: Font.ExtraLight
            Layout.bottomMargin: -5
          }
          TextField {
            id: 'author'
            Layout.fillWidth: true 
            text: control.mode === 'update' ? book_context.author : '';             
            placeholderTextColor: Qt.rgba(0, 0, 0, 0.54)          
            placeholderText: qsTr('Book Author(s)')
          }
        }  
        ColumnLayout {
          Layout.bottomMargin: 4
          Text {
            color: Qt.rgba(0, 0, 0, 0.54)
            font.pixelSize: 12
            text: qsTr('Publisher')
            font.weight: Font.ExtraLight
            Layout.bottomMargin: -5
          }
          TextField {
            id: publisher
            Layout.fillWidth: true  
            text: control.mode === 'update' ? book_context.publisher : ''; 
            placeholderTextColor: Qt.rgba(0, 0, 0, 0.54)          
            placeholderText: qsTr('Book Publisher')
          }
        }        
        RowLayout {
          Layout.bottomMargin: 4
          Layout.fillWidth: true
          ColumnLayout {
            Text {
              color: Qt.rgba(0, 0, 0, 0.54)
              font.pixelSize: 12
              text: qsTr('ISBN')
              font.weight: Font.ExtraLight
              Layout.bottomMargin: -5
            }
            TextField {
              id: isbn
              Layout.fillWidth: true  
              text: control.mode === 'update' ? book_context.isbn : ''; 
              placeholderTextColor: Qt.rgba(0, 0, 0, 0.54)          
              placeholderText: qsTr('Book ISBN')
            }
          } 
          ColumnLayout {            
            Layout.leftMargin: 8
            Text {
              color: Qt.rgba(0, 0, 0, 0.54)
              font.pixelSize: 12
              text: qsTr('Location')
              font.weight: Font.ExtraLight
              Layout.bottomMargin: -5
            }
            TextField {              
              id: location
              text: control.mode === 'update' ? book_context.location : ''; 
              placeholderTextColor: Qt.rgba(0, 0, 0, 0.54)          
              placeholderText: qsTr('Location')
            }
          }
          ColumnLayout {
            
            Layout.leftMargin: 8
            Text {
              color: Qt.rgba(0, 0, 0, 0.54)
              font.pixelSize: 12
              text: qsTr('Pages')
              font.weight: Font.ExtraLight
              Layout.bottomMargin: -5
            }
            TextField {              
              id: pages
              text: control.mode === 'update' ? book_context.pages : ''; 
              Layout.preferredWidth: 80
              placeholderTextColor: Qt.rgba(0, 0, 0, 0.54)          
              placeholderText: qsTr('Pages')
            }
          }
          ColumnLayout {            
            Layout.leftMargin: 8
            Text {
              color: Qt.rgba(0, 0, 0, 0.54)
              font.pixelSize: 12
              text: qsTr('Stock')
              font.weight: Font.ExtraLight
              Layout.bottomMargin: -5
            }
            TextField { 
              id: stock             
              text: control.mode === 'update' ? book_context.stock : '0'; 
              Layout.preferredWidth: 80
              placeholderTextColor: Qt.rgba(0, 0, 0, 0.54)          
              placeholderText: qsTr('Stock')
            }
          }         
        }

        ColumnLayout {
          Layout.bottomMargin: 4
          Text {
            color: Qt.rgba(0, 0, 0, 0.54)
            font.pixelSize: 12
            text: qsTr('Description')
            font.weight: Font.ExtraLight
            Layout.bottomMargin: -5
          }
          TextField {
            id: description
            Layout.fillWidth: true  
            text: control.mode === 'update' ? book_context.description : ''; 
            placeholderTextColor: Qt.rgba(0, 0, 0, 0.54)          
            placeholderText: qsTr('Book Description')
            wrapMode: TextEdit.Wrap
            verticalAlignment: TextInput.AlignTop              
            Layout.maximumHeight: 230
            Layout.preferredHeight: 230
          }
        } 

        ColumnLayout {          
          Layout.bottomMargin: 4
          Layout.fillWidth: true
          Text {
            color: Qt.rgba(0, 0, 0, 0.54)
            font.pixelSize: 12
            text: qsTr('Genre(s)')
            font.weight: Font.ExtraLight
            Layout.bottomMargin: -5
          }
          RowLayout {            
            Layout.fillWidth: true
            id: 'genres' 
            ColumnLayout {   
              Layout.fillWidth: true                        
              CheckBox {                                               
                text: qsTr("Action")                             
              }
              CheckBox { text: qsTr("Drama") }
              CheckBox { text: qsTr("Fantasy") }
              CheckBox { text: qsTr("Psychological") }
              CheckBox { text: qsTr("Horror") }
            }
            ColumnLayout {
              Layout.fillWidth: true
              CheckBox { 
                text: qsTr("Thriller")                 
              }
              CheckBox { text: qsTr("Sports") }
              CheckBox { text: qsTr("Romance") }
              CheckBox { text: qsTr("Mystery") }
              CheckBox { text: qsTr("History") }
            }  
            ColumnLayout {
              Layout.fillWidth: true
              CheckBox { 
                text: qsTr("Fantasy")                 
              }            
              CheckBox { text: qsTr("Education") }
              CheckBox { text: qsTr("Comedy") }
              CheckBox { text: qsTr("Art") }
              CheckBox { text: qsTr("Dictionary") }
            }  
            ColumnLayout {
              Layout.fillWidth: true
              CheckBox { 
                text: qsTr("School")                 
              }            
              CheckBox { text: qsTr("Fiction") }
              CheckBox { text: qsTr("Science") }
              CheckBox { text: qsTr("Technology") }
              CheckBox { text: qsTr("Health") }
            }  
          }        
        }
        
        RowLayout {
          Layout.fillWidth: true
          Layout.alignment: Qt.AlignHCenter
          Layout.topMargin: 8
          Button {            
            Layout.fillWidth: true
            highlighted: true   
            Material.accent: Material.Green 
            text: mode === 'create' ? qsTr('CREATE') : qsTr('UPDATE')  
            onClicked: {
              let _genres = []
              for (let i = 0; i < genres.children.length; i++) {

                for (let j = 0; j < genres.children[i].children.length; j++) {
                  let checkbox = genres.children[i].children[j]                  
                  if (checkbox.checked === true) {
                    _genres.push(checkbox.text)
                  }
                }                
              }

              let new_book = {           
                _id: book_context._id,   
                title: title.text,
                author: author.text,
                pages: pages.text,
                location: location.text,
                isbn: isbn.text,
                description: description.text,
                publisher: publisher.text,
                stock: stock.text,          
                cover: preview.source,
                genres: _genres
              }   
              
              
              if (control.mode === 'create') {                
                AdminProps.create_book(new_book.title, new_book.cover, new_book.author, new_book.location, new_book.isbn, new_book.description, new_book.publisher, new_book.pages, new_book.stock, new_book.genres)                                          
              } else {                                
                AdminProps.update_book(new_book._id, new_book.title, new_book.cover, new_book.author, new_book.location, new_book.isbn, new_book.description, new_book.publisher, new_book.pages, new_book.stock, new_book.genres)                                          
              }
              
              if (control.mode === 'create') {                
                title.text = ''
                author.text = ''
                pages.text = ''
                location.text = ''
                isbn.text = ''
                description.text = ''
                publisher.text = ''
                stock.text = '0'
                preview.source = '../assets/placeholder.jpg'
              }

              control.close()

            }
          }         
        }
      }
    }
  }
} 