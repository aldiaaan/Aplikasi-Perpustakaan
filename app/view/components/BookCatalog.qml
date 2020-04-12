
import QtQuick 2.4
import QtQuick.Controls 2.14
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Layouts 1.14
import QtGraphicalEffects 1.12

GridView {
  id: gv_guest  
  Layout.fillHeight: true    
  Layout.fillWidth: true
  Layout.leftMargin: 12         
  clip: true        
  height: Screen.height
  snapMode: ListView.SnapToItem
  cellHeight: cellWidth + 80
  cellWidth:  width / 6
  model: ListModel {}  
}
