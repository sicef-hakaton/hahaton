#include <QApplication>
#include <QQmlApplicationEngine>

//#include "statestack.h"
#include "appcontext.h"

#include <QtQml>

#include "sqleventmodel.h"
#include "openable.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    //engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

//    QObject* root = engine.rootObjects().first();

//    QObject* t1 = root->findChild<QObject*>("t1");

//    t1->setProperty("text", QVariant("Iz C++-a"));

    qmlRegisterType<SqlEventModel>("SqlEventModel", 1, 2, "SqlEventModel");

    AppContext context(&engine);
    context.init();
    //StateStack stateStack(&engine);

//    Openable o(NULL, "./files/os1.pdf", "e", Openable::Type::pdf);
//    o.open();


    return app.exec();
}
