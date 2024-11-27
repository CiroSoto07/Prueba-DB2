--Crear una Tabla de Auditoría
--El tipo de acción (action_type) puede tomar los siguientes valores:
    --INSERT: Cuando se inserta un nuevo permiso.
    --UPDATE: Cuando se actualiza un permiso existente.
    --DELETE: Cuando se elimina un permiso.


CREATE TABLE AuditLog (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,  -- Identificador único de la auditoría
    action_type VARCHAR(50),               -- Tipo de acción: 'INSERT', 'UPDATE', 'DELETE'
    table_name VARCHAR(50),                -- Nombre de la tabla afectada
    record_id BIGINT,                      -- ID del registro afectado
    permission_id BIGINT,                  -- ID del permiso afectado
    user_id BIGINT,                        -- ID del usuario que realizó la acción
    role_id BIGINT NULL,                   -- ID del rol (si es relevante)
    entitycatalog_id BIGINT,               -- ID de la entidad catalogada (Sucursal, Centro de Costo, etc.)
    old_value TEXT NULL,                   -- Valor anterior (antes del cambio)
    new_value TEXT NULL,                   -- Valor nuevo (después del cambio)
    action_timestamp DATETIME DEFAULT GETDATE() -- Fecha y hora de la acción
);
