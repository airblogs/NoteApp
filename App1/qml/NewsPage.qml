import Felgo 3.0
import QtQuick 2.2

Page {
    id:newspage
    title: qsTr("新文件")
  SearchBar {
      id: searchBar

  }
  rightBarItem: IconButtonBarItem {
      icon: IconType.camera
      color: "white"
      onClicked:{
         nativeUtils.displayCameraPicker("test")
      }
  }
  AppImage {
      id: image
      anchors.fill: parent
      autoTransform: true
      fillMode: Image.PreserveAspectFit
  }
  Connections {
      target: nativeUtils
      onCameraPickerFinished: {
      if(accepted) image.source = path
      }
  }

  Component {
      id: delegate
      Item{
          id:item
          height:110
          width: 480
          Item{
              anchors.left: parent.left
              id:imageitem
              height:110
              width: 180
              Item{
                  height:50
                  width: 50
                  anchors.top: nametext.bottom
                  anchors.left: parent.left
                  IconButton{
                      //anchors.top: nametext.bottom
                      //anchors.left: parent.left
                      //anchors.leftMargin:0
                      anchors.centerIn: parent
                      icon: IconType.bars
                      color: "lightsteelblue"
                      size: 45
                      MouseArea{
                          anchors.fill: parent
                          onClicked: {
                              navigationStack.push(openPageComponent,{count:number})
                          }
                      }
                  }
              }
              Text {

                      height: 15
                      width: 70
                      clip: true
                      id: nametext
                      anchors.left: parent.left
                      anchors.top: userimage.bottom
                      anchors.leftMargin: 5
                      text:  name

              }
              Image {
                  id:userimage
                  height: 50
                  width: 50
                  source: userimages
                  MouseArea{
                  }
              }
              Image {
                  anchors.left: userimage.right
                  anchors.leftMargin: 10
                  id:image
                  height: 105
                  width: 110
                  source: firstimage
                  MouseArea{
                  }
              }
          }
          Item{
              anchors.left: imageitem.right
              height:110
              width: 300
              Text {
                  height: 15
                  width: 460
                  clip: true
                  id: titletext
                  anchors.left: parent.left
                  anchors.leftMargin: 5
                  text: '<b>标题:</b> ' + name
              }

              Text {
                  height: 15
                  width: 460
                  wrapMode:Text.WrapAnywhere
                  clip: true
                  id: essaytext
                  anchors.top: titletext.bottom
                  anchors.left: parent.left
                  anchors.leftMargin: 5
                  text: '<b>内容:</b> ' + atext
                  MouseArea{
                  }
              }
          }
          MouseArea {
              height: 110
              width: 420
              anchors.right:  parent.right
              onPressAndHold: ListView.view.Items.dragMode =
                              !ListView.view.Items.dragMode
              onClicked:{
                   item.ListView.view.currentIndex = index
              }
              onDoubleClicked: {
                  navigationStack.push(openPageComponent,{count:number})
              }
          }
      }
  }
  //显示部分内容
  ListModel {
      id:showmodel
      ListElement { name: "a" ;number:"1";title:"A";atext:"a";userimages: "apple.png";firstimage:"a.png"}
      ListElement { name: "b" ;number:"2";title:"B";atext:"b";userimages: "apple.png";firstimage:"a.png"}
      ListElement { name: "c" ;number:"3";title:"C";atext:"c";userimages: "apple.png";firstimage:"a.png"}
  }
  Item{
      anchors.fill: parent
      anchors.topMargin:100
      anchors.leftMargin: 0
      anchors.rightMargin: 0
      anchors.bottomMargin: 0
      AppListView {
          id:al
              anchors.fill: parent
              model:showmodel
              delegate: delegate
              highlight: Rectangle { color: "Lightgray";  radius: 5;}
              highlightFollowsCurrentItem :true
      }
  }
}
