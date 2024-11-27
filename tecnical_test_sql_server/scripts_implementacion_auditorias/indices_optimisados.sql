--índices optimisados
-- Índice para optimizar consultas por fecha y tipo de acción
CREATE INDEX idx_AuditLog_Timestamp_ActionType ON AuditLog(action_timestamp, action_type);

-- Índice para optimizar consultas por usuario o entidad
CREATE INDEX idx_AuditLog_User_Entity ON AuditLog(user_id, entitycatalog_id);