#include "TaskItem.h"
#include <QMetaObject>

TaskItem::TaskItem(const QString &description, int priority, QObject *parent)
    : QObject(parent)
    , m_description(description)
    , m_priority(priority)
{
}

void TaskItem::setDescription(const QString &description)
{
    if (m_description == description)
        return;

    m_description = description;
    emit descriptionChanged();
}

void TaskItem::setPriority(int priority)
{
    if (m_priority == priority)
        return;

    m_priority = priority;
    emit priorityChanged();
}

QHash<int, QByteArray> TaskItem::roleNames()
{
    static const QHash<int, QByteArray> roleNames = []() {
        QHash<int, QByteArray> roles;
        const QMetaObject mo = TaskItem::staticMetaObject;
        for(auto i = 0; i < mo.propertyCount(); i++)
            roles.insert(i, mo.property(i).name());
        return roles;
    }();
    return roleNames;
}

QDebug operator<<(QDebug debug, const TaskItem &item)
{
    QDebugStateSaver saver(debug);
    debug.nospace() << "TaskItem("
                    << item.description() << ", "
                    << "priority: " << item.priority()
                    << ")";
    return debug;
}

QDebug operator<<(QDebug debug, const TaskItem *item)
{
    QDebugStateSaver saver(debug);
    if (!item) {
        debug << "TaskItem(nullptr)";
        return debug;
    }
    debug << *item;
    return debug;
}
