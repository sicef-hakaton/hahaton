#ifndef OPENABLE_H
#define OPENABLE_H

#include <QObject>

class Openable : public QObject
{
    Q_PROPERTY(QString path READ getPath)
    Q_PROPERTY(QString name READ getName)
    Q_OBJECT
public:
    enum Type { ppt, pdf, doc };
    explicit Openable(QObject *parent = 0);
    explicit Openable(QObject *parent, QString p, QString n, Type t);
    Type type;

signals:

public slots:
    QString getPath() { return path; }
    QString getName() { return name; }
    void open();

private:
    QString path;
    QString name;
};

#endif // OPENABLE_H
