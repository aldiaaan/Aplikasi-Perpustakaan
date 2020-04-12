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

Label {
  property string title: ''
  background: Rectangle {
    anchors.fill: parent
    color: '#777777'    
    radius: 12
  }    
  text: title
  wrapMode: Label.Wrap
  color: 'white'
  font.weight: Font.DemiBold  
  font.letterSpacing: 0.375
  leftPadding: 6
  rightPadding: 6
  topPadding: 2
  bottomPadding: 2
  font.pixelSize: 12
}