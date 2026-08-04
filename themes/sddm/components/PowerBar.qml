/**
 * Pixie SDDM - PowerBar Component
 * Author: xCaptaiN09
 */
import QtQuick
import QtQuick.Controls

Row {
    id: powerBarRoot
    spacing: 20
    height: 30

    property color textColor: "white"
    property string iconFontFamily: ""

    // Battery (With forced live updates)
    Row {
        id: batteryRow
        spacing: 5
        visible: typeof battery !== "undefined" && typeof battery.percent !== "undefined"
        anchors.verticalCenter: parent.verticalCenter

        property int pollTick: 0

        Text {
            id: batteryText
            text: {
                batteryRow.pollTick; // Force re-evaluation on timer tick
                return (typeof battery !== "undefined" && battery.present ? battery.percent : "0") + "%";
            }
            color: textColor
            font.pixelSize: 14
            font.weight: Font.Medium
            anchors.verticalCenter: parent.verticalCenter
        }
        Text {
            id: batteryIcon
            text: {
                batteryRow.pollTick; // Force re-evaluation on timer tick
                return (typeof battery !== "undefined" && battery.present && battery.charging) ? "󱐋" : "󰁹";
            }
            color: textColor
            font.pixelSize: 18
            font.family: powerBarRoot.iconFontFamily
            anchors.verticalCenter: parent.verticalCenter
        }

        // Bulletproof Live Update: SDDM sometimes fails to emit battery signals,
        // so we force a check every 5 seconds.
        Timer {
            interval: 5000
            running: typeof battery !== "undefined" && battery.present
            repeat: true
            onTriggered: {
                batteryRow.pollTick++;
            }
        }
    }

    // Keyboard Layout
    Text {
        text: (typeof keyboard !== "undefined" && keyboard.layouts[keyboard.currentLayout]) ? keyboard.layouts[keyboard.currentLayout].shortName : "US"
        color: textColor
        font.pixelSize: 14
        font.capitalization: Font.AllUppercase
        visible: typeof keyboard !== "undefined" && keyboard.layouts.length > 1
        anchors.verticalCenter: parent.verticalCenter

        MouseArea {
            anchors.fill: parent
            onClicked: {
                keyboard.currentLayout = (keyboard.currentLayout + 1) % keyboard.layouts.length
            }
        }
    }

    // Suspend
    AbstractButton {
        width: 30
        height: 30
        anchors.verticalCenter: parent.verticalCenter
        visible: typeof sddm !== "undefined" && sddm.canSuspend
        Accessible.name: "Suspend"
        onClicked: sddm.suspend()

        contentItem: Text {
            text: "󰤄"
            color: textColor
            font.pixelSize: 20
            font.family: powerBarRoot.iconFontFamily
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        background: Item {}
    }

    // Restart
    AbstractButton {
        width: 30
        height: 30
        anchors.verticalCenter: parent.verticalCenter
        visible: typeof sddm !== "undefined" && sddm.canReboot
        Accessible.name: "Restart"
        onClicked: sddm.reboot()

        contentItem: Text {
            text: "󰑐"
            color: textColor
            font.pixelSize: 20
            font.family: powerBarRoot.iconFontFamily
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        background: Item {}
    }

    // Shutdown
    AbstractButton {
        width: 30
        height: 30
        anchors.verticalCenter: parent.verticalCenter
        visible: typeof sddm !== "undefined" && sddm.canPowerOff
        Accessible.name: "Shutdown"
        onClicked: sddm.powerOff()

        contentItem: Text {
            text: "󰐥"
            color: textColor
            font.pixelSize: 20
            font.family: powerBarRoot.iconFontFamily
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        background: Item {}
    }
}
