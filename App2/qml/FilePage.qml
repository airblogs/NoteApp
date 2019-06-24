import Felgo 3.0
import QtQuick 2.0

Page {
    id:filepage
    title: qsTr("文档")
    property variant v: []
    Item{
        anchors.top: searchBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        AppListView{
            anchors.fill: parent
            model: model
            delegate: delegate
            highlight: Rectangle { color: "Lightgray";  radius: 5;}
            highlightFollowsCurrentItem :true
        }
    }
    ListModel{
        id:model
    }
    Component {
        id: delegate
        Item {
            id:item
            height:220
            width: parent.width
            Item{
                anchors.left: parent.left
                id:imageitem
                height:220
                width: 360
                Item{
                    height:80
                    width: 100
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left

                    IconButton{
                        anchors.fill: parent
                        size:100
                        icon: IconType.bars
                        color: "lightsteelblue"
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                navigationStack.push(userPageComponent)
                            }
                        }
                    }
                }
                Text {

                        height: 40
                        width: 100
                        clip: true
                        id: nametext
                        anchors.left: parent.left
                        anchors.top: userimage.bottom
                        anchors.leftMargin: 5
                        text:  name
                }
                Image {
                    id:useimage
                    height: 100
                    width: 100
                    source: userimage
                }
                Image {
                    anchors.left: useimage.right
                    anchors.leftMargin: 10
                    id:image
                    height: 210
                    width: 220
                    source: firstimage
                }
            }
            Item{
                anchors.left: imageitem.right
                height:110
                width: 600
                Text {
                    height: 50
                    width: 600
                    clip: true
                    id: titletext
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    text: '<b>标题:</b> ' + thetitle
                }

                Text {
                    height: 150
                    width: 600
                    lineHeightMode: Text.FixedHeight
                    wrapMode:Text.WrapAnywhere
                    clip: true
                    id: essaytext
                    anchors.top: titletext.bottom
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    text: '<b>内容:</b> ' + atext
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    item.ListView.view.currentIndex = index
                }
                onDoubleClicked: {
                    navigationStack.push(openPageComponent,{images:images,atext:atext})
                }
            }
        }
   }
    SearchBar {
        id: searchBar
    }
    rightBarItem: IconButtonBarItem {
      icon: IconType.spotify
      color: "white"
      onClicked: dialog.open()

    }
    function setmodel(){
        console.log(arguments[0])
        if(arguments[0]=="文字"){
            var json = JSON.parse(fileio.text);
            model.clear()
            for (var i in json.TEXT) {
                if(json.TEXT[i].firstimage==""){
                    console.log(i)
                    var t = json.TEXT[ i ];
                    model.append( t );
                }
            }
        }else if(arguments[0]=="图片"){
            var json = JSON.parse(fileio.text);
            model.clear()
            //var count = json.TEXT.length;
            for (var i in json.TEXT) {
                v=json.TEXT[i].images.split(",")
                if(v.length==1&&v[0]!=""){
                    var t = json.TEXT[ i ];
                    model.append( t );
                }
            }
        }else if(arguments[0]=="图集"){
            var json = JSON.parse(fileio.text);
            model.clear()
            for (var i in json.TEXT) {
                v=json.TEXT[i].images.split(",")
                if(v.length>1){
                    console.log(i)
                    var t = json.TEXT[ i ];
                    model.append( t );
                }
            }
        }
    }

    Dialog {
          id: dialog
          title: "分类"
          negativeAction : false
          positiveAction : false
          AppListView {
              anchors.fill: parent
              model:ListModel {
                   ListElement { name: "文字" }
                   ListElement { name: "图片" }
                   ListElement { name: "图集" }
              }
              delegate: SimpleRow {
                  text: name
                  onSelected: {
                      setmodel(name)
                      dialog.close()
                  }
             }
         }
    }
}
