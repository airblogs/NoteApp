import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.9

Page{
    id:videopage
    MediaPlayer {
             id: mediaplayer
             autoPlay: true
             loops: MediaPlayer.Infinite
             source: "d.mp4"
           }

           VideoOutput {
             anchors.fill: parent
             source: mediaplayer
           }
}
