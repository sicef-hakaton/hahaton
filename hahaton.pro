TEMPLATE = app

QT += qml quick widgets sql

SOURCES += main.cpp \
    statestack.cpp \
    appcontext.cpp \
    contact.cpp \
    class.cpp \
    note.cpp \
    link.cpp \
    sqleventmodel.cpp \
    event.cpp \
    openable.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    statestack.h \
    appcontext.h \
    contact.h \
    class.h \
    note.h \
    link.h \
    sqleventmodel.h \
    event.h \
    openable.h

OTHER_FILES +=
