# Changelog

## 2026-03-18 — Keith Kyzivat

- `TaskItem` now specializes `QRangeModel::RowOptions` with `rowCategory = MultiRoleItem`,
  enabling the adapter to expose multiple named Qt model roles per row.
- Role names are built by iterating over the properties of `TaskItem::staticMetaObject`,
  exposed via a new static `TaskItem::roleNames()` method used by `TaskBackend`.
- `TaskDelegate.qml` binds to the typed `description` and `priority` properties directly,
  replacing the generic `display` role.
