import Felgo 3.0

import QtQuick 2.2


Page {
    id:newspage
    title: qsTr("新文件")

    property string nowtime: Qt.formatDateTime(new Date(), "yyyy-MM-dd  hh-mm-ss  dddd")
    //自动刷新获取json数据
    Timer{
        interval: 500; running: true; repeat: false
        onTriggered: {
            var json = JSON.parse(fileio.text);
            model.clear()
            var count = json.TEXT.length;
            for (var i in json.TEXT) {
                var t = json.TEXT[ i ];
                if(t.atext!=""||t.thetitle!=""||t.firstimage!=""){
                    model.append( t );
                }
            }
        }
    }

    //手动刷新获取json数据
    rightBarItem: IconButtonBarItem {
      icon: IconType.refresh
      //color: "lightblue"
      color:"white"
      onClicked: {
          console.log(nowtime)
          var json = JSON.parse(fileio.text);
          model.clear()
          var count = json.TEXT.length;
          for (var i in json.TEXT) {
              var t = json.TEXT[ i ];
              if((t.atext!=""||t.thetitle!=""||t.firstimage!="")&&t.name==json.TEXT[ count-1 ].name){
                  model.append( t );
              }
          }
      }

    }

    //listview信息显示
  Item{
      anchors.fill: parent
      anchors.top: parent.top
      anchors.leftMargin: 0
      anchors.rightMargin: 0
      anchors.bottomMargin: 0
      AppListView {
          id:al
              anchors.fill: parent
              model:model
              delegate: delegate
              highlight: Rectangle { color: "Lightgray";  radius: 5;}
              highlightFollowsCurrentItem :true
      }
  }

  ListModel{
      id:model
      ListElement{
          number:"0"
          name: "zlq"
          userimage: "qrc:user.png"
          time: "2019-06-23  18-42-29  星期日"
          thetitle: "图集"
          firstimage: "qrc:firstimage.png"
          images: "[qrc:firstimage.png,qrc:firstimage.png,qrc:firstimage.png]"
          atext: "这是图集"

      }
      ListElement{
          number:"1"
          name: "zlq"
          userimage: "qrc:user.png"
          time: "2019-06-23  18-42-29  星期日"
          thetitle: "图片"
          firstimage: "qrc:firstimage.png"
          images: "[qrc:firstimage.png]"
          atext: "这是图片"

      }
      ListElement{
          number:"2"
          name: "zlq"
          userimage: "qrc:user.png"
          time: "2019-06-23  18-42-29  星期日"
          thetitle: "文字"
          firstimage: ""
          images: ""
          atext: "这是文字"

      }
  }

  Component {
      id: delegate
      Item{
          id:item
          height:220
          width: parent.width
          Item{
              anchors.left: parent.left
              id:imageitem
              height:220
              width: 360
              Item{
                  height:80
                  width: 100
                  anchors.bottom: parent.bottom
                  anchors.left: parent.left

                  IconButton{
                      anchors.fill: parent
                      size:100
                      icon: IconType.bars
                      color: "lightsteelblue"
                      MouseArea{
                          anchors.fill: parent
                          onClicked: {
                              navigationStack.push(userPageComponent,{name:name,userimage:userimage})
                          }
                      }
                  }
              }
              Text {
                      id: nametext
                      height: 40
                      width: 100
                      clip: true
                      anchors.left: parent.left
                      anchors.top: useimage.bottom
                      anchors.leftMargin: 5
                      text:  name

              }
              Image {
                  id:useimage
                  height: 100
                  width: 100
                  source: userimage
              }
              Image {
                  id:image
                  anchors.left: useimage.right
                  anchors.leftMargin: 10
                  height: 210
                  width: 220
                  source: firstimage
              }
          }
          Item{
              anchors.left: imageitem.right
              height:110
              width: parent.width-110
              Text {
                  id: titletext
                  height: 50
                  width: 300
                  clip: true
                  anchors.left: parent.left
                  anchors.leftMargin: 5
                  text: '<b>标题:</b> ' + thetitle
              }
              Text{
                  id:timetext
                  height: 50
                  width: 700
                  anchors.right: parent.right
                  text: time
              }

              Text {
                  id: essaytext
                  height: 150
                  width: parent.width-330
                  lineHeightMode: Text.FixedHeight
                  wrapMode:Text.WrapAnywhere
                  clip: true
                  anchors.top: titletext.bottom
                  anchors.left: parent.left
                  anchors.leftMargin: 5
                  text: '<b>内容:</b> ' + atext
              }
          }

          //单击选中，双击进入openpage
          MouseArea {
              height: 220
              width: parent.width-110
              anchors.right:  parent.right
              onPressAndHold: ListView.view.Items.dragMode =
                              !ListView.view.Items.dragMode
              onClicked:{
                   item.ListView.view.currentIndex = index
              }
              onDoubleClicked: {
                  navigationStack.push(openPageComponent,{images:images,atext:atext,number:number})

              }
          }
      }
  }

}


