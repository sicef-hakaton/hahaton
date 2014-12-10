#include "note.h"

Note::Note()
{
}

Note::Note(QObject *parent, QString classsBel, QString points) : QObject(parent)
{

}

QString Note::getClassName()
{
    return classBelong;
}

void Note::setClassName(QString newClass)
{
    classBelong = newClass;
}

void Note::addPoint(QString point)
{
    points.append(point);
}

QString Note::getPoint(int index)
{
    return points[index];
}

QString Note::getPoints()
{
    return points;
}

void Note::deletePoint(int index)
{

}
