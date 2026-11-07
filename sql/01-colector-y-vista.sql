-- 1. Eliminar la vista anterior para evitar conflictos de collation
DROP VIEW IF EXISTS dba_valenzuela_anahi.bitacora;

-- 2. Crear la vista corregida con soporte de codificación
CREATE VIEW dba_valenzuela_anahi.bitacora AS
SELECT t.n AS num, t.linea
FROM regexp_split_to_table(
         convert_from(pg_read_binary_file(pg_current_logfile()), 'WIN1252'), 
         E'\r?\n'
     ) WITH ORDINALITY AS t(linea, n)
WHERE t.linea <> '';

-- 3. Probar la consulta
SELECT num, linea FROM dba_valenzuela_anahi.bitacora ORDER BY num DESC LIMIT 10;
