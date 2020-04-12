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
    id: borrower_context
    property string _id: ''
  }

  Item {
    Popup {
      id: delete_borrower
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
            AdminProps.delete_borrower(borrower_context._id)
            delete_borrower.close()
          }
        }
      }
    } 
  }
  RowLayout {         
    Layout.alignment: Qt.AlignTop        
    id: search_bar
    Layout.fillWidth: true 
    Layout.leftMargin: 16
    Layout.rightMargin: 16
    Layout.topMargin: 12
    Layout.bottomMargin: 12

    TextField {      
      id: search_field
      Layout.fillWidth: true                   
      placeholderText: 'Search Borrower ( empty search to refresh )'        
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
        ListElement { key: "user name";}
        ListElement { key: "book title";}        
      }
    }

    Button {        
      text: qsTr('SEARCH')
      highlighted: true
      Layout.leftMargin: 4
      Material.accent: Material.Blue   
      onClicked: {
        let temp = ''
        switch(search_by.currentText) {
          case 'user name':
            temp = 'fullname'
            break;
          case 'book title':
            temp  = 'title'
            break;
        }        
        AdminProps.search_borrower(temp, search_field.text)
      }     
    } 
  } 

  RowLayout {
    Layout.fillHeight: true
    Layout.fillWidth: true 
    // Layout.leftMargin: 12   
    clip: true
    GridView {      
      id: gv_borrowers
      snapMode: GridView.NoSnap      
      Layout.fillHeight: true
      Layout.fillWidth: true
      Layout.leftMargin: 12     
      clip: true      
      height: Screen.height
      cellHeight: 180
      cellWidth:  width / 3
      model: ListModel {}
      delegate: BorrowerCard {
        _width: gv_borrowers.cellWidth - 16
        _height: gv_borrowers.cellHeight - 16
        _id: borrower_id
        fullname: borrower_fullname
        profile_picture: borrower_profile_picture
        return_at: borrower_return_at
        borrowing: borrower_title            
        onDeleteClick: {
          borrower_context._id = _id
          
        }       
      }
    
    }

    Rectangle {
      id: late_borrower
      Layout.rightMargin: 12
      Layout.preferredWidth: 320
      Layout.preferredHeight: 520
      Layout.alignment: Qt.AlignTop
      border.color: '#e5e5e5'
      border.width: 1          
      radius: 4      

      ColumnLayout {             
        spacing: -4
        Rectangle {      
          radius: 4                    
          Layout.fillWidth: true
          Layout.preferredHeight: 72           
          color: Material.color(Material.LightBlue)                     
          
          Text {            
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.centerIn: parent
            anchors.topMargin: 4
            anchors.leftMargin: 12
            anchors.rightMargin: 12
            font.pointSize: 14
            color: 'white'
            text: qsTr('Telat Mengembalikan')
          }
        }          
        
        ScrollView {
          clip: true
          Layout.preferredWidth: late_borrower.width
          Layout.preferredHeight: late_borrower.height            
          ListView {
            id: 'late_borrower_model'
            spacing: -1
            model: ListModel {}                     
            delegate: LateBorrower {
              width: parent.width
              height: 64       
              fullname: late_borrower_fullname
              penalty: late_borrower_penalty
              title: late_borrower_title
            }
          }
        }
      }      
    }
  }

  Connections {
    target: AdminProps
    onSearchLateBorrowersCompleted: {
      late_borrower_model.model.clear()
      late_borrowers.forEach(_late_borrower => {                   
        let late_borrower = {
          late_borrower_title: _late_borrower.title,
          late_borrower_fullname: _late_borrower.fullname,
          late_borrower_penalty: _late_borrower.penalty          
        }
        // console.log(late_borrower.late_borrower_penalty)
        late_borrower_model.model.append(late_borrower)
      })
    }
    onSearchBorrowersCompleted: {          
      gv_borrowers.model.clear()
      borrowers.forEach(_borrower => {        
        let borrower = {
          borrower_id: _borrower._id,
          borrower_fullname: _borrower.fullname,
          borrower_profile_picture: _borrower.profile_picture,          
          borrower_title: _borrower.title,
          borrower_return_at: _borrower.return_at          
        }
        // console.log(borrower.borrower_id, borrower.borrower_fullname, borrower.borrower_title)
        gv_borrowers.model.append(borrower)          
      })      
    }
  }

  Component.onCompleted: {    
    AdminProps.search_borrower()
    AdminProps.search_late_borrower()
  }
}