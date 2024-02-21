#include "gearselection.h"
#include <QDBusInterface>
#include <QDBusConnection>
#include <QDebug>
#include <QDBusReply>
#include <QTimer>

GearSelection::GearSelection(QObject *parent)
    : QObject{parent}{
    QTimer *timer1 = new QTimer(this);
    connect(timer1, &QTimer::timeout, this, &GearSelection::receiveGearInformation);
    timer1->start(10);
}

QString GearSelection::receiveGearInformation()
{
    qDebug() << "Trying to connect D-Bus to receive gear information...";
    QDBusInterface dbusInterface("com.example.dbus.gear", "/com/example/dBus/gear", "com.example.dbus.gear", QDBusConnection::sessionBus());

    // Show error if connection is failed
    if(!dbusInterface.isValid()) {
        qDebug() << "Failed to create DBusInterface to receive gear information...";
    }

    QDBusReply<QString> gear = dbusInterface.call("Get_Gear_Information");

    if(!gear.isValid()) {
        qWarning() << "Failed to call method for Gear Information:" << gear.error().message();
        qDebug() << "Error printing gear information";
    } else {
        m_gear = gear.value();
        qDebug() << "Gear: " << gear.value();
    }

    emit gearChanged();
    return gear.value();
}

QString GearSelection::gear()
{
    return m_gear;
}
