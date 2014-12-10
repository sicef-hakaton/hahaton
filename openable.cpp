#include "openable.h"
#include <QProcess>

Openable::Openable(QObject *parent) :
    QObject(parent)
{
}

Openable::Openable(QObject *parent, QString p, QString n, Type t) :
    QObject(parent), path(p), name(n), type(t)
{
}

void Openable::open()
{
    QProcess* process = new QProcess(this);
    if (type == pdf)
        process->start("C:\\Program Files (x86)\\Adobe\\Reader 11.0\\Reader\\AcroRd32.exe",
                       QStringList() << path);
    else if (type == doc)
        process->start("C:\\Program Files\\Microsoft Office\\Office15\\WINWORD.exe", QStringList() << path);
    else
        process->start("C:\\Program Files\\Microsoft Office\\Office15\\POWERPNT.exe", QStringList() << path);

}
