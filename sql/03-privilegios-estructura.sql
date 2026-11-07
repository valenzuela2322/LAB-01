REVOKE UPDATE ON clientes FROM soporte_valenzuela_anahi;
GRANT UPDATE ON clientes TO app_ventas_valenzuela_anahi;
ALTER TABLE clientes ADD COLUMN IF NOT EXISTS segmento_valenzuela_anahi VARCHAR(20);


SELECT num, linea 
FROM dba_valenzuela_anahi.bitacora 
WHERE linea ~ '(GRANT|REVOKE|ALTER TABLE)' 
ORDER BY num;
