#ifndef STATESTACK_H
#define STATESTACK_H

#include <QQmlApplicationEngine>
#include <QStack>

class State;


class StateStack: public QObject
{
    Q_OBJECT

public:
    explicit                    StateStack(QQmlApplicationEngine* engine);

    void                        registerState(QString name, QObject* state);

    //void                        setScreenLoader(QObject* loader);
    //QObject*                    getScreenLoader() const;

    //void                        setSignalConnector(SignalConnector* binder);

                               // ~StateStack();

public slots:
    void                          push(QString screenName);
    void                          pop();
    //void                        clear();

    //void                        startFullScreen();

private:
    //void                        update();
    //void                        closeApplication();

    //QObject*                    m_activeA;
    //SignalConnector*            m_binder;
    QObject*                      m_root;
    QQmlApplicationEngine*        m_engine;
    //QtQuick2ApplicationViewer*  m_viewer;
    QStack<QObject*>              m_stateStack;
    QMap<QString, QObject*>       m_stateMap;
};

#endif // STATESTACK_H
