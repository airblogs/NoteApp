import QtQuick 2.0
import QtQuick.Controls 1.2
import Felgo 3.0
import "savejson.js" as Data



Page{
    id:openpage
    title: qsTr("open")
    property string images:""
    property string  atext:""
    property string number: ""
    property variant t: []

    rightBarItem: IconButtonBarItem {
      icon: IconType.remove
      color:"white"
      onClicked: {
          var json = JSON.parse(fileio.text);
          model.clear()
          var count = json.TEXT.length;
          for (var i in json.TEXT) {
              var t = json.TEXT[ i ];
              if(t.number!=number){
                  model.append( t );
              }
          }
          var res = Data.serialize(model);
          fileio.text = res;
      }

    }
    ListModel{
        id:model
    }

    //自动刷行显示
    Timer{
        interval: 500; running: true; repeat: false
        onTriggered: {
            images=images.replace("[",'')
            images=images.replace("]",'')
            t=images.split(",")
            console.log(t)
            if(t.length>1){
                setFilesModel(t)
                console.log(t.length)
            }else if(t.length==1&&t[0]!=""){
                console.log(t.length)
                firstimage.source = t[0]

            }else {
                text.text='<b>内容:</b> '+atext
            }
        }
    }

    //设置model
    function setFilesModel(){
        console.log(arguments[0])
        filesModel.clear();
        for(var i = 0; i < arguments[0].length; i++){
            var data = {"filePath": arguments[0][i]};
            filesModel.append(data);
            multiPics.currentIndex = 0;
        }
    }

    //多图片显示
    GridView {
        id:multiPics
        cellHeight: 300
        cellWidth: 300
        anchors.fill: parent
        property int fillMode: Image.PreserveAspectFit
        model:filesModel
        delegate: imageDelegate
    }

    ListModel{
        id:filesModel
    }

    Component {
        id: imageDelegate
        Image {
            id:image
            width: multiPics.cellWidth - 10;
            height: multiPics.openPageComponentcellHeight - 10
            fillMode: multiPics.fillMode
            asynchronous: true
            source: filePath
            MouseArea{
                id:mouseArea
                anchors.fill: parent
                onClicked: {
                    navigationStack.push(openimagePageComponent,{imagesource:filePath})
                    //theimage.source=filePath
                    //aimage.open()
                }
            }
        }
    }

    //单图片显示
    AppImage {
    id: firstimage
    anchors.fill: parent
    autoTransform: true
    fillMode: Image.PreserveAspectFit
    }

    //文字显示
    Text {
        id: text
    }

    //点击查看文字
    AppButton{
        id:textbutton
        icon: IconType.file
        anchors.bottomMargin: 0
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
            textdialog.open()
        }
    }

    //文字显示
    Dialog{
        id:textdialog
        Text {
            anchors.centerIn: parent
            text: atext
        }
        positiveAction:false
        negativeActionLabel: "Close"
        onCanceled: close()
    }

    //显示多图片选中的大图
    Dialog{
        id:aimage
        height: parent.height
        width: parent.width
        positiveAction:false
        negativeActionLabel: "Close"
        onCanceled: close()
            Image {
            id:theimage
            source: ""
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }
    }

}



