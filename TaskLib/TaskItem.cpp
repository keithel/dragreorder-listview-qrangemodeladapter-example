#include "TaskItem.h"

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
