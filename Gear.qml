import QtQuick 2.15
import QtGraphicalEffects 1.15

Item {
    id: gearLayout
    width: parent.width
    height: parent.height

    RadialGradient {
        visible: showBackButton
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: themeColor }
            GradientStop { position: 0.4; color: "transparent" }
            GradientStop { position: 1.0; color: "#000" }
        }
    }

    Back {
        visible: showBackButton
        id: gearLayoutForBack
        width: parent.width
    }
    Row {
        anchors.centerIn: parent
        spacing: defaultFontSize
        Text {
            text: "P"
            color: "#fff"
            font.pointSize: GearSelection.gear === "P" ? defaultFontSize + 5 : defaultFontSize
            font.bold: GearSelection.gear === "P"
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Gear P Touched");
                    if(GearSelection.gear !== "P") {
                        GearSelection.setGear("P");
                        showGearMenu = false;
                    }
                }
            }
        }
        Text {
            text: "R"
            color: "#fff"
            font.pointSize: GearSelection.gear === "R" ? defaultFontSize + 5 : defaultFontSize
            font.bold: GearSelection.gear === "R"
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Gear R Touched");
                    if(GearSelection.gear !== "R") {
                        GearSelection.setGear("R");
                        showGearMenu = false;
                    }
                }
            }
        }
        Text {
            text: "N"
            color: "#fff"
            font.pointSize: GearSelection.gear === "N" ? defaultFontSize + 5 : defaultFontSize
            font.bold: GearSelection.gear === "N"
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Gear N Touched");
                    if(GearSelection.gear !== "N") {
                        GearSelection.setGear("N");
                        showGearMenu = false;
                    }
                }
            }
        }
        Text {
            text: "D"
            color: "#fff"
            font.pointSize: GearSelection.gear === "D" ? defaultFontSize + 5 : defaultFontSize
            font.bold: GearSelection.gear === "D"
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Gear D Touched");
                    if(GearSelection.gear !== "D") {
                        GearSelection.setGear("D");
                        showGearMenu = false;
                    }
                }
            }
        }
    }

    property int defaultFontSize: parent.defaultFontSize ? parent.defaultFontSize : 100
}
