#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <currenttime.h>
#include <QQmlContext>
#include <audio.h>

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

    ///////////////////////////////////////
    // Audio audioObj;
    // audioObj.playAudio();
    //////////////////////////////////////

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
