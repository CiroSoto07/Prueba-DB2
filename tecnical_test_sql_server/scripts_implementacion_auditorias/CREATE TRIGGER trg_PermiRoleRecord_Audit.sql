CREATE TRIGGER trg_PermiRoleRecord_Audit
ON PermiRoleRecord
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @action_type VARCHAR(50);
    DECLARE @role_id BIGINT;
    DECLARE @entitycatalog_id BIGINT;
    DECLARE @record_id BIGINT;
    DECLARE @permission_id BIGINT;
    DECLARE @old_value TEXT;
    DECLARE @new_value TEXT;

    -- Determinar el tipo de acción (INSERT, UPDATE, DELETE)
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @action_type = 'INSERT';
        SELECT @role_id = role_id, @entitycatalog_id = entitycatalog_id, @record_id = perrc_record, @permission_id = permission_id
        FROM inserted;
        SET @new_value = (SELECT permission_id FROM inserted);
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @action_type = 'DELETE';
        SELECT @role_id = role_id, @entitycatalog_id = entitycatalog_id, @record_id = perrc_record, @permission_id = permission_id
        FROM deleted;
        SET @old_value = (SELECT permission_id FROM deleted);
    END

    -- Registrar el cambio en la tabla de auditoría
    INSERT INTO AuditLog (action_type, table_name, record_id, permission_id, role_id, entitycatalog_id, old_value, new_value)
    VALUES (@action_type, 'PermiRoleRecord', @record_id, @permission_id, @role_id, @entitycatalog_id, @old_value, @new_value);
END;
