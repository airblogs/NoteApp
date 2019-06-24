import Felgo 3.0

import QtQuick 2.2


Page {
    id:newspage
    title: qsTr("新文件")
    Timer{
        interval: 500; running: true; repeat: false
        onTriggered: {
            var json = JSON.parse(fileio.text);
            model.clear()
            var count = json.TEXT.length;
            for (var i in json.TEXT) {
                var t = json.TEXT[ i ];
                model.append( t );
            }
        }
    }
    rightBarItem: IconButtonBarItem {
      icon: IconType.refresh
      color: "white"
      onClicked: {
          var json = JSON.parse(fileio.text);
          model.clear()
          var count = json.TEXT.length;
          for (var i in json.TEXT) {
              var t = json.TEXT[ i ];
              model.append( t );
          }
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
                              navigationStack.push(userPageComponent)
                          }
                      }
                  }
              }
              Text {

                      height: 40
                      width: 100
                      clip: true
                      id: nametext
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
                  anchors.left: useimage.right
                  anchors.leftMargin: 10
                  id:image
                  height: 210
                  width: 220
                  source: firstimage
              }
          }
          Item{
              anchors.left: imageitem.right
              height:110
              width: 600
              Text {
                  height: 50
                  width: 600
                  clip: true
                  id: titletext
                  anchors.left: parent.left
                  anchors.leftMargin: 5
                  text: '<b>标题:</b> ' + thetitle
              }

              Text {
                  height: 150
                  width: 600
                  lineHeightMode: Text.FixedHeight
                  wrapMode:Text.WrapAnywhere
                  clip: true
                  id: essaytext
                  anchors.top: titletext.bottom
                  anchors.left: parent.left
                  anchors.leftMargin: 5
                  text: '<b>内容:</b> ' + atext
              }
          }
          MouseArea {
              height: 220
              width: 970
              anchors.right:  parent.right
              onPressAndHold: ListView.view.Items.dragMode =
                              !ListView.view.Items.dragMode
              onClicked:{
                   item.ListView.view.currentIndex = index
              }
              onDoubleClicked: {
                  navigationStack.push(openPageComponent,{images:images,atext:atext})

              }
          }
      }
  }
  //显示部分内容

  ListModel{

      id:model
      ListElement{
          name: "a"
          userimage: "apple.png"
          thetitle: "图集"
          firstimage: "a.png"
          images: "[a.png,a.png,a.png]"
          atext: "这是图集"

      }
      ListElement{
          name: "a"
          userimage: "apple.png"
          thetitle: "图片"
          firstimage: "a.png"
          images: "[a.png]"
          atext: "这是图片"

      }
      ListElement{
          name: "a"
          userimage: "apple.png"
          thetitle: "文字"
          firstimage: ""
          images: ""
          atext: "这是文字"

      }
  }


  Item{
      anchors.fill: parent
      //anchors.topMargin: 120
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
}
