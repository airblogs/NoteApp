import Felgo 3.0
import QtQuick 2.0
import QtQuick.Layouts 1.1
import "savejson.js" as Data

Page {
  id: loginPage
  title: "Login"

  signal loginSucceeded

  backgroundColor: Qt.rgba(0,0,0, 0.75)

  property string time: Qt.formatDateTime(new Date(), "yyyy-MM-dd  hh-mm-ss  dddd")

  property bool hasname:false
  property bool password:false
  property var userimage: NULL

  Rectangle {
    id: loginForm
    anchors.centerIn: parent
    color: "white"
    width: content.width + dp(48)
    height: content.height + dp(16)
    radius: dp(4)
  }

  GridLayout {
    id: content
    anchors.centerIn: loginForm
    columnSpacing: dp(20)
    rowSpacing: dp(10)
    columns: 2

    AppText {
      Layout.topMargin: dp(8)
      Layout.bottomMargin: dp(12)
      Layout.columnSpan: 2
      Layout.alignment: Qt.AlignHCenter
      text: "Login"
    }

    AppText {
      text: qsTr("name")
      font.pixelSize: sp(12)
    }

    AppTextField {
      id: txtUsername
      Layout.preferredWidth: dp(200)
      showClearButton: true
      font.pixelSize: sp(14)
      borderColor: Theme.tintColor
      borderWidth: !Theme.isAndroid ? dp(2) : 0
    }

    AppText {
      text: qsTr("Password")
      font.pixelSize: sp(12)
    }

    AppTextField {
      id: txtPassword
      Layout.preferredWidth: dp(200)
      showClearButton: true
      font.pixelSize: sp(14)
      borderColor: Theme.tintColor
      borderWidth: !Theme.isAndroid ? dp(2) : 0
      echoMode: TextInput.Password
    }

    Column {
      Layout.fillWidth: true
      Layout.columnSpan: 2
      Layout.topMargin: dp(12)

      AppButton {
        text: qsTr("Login")
        flat: false
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
            time=Qt.formatDateTime(new Date(), "yyyy-MM-dd  hh-mm-ss  dddd")

            var json = JSON.parse(fileio.text);
            models.clear()
            var count = json.TEXT.length;
            for (var i in json.TEXT) {

                if(json.TEXT[ i ].name==txtUsername.text){
                    userimage=json.TEXT[ i ].userimage
                    console.log(userimage)
                    hasname = true
                    if(txtPassword.text==json.TEXT[ i ].password){
                        password = true
                    }
                }

                var t = json.TEXT[ i ];
                models.append( t );

            }

            var data = {
                "name":txtUsername.text,
                "userimage":userimage,
                "password":txtPassword.text,
                "time":time,
                "firstimage":"",
                "images":"",
                "thetitle":"",
                "atext":""
            }

            if(hasname == true&&password == true){
                console.debug("Login Successful!")
                models.append(data)
            }else if(hasname == false){

                console.debug("Creat login Successful!")
                models.append(data)
            }else{
                reminder.text="密码错误!"
                console.debug("Password error!")
            }

            var res = Data.serialize(models);
            fileio.text = res;


            //model.clear()
            //for (var n in json.TEXT) {
            //    var m = json.TEXT[ n ];
            //    if(json.TEXT[ n ]==json.TEXT[ count ]){
            //        model.append( m );
            //    }
            //}
            //var res = Data.serialize(models);
            //fileio.text = res;

            if((hasname == true&&password == true)||hasname == false){
                loginSucceeded()
            }
        }
      }


      ListModel{
          id:models
      }

      AppButton {
        id:reminder
        text: ""
        flat: true
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
        }
      }
    }
  }
}
