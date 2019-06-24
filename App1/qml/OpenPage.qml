import QtQuick 2.0
import QtQuick.Controls 1.2
import Felgo 3.0



ListPage{
    id:openpage
    title: qsTr("open")
    property int count: 0
    //获取图片文字并显示
    function setFilesModel(){
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
                anchors.fill:parent
                }
            }
        }

}

