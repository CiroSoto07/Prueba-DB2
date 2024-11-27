--eliminación automática

DELETE FROM AuditLog
WHERE action_timestamp < DATEADD(YEAR, -1, GETDATE());
