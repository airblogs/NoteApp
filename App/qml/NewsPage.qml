import Felgo 3.0
import QtQuick 2.2

ListPage {
    id:newspage
    title: qsTr("1")
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
          height:300
          width: 1050
          Icon{
              anchors.top: image.bottom
              icon: IconType.bars
              color: "lightsteelblue"
              size:100
              MouseArea{
              }
          }
          Image {
              id:image
              height: 160
              width: 160
              source: images
              MouseArea{
              }
          }
          Text {
              height: 50
              width: 1050
              clip: true
              id: nametext
              anchors.left: image.right
              anchors.leftMargin: 10
              text: '<b>Name:</b> ' + name
          }

          Text {
              width: 400
              height: 1050
              wrapMode:Text.WrapAnywhere
              clip: true
              id: essaytext
              anchors.top: nametext.bottom
              anchors.left: image.right
              anchors.leftMargin: 10
              text: '<b>Essay:</b> ' + atext
              MouseArea{
              }
          }
          MouseArea {
              anchors.fill: parent
              onClicked:{
                   item.ListView.view.currentIndex = index
              }
          }

      }
  }
  ListModel {
      id:lm
      ListElement { name: "1" ;atext:"a";images: "apple.png"}
      ListElement { name: "2" ;atext:"b";images: "apple.png"}
      ListElement { name: "3" ;atext:"c";images: "apple.png"}
      ListElement { name: "1" ;atext:"a";images: "apple.png"}
      ListElement { name: "2" ;atext:"b";images: "apple.png"}
      ListElement { name: "3" ;atext:"c";images: "apple.png"}
      ListElement { name: "1" ;atext:"a";images: "apple.png"}
      ListElement { name: "2" ;atext:"b";images: "apple.png"}
      ListElement { name: "3" ;atext:"c";images: "apple.png"}
  }
  Item{
      anchors.fill: parent
      anchors.topMargin:130
      anchors.leftMargin: 0
      anchors.rightMargin: 0
      anchors.bottomMargin: 0
      AppListView {
          id:al
              anchors.fill: parent
              model:lm
              delegate: delegate
              highlight: Rectangle { color: "Lightgray";  radius: 5;}
              highlightFollowsCurrentItem :true
      }
  }
}

