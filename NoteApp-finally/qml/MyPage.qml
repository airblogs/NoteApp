import Felgo 3.0
import QtQuick 2.0


Page {
    id:mypage
    title: qsTr("我的")
    signal logoutClicked
    //显示视频页
  rightBarItem: IconButtonBarItem {
    icon: IconType.circleonotch
    //color: "lightblue"
    color:"white"
    onClicked:{
        navigationStack.push(videoPageComponent)
    }
  }

  Timer{
      interval: 500; running: true; repeat: true
      onTriggered: {
          var json = JSON.parse(fileio.text);
          var count = json.TEXT.length;
          user.source=json.TEXT[ count-1 ].userimage
          name.text=json.TEXT[ count-1 ].name
      }
  }
  //用户信息
  Item {
      id:useritem
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.bottom: buttonitem.top
      Item {
          id: imageitem
          anchors.top: parent.top
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.bottom: nameitem.top
          Image {
              anchors.centerIn: parent
              id: user
              //source: "qrc:user.png"
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
              //text: qsTr("text")
          }
      }
  }

  //登录退出
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
              text: "修改密码"
              onClicked: {
                  logoutClicked()
              }
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

  //选项
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
               //ListElement { name: "修改用户资料" ;images:"qrc:mypage2.png"}
               ListElement { name: "修改文件资料" ;images:"qrc:mypage1.png"}
               ListElement { name: "帮助" ;images:"qrc:mypage3.png"}
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
                if(name=="修改文件资料"){
                    navigationStack.push(changePageComponent)
                }else if(name=="帮助"){
                    dialog.open()
                }
              }
          }
    }
  }
  Dialog{
      id:dialog
      positiveAction:false
      negativeActionLabel: "Close"
      onCanceled: close()
      Text {
          anchors.centerIn: parent
          text: qsTr("NoteApp.\n可以登录不同账户记录图片（拍照）、\n图集（从相册中选）、文字。\n提供了时间记录。\n可以通过标题查找也可以通过分类查看。\n可对笔记进行删除修改操作。\n可对账户的信息进行更改（头像，密码）。\n提供了演示视频。")
      }
  }
}


