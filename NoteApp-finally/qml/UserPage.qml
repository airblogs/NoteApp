import QtQuick 2.0
import QtQuick.Controls 1.2
import Felgo 3.0
import "savejson.js" as Data

Page{

    id: userpage
    title: qsTr("用户信息")
    property string name:""
    property string userimage:""
    property string firsttime:""
    property string lasttime:""
    property string firstlogintime:""
    property string lastlogintime:""
    property var userimagepath:NULL

    Item {
        id:useritem
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height/2
        Image {
            anchors.centerIn: parent
            id: user
            source: userimage

        }
        MouseArea{
            anchors.fill:parent
            onClicked: {
                imagedialog.open()
        }
    }
    Item {
        id: nameitem
        anchors.top: useritem.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height/8
        Text {
            anchors.centerIn: parent
            text: name
        }
    }
    Item {
        id: timeitem
        anchors.top: nameitem.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height*3/8

        Timer{
            interval: 500; running: true; repeat: false
            onTriggered: {
                var json = JSON.parse(fileio.text);
                var count = json.TEXT.length;
                for (var i in json.TEXT) {
                    firsttime=""
                    if((name==json.TEXT[ i ].name)&&(json.TEXT[ i ].atext!=""||json.TEXT[ i ].thetitle!=""||json.TEXT[ i ].firstimage!="")){
                        firsttime=json.TEXT[ i ].time
                        break;
                    }

                }
                for(var x=count-1;x>=0;x--){
                    lasttime=""
                    if((name==json.TEXT[ x ].name)&&(json.TEXT[ x ].atext!=""||json.TEXT[ x ].thetitle!=""||json.TEXT[ x ].firstimage!="")){
                        lasttime=json.TEXT[ x ].time
                        break;
                    }
                }
                for(var z in json.TEXT){
                    firstlogintime=""
                    if(name==json.TEXT[ z ].name){
                        firstlogintime=json.TEXT[ z ].time
                        break;
                    }
                }

                for(var y=count-2;y>=0;y--){
                    lastlogintime=""
                    if(name==json.TEXT[ y ].name){
                        lastlogintime=json.TEXT[ y ].time
                        break;
                    }
                }

            }
        }

        Text {
            anchors.centerIn: parent
            text:"第一次登录时间："+firstlogintime+"\n上一次登录时间："+lastlogintime+"\n第一次发表时间："+firsttime+"\n上一次发表时间："+lasttime
        }
    }
    ListModel{
        id:models
    }

    Dialog{
        id:imagedialog
        positiveActionLabel: "OK"
        negativeActionLabel: "Close"
        onCanceled: close()
        onAccepted: {
            userimagepath=imagePicker.selection[0]
            console.log(userimagepath)
            var json = JSON.parse(fileio.text);
            models.clear()
            var count = json.TEXT.length;
            for (var i in json.TEXT) {
                var t = json.TEXT[ i ];
                if(t.name==name){
                    t.userimage=userimagepath
                    console.log(t.userimage)
                }
                models.append( t );
            }
            var res = Data.serialize(models);
            fileio.text = res;
            close()
        }
        ImagePicker {
            id: imagePicker
            anchors.fill: parent
        }
    }
    }


}

