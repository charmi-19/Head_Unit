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
            font.pointSize: GearSelection.gear === "P" ? increasedFontSizeForSelectedGear : defaultFontSize
            font.bold: GearSelection.gear === "P"
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Gear P Touched");
                    if(SpeedReceiver.speed > 0 && GearSelection.gear === "P") {
                        console.log("Either driving or already gear P selected");
                    } else {
                        GearSelection.setGear("P");
                        showGearMenu = false;
                    }
                }
            }
        }
        Text {
            text: "R"
            color: "#fff"
            font.pointSize: GearSelection.gear === "R" ? increasedFontSizeForSelectedGear : defaultFontSize
            font.bold: GearSelection.gear === "R"
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Gear R Touched");
                    if(SpeedReceiver.speed > 0 && GearSelection.gear === "R") {
                        console.log("Either driving or already gear R selected");
                    } else {
                        GearSelection.setGear("R");
                        showGearMenu = false;
                    }
                }
            }
        }
        Text {
            text: "N"
            color: "#fff"
            font.pointSize: GearSelection.gear === "N" ? increasedFontSizeForSelectedGear : defaultFontSize
            font.bold: GearSelection.gear === "N"
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Gear N Touched");
                    if(SpeedReceiver.speed > 0 && GearSelection.gear !== "N") {
                        console.log("Either driving or already gear N selected");
                    } else {
                        GearSelection.setGear("N");
                        showGearMenu = false;
                    }
                }
            }
        }
        Text {
            text: "D"
            color: "#fff"
            font.pointSize: GearSelection.gear === "D" ? increasedFontSizeForSelectedGear : defaultFontSize
            font.bold: GearSelection.gear === "D"
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Gear D Touched");
                    if(SpeedReceiver.speed > 0 && GearSelection.gear !== "D") {
                        console.log("Either driving or already gear D selected");
                    } else {
                        GearSelection.setGear("D");
                        showGearMenu = false;
                    }
                }
            }
        }
    }

    property int defaultFontSize: parent.defaultFontSize ? parent.defaultFontSize : 100; // if you want to change this, please change below variable condition as well
    property int increasedFontSizeForSelectedGear: defaultFontSize + (defaultFontSize === 100 ? 90 : 20);
}
