#include "TaskBackend.h"
#include <QDebug>

static int nextPriority() {
    static int priority = 0;
    return ++priority;
}

TaskBackend::TaskBackend(QObject *parent)
    : QObject(parent)
    , m_data({
        new TaskItem("Empty dishwasher", nextPriority()),
        new TaskItem("Wash clothes", nextPriority()),
        new TaskItem("Clear table", nextPriority()),
        new TaskItem("Dry clothes", nextPriority()),
        new TaskItem("Load dishwasher", nextPriority()),
        new TaskItem("Fold clothes", nextPriority()),
        new TaskItem("Run dishwasher", nextPriority()),
        new TaskItem("Put clothes away", nextPriority())
    })
    // Initialize with sample data
    , m_adapter(std::ref(m_data))
{
    qDebug() << m_data;
}

QAbstractItemModel* TaskBackend::taskModel() const
{
    return m_adapter.model();
}

void TaskBackend::moveTask(int from, int to)
{
    if (from == to) return;
    qDebug() << "Moving task" << m_data[from]->description() << "at index" << from << "to index" << to;
    m_adapter.moveRows(from, 1, to > from ? to + 1 : to);
}
