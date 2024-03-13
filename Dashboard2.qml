import QtQuick 2.15
import QtGraphicalEffects 1.15
// import QtWinExtras 1.0
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
import QtMultimedia 5.15
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0
import QtLocation 5.6
import QtPositioning 5.6

Item {
    height: parent.height
    width: parent.width
    anchors.horizontalCenter: parent.horizontalCenter
    anchors {
        top: parent.top
        topMargin: 25
    }
    Rectangle {
        id: timeRectangle
        anchors.left: parent.left
        anchors.leftMargin: 10
        width: (parent.width / 4) - 10
        height: cardHeight
        color: "transparent"
        radius: 20
        Rectangle {
            id: timeRectangleShadow
            anchors.fill: timeRectangle
            gradient: Gradient{
                GradientStop { position: 0.01; color: themeColor }
                GradientStop { position: 1.0; color: "#000" }
            }
            opacity: 0.5
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Time Card Touched");
                    main.componentSource = "Time.qml";
                }
            }
            radius: 20
        }
        // Border { }
        Rectangle {
            id: clock
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 30
            }
            width: parent.width * 0.8
            height: width
            radius: width * 0.5
            color: "#fff"
            opacity: 0.8

            Rectangle {
                id: hourHand
                width: 4
                height: (clock.height * 0.5) - 25
                color: "#fff"
                border.color: "#fff"
                anchors {
                    top: parent.top
                    topMargin: 25
                    horizontalCenter: parent.horizontalCenter
                }
                transform: Rotation {
                    origin.x: hourHand.width / 2
                    origin.y: hourHand.height
                    angle: (main.currentTime.split(":")[0] % 12 + main.currentTime.split(":")[1] / 60) * 30
                }
            }
            Rectangle {
                id: minuteHand
                width: 4
                height: (clock.height * 0.5) - 10
                color: "#000"
                border.width: 3
                border.color: "#000"
                anchors {
                    top: parent.top
                    topMargin: 10
                    horizontalCenter: parent.horizontalCenter
                }
                transform: Rotation {
                    origin.x: minuteHand.width / 2
                    origin.y: minuteHand.height
                    angle: (main.currentTime.split(":")[1] % 60) * 6
                }
            }
            Rectangle {
                id: secondHand
                width: 2
                height: clock.height * 0.5
                color: "red"
                border.width: 3
                border.color: "red"
                anchors {
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                }
                transform: Rotation {
                    origin.x: secondHand.width
                    origin.y: secondHand.height
                    angle: (main.currentTime.split(":")[2] % 60) * 6
                }
            }
        }
        Rectangle {
            width: 10
            height: width
            radius: width * 0.5
            color: "gray"
            anchors.centerIn: clock
        }
        Text {
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: clock.bottom
                topMargin: 20
            }
            text: main.currentTime.split(":")[0] + ":" + main.currentTime.split(":")[1]
            font.pointSize: 24
            color: "#fff"
        }
    }


    Rectangle {
        id: musicRectangle
        anchors.left: timeRectangle.right
        anchors.leftMargin: 10
        width: (parent.width / 4) - 10
        height: cardHeight
        color: "transparent"
        radius: 20
        Rectangle {
            id: musicRectangleShadow
            anchors.fill: musicRectangle
            // color: "#fff"
            gradient: Gradient{
                GradientStop { position: 0.01; color: themeColor }
                GradientStop { position: 1.0; color: "#000" }
            }
            opacity: 0.5
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Music Card Touched");
                    main.componentSource = "AudioLayout2.qml";
                }
            }
            radius: 20
        }
        // Border { }
        // Audio Image
        Rectangle {
            id: audioImage
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 30
            width: musicRectangle.width * 0.8
            height: width
            color: "transparent"
            border.width: 4
            border.color: "#fff"
            radius: 10
            Image {
                source: currentLogo ? currentLogo : "qrc:/assets/Images/Music.jpg"
                anchors.centerIn: parent
                width: parent.width * 0.9
                height: width
                fillMode: Image.Stretch
            }
        }

        Row {
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: audioImage.bottom
                topMargin: 20
            }
            spacing: 30
            // Previous song
            Button {
                id: previousAudio
                height: 30
                width: 30
                background: Rectangle {
                    color: "transparent"
                }
                enabled: currentSongIndex > 0
                Image {
                    id: previousButton
                    source: "qrc:/assets/Images/Previous.svg"
                    anchors.centerIn: parent
                    width: parent.width
                    height: parent.height
                }
                onClicked: {
                    console.log("Previous button clicked...")
                    if (currentSongIndex > 0) {
                        currentSongIndex--;
                        playCurrentItem();
                    }
                }
            }
            // Play or Pause
            Button {
                id: playOrPauseButton
                height: 30
                width: 30
                background: Rectangle {
                    color: "transparent"
                }
                Image {
                    id: playOrPause
                    source: mediaPlayer.playbackState === MediaPlayer.PlayingState ? "qrc:/assets/Images/Pause.svg" : "qrc:/assets/Images/Play.svg"
                    // source: "qrc:/assets/Images/Pause.svg"
                    anchors.centerIn: parent
                    width: parent.width
                    height: parent.height
                }
                onClicked: {
                    if(!audioSelected) {
                        audioSelected = true;
                    }

                    console.log("Test", mediaPlayer.playbackState)
                    if (mediaPlayer.playbackState === MediaPlayer.PlayingState) {
                        mediaPlayer.pause();
                    } else {
                        console.log("currentSongIndex", currentSongIndex);
                        mediaPlayer.source = audioListModel[currentSongIndex].url;
                        mediaPlayer.play();
                        currentLogo = audioListModel[currentSongIndex].logo;
                    }
                    console.log("Play or Pause clicked...", currentSongIndex)
                }
            }
            // Next Song
            Button {
                id: nextAudio
                height: 30
                width: 30
                background: Rectangle {
                    color: "transparent"
                }
                enabled: currentSongIndex < audioListModel.length - 1
                Image {
                    id: nextButton
                    source: "qrc:/assets/Images/Next.svg"
                    anchors.centerIn: parent
                    width: parent.width
                    height: parent.height
                }
                onClicked: {
                    console.log("Next button clicked...");
                    if (currentSongIndex < audioListModel.length - 1) {
                        currentSongIndex++;
                        playCurrentItem();
                    }
                }
            }
        }
    }


    Rectangle {
        id: mapRectangle
        anchors.left: musicRectangle.right
        anchors.leftMargin: 10
        width: (parent.width / 4) - 10
        height: cardHeight
        color: "transparent"
        radius: 20
        Rectangle {
            id: mapRectangleShadow
            anchors.fill: mapRectangle
            // color: "#fff"
            gradient: Gradient{
                GradientStop { position: 0.01; color: themeColor }
                GradientStop { position: 1.0; color: "#000" }
            }
            opacity: 0.5
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Map Card Touched");
                    main.componentSource = "Map.qml";
                }
            }
            radius: 20
        }
        // Border { }
        // CircularGauge {
        //     id:speedometer
        //     style: CircularGaugeStyle {
        //         background: Rectangle {
        //             implicitHeight: speedometer.height
        //             implicitWidth: speedometer.width
        //             color: "transparent"
        //             radius: implicitWidth / 2
        //             // border.color: "#fff"
        //             // border.width: 3
        //         }
        //     }
        //     value: Instrument_Cluster.rps * 3.14 * 2.5
        //     stepSize: 0.5
        //     maximumValue: 100
        //     minimumValue: 0
        //     width: mapRectangle.width * 0.8
        //     height: width
        //     anchors {
        //         horizontalCenter: parent.horizontalCenter
        //         top: parent.top
        //         topMargin: 30
        //     }
        // }
        // Rectangle {
        //     id: bgImageContainer
        //     anchors.centerIn: parent
        //     width: parent.width
        //     height: parent.height
        //     color: "transparent"
        //     Image {
        //         id: bgImage
        //         anchors.centerIn: parent
        //         source: "qrc:/assets/Images/bg-mask.png"
        //         anchors.fill: parent
        //         fillMode: Image.PreserveAspectCrop
        //         rotation: 0
        //     }
        //     Image {
        //         id: bgImageHighlights
        //         anchors.centerIn: parent
        //         source: "qrc:/assets/Images/car-highlights.png"
        //         anchors.fill: parent
        //         fillMode: Image.PreserveAspectCrop
        //         rotation: 0
        //     }
        // }

        // Map {
        //     anchors.fill: parent
        //     plugin: mapPlugin
        //     center: QtPositioning.coordinate(59.91, 10.75) // Oslo
        //     zoomLevel: 14
        //     MapQuickItem {
        //                 anchorPoint.x: marker.width / 2
        //                 anchorPoint.y: marker.height
        //                 coordinate: QtPositioning.coordinate(positionSource.position.coordinate.latitude,
        //                                                       positionSource.position.coordinate.longitude)
        //                 sourceItem: Image {
        //                     id: marker
        //                     source: "marker.png"
        //                 }
        //             }
        // }

        // PositionSource {
        //         id: positionSource
        //         active: true
        //         updateInterval: 1000 // Update interval in milliseconds
        //     }
    }


    Rectangle {
        id: gearRectangle
        anchors.left: mapRectangle.right
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        width: (parent.width / 4) - 10
        height: cardHeight
        color: "transparent"
        radius: 20
        Rectangle {
            id: gearRectangleShadow
            anchors.fill: gearRectangle
            // color: "#fff"
            gradient: Gradient{
                // GradientStop { position: 0.01; color: "gray" }
                // GradientStop { position: 1.0; color: "white" }
                GradientStop { position: 0.01; color: themeColor }
                GradientStop { position: 1.0; color: "#000" }
            }
            opacity: 0.5
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Gear Card Touched");
                    main.componentSource = "Gear.qml";
                }
            }
            radius: 20
        }
        // Border { }
        Column {
            anchors.centerIn: parent
            spacing: 25
            Text {
                text: "P"
                color: "#fff"
                font.pointSize: GearSelection.gear === "P" ? 52 : 30
                font.bold: GearSelection.gear === "P"
                anchors.horizontalCenter: parent.horizontalCenter
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Gear P Touched");
                        if(GearSelection.gear !== "P") {
                            GearSelection.setGear("P");
                        }
                    }
                }
            }
            Text {
                text: "R"
                color: "#fff"
                font.pointSize: GearSelection.gear === "R" ? 52 : 30
                font.bold: GearSelection.gear === "R"
                anchors.horizontalCenter: parent.horizontalCenter
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Gear R Touched");
                        if(GearSelection.gear !== "R") {
                            GearSelection.setGear("R");
                        }
                    }
                }
            }
            Text {
                text: "N"
                color: "#fff"
                font.pointSize: GearSelection.gear === "N" ? 52 : 30
                font.bold: GearSelection.gear === "N"
                anchors.horizontalCenter: parent.horizontalCenter
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Gear N Touched");
                        if(GearSelection.gear !== "N") {
                            GearSelection.setGear("N");
                        }
                    }
                }
            }
            Text {
                text: "D"
                color: "#fff"
                font.pointSize: GearSelection.gear === "D" ? 52 : 30
                font.bold: GearSelection.gear === "D"
                anchors.horizontalCenter: parent.horizontalCenter
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Gear D Touched");
                        if(GearSelection.gear !== "D") {
                            GearSelection.setGear("D");
                        }
                    }
                }
            }
        }
    }

    Row {
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 100
        }
        spacing: 120
        Rectangle {
            width: 100
            height: width
            radius: 20
            color: "transparent"
            Rectangle {
                anchors.fill: parent
                // color: "#fff"
                gradient: Gradient{
                    // GradientStop { position: 0.01; color: "gray" }
                    // GradientStop { position: 1.0; color: "white" }
                    GradientStop { position: 0.01; color: "#000" }
                    GradientStop { position: 1.0; color: themeColor }
                }
                opacity: 0.5
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Calendar Icon Touched");
                        main.componentSource = "Calendar.qml";
                    }
                }
                radius: 20
            }
            Image {
                width: 70
                height: 70
                anchors.centerIn: parent
                fillMode: Image.Stretch
                source: "qrc:/assets/Images/Calendar.svg"
            }
        }
        Rectangle {
            width: 100
            height: width
            radius: 20
            // border.color: "#fff"
            // border.width: 3
            color: "transparent"
            Rectangle {
                anchors.fill: parent
                // color: "#fff"
                gradient: Gradient{
                    // GradientStop { position: 0.01; color: "gray" }
                    // GradientStop { position: 1.0; color: "white" }
                    GradientStop { position: 0.01; color: "#000" }
                    GradientStop { position: 1.0; color: themeColor }
                }
                opacity: 0.5
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Music Icon Touched");
                        main.componentSource = "AudioLayout2.qml";
                    }
                }
                radius: 20
            }
            Image {
                width: 80
                height: 80
                anchors.centerIn: parent
                fillMode: Image.Stretch
                source: "qrc:/assets/Images/Music.svg"
            }
        }
        Rectangle {
            width: 100
            height: width
            radius: 20
            color: "transparent"
            Rectangle {
                anchors.fill: parent
                // color: "#fff"
                gradient: Gradient{
                    // GradientStop { position: 0.01; color: "gray" }
                    // GradientStop { position: 1.0; color: "white" }
                    GradientStop { position: 0.01; color: "#000" }
                    GradientStop { position: 1.0; color: themeColor }
                }
                opacity: 0.5
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Video Icon Touched");
                        main.componentSource = "VideoLayout.qml";
                    }
                }
                radius: 20
            }
            Image {
                width: 85
                height: 85
                anchors.centerIn: parent
                fillMode: Image.Stretch
                source: "qrc:/assets/Images/Video.svg"
            }
        }
        Rectangle {
            width: 100
            height: width
            radius: 20
            color: "transparent"
            Rectangle {
                anchors.fill: parent
                // color: "#fff"
                gradient: Gradient{
                    // GradientStop { position: 0.01; color: "gray" }
                    // GradientStop { position: 1.0; color: "white" }
                    GradientStop { position: 0.01; color: "#000" }
                    GradientStop { position: 1.0; color: themeColor }
                }
                opacity: 0.5
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Settings Icon Touched");
                        main.componentSource = "Settings.qml";
                    }
                }
                radius: 20
            }
            Image {
                width: 75
                height: 75
                anchors.centerIn: parent
                fillMode: Image.Stretch
                source: "qrc:/assets/Images/Settings.svg"
            }
        }
    }

    property int cardHeight: 350;
}
