#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDir>
#include <QQuickStyle>

// using namespace Qt::StringLiterals;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");

    QQmlApplicationEngine engine;
    engine.addImportPath(QCoreApplication::applicationDirPath() + QDir::separator() + "qml");

    // The QML module URI for the main app is "Com.Example.App"
    // The Main.qml file is part of this module.
    // const QUrl url(u"qrc:/qt/qml/Com/Example/App/Main.qml"_s);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("Com.Example.App", "Main");
    // engine.load(url);

    return app.exec();
}
