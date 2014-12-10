#ifndef CLASS_H
#define CLASS_H

#include <QObject>
#include <QDate>

class Class : public QObject
{
    Q_OBJECT

    Q_PROPERTY (QString name READ getName WRITE setName)
    Q_PROPERTY (QString info READ getInfo WRITE setInfo)
    Q_PROPERTY (QString examDate READ getDate WRITE setDate)
    Q_PROPERTY (int studyingTime READ getStudyingTime WRITE setStudyingTime)
    Q_PROPERTY (int timeSpent READ getTimeSpent WRITE setTimeSpent)

public:
    explicit Class(QObject *parent = 0);
        explicit Class(QObject* parent, QString n, QString i, QString date, int time, int time2);

    QString getName() { return name; }
    QString getInfo() { return info; }
    QString getDate() { return examDate.toString(); }
    int getStudyingTime() { return studyingTime - timeSpent; }
    void setName(QString n) { name = n; }
    void setInfo(QString i) { info = i; }
    void setDate(QString d) { examDate = QDate::fromString(d, "dd/MM/yyyy"); }
    void setStudyingTime(int time) { studyingTime = time; }
    QList<QObject*> getOpenables() { return openables; }
    void addOpenable(QObject* o) { openables.append(o);}
    void setTimeSpent(int t){timeSpent = t;}
    int getTimeSpent(){return timeSpent;}

signals:

public slots:

private:
    QString name;
    QString info;
    QDate examDate;
    int studyingTime;
    int timeSpent;

    QList<QObject*> openables;
};

#endif // CLASS_H
