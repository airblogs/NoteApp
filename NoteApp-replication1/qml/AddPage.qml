import Felgo 3.0
import QtQuick 2.0
import "savejson.js" as Data

Page{
    id:addpage
    title: qsTr("添加")
    property string time: Qt.formatDateTime(new Date(), "yyyy-MM-dd  hh-mm-ss  dddd")
    property string imagesource:""
    rightBarItem: IconButtonBarItem {
        icon: IconType.camera
        color: "white"
        onClicked:{
           nativeUtils.displayCameraPicker("test")
        }
    }
    Item {
        AppTextField{
            id:title
            anchors.top: parent.top
            placeholderText: "The title:"
        }
        Text{
            id:text
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Piease enter the text:")
            anchors.bottom: textitem.top
            anchors.top:title.bottom
        }
        id: textitem
        anchors.topMargin: 1000
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        TextEdit {
            id:textedit
            anchors.topMargin: 150
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            wrapMode:Text.WrapAnywhere
            clip: true
            focus: true
        }
    }
    Item {
        id: imagetext
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: textitem.top
        anchors.topMargin: 10
        anchors.bottomMargin: 40
        anchors.leftMargin: 10
        anchors.rightMargin: 10
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
            imagesource=path
            console.log(imagesource)
            }
        }
    }
    //        time=Qt.formatDateTime(new Date(), "yyyy-MM-dd  hh-mm-ss  dddd")
    ListModel{
        id:models
    }

    AppButton{
        id:plus
        icon: IconType.plus
        anchors.bottomMargin: 0
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
            time=Qt.formatDateTime(new Date(), "yyyy-MM-dd  hh-mm-ss  dddd")
            var data = {
                "name":"a",
                "userimage":"qrc:user.png",
                "time":time,
                "firstimage":imagesource,
                "images":imagesource,
                "thetitle":title.text,
                "atext":textedit.text
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

}
