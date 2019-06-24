import Felgo 3.0
import QtQuick 2.0

Page{
    title: qsTr("添加")
    AppButton {
        anchors.centerIn: parent
        id:button
        text: "add"
               onClicked:{
                   dialog.open()
               }
    }
    Dialog {
          id: dialog
          title: "add"
          negativeAction : false
          positiveAction : false
          AppListView {
              anchors.fill: parent
              model:ListModel {
                  id:lm
                  ListElement { name: "文档" }
                  ListElement { name: "视频" }
                  ListElement { name: "音频" }
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
}

