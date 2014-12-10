#include "link.h"

Link::Link(QObject *parent) :
    QObject(parent)
{
}

Link::Link(QObject* parent, QString _link, QString _tag) :
    QObject(parent), link(_link), tag(_tag)
{
}
