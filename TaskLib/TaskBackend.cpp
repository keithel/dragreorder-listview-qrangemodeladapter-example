#include "TaskBackend.h"

TaskBackend::TaskBackend(QObject *parent = nullptr)
    : QObject(parent)
    , m_adapter(std::ref(m_data))
{
    // Initialize with sample data
    m_adapter.insertRow(0, new TaskItem("Fix CMake bugs", 1));
    m_adapter.insertRow(1, new TaskItem("Update Qt 6.11 docs", 2));
    m_adapter.insertRow(2, new TaskItem("Refactor QML Modules", 3));
}

QAbstractItemModel* TaskBackend::taskModel() const
{
    return m_adapter.model();
}

void TaskBackend::moveTask(int from, int to)
{
    if (from == to) return;
    m_adapter.moveRows({}, from, 1, {}, to > from ? to + 1 : to);
}
