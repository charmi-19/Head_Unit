import QtQuick 2.15

Rectangle {
    property int animationDuration: Math.random() * 2000 + 1000 // Randomize animation duration between 1 and 3 seconds
    width: 20 // Default width
    height: width
    radius: width / 2
    color: "white"
    opacity: 0.5
}

