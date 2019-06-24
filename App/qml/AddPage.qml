import Felgo 3.0
import QtQuick 2.0

Page{
    title: qsTr("3")
    AppButton {
        anchors.centerIn: parent
        id:button
        text: "add"
               onClicked: dialog.open()
    }
    Dialog {
          id: dialog
          title: "add"
          negativeAction : false
          positiveAction : false
          AppListView {
              anchors.fill: parent
              //delegate: SimpleRow {
                  //navigationStack.push(newspage)
              //}
          //model: [
          //  { "text": "1"},
          //  { "text": "2"},
          //  { "text": "3"}
          //]
              model:ListModel {
                  id:lm
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
}
