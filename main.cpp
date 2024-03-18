#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <currenttime.h>
#include <QQmlContext>
#include <gearselection.h>
#include <speedreceiver.h>
#include <ambientlight.h>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    CurrentTime obj;
    QObject::connect(&obj, SIGNAL(currentTimeChanged()), &obj, SLOT(updateCurrentTime()));

    QQmlContext * rootContext = engine.rootContext();
    rootContext->setContextProperty("Head_Unit", &obj);

    GearSelection gearSelection;
    QObject::connect(&gearSelection, SIGNAL(gearChanged()), &gearSelection, SLOT(gear()));

    QQmlContext * rootContext1 = engine.rootContext();
    rootContext1->setContextProperty("GearSelection", &gearSelection);

    SpeedReceiver speedObj;
    QObject::connect(&speedObj, SIGNAL(speedChanged()), &speedObj, SLOT(speed()));

    QQmlContext * rootContext2 = engine.rootContext();
    rootContext2->setContextProperty("SpeedReceiver", &speedObj);

    AmbientLight colorObj;

    QQmlContext * rootContext3 = engine.rootContext();
    rootContext3->setContextProperty("AmbientLight", &colorObj);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
