#pragma once

#include <QByteArray>
#include <QDebug>
#include <QObject>
#include <QString>
#include <QQmlEngine>
#include <QRangeModel>

class TaskItem : public QObject {
    Q_OBJECT
    QML_ELEMENT
    QML_UNCREATABLE("TaskItem is managed by the C++ Backend")

    Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged FINAL)
    Q_PROPERTY(int priority READ priority WRITE setPriority NOTIFY priorityChanged FINAL)

public:
    explicit TaskItem(const QString &description = "", int priority = 0, QObject *parent = nullptr);

    inline QString description() const { return m_description; }
    void setDescription(const QString &description);

    inline int priority() const { return m_priority; }
    void setPriority(int priority);

    static QHash<int, QByteArray> roleNames();

signals:
    void descriptionChanged();
    void priorityChanged();

private:
    QString m_description;
    int m_priority;
};

template<> struct QRangeModel::RowOptions<TaskItem>
{
    static constexpr auto rowCategory = QRangeModel::RowCategory::MultiRoleItem;
};

QDebug operator<<(QDebug debug, const TaskItem &item);
QDebug operator<<(QDebug debug, const TaskItem *item);
