import QtQuick
import Quickshell

Item {
    id: island

    readonly property int closedWidth: 90
    readonly property real centerX: width / 2
    readonly property real gap: 15

    height: 32
    state: "closed"

    NetworkStatus {
        id: netStatus
    }
    BatteryStatus {
        id: batStatus
    }
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Rectangle {
        id: pill

        width: island.closedWidth
        x: island.centerX - width / 2

        radius: height / 2
        height: parent.height
        color: "#161616"
        clip: true

        Behavior on x {
            NumberAnimation {
                duration: 220
                easing: Easing.OutExpo
            }
        }
        Behavior on width {
            NumberAnimation {
                duration: 220
                easing: Easing.OutExpo
            }
        }

        Row {
            id: middleRow
            x: island.centerX - pill.x - width / 2
            anchors.verticalCenter: parent.verticalCenter

            Text {
                id: timeText

                color: "white"
                text: Qt.formatTime(clock.date, "hh:mm")

                font {
                    family: "JetBrainsMono Nerd Font"
                    letterSpacing: -1
                    pixelSize: 15
                    bold: true
                }
            }
        }
    }
}
