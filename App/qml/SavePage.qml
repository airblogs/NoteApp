import Felgo 3.0
import QtQuick 2.0

Page {
  id:savepage
  title: qsTr("4")
  SearchBar {
      id: searchBar

  }
  rightBarItem: IconButtonBarItem {
    icon: IconType.lightbulbo
    color: "white"
    onClicked:{}
  }
}
