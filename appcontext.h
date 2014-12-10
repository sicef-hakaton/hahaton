#ifndef APPCONTEXT_H
#define APPCONTEXT_H

#include <QQmlApplicationEngine>
#include <QObject>
#include <QQmlContext>

#include "statestack.h"
#include "class.h"

class AppContext : public QObject
{
    Q_OBJECT

public:
    AppContext(QQmlApplicationEngine* engine);

    void init();

public slots:
    void addContact(QString name, QString lastname, QString nickname);
    void addClass(QString name, QString date, QString info, int time);
    void editClass(int index, QString info, QString date, int time);

    void callSkype();
    void addLink(QString l, QString t);
    void setupOpenables(int index);
    void open(int index);
    void addNote(QString c, QString m);

private:
    QQmlApplicationEngine* m_engine;
    QObject*               m_root;

    StateStack*            m_stack;

    QQmlContext*           m_context;

    QList<QObject*>        m_contactListData;
    QList<QObject*>        m_classes;
    QList<QObject*>        m_links;
    QList<QObject*>        m_notes;

    Class*                 m_selected;


};

#endif // APPCONTEXT_H
