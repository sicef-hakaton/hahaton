#include "class.h"

Class::Class(QObject *parent) :
    QObject(parent)
{
}

Class::Class(QObject* parent, QString n, QString i, QString date, int time, int time2) :
    QObject(parent), name(n), info(i), examDate(QDate::fromString(date, "dd/MM/yyyy")), studyingTime(time),timeSpent(time2)
{
}
