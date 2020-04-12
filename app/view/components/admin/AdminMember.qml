import '../'

import QtQuick 2.4
import QtQuick.Controls 2.14
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Layouts 1.14
import QtGraphicalEffects 1.12

ColumnLayout {
  width: Screen.Width

  QtObject {
    id: member_context
    property string _id: ''
    property string fullname: ''
    property string username: ''
    property string password: ''
    property string phone: ''
    property string address: ''
    property string role: ''
    property string profile_picture: ''
  }

  Item {
    Popup {
      id: delete_member
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
            AdminProps.delete_member(member_context._id)
            delete_member.close()
          }
        }
      }
    } 
  }

  Item {
    MemberForm {
      id: create_member      
    }
    MemberForm {      
      id: update_member
      mode: 'update'
      fullname: member_context.fullname
      _id: member_context._id
      username: member_context.username
      password: member_context.password
      phone: member_context.phone
      address: member_context.address
      profile_picture: member_context.profile_picture
      role: member_context.role
    }
  }
  
  
  RowLayout {           
    Layout.alignment: Qt.AlignTop        
    
    Layout.fillWidth: true 
    Layout.leftMargin: 16
    Layout.rightMargin: 16
    Layout.topMargin: 12
    Layout.bottomMargin: 12

    TextField {      
      Layout.fillWidth: true                   
      placeholderText: 'Search Member ( empty search to refresh )'     
      id: search_field   
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
        ListElement { key: "fullname";}
        ListElement { key: "username";}        
      }
    }

    Button {        
      text: qsTr('SEARCH')
      highlighted: true
      Layout.leftMargin: 4
      Material.accent: Material.Blue
      onClicked: {        
        AdminProps.search_members(search_by.currentText, search_field.text)
      }        
    } 
    Button {        
      text: qsTr('+ ADD MEMBER')
      highlighted: true
      Layout.leftMargin: 4
      Material.accent: Material.Green   
      onClicked: {
        create_member.open()
      }     
    } 
  } 
  RowLayout {    
    clip: true
    GridView {
      id: gv_members
      snapMode: ListView.SnapToItem      
      Layout.fillWidth: true
      Layout.leftMargin: 12              
      height: Screen.height
      cellHeight: 180
      cellWidth:  width / 4
      model: ListModel {}
      delegate: MemberCard {

        _width: gv_members.cellWidth - 12
        _height: gv_members.cellHeight - 12    
        _id: member_id
        fullname: member_fullname
        profile_picture: member_profile_picture
        phone: member_phone
        address: member_address
        username: member_username
        password: member_password        
        role: member_role        
        
        onUpdateClick: {          
          member_context._id = _id
          member_context.fullname = fullname
          member_context.username = username
          member_context.password = password
          member_context.phone = phone
          member_context.address = address
          member_context.role = role
          member_context.profile_picture = profile_picture                
          update_member.open()                
        }

        onDeleteClick: {
          member_context._id = _id
          console.log(_id)
          delete_member.open()
        }
      }
    }
  }

  Connections {
    target: AdminProps
    onSearchMembersCompleted: {    
      gv_members.model.clear()  
      members.forEach(_member => {
        let member = {
          member_id: _member._id,
          member_role: _member.role,
          member_fullname: _member.fullname,
          member_username: _member.username,
          member_password: _member.password,
          member_address: _member.address,
          member_role: _member.role,
          member_phone: _member.phone,
          member_profile_picture: _member.profile_picture
        }        
        gv_members.model.append(member)
      })
    }
  }

  Component.onCompleted: {
    AdminProps.search_members()
  }
}