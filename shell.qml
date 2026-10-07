import Quickshell
import QtQuick

ShellRoot {
    PanelWindow {
        id: bar
        anchors {
            top: true
            left: true
            right: true
        }

        margins.top: 5
        aboveWindows: true

        height: 32
        color: "transparent"

        Item {
            anchors.centerIn: parent
            width: island.width
            height: island.height

            Island {
                id: island
                anchors.centerIn: parent
            }
        }
    }
}
