import Felgo 3.0
import QtQuick 2.0
import "savejson.js" as Data

Page {

  id:savepage
  title: qsTr("图集")

  property int number: -1
  property string time: Qt.formatDateTime(new Date(), "yyyy-MM-dd  hh-mm-ss  dddd")
  property string name: "a"
  property string userimage : "qrc:user.png"
  property string thetitle: "A"
  property var imagesource :NULL
  property var imagesources:NULL
  property string atext:""

  //选择相册中的图片
  rightBarItem: IconButtonBarItem {
        id:a
        icon: IconType.pictureo
        //color: "lightblue"
        color:"white"
        onClicked:{
            imagedialog.open()
        }
  }

  //将图片路径存入model
  function setFilesModel(){
      filesModel.clear();
      for(var i = 0; i < arguments[0].length; i++){
          var data = {"filePath": arguments[0][i]};
          filesModel.append(data);
          multiPics.currentIndex = 0;
      }
  }

  //gridview 网格显示
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

  //添加文字按钮
  AppButton{
      icon: IconType.fileo
      anchors.bottomMargin: 0
      anchors.bottom: plus.top
      anchors.horizontalCenter: parent.horizontalCenter
      onClicked: {
          textdialog.open()
      }
  }

  //添加文字
  Dialog{
      id:textdialog
      AppTextField{
          id:title
          placeholderText: "The title:"
          anchors.horizontalCenter: parent.horizontalCenter
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

  //选择图片
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

  //将数据存入jison
  AppButton{
      id:plus
      icon: IconType.plus
      anchors.bottomMargin: 0
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      onClicked: {
          if(number<0){
              time=Qt.formatDateTime(new Date(), "yyyy-MM-dd  hh-mm-ss  dddd")
              var json = JSON.parse(fileio.text);
              models.clear()
              var count = json.TEXT.length;
              for (var i in json.TEXT) {
                  var t = json.TEXT[ i ];
                  models.append( t );
              }
              //console.log(json.TEXT[count-1].name)
              //console.log(json.TEXT[count-1].password)
                  var data = {
                  "name":json.TEXT[count-1].name,
                  "password":json.TEXT[count-1].password,
                  "userimage":json.TEXT[count-1].userimage,
                  "time":time,
                  "firstimage":imagesource,
                  "images":imagesources.toString(),
                  "thetitle":thetitle,
                  "atext":atext
              }
              models.append(data)
              var res = Data.serialize(models);
              fileio.text = res;
          }else {
              time=Qt.formatDateTime(new Date(), "yyyy-MM-dd  hh-mm-ss  dddd")
              var json = JSON.parse(fileio.text);
              models.clear()
              var count = json.TEXT.length;
              var data = {
                  "name":json.TEXT[count-1].name,
                  "password":json.TEXT[count-1].password,
                  "userimage":json.TEXT[count-1].userimage,
                  "time":time,
                  "firstimage":imagesource,
                  "images":imagesources.toString(),
                  "thetitle":thetitle,
                  "atext":atext
              }
              for (var i in json.TEXT) {
                  var t = json.TEXT[ i ];
                  if(t.number==number){
                      t=data
                  }
                  models.append( t );
              }
              var res = Data.serialize(models);
              fileio.text = res;
          }

          //清空
          imagesource=""
          imagesources=""
          filesModel.clear()
          title.text=""
          thetext.text=""
      }
  }

  ListModel{
      id:models
  }

}



