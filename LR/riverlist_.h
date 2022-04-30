#ifndef RIVERLIST__H
#define RIVERLIST__H

#include <QtSql>

class riverListSQL: public QSqlQueryModel
{
    Q_OBJECT

    Q_PROPERTY(QSqlQueryModel* riverModel READ getModel CONSTANT)
    Q_PROPERTY(bool IsConnectionOpen READ isConnectionOpen CONSTANT)

public:
    explicit riverListSQL(QObject *parent);
    void refresh();
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const override;

    Q_INVOKABLE void add(const QString& nameRiv,
                         const int lengthRiv,
                         const QString& fallRiv,
                         const int sinkRiv,
                         const int squareRiv);
    Q_INVOKABLE void del(const int index);
    Q_INVOKABLE void edit(const QString& nameRiv,
                          const int lengthRiv,
                          const QString& fallRiv,
                          const int sinkRiv,
                          const int squareRiv,
                          const int index);
    Q_INVOKABLE QString count(const QString& textSelArea);

signals:

public slots:

private:
    const static char* SQL_SELECT;
    QSqlDatabase db;
    QSqlQueryModel *getModel();
    bool _isConnectionOpen;
    bool isConnectionOpen();
};

#endif // RIVERLIST__H
