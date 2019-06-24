import Felgo 3.0
import QtQuick 2.0

Page {
    id:mypage
    title: qsTr("我的")
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
      height: 200
      width: parent.width
      anchors.top: parent.top
      anchors.topMargin:0
      Item {
          height: 200
          width: (parent.width)/2
          anchors.top: parent.top
          anchors.topMargin:0
          anchors.left: parent.left
          anchors.leftMargin: 0
          AppButton {
              anchors.centerIn: parent
              id:button
              text: "登录"
              onClicked: {}
          }
      }
      Item {
          height: 200
          width: (parent.width)/2
          anchors.top: parent.top
          anchors.topMargin:0
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
      anchors.fill: parent
      anchors.topMargin:200
      anchors.leftMargin: 0
      anchors.rightMargin: 0
      anchors.bottomMargin: 0
      AppListView {
          anchors.fill: parent
          model:ListModel {
              id:lm
               ListElement { name: "修改用户资料" ;images:"xiugai.png"}
               ListElement { name: "修改文件资料" ;images:"ziliao.png"}
               ListElement { name: "帮助" ;images:"wenghao.png"}
             }
          delegate: SimpleRow {
              height: 100
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
                      anchors.top: parent.top
                      anchors.topMargin: 25
                      id:tex
                      text: name
                      font.pixelSize: 30
                  }
              }
              onSelected: {
                if(name=="1"){
                dialog.close()
                }
              }
          }
    }
  }
}
