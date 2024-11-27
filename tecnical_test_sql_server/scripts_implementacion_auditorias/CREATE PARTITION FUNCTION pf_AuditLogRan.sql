CREATE PARTITION FUNCTION pf_AuditLogRange (DATETIME)
AS RANGE RIGHT FOR VALUES 
    ('2024-01-01', '2025-01-01', '2026-01-01'); -- Define los rangos de fechas

CREATE PARTITION SCHEME ps_AuditLog
AS PARTITION pf_AuditLogRange
TO ([PRIMARY], [AuditLog2024], [AuditLog2025], [AuditLog2026]);

CREATE TABLE AuditLog (
    id BIGINT IDENTITY(1,1),
    action_type VARCHAR(50),
    table_name VARCHAR(50),
    record_id BIGINT,
    permission_id BIGINT,
    user_id BIGINT,
    role_id BIGINT,
    entitycatalog_id BIGINT,
    old_value TEXT,
    new_value TEXT,
    action_timestamp DATETIME DEFAULT GETDATE()
)
ON ps_AuditLog(action_timestamp);  -- Usa la función de particionamiento
