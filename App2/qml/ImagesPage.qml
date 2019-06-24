import Felgo 3.0
import QtQuick 2.0
import "savejson.js" as Data

Page {
  id:savepage
  title: qsTr("图集")
  property string time: Qt.formatDateTime(new Date(), "yyyy-MM-dd  hh-mm-ss  dddd")
  property string name: "a"
  property string userimage : "../../App2/apple.png"
  property string thetitle: "A"
  property var imagesource :NULL
  property var imagesources:NULL
  property string atext:""

  rightBarItem: IconButtonBarItem {
        id:a
        icon: IconType.pictureo
        color: "white"
        onClicked:{
            imagedialog.open()
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
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.bottom: parent.bottom
      GridView {
          id:multiPics
          cellHeight: 500
          cellWidth: 500
          anchors.fill: parent
          property int fillMode: Image.PreserveAspectFit
          model:filesModel
          delegate: imageDelegate
      }
  }
  ListModel{
      id:filesModel
  }
  ListModel{
      id:models
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
              anchors.fill:parent
              }
          }
      }
  AppButton{
      icon: IconType.fileo
      anchors.bottomMargin: 0
      anchors.bottom: plus.top
      anchors.horizontalCenter: parent.horizontalCenter
      onClicked: {
          textdialog.open()
      }
  }
  AppButton{
      id:plus
      icon: IconType.plus
      anchors.bottomMargin: 0
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      onClicked: {
          var data = {
              "name":"a",
              "userimage":"apple.png",
              "firstimage":imagesource,
              "images":imagesources,
              "thetitle":thetitle,
              "atext":atext
          }
          var json = JSON.parse(fileio.text);
          models.clear()
          var count = json.TEXT.length;
          for (var i in json.TEXT) {
              var t = json.TEXT[ i ];
              models.append( t );
          }
          models.append(data)
          var res = Data.serialize(models);
          fileio.text = res;

      }
  }

  Dialog{
      id:textdialog
      AppTextField{
          id:title
          placeholderText: "The title:"
      }
      TextEdit {
          id:thetext
          anchors.top:title.bottom
          anchors.left:parent.left
          anchors.right:parent.right
          anchors.bottom:parent.bottom
          wrapMode:Text.WrapAnywhere
          clip: true
          focus: true
      }
      positiveActionLabel: "OK"
      negativeActionLabel: "Close"
      onCanceled: close()
      onAccepted: {
          time=Qt.formatDateTime(new Date(), "yyyy-MM-dd  hh-mm-ss  dddd")
          atext=thetext.text
          thetitle=title.text
          close()
      }
  }

  Dialog{
      id:imagedialog
      positiveActionLabel: "OK"
      negativeActionLabel: "Close"
      onCanceled: close()
      onAccepted: {
          imagesource=imagePicker.selection[0]
          imagesources=imagePicker.selection
          setFilesModel(imagePicker.selection)
          close()
      }

      ImagePicker {
          id: imagePicker
          anchors.fill: parent
      }
  }

}
