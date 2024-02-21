#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <currenttime.h>
#include <QQmlContext>
#include <gearselection.h>

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
    QObject::connect(&obj, SIGNAL(gearChanged()), &obj, SLOT(gear()));

    QQmlContext * rootContext1 = engine.rootContext();
    rootContext1->setContextProperty("GearSelection", &gearSelection);


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
