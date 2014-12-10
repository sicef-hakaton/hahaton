#ifndef CONTACT_H
#define CONTACT_H

#include <QObject>
#include <QStringList>

class Class;
class Note;

class Contact : public QObject
{
    Q_OBJECT
public:

    Q_PROPERTY(QString name READ getName)
    Q_PROPERTY(QString lastname READ getLastName)
    Q_PROPERTY(QString status READ getStatus)

    explicit Contact(QObject *parent = 0);
    explicit Contact(QObject* parent, QString _name, QString _last, QString _status);

    void addClass(QString c) { _classes.append(c); }
    void removeClass(QString c) { _classes.removeOne(c); }

signals:

public slots:
    QString getName() { return name; };
    QString getLastName() { return lastname; }
    QString getStatus() { return status; }
    QStringList getClasses() { return _classes; }

private:
    QString name;
    QString lastname;
    QString status;
    //QVector<Class> classes;

    QStringList _classes;

};

#endif // CONTACT_H
