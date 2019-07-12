import Felgo 3.0
import QtQuick 2.0

App {
    id:app

    property bool userLoggedIn: false
    LoginPage {
      z: 1
      visible: opacity > 0
      enabled: visible
      opacity: userLoggedIn ? 0 : 1
      onLoginSucceeded: userLoggedIn = true

      Behavior on opacity { NumberAnimation { duration: 250 } }
    }
    //导航页
      Navigation {
          id: navigation
          enabled: userLoggedIn

        NavigationItem {
          title: "新文件"
          icon: IconType.file
          NavigationStack {
            NewsPage { }
          }
        }
        NavigationItem {
          title: "文档"
          icon:IconType.folder
          NavigationStack {
            FilePage { }
          }
        }
        NavigationItem {
          title: "添加"
          icon: IconType.plus
          NavigationStack {
              AddPage{}
          }
        }
        NavigationItem {
          title: "图片"
          icon: IconType.pictureo
          NavigationStack {
            ImagesPage { }
          }
        }
        NavigationItem {
          title: "我的"
          icon: IconType.user
          NavigationStack {
            MyPage {
                onLogoutClicked: userLoggedIn = false
            }
          }
        }
      }

      //navigationStack.push
      Component { id: openPageComponent; OpenPage { } }
      Component { id: imagesPageComponent; ImagesPage { } }
      Component { id: userPageComponent; UserPage { } }
      Component { id: videoPageComponent; VideoPage{ } }
      Component { id: openimagePageComponent; OpenimagePage{ } }
      Component { id: changePageComponent; ChangePage{ } }

}


