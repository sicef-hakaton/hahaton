#include <QGuiApplication>
#include <QDebug>

#include "statestack.h"

StateStack::StateStack(QQmlApplicationEngine* engine)
    : m_engine(engine)
{

   m_root = m_engine->rootObjects().first();

   QObject* homeScreen = m_root->findChild<QObject*>("homeScreen");
   QObject::connect(homeScreen, SIGNAL(gridClicked(QString)), this, SLOT(push(QString)));

   QObject* classesScreen = m_root->findChild<QObject*>("classesScreen");
   QObject::connect(classesScreen, SIGNAL(titleClicked()), this, SLOT(pop()));

   QObject* plannerScreen = m_root->findChild<QObject*>("plannerScreen");
   QObject::connect(plannerScreen, SIGNAL(titleClicked()), this, SLOT(pop()));

   QObject* notesScreen = m_root->findChild<QObject*>("notesScreen");
   QObject::connect(notesScreen, SIGNAL(titleClicked()), this, SLOT(pop()));

   QObject* linksScreen = m_root->findChild<QObject*>("linksScreen");
   QObject::connect(linksScreen, SIGNAL(titleClicked()), this, SLOT(pop()));

   QObject* tipsScreen = m_root->findChild<QObject*>("tipsScreen");
   QObject::connect(tipsScreen, SIGNAL(titleClicked()), this, SLOT(pop()));

   QObject* otherScreen = m_root->findChild<QObject*>("otherScreen");
   QObject::connect(otherScreen, SIGNAL(titleClicked()), this, SLOT(pop()));

   //QObject::connect(homeScreen, SIGNAL(classesClicked()), this, SLOT(pop()));
   //QObject::connect(homeScreen, SIGNAL(notesClicked()), this, SLOT(push(State::ID, bool)));

       //t1->setProperty("text", QVariant("Iz C++-a"));

   m_stateStack.push(homeScreen);
   m_stateStack.top()->setProperty("visible", QVariant(true));
}

void StateStack::registerState(QString name, QObject *state)
{
    m_stateMap.insert(name, state);

}

void StateStack::push(QString screenName)
{
    QObject* screen = m_root->findChild<QObject*>(screenName);

    if (!m_stateStack.isEmpty())
        m_stateStack.top()->setProperty("visible", QVariant(false));

    m_stateStack.push(screen);

    m_stateStack.top()->setProperty("visible", QVariant(true));

    qDebug() << "Push called: " + screenName;
}

void StateStack::pop()
{
    if (!m_stateStack.isEmpty())
    {
        m_stateStack.top()->setProperty("visible", QVariant(false));
        m_stateStack.pop();
        m_stateStack.top()->setProperty("visible", QVariant(true));
    }
    qDebug() << "Pop called";
}

//void StateStack::registerState(State* state)
//{
//    m_stateMap.insert(state->getStateID(), state);
//    QObject::connect(state, SIGNAL(requestStackClear()), this, SLOT(clear()));
//    QObject::connect(state, SIGNAL(requestStackPop()), this, SLOT(pop()));
//    QObject::connect(state, SIGNAL(requestStackPush(State::ID, bool)), this, SLOT(push(State::ID, bool)));
//}

//void StateStack::setScreenLoader(QObject* loader)
//{
//    m_screenLoader = loader;
//}

//void StateStack::push(State::ID stateID, bool popCurrent)
//{
////    if (popCurrent)
////    {
////        if (!m_stateStack.isEmpty())
////            m_stateStack.pop();
////    }
////    State* state = m_stateMap.find(stateID).value();

////    m_stateStack.push(state);
////    update();
//}

//void StateStack::pop()
//{
////    if (!m_stateStack.isEmpty())
////        m_stateStack.pop();
////    update();
//}

//void StateStack::clear()
//{
////    while (!m_stateStack.isEmpty())
////        m_stateStack.pop();
////    update();
//}
