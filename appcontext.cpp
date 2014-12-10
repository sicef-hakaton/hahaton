#include "appcontext.h"
#include <QProcess>

#include "contact.h"
#include "link.h"
#include "openable.h"

AppContext::AppContext(QQmlApplicationEngine* engine)
{
    m_engine = engine;
    m_stack = NULL;
    m_root = NULL;
    m_context = m_engine->rootContext();
}

void AppContext::init()
{
    m_contactListData.append(new Contact(this, "Mark", "Fisher", "Graphics again...zzz"));
    m_contactListData.append(new Contact(this, "Susan", "Fletcher", "In the Digital Fortress"));
    m_contactListData.append(new Contact(this, "Bobby", "Singer", "Battling the compiler"));
    m_contactListData.append(new Contact(this, "Bill", "Gates", "Rackin' up that money"));

    m_context->setContextProperty("contactModel", QVariant::fromValue(m_contactListData));

    m_classes.append(new Class(this, "classA", "classA info", "06/12/2014", 20, 5));
    Class* c = static_cast<Class*>(m_classes.at(0));
    c->addOpenable(new Openable(this, "./files/os1.pdf", "OS Presentation 1", Openable::Type::pdf));
    c->addOpenable(new Openable(this, "./files/os2.pdf", "OS Presentation 2", Openable::Type::pdf));
    c->addOpenable(new Openable(this, "./files/os3.pdf", "OS Presentation 3", Openable::Type::pdf));
    c->addOpenable(new Openable(this, "./files/os-janp.pdf", "OS Example 1", Openable::Type::pdf));
    c->addOpenable(new Openable(this, "./files/os-janu.pdf", "OS Example 2", Openable::Type::pdf));

    m_classes.append(new Class(this, "classB", "classB info", "14/01/2015", 14, 7));
    c = static_cast<Class*>(m_classes.at(1));
    c->addOpenable(new Openable(this, "./files/oop1.pdf", "OOP Presentation 1", Openable::Type::pdf));
    c->addOpenable(new Openable(this, "./files/oop2.pdf", "OOP Presentation 2", Openable::Type::pdf));
    c->addOpenable(new Openable(this, "./files/oop2.pdf", "OOP Presentation 3", Openable::Type::pdf));
    c->addOpenable(new Openable(this, "./files/oop-okt.doc", "OOP Example 1", Openable::Type::doc));
    c->addOpenable(new Openable(this, "./files/oop-jan.pdf", "OOP Example 2", Openable::Type::pdf));

    m_classes.append(new Class(this, "classC", "classC info", "09/12/2014", 17, 13));
    m_classes.append(new Class(this, "classD", "classD info", "01/12/2014", 10, 3));

    m_context->setContextProperty("classModel", QVariant::fromValue(m_classes));

    m_links.append(new Link(this, "https://www.google.rs/", "Google"));
    m_links.append(new Link(this, "https://www.wikipedia.org/", "Wikipedia"));
    m_links.append(new Link(this, "https://www.arcsynthesis.org/gltut", "Computer Graphics"));
    m_links.append(new Link(this, "https://www.coursera.org/", "MOOC"));
    m_links.append(new Link(this, "https://www.udacity.com/", "MOOC"));

    m_links.append(new Link(this, "https://www.google.rs/", "Google"));
    m_links.append(new Link(this, "https://www.wikipedia.org/", "Wikipedia"));

    m_context->setContextProperty("linkModel", QVariant::fromValue(m_links));

    m_notes.append(new Link(this, "Information security", "The results are on cs portal!"));
    m_notes.append(new Link(this, "Artificial Intelligence", "Great class"));

    m_context->setContextProperty("noteModel", QVariant::fromValue(m_notes));

    m_engine->load(QUrl(QStringLiteral("qrc:/main.qml")));

    m_stack = new StateStack(m_engine);
    m_root = m_engine->rootObjects().first();

    QObject* classesScreen = m_root->findChild<QObject*>("classesScreen");
    QObject::connect(classesScreen, SIGNAL(addNewClass(QString, QString, QString, int)), this, SLOT(addClass(QString, QString, QString, int)));
    QObject::connect(classesScreen, SIGNAL(classPicked(int)), this, SLOT(setupOpenables(int)));

    QObject* fileOpener = m_root->findChild<QObject*>("FileOpener");
    QObject::connect(fileOpener, SIGNAL(openFile(int)), this, SLOT(open(int)));

    QObject* linksScreen = m_root->findChild<QObject*>("linksScreen");
    QObject::connect(linksScreen, SIGNAL(addNewLink(QString, QString)), this, SLOT(addLink(QString ,QString)));

    QObject* contactBar = m_root->findChild<QObject*>("ContactBar");
    QObject::connect(contactBar, SIGNAL(skypeCall()), this, SLOT(callSkype()));

    QObject* notesScreen = m_root->findChild<QObject*>("notesScreen");
    QObject::connect(notesScreen, SIGNAL(addNewNote(QString, QString)), this, SLOT(addNote(QString ,QString)));
}

void AppContext::addContact(QString name, QString lastname, QString nickname)
{
    m_contactListData.append(new Contact(this, name, lastname, nickname));
    m_context->setContextProperty("contactModel", QVariant::fromValue(m_contactListData));
}

void AppContext::addClass(QString name, QString date, QString info, int time)
{
    m_classes.append(new Class(this, name, info, date, time, 0));
    m_context->setContextProperty("classModel", QVariant::fromValue(m_classes));
}

void AppContext::editClass(int index, QString info, QString date, int time)
{
    if (index >= 0)
    {
        Class* c = static_cast<Class*>(m_classes.at(index));
        c->setInfo(info);
        c->setDate(date);
        c->setStudyingTime(time);

        m_context->setContextProperty("classModel", QVariant::fromValue(m_classes));
    }
}

void AppContext::callSkype()
{
    QString program = "C:\\Program Files (x86)\\Skype\\Phone\\Skype.exe";
    QStringList arguments;
    arguments << " /callto:echo123";

    QProcess *myProcess = new QProcess(this);
    myProcess->start(program, arguments);
}

void AppContext::addLink(QString l, QString t)
{
    m_links.append(new Link(this, l, t));
    m_context->setContextProperty("linkModel", QVariant::fromValue(m_links));
}

void AppContext::addNote(QString c, QString m)
{
    m_notes.append(new Link(this, c, m));
    m_context->setContextProperty("noteModel", QVariant::fromValue(m_notes));
}

void AppContext::setupOpenables(int index)
{
    m_selected = static_cast<Class*>(m_classes.at(index));
    m_context->setContextProperty("openableModel", QVariant::fromValue(m_selected->getOpenables()));
}

void AppContext::open(int index)
{
    static_cast<Openable*>(m_selected->getOpenables().at(index))->open();
}
