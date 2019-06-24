import Felgo 3.0
import QtQuick 2.0

Page {
    id:mypage
    title: qsTr("我的")

  rightBarItem: IconButtonBarItem {
    icon: IconType.circleonotch
    color: "white"
    onClicked:{}
  }

  Item {
      id:useritem
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.bottom: buttonitem.top
      Item {
          id: imageitem
          anchors.top: parent.bottom
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.bottom: nameitem.top
          Image {
              id: user
              source: "file"
          }
      }
      Item {
          id: nameitem
          height: 200
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.bottom: parent.bottom
          Text {
              anchors.centerIn: parent
              id: name
              text: qsTr("text")
          }
      }
  }
  Item {
      id: buttonitem
      height: 200
      width: parent.width
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.bottom: chooseitem.top
      Item {
          width: (parent.width)/2
          anchors.top: parent.top
          anchors.bottom: parent.bottom
          anchors.left: parent.left
          AppButton {
              anchors.centerIn: parent
              id:button
              text: "切换用户"
              onClicked: {}
          }
      }
      Item {
          width: (parent.width)/2
          anchors.top: parent.top
          anchors.bottom: parent.bottom
          anchors.right: parent.right
          anchors.rightMargin: 0
          AppButton {
              anchors.centerIn: parent
              id:button2
              text: "退出"
              onClicked: {
                  close()
              }
          }
      }

  }
  Item{
      id:chooseitem
      anchors.top:parent.top
      anchors.topMargin:1000
      anchors.left:parent.left
      anchors.right:parent.right
      anchors.bottom:parent.bottom
      AppListView {
          anchors.fill: parent
          model:ListModel {
              id:lm
               ListElement { name: "修改用户资料" ;images:"xiugai.png"}
               ListElement { name: "修改文件资料" ;images:"ziliao.png"}
               ListElement { name: "帮助" ;images:"wenghao.png"}
             }
          delegate: SimpleRow {
              height: 200
              Item {
                  Image {
                      anchors.top: parent.top
                      anchors.topMargin: 30
                      anchors.left: parent.left
                      anchors.leftMargin: 5
                      height: 40
                      width: 40
                      id:img
                      source: images
                  }
                  Text {
                      anchors.left: img.right
                      anchors.leftMargin: 10
                      anchors.verticalCenter: img.verticalCenter
                      id:tex
                      text: name
                      font.pixelSize: 30
                  }
              }
              onSelected: {
                //if(name=="1"){
                //dialog.close()
                //}
              }
          }
    }
  }
}

