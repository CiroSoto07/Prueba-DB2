-- Insertar permisos en la tabla Permission
INSERT INTO Permission (name, description, can_create, can_read, can_update, can_delete, can_import, can_export)
VALUES ('Read Only', 'Permiso solo lectura', 0, 1, 0, 0, 0, 0),
       ('Full Access', 'Permiso completo de acceso', 1, 1, 1, 1, 1, 1);

-- Insertar roles
INSERT INTO Role (company_id, role_name, role_code)
VALUES (1, 'Administrador', 'ADMIN'),
       (1, 'Usuario', 'USER');

-- Insertar usuarios
INSERT INTO [User] (user_username, user_password, user_email)
VALUES ('juan', 'password123', 'juan@empresa.com'),
       ('maria', 'password123', 'maria@empresa.com');

-- Relación usuario-empresa
INSERT INTO UserCompany (user_id, company_id)
VALUES (1, 1),
       (2, 1);



--Insertar Permisos a Nivel de Entidad
-- Asignar permisos a un usuario para toda la entidad BranchOffice
INSERT INTO PermiUser (usercompany_id, entitycatalog_id, can_create, can_read, can_update, can_delete, can_import, can_export)
VALUES
(1, 1, 1, 1, 1, 0, 1, 0);  -- Usuario con ID 1 tiene permisos de crear, leer, y actualizar BranchOffice, pero no eliminar ni exportar

INSERT INTO PermiUser (usercompany_id, entitycatalog_id, can_create, can_read, can_update, can_delete, can_import, can_export)
VALUES
(2, 1, 0, 1, 0, 0, 0, 0);  -- Usuario con ID 2 tiene solo permiso de leer BranchOffice

--Permisos de Rol a Nivel de Entidad
-- Asignar permisos al rol "Gerente" para toda la entidad BranchOffice
INSERT INTO PermiRole (role_id, entitycatalog_id, can_create, can_read, can_update, can_delete, can_import, can_export)
VALUES
(1, 1, 1, 1, 1, 1, 1, 1);  -- El rol Gerente tiene todos los permisos sobre BranchOffice

-- Asignar permisos al rol "Vendedor" para toda la entidad BranchOffice
INSERT INTO PermiRole (role_id, entitycatalog_id, can_create, can_read, can_update, can_delete, can_import, can_export)
VALUES
(2, 1, 0, 1, 0, 0, 0, 0);  -- El rol Vendedor solo tiene permisos de lectura sobre BranchOffice



--Insertar Permisos a Nivel de Registro
-- Asignar permisos a un usuario para un registro específico de la entidad BranchOffice (id_broff = 3)
INSERT INTO PermiUserRecord (usercompany_id, entitycatalog_id, record_id, can_create, can_read, can_update, can_delete, can_import, can_export)
VALUES
(1, 1, 3, 0, 1, 0, 0, 0, 0);  -- Usuario 1 tiene permiso de lectura para la sucursal con ID 3

-- Asignar permisos a un usuario para otro registro específico de la entidad BranchOffice (id_broff = 5)
INSERT INTO PermiUserRecord (usercompany_id, entitycatalog_id, record_id, can_create, can_read, can_update, can_delete, can_import, can_export)
VALUES
(2, 1, 5, 0, 1, 1, 0, 0, 0);  -- Usuario 2 tiene permiso de leer y actualizar la sucursal con ID 5

--Permisos de Rol a Nivel de Registro
-- Asignar permisos al rol "Gerente" para un registro específico de la entidad BranchOffice (id_broff = 3)
INSERT INTO PermiRoleRecord (role_id, entitycatalog_id, record_id, can_create, can_read, can_update, can_delete, can_import, can_export)
VALUES
(1, 1, 3, 1, 1, 1, 0, 1, 0);  -- El rol Gerente tiene permisos completos para la sucursal con ID 3

-- Asignar permisos al rol "Vendedor" para un registro específico de la entidad BranchOffice (id_broff = 5)
INSERT INTO PermiRoleRecord (role_id, entitycatalog_id, record_id, can_create, can_read, can_update, can_delete, can_import, can_export)
VALUES
(2, 1, 5, 0, 1, 0, 0, 0, 0);  -- El rol Vendedor solo tiene permiso de lectura para la sucursal con ID 5
