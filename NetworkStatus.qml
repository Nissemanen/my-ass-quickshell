import QtQuick
import Quickshell.Io

QtObject {
    id: net

    property bool connected: false
    property int signalStrength: 0
    property bool internetReachable: false
    property bool hotspot: false
    property bool important: (!net.internetReachable && !net.connected) || net.signalStrength < 15

    property Process proc: Process {
        command: ["sh", "-c", "nmcli -t -f active,signal dev wifi | grep '^yes'; ping -c1 -W1 1.1.1.1 >/dev/null 2>&1 && echo 1 || echo 0 && nmcli device status"]
        stdout: StdioCollector {
            onStreamFinished: {
                const lines = text.trim().split("\n");
                const activeLine = lines.find(l => l.startsWith("yes:"));
                const connectionTypeLines = lines.find(l => (l.includes("connected") && !l.includes("lo") && !l.includes("docker0")));

                net.signalStrength = activeLine ? (parseInt(activeLine.split(":")[1]) || 0) : 0;
                //net.signalStrength = 10;
                net.connected = !!activeLine;
                net.internetReachable = lines.includes("1");
                //net.internetReachable = false;
                net.hotspot = connectionTypeLine ? (!!connectionTypeLines.find(l => l.includes("ethernet")) && !connectionTypeLine.find(l => l.includes("wifi"))) : false;
            }
        }
    }

    property Timer poll: Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: net.proc.running = true
    }
}
