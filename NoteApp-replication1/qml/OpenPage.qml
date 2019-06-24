import QtQuick 2.0
import QtQuick.Controls 1.2
import Felgo 3.0



Page{
    id:openpage
    title: qsTr("open")
    property string images:""
    property string  atext:""
    property variant t: []
    function setFilesModel(){
        console.log(arguments[0])
        filesModel.clear();
        for(var i = 0; i < arguments[0].length; i++){
            var data = {"filePath": arguments[0][i]};
            filesModel.append(data);
            multiPics.currentIndex = 0;
        }
    }

    GridView {
        id:multiPics
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
            height: multiPics.cellHeight - 10
            fillMode: multiPics.fillMode
            asynchronous: true
            source: filePath
            MouseArea{
                id:mouseArea
                anchors.fill: parent
                onClicked: {
                    theimage.source=filePath
                    aimage.open()
                }
            }
        }
    }

    AppImage {
    id: firstimage
    anchors.fill: parent
    autoTransform: true
    fillMode: Image.PreserveAspectFit
    }

    Text {
        id: text
    }
    Timer{
        interval: 500; running: true; repeat: false
        onTriggered: {
            images=images.replace("[",'')
            images=images.replace("]",'')
            t=images.split(",")
            //console.log()
            if(t.length>1){
                setFilesModel(t)
                console.log(t.length)
            }else if(t.length==1&&t[0]!=""){
                console.log(t.length)
                firstimage.source = t[0]

            }else{
                text.text='<b>内容:</b> '+atext
            }
        }
    }

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
    //AppButton{
    //    text: "ad"
    //    anchors.bottomMargin: 0
    //    anchors.bottom: textbutton.top
    //    anchors.horizontalCenter: parent.horizontalCenter
    //    onClicked: {
    //        if(images.length>1){
    //            setFilesModel(images)
    //            console.log(images)
    //        }else{
    //            firstimage.source = images[0]
    //        }
    //    }
    //}
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
    Dialog{
        id:aimage
        positiveAction:false
        negativeActionLabel: "Close"
        onCanceled: close()
            Image {
            id:theimage
            source: ""
            anchors.fill: parent
        }
    }

}


