import Felgo 3.0
import QtQuick 2.0

App {
    id:app
      Navigation {
          id: navigation
        //drawer.drawerPosition: drawer.drawerPositionLeft
        //navigationMode: navigationModeTabsAndDrawer
        NavigationItem {
          title: "1"
          icon: IconType.file
          NavigationStack {
            NewsPage { }
          }
        }
        NavigationItem {
          title: "2"
          icon: IconType.folder
          NavigationStack {
            FilePage { }
          }
        }
        NavigationItem {
          title: "3"
          icon: IconType.plus
          NavigationStack {
              AddPage{}
          }
        }
        NavigationItem {
          title: "4"
          icon: IconType.star
          NavigationStack {
            SavePage { }
          }
        }
        NavigationItem {
          title: "5"
          icon: IconType.user
          NavigationStack {
            MyPage { }
          }
        }
      }
}
