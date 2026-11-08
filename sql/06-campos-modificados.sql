UPDATE clientes SET rfc = 'LOAA850315999' WHERE id = 1;
SELECT 
    a.id, 
    a.fecha_hora, 
    a.usuario_sesion, 
    a.operacion,
    a.cliente_id,
    d.key AS campo_modificado, 
    a.datos_anteriores ->> d.key AS valor_anterior, 
    d.value #>> '{}' AS valor_nuevo 
FROM dba_valenzuela_anahi.auditoria_clientes a
CROSS JOIN LATERAL jsonb_each(a.datos_nuevos) d
WHERE a.operacion = 'UPDATE' 
  AND a.datos_anteriores -> d.key IS DISTINCT FROM d.value
ORDER BY a.id;
