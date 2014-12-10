#include "contact.h"

Contact::Contact(QObject *parent) :
    QObject(parent)
{
}

Contact::Contact(QObject* parent, QString _name, QString _last, QString _status) :
    QObject(parent), name(_name), lastname(_last), status(_status)
{
}
