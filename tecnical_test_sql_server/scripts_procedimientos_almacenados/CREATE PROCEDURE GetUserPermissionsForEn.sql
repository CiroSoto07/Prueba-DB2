CREATE PROCEDURE GetUserPermissionsForEntity
    @UserId BIGINT,              -- ID del usuario
    @EntityCatalogId INT         -- ID de la entidad en EntityCatalog
AS
BEGIN
    -- Variables para almacenar permisos a nivel de entidad y de registro
    DECLARE @Permissions TABLE (
        PermissionId BIGINT,
        CanCreate BIT,
        CanRead BIT,
        CanUpdate BIT,
        CanDelete BIT,
        CanImport BIT,
        CanExport BIT,
        EntityType NVARCHAR(255),
        IsRolePermission BIT
    );

    -- Obtener el nombre de la tabla asociada con el EntityCatalogId
    DECLARE @EntityTableName NVARCHAR(255);
    SELECT @EntityTableName = entit_table_name
    FROM EntityCatalog
    WHERE id_entit = @EntityCatalogId;

    -- Si no se encuentra la entidad, terminar el procedimiento
    IF @EntityTableName IS NULL
    BEGIN
        PRINT 'Entidad no encontrada';
        RETURN;
    END

    -- 1. Obtener permisos a nivel de entidad (sin especificar registros)
    -- Permisos asignados a roles a nivel de entidad
    INSERT INTO @Permissions
    SELECT 
        pr.permission_id,
        pr.can_create, pr.can_read, pr.can_update, pr.can_delete,
        pr.can_import, pr.can_export,
        ec.entit_name AS EntityType,
        1 AS IsRolePermission
    FROM PermiRole pr
    JOIN UserCompany uc ON pr.role_id = uc.role_id
    JOIN EntityCatalog ec ON pr.entitycatalog_id = ec.id_entit
    WHERE uc.user_id = @UserId
    AND pr.entitycatalog_id = @EntityCatalogId;

    -- Permisos asignados directamente al usuario a nivel de entidad
    INSERT INTO @Permissions
    SELECT 
        pu.permission_id,
        pu.can_create, pu.can_read, pu.can_update, pu.can_delete,
        pu.can_import, pu.can_export,
        ec.entit_name AS EntityType,
        0 AS IsRolePermission
    FROM PermiUser pu
    JOIN UserCompany uc ON pu.usercompany_id = uc.id_useco
    JOIN EntityCatalog ec ON pu.entitycatalog_id = ec.id_entit
    WHERE uc.user_id = @UserId
    AND pu.entitycatalog_id = @EntityCatalogId;

    -- 2. Obtener permisos a nivel de registros específicos de la tabla asociada
    DECLARE @SQL NVARCHAR(MAX);
    SET @SQL = N'
    -- Permisos a nivel de registros para roles
    INSERT INTO @Permissions
    SELECT 
        prr.permission_id,
        prr.can_create, prr.can_read, prr.can_update, prr.can_delete,
        prr.can_import, prr.can_export,
        ec.entit_name AS EntityType,
        1 AS IsRolePermission
    FROM PermiRoleRecord prr
    JOIN UserCompany uc ON prr.role_id = uc.role_id
    JOIN EntityCatalog ec ON prr.entitycatalog_id = ec.id_entit
    WHERE uc.user_id = @UserId
    AND prr.entitycatalog_id = @EntityCatalogId;

    -- Permisos a nivel de registros para usuarios
    INSERT INTO @Permissions
    SELECT 
        pur.permission_id,
        pur.can_create, pur.can_read, pur.can_update, pur.can_delete,
        pur.can_import, pur.can_export,
        ec.entit_name AS EntityType,
        0 AS IsRolePermission
    FROM PermiUserRecord pur
    JOIN UserCompany uc ON pur.usercompany_id = uc.id_useco
    JOIN EntityCatalog ec ON pur.entitycatalog_id = ec.id_entit
    WHERE uc.user_id = @UserId
    AND pur.entitycatalog_id = @EntityCatalogId;
    ';

    -- Ejecutar la consulta dinámica para obtener los permisos a nivel de registro
    EXEC sp_executesql @SQL;

    -- 3. Seleccionar los permisos finales (combinando entidad y registros)
    SELECT 
        p.PermissionId,
        MAX(p.CanCreate) AS CanCreate,
        MAX(p.CanRead) AS CanRead,
        MAX(p.CanUpdate) AS CanUpdate,
        MAX(p.CanDelete) AS CanDelete,
        MAX(p.CanImport) AS CanImport,
        MAX(p.CanExport) AS CanExport,
        p.EntityType,
        p.IsRolePermission
    FROM @Permissions p
    GROUP BY p.PermissionId, p.EntityType, p.IsRolePermission
    ORDER BY p.EntityType, p.PermissionId;
END;
