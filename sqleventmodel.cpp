/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the Qt Quick Controls module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include "sqleventmodel.h"

#include <QDebug>
#include <QFileInfo>
#include <QSqlError>
#include <QSqlQuery>
#include <QSqlDatabase>
#include <QString>

SqlEventModel::SqlEventModel() :
    QSqlQueryModel()
{
    //createConnection();
}

QList<QObject*> SqlEventModel::eventsForDate(const QDate &date)
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
        db.setDatabaseName("events.db");
    if (!db.open())
        db = QSqlDatabase();

    const QString queryStr = QString::fromLatin1("SELECT * FROM Event WHERE '%1' == startDate").arg(date.toString("yyyy-MM-dd"));
    QSqlQuery query(queryStr);
    if (!query.exec())
        qFatal("Query failed");

    QList<QObject*> events;
    while (query.next()) {
        Event *event = new Event(this);
        event->setName(query.value("name").toString());
        event->setPartner(query.value("partner").toString());

        QDateTime startDate;
        startDate.setDate(query.value("startDate").toDate());
        startDate.setTime(QTime(0, 0).addSecs(query.value("startTime").toInt()));
        event->setStartDate(startDate);

//        QDateTime endDate;
//        endDate.setDate(query.value("endDate").toDate());
//        endDate.setTime(QTime(0, 0).addSecs(query.value("endTime").toInt()));
//        event->setEndDate(endDate);

        events.append(event);
    }

    db.close();

    return events;
}


void SqlEventModel::createConnection()
{
//    QSqlError err;
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
        db.setDatabaseName("events.db");
    if (!db.open())
        db = QSqlDatabase();
        QSqlQuery query;
        //query.exec("drop table Event");
        query.exec("create table Event (name TEXT, partner TEXT, startDate DATE, startTime INT)");
        query.exec("insert into Event values('Studying graphics', 'Mark Fisher', '2014-11-23', 36000)");
        db.close();

}

void SqlEventModel::addEvent(QString name, QString partner, QDate startDate, QString startTime)
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("events.db");
    if (!db.open())
        db = QSqlDatabase();

    QSqlQuery query;
    QTime t = QTime::fromString(startTime, "hh:mm");
    int start = QTime(0, 0).secsTo(t);
    QString q("insert into Event values('" + name + "', '" + partner + "', '" + startDate.toString("yyyy-MM-dd") +
              "', " + QString::number(start) + ")");
    qDebug () << query.exec(q);

    db.close();
}

void SqlEventModel:: removeEvent(QString name)
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("events.db");
    if (!db.open())
        db = QSqlDatabase();

    QSqlQuery query;
    QString q("delete from Event where name = '%1'");
    q = q.arg(name);

    qDebug () << query.exec(q);

    db.close();
}
