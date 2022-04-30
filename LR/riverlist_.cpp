#include "riverlist_.h"
#include "QObject"

riverListSQL::riverListSQL(QObject *parent) :
    QSqlQueryModel(parent)
{

//    QSqlDatabase::removeDatabase("myConnection");

//    db = QSqlDatabase::addDatabase("QODBC3", "myConnection");

//    QString connectString = "Driver={SQL Server Native Client 11.0};";
//    connectString.append("Server=localhost\\SQLEXPRESS;");
//    connectString.append("Database=Lab4Students;");
//    connectString.append("Trusted_Connection=yes;");

//    db.setDatabaseName(connectString);

    db = QSqlDatabase::addDatabase("QPSQL", "myConnection");

    db.setHostName("127.0.0.1");
    db.setPort(5432);
    db.setUserName("postgres");
    db.setPassword("123");
    db.setDatabaseName("Students");

     _isConnectionOpen = true;

    if(!db.open())
    {
        qDebug() << db.lastError().text();
        _isConnectionOpen = false;
    }

    QString m_schema = QString( "CREATE TABLE IF NOT EXISTS Rivers (Id SERIAL PRIMARY KEY, "
                                "Name text, "
                                "Length integer, "
                                "Fall text, "
                                "Sink integer, "
                                "Square integer);" );

    QSqlQuery qry(m_schema, db);

    if( !qry.exec() )
    {
        //qDebug() << db.lastError().text();
        //_isConnectionOpen = false;
    }

    refresh();
}

QSqlQueryModel* riverListSQL::getModel(){
    return this;
}
bool riverListSQL::isConnectionOpen(){
    return _isConnectionOpen;
}
//!!!!
QHash<int, QByteArray> riverListSQL::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole + 1] = "NameOfRiver";
    roles[Qt::UserRole + 2] = "LengthOfRiver";
    roles[Qt::UserRole + 3] = "FallInRiver";
    roles[Qt::UserRole + 4] = "SinkOfRiver";
    roles[Qt::UserRole + 5] = "SquareOfRiver";
    roles[Qt::UserRole + 6] = "Id";

    return roles;
}


QVariant riverListSQL::data(const QModelIndex &index, int role) const
{
    QVariant value = QSqlQueryModel::data(index, role);
    if(role < Qt::UserRole-1)
    {
        value = QSqlQueryModel::data(index, role);
    }
    else
    {
        int columnIdx = role - Qt::UserRole - 1;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
    }
    return value;
}

const char* riverListSQL::SQL_SELECT =
        "SELECT Name, Length, Fall, Sink, Square, Id "
        "FROM Rivers";

void riverListSQL::refresh()
{
    this->setQuery(riverListSQL::SQL_SELECT,db);
}

void riverListSQL::add(const QString& nameRiv,
                       const int lengthRiv,
                       const QString& fallRiv,
                       const int sinkRiv,
                       const int squareRiv){

    QSqlQuery query(db);
    QString strQuery= QString("INSERT INTO Rivers (Name, Length, Fall, Sink, Square) "
                              "VALUES ('%1', %2, '%3', %4, %5)")
            .arg(nameRiv)
            .arg(lengthRiv)
            .arg(fallRiv)
            .arg(sinkRiv)
            .arg(squareRiv);
    query.exec(strQuery);

    refresh();

}
void riverListSQL::edit(const QString& nameRiv,
                        const int lengthRiv,
                        const QString& fallRiv,
                        const int sinkRiv,
                        const int squareRiv,
                        const int index){

    QSqlQuery query(db);
    QString strQuery= QString("UPDATE Rivers SET Name = '%1', "
                              "Length = %2, "
                              "Fall = '%3', "
                              "Sink = %4, "
                              "Square = %5 "
                              "WHERE Id = %6")
            .arg(nameRiv)
            .arg(lengthRiv)
            .arg(fallRiv)
            .arg(sinkRiv)
            .arg(squareRiv)
            .arg(index);
    query.exec(strQuery);

    refresh();

}
void riverListSQL::del(const int index){


    QSqlQuery query(db);
    QString strQuery= QString("DELETE FROM Rivers WHERE Id = %1")
            .arg(index);
    query.exec(strQuery);

    refresh();
}

QString riverListSQL::count(const QString& textSelArea)
{
    QSqlQuery query(db);
    QString strQuery= QString("SELECT COUNT(Id) FROM Rivers WHERE square > %1")
            .arg(textSelArea.toInt());

    query.exec(strQuery);
    QString info;
    while (query.next())
    {
        info = query.value(0).toString();
        qDebug() << info;
    }

    return(info);
}
