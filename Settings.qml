import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.15
import QtBluetooth 5.15

Item {
    id: calendarLayout
    width: parent.width
    height: parent.height
    // RadialGradient {
    //     anchors.fill: parent
    //     gradient: Gradient {
    //         GradientStop { position: 0.0; color: themeColor }
    //         GradientStop { position: 0.4; color: "transparent" }
    //         GradientStop { position: 1.0; color: "#000" }
    //     }
    // }
    GearMenu {
        id: gearMenu
        width: parent.width
        height: parent.height
    }
    Rectangle {
        id: topLine
        anchors.top: parent.top
        anchors.topMargin: 40
        width: parent.width
        border.color: "#fff"
        height: 1
    }
    Rectangle {
        id: bottomLine
        anchors {
            bottom: parent.bottom
            bottomMargin: 55
        }
        border.color: "#fff"
        width: parent.width
        height: 1
    }
    Back {
        id: settingsLayoutForBack
        width: parent.width
    }

    ScrollView {
        width: parent.width
        clip: true
        anchors {
            left: parent.left
            leftMargin: 200
            right: parent.right
            rightMargin: 200
            top: topLine.bottom
            topMargin: 20
            bottom: bottomLine.top
            bottomMargin: 20
        }
        contentWidth: parent.width - 420
        Column {
            width: parent.width
            spacing: 20
            Text {
                id: styleText
                text: "Style"
                color: "#fff"
                font.pointSize: 18
                anchors.left: parent.left
            }
            Rectangle {
                id: mainRectangle
                width: parent.width
                height: 320
                color: "transparent"
                border.color: "gray"
                radius: 20
                Rectangle {
                    id: selectedColor
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        top: parent.top
                        topMargin: 15
                    }
                    border.color: themeColor
                    border.width: 5
                    color: "transparent"
                    width: parent.width * 0.5
                    height: parent.height * 0.7
                    radius: parent.radius
                    Rectangle {
                        anchors{
                            top: parent.top
                            topMargin: 15
                            horizontalCenter: parent.horizontalCenter
                        }
                        width: parent.width * 0.5
                        height: parent.height * 0.9
                        gradient: Gradient{
                            GradientStop { position: 0.01; color: themeColor }
                            GradientStop { position: 1.0; color: "#000" }
                        }
                        opacity: 0.5
                        radius: 20
                    }
                }
                Rectangle {
                    id: horizontalSeparator
                    anchors {
                        top: selectedColor.bottom
                        topMargin: 15
                    }
                    width: parent.width
                    height: 1
                    color: "transparent"
                    border.color: "gray"
                }

                Text {
                    id: colorText
                    anchors {
                        bottom: parent.bottom
                        bottomMargin: 20
                        left: parent.left
                        leftMargin: 20
                    }
                    text: "Color"
                    color: "#fff"
                    font.pointSize: 16
                }
                Item {
                    anchors {
                        top: horizontalSeparator.bottom
                        bottom: parent.bottom
                        left: colorText.right
                        leftMargin: 30
                    }
                    Rectangle {
                        visible: themeColor === "#00f"
                        id: outerBlue
                        anchors.verticalCenter: parent.verticalCenter
                        width: 38
                        height: width
                        radius: width * 0.5
                        color: "transparent"
                        border.color: "#00f"
                        border.width: 2
                    }
                    Rectangle {
                        anchors.centerIn: outerBlue
                        width: 30
                        height: width
                        radius: width * 0.5
                        color: "#00f"
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                console.log("#00f");
                                themeColor = "#00f";
                            }
                        }
                    }

                    Rectangle {
                        visible: themeColor === "gray"
                        id: outerGray
                        anchors {
                            verticalCenter: parent.verticalCenter
                            left: outerBlue.right
                            leftMargin: 30
                        }
                        width: 38
                        height: width
                        radius: width * 0.5
                        color: "transparent"
                        border.color: "gray"
                        border.width: 2
                    }
                    Rectangle {
                        anchors.centerIn: outerGray
                        width: 30
                        height: width
                        radius: width * 0.5
                        color: "gray"
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                console.log("gray");
                                themeColor = "gray";
                            }
                        }
                    }

                    Rectangle {
                        visible: themeColor === "pink"
                        id: outerPink
                        anchors {
                            verticalCenter: parent.verticalCenter
                            left: outerGray.right
                            leftMargin: 30
                        }
                        width: 38
                        height: width
                        radius: width * 0.5
                        color: "transparent"
                        border.color: "pink"
                        border.width: 2
                    }
                    Rectangle {
                        anchors.centerIn: outerPink
                        width: 30
                        height: width
                        radius: width * 0.5
                        color: "pink"
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                console.log("pink");
                                themeColor = "pink";
                            }
                        }
                    }
                }
            }
            Rectangle {
                color: "transparent"
                height: 10
                width: parent.width
            }
            Text {
                id: powerText
                text: "Brightness"
                color: "#fff"
                font.pointSize: 18
            }
            Rectangle {
                width: parent.width
                height: 100
                color: "transparent"
                border.color: "gray"
                radius: 20
                Slider {
                    id: brightnessControl
                    value: brightnessValue // Initial value
                    width: parent.width * 0.95
                    anchors.centerIn: parent
                    // Slider background and handle properties...
                    background: Rectangle {
                        x: brightnessControl.leftPadding
                        y: brightnessControl.topPadding + brightnessControl.availableHeight / 2 - height / 2
                        implicitWidth: 200
                        implicitHeight: 2
                        width: brightnessControl.availableWidth
                        height: implicitHeight
                        radius: 2
                        color: "#bdbebf"
                        Rectangle {
                            width: brightnessControl.visualPosition * parent.width
                            height: parent.height
                            color: "gray"
                            radius: 2
                        }
                    }
                    handle: Rectangle {
                        x: brightnessControl.leftPadding + brightnessControl.visualPosition * (brightnessControl.availableWidth - width)
                        y: brightnessControl.topPadding + brightnessControl.availableHeight / 2 - height / 2
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 8
                        color: brightnessControl.pressed ? "#f0f0f0" : "#f6f6f6"
                        border.color: "#bdbebf"
                    }
                    onValueChanged: {
                        // Set the volume of the media player
                        console.log("Power===",brightnessControl.value)
                        brightnessValue = brightnessControl.value;
                    }
                }
            }
        }
    }
}
