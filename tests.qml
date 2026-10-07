import QtQuick

Text {
    text: parseInt("12.53")
}

/*

Item {

    width: 500
    height: 500

    Row {
        id: rightRow

        anchors.fill: parent
        spacing: 5

        move: Transition {
            NumberAnimation {
                properties: "x"
                duration: 220
                easing: Easing.OutExpo
            }
        }

        Rectangle {
            color: "red"
            height: 50
            width: text1.implicitWidth

            TextInput {
                id: text1
                color: "blue"
                text: "hello world"
            }
        }

        Rectangle {
            height: 50
            width: parent.width / 3
            color: "blue"

            Text {
                id: text2

                anchors.fill: parent
                color: "red"
                text: "idk, maybe world?"
            }
        }

        Rectangle {
            height: 50
            width: parent.width / 3
            color: "black"

            Text {
                text: "hello world"
                color: "white"
            }
        }
    }
}
*/
