import QtQuick
import QtQuick.Layouts
import Quickshell

Rectangle {
    id: island

    color: "white"

    readonly property int closedWidth: 90
    readonly property int islandHeight: 32
    readonly property real gap: 20

    height: islandHeight
    state: "closed"

    readonly property real centerX: width / 2

    NetworkStatus {
        id: net
    }
    BatteryStatus {
        id: power
    }
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Rectangle {
        id: pill

        radius: height / 2
        height: island.islandHeight
        color: "#161616"
        clip: true

        readonly property real leftExtra: island.state === "peek" ? dateText.implicitWidth + dateText.anchors.rightMargin : 0
        readonly property real rightExtra: island.state === "peek" ? netSymbol.implicitWidth + netSymbol.anchors.leftMargin + powSymbol.implicitWidth + powSymbol.anchors.leftMargin : (net.important ? netSymbol.implicitWidth + netSymbol.anchors.leftMargin : 0) + (power.important ? powSymbol.implicitWidth + powSymbol.anchors.leftMargin : 0)
        x: island.centerX - island.closedWidth / 2 - leftExtra
        width: island.closedWidth + leftExtra + rightExtra

        Behavior on x {
            NumberAnimation {
                duration: 220
                easing.type: Easing.OutExpo
            }
        }
        Behavior on width {
            NumberAnimation {
                duration: 220
                easing.type: Easing.OutExpo
            }
        }

        Text {
            id: timeText

            x: island.centerX - pill.x - width / 2
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            text: Qt.formatTime(clock.date, "hh:mm")

            font {
                family: "JetBrainsMono Nerd Font"
                letterSpacing: -1
                pixelSize: 15
                bold: true
            }
        }

        Text {
            id: dateText

            anchors {
                right: timeText.left
                rightMargin: island.gap
                verticalCenter: timeText.verticalCenter
            }
            font {
                family: "JetBrainsMono Nerd Font"
                pixelSize: 12
            }

            color: "#aaaaaa"
            text: Qt.formatDate(clock.date, "ddd d")

            opacity: island.state === "peek" ? 1 : 0
            Behavior on opacity {
                NumberAnimation {
                    duration: 150
                }
            }
        }

        Text {
            id: netSymbol

            anchors {
                left: timeText.right
                leftMargin: island.gap
                verticalCenter: timeText.verticalCenter
            }
            font {
                family: "JetBrainsMono Nerd Font"
                pixelSize: 13
            }

            color: net.connected && net.internetReachable ? (net.signalStrength > 25 ? "#aaaaaa" : "#fbc02d") : "#ff8f00"

            text: {
                if (!net.connected)
                    return (net.internetReachable ? "󱜠" : "󰤮");
                if (!net.internetReachable) {
                    if (net.signalStrength > 75)
                        return "󰤩";
                    if (net.signalStrength > 50)
                        return "󰤦";
                    if (net.signalStrength > 25)
                        return "󰤣";
                    if (net.signalStrength > 0)
                        return "󰤠";
                    return "󰤫";
                }

                if (net.signalStrength > 75)
                    return "󰤨";
                if (net.signalStrength > 50)
                    return "󰤥";
                if (net.signalStrength > 25)
                    return "󰤢";
                if (net.signalStrength > 0)
                    return "󰤟";
                return "󰤯";
            }

            opacity: island.state === "peek" || net.important ? 1 : 0
            Behavior on opacity {
                NumberAnimation {
                    duration: 150
                }
            }
        }

        Text {
            id: powSymbol

            anchors {
                left: netSymbol.opacity > 0 ? netSymbol.right : timeText.right
                leftMargin: island.gap
                verticalCenter: timeText.verticalCenter
            }
            font {
                family: "JetBrainsMono Nerd Font"
                pixelSize: 13
            }

            color: "#aaaaaa"

            opacity: island.state === "peek" || power.important ? 1 : 0
            Behavior on opacity {
                NumberAnimation {
                    duration: 150
                }
            }

            text: {
                if (power.charging) {
                    if (power.percentage > 95)
                        return "󰂅";
                    if (power.percentage > 85)
                        return "󰂋";
                    if (power.percentage > 75)
                        return "󰂊";
                    if (power.percentage > 65)
                        return "󰢞";
                    if (power.percentage > 55)
                        return "󰂉";
                    if (power.percentage > 45)
                        return "󰢝";
                    if (power.percentage > 35)
                        return "󰂈";
                    if (power.percentage > 25)
                        return "󰂇";
                    if (power.percentage > 15)
                        return "󰂆";
                    if (power.percentage > 5)
                        return "󰢜";
                    return "󰢟";
                }
                if (power.percentage > 95)
                    return "󰁹";
                if (power.percentage > 85)
                    return "󰂂";
                if (power.percentage > 75)
                    return "󰂁";
                if (power.percentage > 65)
                    return "󰂀";
                if (power.percentage > 55)
                    return "󰁿";
                if (power.percentage > 45)
                    return "󰁾";
                if (power.percentage > 35)
                    return "󰁽";
                if (power.percentage > 25)
                    return "󰁼";
                if (power.percentage > 15)
                    return "󰁻";
                if (power.percentage > 5)
                    return "󰁺";
                return "󰂎";
            }
        }

        /*
        Text {
            id: netText

            anchors {
                left: netSymbol.right
                leftMargin: 5
                verticalCenter: timeText.verticalCenter
            }
            font {
                family: "JetBrainsMono Nerd Font"
                pixelSize: 12
            }

            color: net.connected && net.internetReachable ? (net.signalStrength > 25 ? "#aaaaaa" : "#fbc02d") : "#ff8f00"

            text: net.signalStrength + "%"

            opacity: island.state === "peek" ? 1 : 0
            Behavior on opacity {
                NumberAnimation {
                    duration: 150
                }
            }
          }*/

    }

    MouseArea {
        anchors.fill: pill
        hoverEnabled: true
        onExited: island.state = "closed"
        onEntered: island.state = "peek"
        onClicked: console.log("wow")
    }
}
