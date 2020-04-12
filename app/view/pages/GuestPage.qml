import '../components'

import QtQuick 2.4
import QtQuick.Controls 2.14
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Layouts 1.14
import QtGraphicalEffects 1.12

Page {
  id: guest_page  

  QtObject {
    id: book_context
    property string _id: ''
    property string title: ''
    property string cover: ''
    property string author: ''
    property string location: ''
    property string isbn: ''
    property string description: ''
    property string publisher: ''
    property string stock: ''
    property string pages: ''
    property string genres: ''
    property variant _genres: genres.split(' ')
  }
  

  Item {
    BookInfo {
      id: book_info
      _id: book_context._id
      title: book_context.title
      cover: book_context.cover
      author: book_context.author
      location: book_context.location
      isbn: book_context.isbn
      description: book_context.description
      publisher: book_context.publisher
      stock: book_context.stock
      pages: book_context.pages
      genres: book_context.genres
    }

    Popup {
      id: borrow_book       
      width: 400
      modal: true
      focus: true 
      closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
      y: Math.round((parent.height - height) / 2)
      x: Math.round((parent.width - width) / 2)
      anchors.centerIn: Overlay.overlay  
      ColumnLayout {
        anchors.fill: parent
        // Text {          
        //   font.pointSize: 16
        //   Layout.topMargin: 8
        //   Layout.bottomMargin: 8
        //   Layout.alignment: Qt.AlignHCenter
        //   text: qsTr('Login')
        // }
        RowLayout {    
          Layout.fillWidth: true
          Text {
            text: 'Username'
            Layout.preferredWidth: 90                  
          }  
          TextField {          
            id: borrow_username               
            Layout.fillWidth: true
            placeholderText: 'Username'
          }
        }
        RowLayout {    
          Layout.fillWidth: true
          Text {
            text: 'Password'
            Layout.preferredWidth: 90                  
          }  
          TextField {          
            echoMode: TextInput.Password 
            id: borrow_password               
            Layout.fillWidth: true
            placeholderText: 'Password'
          }
        }        
        Button {
          text: qsTr('BORROW')
          highlighted: true 
          Layout.fillWidth: true       
          Material.accent: Material.Blue  
          onClicked: {              
            GuestProps.login_guest(borrow_username.text, borrow_password.text)
          }  
        }
        Text {
          id: login_failed                      
          Layout.fillWidth: true           
          visible: true
          color: Material.color(Material.Red)   
          text: ''       
        }
        
      }
    }

  }

  ColumnLayout {
    id: control
    anchors.left: parent.left
    anchors.right: parent.right
    
    RowLayout {                 
      id: search_bar
      Layout.fillWidth: true 
      Layout.margins: 20

      TextField {          
        id: search_field
        Layout.fillWidth: true                   
        placeholderText: 'Search Book'        
      }

      Text {
        text: qsTr('Search by:')
        Layout.leftMargin: 12        
      }

      ComboBox {        
        currentIndex: 0
        textRole: "key"
        id: search_by        
        model: ListModel {          
          ListElement { key: "title"}
          ListElement { key: "author"}
          ListElement { key: "publisher"}
        }
        Layout.preferredWidth: 160
        Layout.leftMargin: 12
      }

      Button {                
        text: qsTr('SEARCH')
        highlighted: true
        Layout.leftMargin: 4
        Material.accent: Material.Blue 
        onClicked: {
          GuestProps.search_book(search_by.currentText, search_field.text)                                        
        }
      }  
      Button {        
        text: qsTr('LOGIN ADMIN')
        highlighted: true
        Layout.leftMargin: 4
        Material.accent: Material.Red
        onClicked: {
          main_view.pop()
          main_view.pop()
        }        
      }     
    }    
    BookCatalog {
      id: guest_catalog
      Layout.preferredHeight: Screen.height - search_bar.height  - 64  
      delegate: BookCard {
        mode: 'guest'
        _width: guest_catalog.cellWidth - 12
        _height: guest_catalog.cellHeight - 12
        _id: book_id
        _genres: book_genres
        cover: book_cover
        title: book_title
        location: book_location
        stock: book_stock
        isbn: book_isbn
        author: book_author
        publisher: book_publisher
        description: book_description
        pages: book_pages
        genres: book_genres
        onClick: {                     
          book_context._id = _id
          book_context.title = title
          book_context.cover = book_cover
          book_context.location = location
          book_context.stock = stock
          book_context.isbn = isbn
          book_context.author = author
          book_context.publisher = publisher
          book_context.description = description
          book_context.pages = pages   
          book_context.genres = genres                    
          book_info.open()           
        }
      }
    }
    Component.onCompleted: {               
      GuestProps.search_book()      
    }        

    Connections {
      target: GuestProps
      onSearchCompleted: {
        guest_catalog.model.clear()
        books.forEach(_book => {          
          let book = {
            book_id: _book._id,
            book_title: _book.title,
            book_author: _book.author,
            book_cover: _book.cover,
            book_location: _book.location,
            book_stock: _book.stock,
            book_publisher: _book.publisher,
            book_description: _book.description,
            book_isbn: _book.isbn,
            book_pages: _book.pages,
            book_genres: _book.genres
          }                              
          guest_catalog.model.append(book)
        })
      }
      onLoginGuestCompleted: {        
        // console.log(book_context._id, _id)
        if (success) {
          let _user = user[0]  
          GuestProps.borrow(_user._id, _user.fullname, _user.profile_picture, book_context._id, book_context.title)
          borrow_username.text = ''
          borrow_password.text = ''
          borrow_book.close()          
          login_failed.text = ''
        } else {
          login_failed.text = 'Unknown credential'
        }
      }
    }
    
  }

  
}