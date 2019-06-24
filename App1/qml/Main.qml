import Felgo 3.0
import QtQuick 2.0

App {
    id:app
      Navigation {
          id: navigation
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
          title: "图集"
          icon: IconType.pictureo
          NavigationStack {
            SavePage { }
          }
        }
        NavigationItem {
          title: "我的"
          icon: IconType.user
          NavigationStack {
            MyPage { }
          }
        }
      }
      Component { id: openPageComponent; OpenPage { } }
      Component { id: choosePageComponent; ChoosePage { } }
      Component { id: savePageComponent; SavePage { } }

}
