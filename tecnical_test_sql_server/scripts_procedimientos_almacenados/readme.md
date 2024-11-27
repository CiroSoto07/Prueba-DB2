Resumen de la Gestión de Permisos

Permisos a Nivel de Entidad:
Los permisos a nivel de entidad se asignan de manera general a toda la entidad (como BranchOffice o CostCenter). Estos permisos afectan a todos los registros de la tabla asociada (por ejemplo, todas las sucursales o centros de costos), y se asignan tanto a usuarios como a roles. En este caso, los permisos son más generales y no están relacionados con registros individuales.

Tablas que gestionan estos permisos:
PermiUser: Define los permisos asignados a un usuario para una entidad completa (como acceso a toda la tabla BranchOffice).
PermiRole: Define los permisos asignados a un rol para una entidad completa.

Permisos a Nivel de Registro:
Los permisos a nivel de registro individual se asignan a registros específicos dentro de una entidad. Esto permite un control más detallado, como permitir que un usuario solo pueda ver o modificar una sucursal específica o un centro de costos específico.

Tablas que gestionan estos permisos:
PermiUserRecord: Define los permisos asignados a un usuario para un registro específico dentro de una entidad (por ejemplo, para un registro de BranchOffice específico).

PermiRoleRecord: Define los permisos asignados a un rol para un registro específico dentro de una entidad.
Esquema de Gestión de Permisos para las Entidades

1. Permisos a Nivel de Entidad

Se asignan permisos de crear, leer, actualizar, eliminar, importar y exportar para toda la entidad.
Ejemplo de permisos para una sucursal (entidad BranchOffice):

Usuario Juan tiene permiso para leer todas las sucursales de la empresa.
Rol Gerente tiene permiso para leer, crear y actualizar todas las sucursales, pero no eliminar ninguna.
Las tablas involucradas:
PermiUser: Asocia permisos de entidad a usuarios.
PermiRole: Asocia permisos de entidad a roles.

2. Permisos a Nivel de Registro

Se asignan permisos más específicos a nivel de registro individual, lo que significa que un usuario o rol puede tener acceso a un solo registro de una entidad, como una sucursal específica.
Ejemplo de permisos para registros específicos de una sucursal:

Usuario Ana tiene permiso para leer la sucursal con id_broff = 3 pero no tiene acceso a otras sucursales.
Rol Vendedor tiene permiso para leer todas las sucursales, pero solo puede actualizar información en la sucursal con id_broff = 5.
Las tablas involucradas:
PermiUserRecord: Asocia permisos de registros a usuarios.
PermiRoleRecord: Asocia permisos de registros a roles.
Procedimiento para Obtener Permisos por Entidad y Registro
Como mencionamos antes, el procedimiento para obtener los permisos puede combinar los permisos de nivel de entidad con los de nivel de registro. Aquí te dejo una estructura para que veas cómo se puede gestionar esto de manera generalizada, sin necesidad de definir específicamente cada entidad.


GetUserPermissionsForEntity

Este procedimiento se encarga de obtener los permisos tanto a nivel de entidad completa como a nivel de registros individuales para un usuario dado y una entidad especificada.

Explicación:
Permisos a Nivel de Entidad: Como antes, se obtiene el permiso para la entidad completa, ya sea asignado a un rol o a un usuario.
Permisos a Nivel de Registro: Luego, usando una consulta dinámica, se obtienen los permisos para registros específicos dentro de la tabla asociada a la entidad (por ejemplo, BranchOffice o CostCenter).
Combinación de Permisos: Los resultados finales combinan los permisos tanto a nivel de entidad como a nivel de registro, y se agrupan por tipo de permiso (para roles o usuarios).

Conclusión:
Cada una de las entidades (como BranchOffice, CostCenter, etc.) en EntityCatalog puede tener permisos tanto a nivel de entidad completa como de registros individuales, y este sistema es flexible para manejar cualquier nueva entidad que se agregue al catálogo.