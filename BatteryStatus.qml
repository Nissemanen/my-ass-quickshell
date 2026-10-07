import QtQuick
import Quickshell.Io

QtObject {
    id: power

    property int percentage: 0
    property int timeToEmpty: 0
    property bool charging: false
    property bool important: (power.percentage <= 10 && !power.charging) || power.warning != "none"
    property string warning: "none"

    property Process proc: Process {
        command: ["upower", "-i", "/org/freedesktop/UPower/devices/battery_BAT0"]
        stdout: StdioCollector {
            onStreamFinished: {
                const lines = text.trim().split("\n");
                const percentageLine = lines.find(l => l.startsWith("    percentage:"));
                const timeToEmptyLine = lines.find(l => l.startsWith("    time to empty:"));
                const chargingLine = lines.find(l => l.startsWith("    state:"));
                const warningLine = lines.find(l => l.startsWith("    warning-level:"));

                power.percentage = percentageLine ? (parseInt(percentageLine.split(":")[1]) || 0) : 0;
                power.timeToEmpty = timeToEmptyLine ? (parseInt(timeToEmptyLine.split(":")[1]) || 0) : 9;
                power.charging = !chargingLine.includes("discharging");
            }
        }
    }

    property Timer poll: Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: power.proc.running = true
    }
}
