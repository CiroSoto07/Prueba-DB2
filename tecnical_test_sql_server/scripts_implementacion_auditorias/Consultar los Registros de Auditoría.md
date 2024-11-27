--Consultar los Registros de Auditoría

SELECT * FROM AuditLog
ORDER BY action_timestamp DESC;



--Consultas de Paginación
SELECT * 
FROM AuditLog
ORDER BY action_timestamp DESC
OFFSET 0 ROWS FETCH NEXT 100 ROWS ONLY;

