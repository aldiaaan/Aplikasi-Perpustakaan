import '../'

import QtQuick 2.4
import QtQuick.Controls 2.14
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Layouts 1.14
import QtGraphicalEffects 1.12

ColumnLayout {

  QtObject {
    id: book_context    
    property string _id: ''
    property string title: ''
    property string cover: '../assets/placeholder.jpg'  
    property string author: ''
    property string location: ''
    property string isbn: ''
    property string description: ''
    property string publisher: ''
    property string stock: ''
    property string pages: ''    
  }

  Item {
    BookForm {
      id: create_book
    }
    BookForm {
      id: update_book
      mode: 'update'
    } 
    Popup {
      id: delete_book
      width: 300
      modal: true
      focus: true 
      closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
      y: Math.round((parent.height - height) / 2)
      x: Math.round((parent.width - width) / 2)
      anchors.centerIn: Overlay.overlay   
      ColumnLayout {
        anchors.fill: parent
        Text {          
          text: qsTr('Are you sure?')          
        }
        Button {
          Layout.alignment: Qt.AlignRight
          text: qsTr('DELETE')
          highlighted: true
          Material.accent: Material.Red
          onClicked: { 
            AdminProps.delete_book(book_context._id)          
            delete_book.close()
          }
        }
      }
    }  
  }
  RowLayout {           
    id: search_bar
    Layout.alignment: Qt.AlignTop            
    Layout.fillWidth: true 
    Layout.leftMargin: 16
    Layout.rightMargin: 16
    Layout.topMargin: 12
    Layout.bottomMargin: 12

    TextField {   
      id: search_field
      Layout.fillWidth: true                   
      placeholderText: 'Search Book ( empty search to refresh )'        
    }

    Text {
      text: qsTr('Search by:')
      Layout.leftMargin: 12
    }

    ComboBox {        
      id: search_by
      currentIndex: 0
      textRole: "key"        
      Layout.preferredWidth: 160
      Layout.leftMargin: 12
      model: ListModel {          
        ListElement { key: "title" }
        ListElement { key: "author" }
        ListElement { key: "publisher" }
      }
    }

    Button {        
      text: qsTr('SEARCH')
      highlighted: true
      Layout.leftMargin: 4
      Material.accent: Material.Blue 
      onClicked: {
        AdminProps.search_book(search_by.currentText, search_field.text)
      }          
    } 
    Button {        
      text: qsTr('+ ADD BOOK')
      highlighted: true
      Layout.leftMargin: 4
      Material.accent: Material.Green  
      onClicked: {
        create_book.open()
      }       
    } 
    Button {        
      text: qsTr('GUEST VIEW')
      highlighted: true
      Layout.leftMargin: 4
      Material.accent: Material.Teal   
      onClicked: {
        main_view.push('../../pages/GuestPage.qml')
      }     
    } 
  }
  RowLayout {
    BookCatalog {
      id: admin_catalog
      delegate: BookCard {
        _width: admin_catalog.cellWidth - 12
        _height: admin_catalog.cellHeight - 12
        _id: book_id
        cover: book_cover
        title: book_title
        location: book_location
        stock: book_stock
        isbn: book_isbn
        author: book_author
        publisher: book_publisher
        description: book_description
        pages: book_pages
        onDeleteClick: {
          book_context._id = _id
        }
        onUpdateClick: {          
          book_context._id = _id
          book_context.title = title
          book_context.cover = cover
          book_context.location = location
          book_context.stock = stock
          book_context.isbn = isbn
          book_context.author = author
          book_context.publisher = publisher
          book_context.description = description
          book_context.pages = pages          
        }
      }
    }
  }

  Component.onCompleted: {      
    AdminProps.search_book()
  }

  Connections {
    target: AdminProps    
    onSearchBookCompleted: {
      admin_catalog.model.clear()
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
          book_pages: _book.pages
        }                             
        admin_catalog.model.append(book)
      })
    }
  }
}