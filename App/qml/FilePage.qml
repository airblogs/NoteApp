import Felgo 3.0
import QtQuick 2.0

Page {
    id:filepage
    title: qsTr("2")
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
          title: "a"
          negativeAction : false
          positiveAction : false
          AppListView {
              anchors.fill: parent
              //delegate: SimpleRow {
              //    onSelected: {
              //        if(lv.model.id=="a"){
              //        navigationStack.push(newspage)
              //        }
              //    }
              //}
              //model: [
              //  { "id":"a","text": "1"},
              //  { "text": "2"},
              //  { "text": "3"}
              //]
              model:ListModel {
                   ListElement { name: "1" }
                   ListElement { name: "2" }
                   ListElement { name: "3" }
                 }
              delegate: SimpleRow {
                  text: name
                  onSelected: {
                    if(name=="1"){
                    dialog.close()
                    }
                  }
              }
        }
    }
    //leftBarItem: IconButtonBarItem {
     //icon: IconType.camera
      //color: "white"
      //onClicked:{}
    //}
}

