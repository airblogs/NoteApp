import QtQuick 2.0
import QtQuick.Controls 1.2
import Felgo 3.0

Page{
    id: page
    title: qsTr("Choose Photos")
    property int count: 0

    rightBarItem: TextButtonBarItem {
        text: "Ok"
        enabled: imagePicker.selectedCount > 0
        onClicked: {
            //SavePage{}
            //navigationStack.push(savePageComponent,{asd:imagePicker.selection})
            //图片路径存入json
        }
    }
    ImagePicker {
        id: imagePicker
        anchors.fill: parent
    }
}


