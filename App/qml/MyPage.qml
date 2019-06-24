import Felgo 3.0
import QtQuick 2.0

Page {
  id:mypage
  leftBarItem: IconButtonBarItem {
    icon: IconType.twittersquare
    color: "white"
    onClicked:{}
  }
  rightBarItem: IconButtonBarItem {
    icon: IconType.circleonotch
    color: "white"
    onClicked:{}
  }
  Item {
      height: 300
      width: parent.width
      anchors.top: parent.top
      anchors.topMargin:0
      Item {
          height: 300
          width: (parent.width)/2
          anchors.top: parent.top
          anchors.topMargin:0
          anchors.left: parent.left
          anchors.leftMargin: 0
          AppButton {
              anchors.centerIn: parent
              id:button
              width: 161
              height: 26
              text: "1"
              onClicked: {}
          }
      }
      Item {
          height: 300
          width: (parent.width)/2
          anchors.top: parent.top
          anchors.topMargin:0
          anchors.right: parent.right
          anchors.rightMargin: 0
          AppButton {
              anchors.centerIn: parent
              id:button2
              width: 160
              height: 26
              text: "2"
              onClicked: {}
          }
      }

  }
  Item{
      anchors.fill: parent
      anchors.topMargin:300
      anchors.leftMargin: 0
      anchors.rightMargin: 0
      anchors.bottomMargin: 0
      AppListView {
          anchors.fill: parent
          model:ListModel {
              id:lm
               ListElement { name: "1" }
               ListElement { name: "2" }
               ListElement { name: "3" }
             }
          delegate: SimpleRow {
              height: 200
              text: name
              onSelected: {
                if(name=="1"){
                dialog.close()
                }
              }
          }
    }
  }
}
