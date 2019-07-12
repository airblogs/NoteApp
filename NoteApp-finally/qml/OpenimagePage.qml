import Felgo 3.0
import QtQuick 2.0

Page{
    id:imagepage

    property string imagesource :""

    Image {
    id:theimage
    source: imagesource
    anchors.fill: parent
    fillMode: Image.PreserveAspectFit
    }
}

