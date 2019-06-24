import Felgo 3.0
import QtQuick 2.0

Page {
  id:savepage
  title: qsTr("图片")
  //property var asd: ImagePicker.selection
  SearchBar {
      id: searchBar

  }
  rightBarItem: IconButtonBarItem {
        id:a
        icon: IconType.pictureo
        color: "white"
        onClicked:{
            dialog.open()
        //    navigationStack.push(choosePageComponent)
        //    console.debug("SELECTED:", JSON.stringify(imagePicker.selection))
        }
  }
  function setFilesModel(){
      filesModel.clear();
      for(var i = 0; i < arguments[0].length; i++){
          var data = {"filePath": arguments[0][i]};
          filesModel.append(data);
          multiPics.currentIndex = 0;
      }
  }
  Item{
      anchors.top: searchBar.bottom
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.bottom: parent.bottom
      GridView {
          id:multiPics
          cellHeight: 300
          cellWidth: 300
          anchors.fill: parent
          property int fillMode: Image.PreserveAspectFit
          model:filesModel
          delegate: imageDelegate
      }
  }
  ListModel{
      id:filesModel
  }
  Component {
      id: imageDelegate
      Image {
          id:image
          width: multiPics.cellWidth - 10;
          height: multiPics.cellHeight - 10
          fillMode: multiPics.fillMode
          asynchronous: true
          source: filePath
          MouseArea{
              id:mouseArea
              //anchors.fill:parent
              }
          }
      }
  Dialog{
      id:dialog
      positiveActionLabel: "OK"
      negativeActionLabel: "Close"
      onCanceled: close()
      onAccepted: {
          setFilesModel(imagePicker.selection)
          close()
      }

      ImagePicker {
          id: imagePicker
          anchors.fill: parent
      }
  }
  //获取图片并网格显示
  //获取文字并存入json
  //AppImage {
  //    id: image
  //    anchors.fill: parent
  //    autoTransform: true
  //    fillMode: Image.PreserveAspectFit
  //}
  //Connections {
  //    target: nativeUtils
  //    onImagePickerFinished: {
  //    if(accepted) image.source = path
  //    }
  //}
}
