#ifndef NOTE_H
#define NOTE_H
#include <QObject>
#include "class.h"
#include <QString>
#include <QStringList>

class Note : public QObject
{

    Q_OBJECT
public:
    Q_PROPERTY(QString classBelong READ getClassName)
    Q_PROPERTY(QString points READ getPoints)
private:
    QString classBelong;
    QString points;

public:
    Note();
    Note(QObject* parent, QString classsBel, QString points);

    QString getClassName();
    void setClassName(QString newClass);
    void addPoint(QString point);
    QString getPoint(int index);
    QString getPoints();

    void deletePoint(int index);
};

#endif // NOTE_H
