import QtQuick 2.0
import QtQuick.Window 2.14
import QtLocation 5.6
import QtPositioning 5.6
import QtWebView 1.1

Item {
    width: 800
    height: 600
    WebView {
        id: webView
        anchors.fill: parent
        url: "qrc:/assets/HTML/map.html" // Load a local HTML file containing the Google Map
    }
}

    // Plugin {
    //     id: mapPlugin
    //     name: "osm"
    // }

    // Map {
    //     anchors.fill: parent
    //     plugin: mapPlugin
    //     center: QtPositioning.coordinate(52.4242402, 10.7909489) // Default center (Oslo)
    //     zoomLevel: 14
    // }
