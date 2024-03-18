#include "speedreceiver.h"
#include <QDBusInterface>
#include <QDBusConnection>
#include <QDebug>
#include <QDBusReply>
#include <QTimer>

SpeedReceiver::SpeedReceiver(QObject *parent)
    : QObject{parent}
{
    QTimer *timer1 = new QTimer(this);
    connect(timer1, &QTimer::timeout, this, &SpeedReceiver::receiveSpeedData);
    timer1->start(100);
}

// Receiver function
float SpeedReceiver::receiveSpeedData() {
    qDebug() << "Trying to connect D-Bus to receive RPS data...";
    QDBusInterface dbusInterface("com.example.dBus.rps", "/com/example/dBus/rps", "com.example.dBus.rps", QDBusConnection::sessionBus());

    // Show error if connection is failed
    if(!dbusInterface.isValid()) {
        qDebug() << "Failed to create DBusInterface to receive RPS data";
    }

    QDBusReply<QString> rps = dbusInterface.call("RPS");

    m_speed = 5;

    if(!rps.isValid()) {
        qWarning() << "Failed to call method for speed:" << rps.error().message();
        qDebug() << "Error printing speed data";
    } else {
        m_speed = rps.value().toFloat() * 3.14 * 2.5;
        qDebug() << "Speed: " << rps.value().toFloat() * 3.14 * 2.5;
    }

    emit speedChanged();
    return rps.value().toFloat() * 3.14 * 2.5;
}

float SpeedReceiver::speed()
{
    return m_speed;
}
