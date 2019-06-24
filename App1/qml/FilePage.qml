import Felgo 3.0
import QtQuick 2.0

Page {
    id:filepage
    title: qsTr("文档")
    SearchBar {
        id: searchBar
    }
    rightBarItem: IconButtonBarItem {
      icon: IconType.spotify
      color: "white"
      onClicked: dialog.open()
    }
    Dialog {
          id: dialog
          title: "分类"
          negativeAction : false
          positiveAction : false
          AppListView {
              anchors.fill: parent
              model:ListModel {
                   ListElement { name: "文档" }
                   ListElement { name: "视频" }
                   ListElement { name: "音频" }
                 }
              delegate: SimpleRow {
                  text: name
                  onSelected: {
                    //if(name=="1"){
                    //dialog.close()
                    //}
                  }
              }
        }
    }
}
