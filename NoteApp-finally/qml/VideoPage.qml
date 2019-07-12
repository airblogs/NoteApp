import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.9

Page{
    id:videopage
    MediaPlayer {
             id: mediaplayer
             autoPlay: true
             loops: MediaPlayer.Infinite
             source: "file:///storage/emulated/0/Android/data/com.yourcompany.wizardEVAP.NoteAppreplication1/files/Video/show.mp4"
           }

           VideoOutput {
             anchors.fill: parent
             source: mediaplayer
           }
}

