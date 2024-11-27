-- Ejecución del procedimiento para obtener permisos de un usuario (Usuario con ID 1) sobre la entidad BranchOffice (id_entit = 1)

    EXEC GetUserPermissionsForEntity @UserId = 1, @EntityCatalogId = 1;


Resultado esperado (tabla de permisos):

PermissionId	CanCreate	CanRead	CanUpdate	CanDelete	CanImport	CanExport	EntityType	IsRolePermission
1	1	1	1	0	1	0	BranchOffice	0
2	0	1	0	0	0	0	BranchOffice	0
3	1	1	1	0	1	0	BranchOffice	1

Descripción de la salida:

Usuario 1 tiene permisos a nivel de entidad BranchOffice (puede crear, leer y actualizar, pero no eliminar ni exportar).

El usuario 1 también tiene permisos de lectura y actualización sobre el registro específico de la sucursal con id_broff = 5 (a través de PermiUserRecord).

El rol Gerente tiene permisos completos sobre la sucursal con id_broff = 3 (a través de PermiRoleRecord).