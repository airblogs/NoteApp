import Felgo 3.0
import QtQuick 2.0

Page {
    id:filepage
    title: qsTr("文档")

    property variant v: []

    //分类栏
    rightBarItem: IconButtonBarItem {
      icon: IconType.spotify
      //color: "lightblue"
      color:"white"
      onClicked: dialog.open()
    }




    //判断多图片或但图片或文字显示
    function setmodel(){
        console.log(arguments[0])
        if(arguments[0]=="文字"){
            var json = JSON.parse(fileio.text);
            model.clear()
            for (var i in json.TEXT) {
                if((json.TEXT[i].firstimage==""||json.TEXT[i].firstimage=="undefined")&&(json.TEXT[i].atext!=""||json.TEXT[i].thetitle!="")){
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


    //搜索
    SearchBar {
        id: searchBar
        onAccepted: {
            var json = JSON.parse(fileio.text);
            model.clear()
            for (var i in json.TEXT) {
                if(json.TEXT[i].thetitle==text&&json.TEXT[i].title!=""){
                    var t = json.TEXT[ i ];
                    model.append( t );
                }
            }

        }
    }

    //listview显示布局
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
        Item{
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
                        id: nametext
                        height: 40
                        width: 100
                        clip: true
                        anchors.left: parent.left
                        anchors.top: useimage.bottom
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
                    id:image
                    anchors.left: useimage.right
                    anchors.leftMargin: 10
                    height: 210
                    width: 220
                    source: firstimage
                }
            }
            Item{
                anchors.left: imageitem.right
                height:110
                width: parent.width-110
                Text {
                    id: titletext
                    height: 50
                    width: 300
                    clip: true
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    text: '<b>标题:</b> ' + thetitle
                }
                Text{
                    id:timetext
                    height: 50
                    width: 700
                    anchors.right: parent.right
                    text: time
                }

                Text {
                    id: essaytext
                    height: 150
                    width: parent.width-330
                    lineHeightMode: Text.FixedHeight
                    wrapMode:Text.WrapAnywhere
                    clip: true
                    anchors.top: titletext.bottom
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    text: '<b>内容:</b> ' + atext
                }
            }

            //单击选中，双击进入openpage
            MouseArea {
                height: 220
                width: parent.width-110
                anchors.right:  parent.right
                onPressAndHold: ListView.view.Items.dragMode =
                                !ListView.view.Items.dragMode
                onClicked:{
                     item.ListView.view.currentIndex = index
                }
                onDoubleClicked: {

                    navigationStack.push(openPageComponent,{images:images,atext:atext})

                }
            }
        }
    }
    //显示分类
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
                      console.log("A")
                      setmodel(name)
                      dialog.close()
                  }
             }
         }
    }


}


