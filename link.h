#ifndef LINK_H
#define LINK_H

#include <QObject>
#include <QStringList>

class Class;
class Note;

class Link : public QObject
{
    Q_OBJECT
public:

    Q_PROPERTY(QString link READ getLink)
    Q_PROPERTY(QString tag READ getTag)

    explicit Link(QObject *parent = 0);
    explicit Link(QObject* parent, QString _link, QString _tag);

public slots:
    QString getLink() {return link;}
    QString getTag() {return tag;}


private:
    QString link;
    QString tag;

};

#endif // LINK_H
