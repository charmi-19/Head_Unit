import QtQuick 2.15

Item {
    // Rectangle {
    //     id: mainRectangle
    //     anchors {
    //         top: styleText.bottom
    //         topMargin: 15
    //         horizontalCenter: parent.horizontalCenter
    //     }
    //     width: parent.width
    //     height: 320
    //     color: "transparent"
    //     border.color: "gray"
    //     radius: 20
    //     Rectangle {
    //         id: selectedColor
    //         anchors {
    //             horizontalCenter: parent.horizontalCenter
    //             top: parent.top
    //             topMargin: 15
    //         }
    //         border.color: themeColor
    //         border.width: 5
    //         color: "transparent"
    //         width: parent.width * 0.5
    //         height: parent.height * 0.7
    //         radius: parent.radius
    //         Rectangle {
    //             anchors{
    //                 top: parent.top
    //                 topMargin: 15
    //                 horizontalCenter: parent.horizontalCenter
    //             }
    //             width: parent.width * 0.5
    //             height: parent.height * 0.9
    //             gradient: Gradient{
    //                 GradientStop { position: 0.01; color: themeColor }
    //                 GradientStop { position: 1.0; color: "#000" }
    //             }
    //             opacity: 0.5
    //             radius: 20
    //         }
    //     }
    //     Rectangle {
    //         id: horizontalSeparator
    //         anchors {
    //             top: selectedColor.bottom
    //             topMargin: 15
    //         }
    //         width: parent.width
    //         height: 1
    //         color: "transparent"
    //         border.color: "gray"
    //     }

    //     Text {
    //         id: colorText
    //         anchors {
    //             bottom: parent.bottom
    //             bottomMargin: 20
    //             left: parent.left
    //             leftMargin: 20
    //         }
    //         text: "Color"
    //         color: "#fff"
    //         font.pointSize: 16
    //     }
    //     Item {
    //         anchors {
    //             top: horizontalSeparator.bottom
    //             bottom: parent.bottom
    //             left: colorText.right
    //             leftMargin: 30
    //         }
    //         Rectangle {
    //             visible: themeColor === "#00f"
    //             id: outerBlue
    //             anchors.verticalCenter: parent.verticalCenter
    //             width: 38
    //             height: width
    //             radius: width * 0.5
    //             color: "transparent"
    //             border.color: "#00f"
    //             border.width: 2
    //         }
    //         Rectangle {
    //             anchors.centerIn: outerBlue
    //             width: 30
    //             height: width
    //             radius: width * 0.5
    //             color: "#00f"
    //             MouseArea {
    //                 anchors.fill: parent
    //                 onClicked: {
    //                     console.log("#00f");
    //                     themeColor = "#00f";
    //                 }
    //             }
    //         }

    //         Rectangle {
    //             visible: themeColor === "gray"
    //             id: outerGray
    //             anchors {
    //                 verticalCenter: parent.verticalCenter
    //                 left: outerBlue.right
    //                 leftMargin: 30
    //             }
    //             width: 38
    //             height: width
    //             radius: width * 0.5
    //             color: "transparent"
    //             border.color: "gray"
    //             border.width: 2
    //         }
    //         Rectangle {
    //             anchors.centerIn: outerGray
    //             width: 30
    //             height: width
    //             radius: width * 0.5
    //             color: "gray"
    //             MouseArea {
    //                 anchors.fill: parent
    //                 onClicked: {
    //                     console.log("gray");
    //                     themeColor = "gray";
    //                 }
    //             }
    //         }
    //     }
    // }
    Text {
        id: powerText
        text: "Brightness"
        color: "#fff"
        font.pointSize: 18
        anchors {
            top: styleText.bottom
            topMargin: 50
        }
    }

}
