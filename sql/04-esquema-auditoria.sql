-- Parte B (Actividad 7)
CREATE SCHEMA IF NOT EXISTS dba_valenzuela_anahi;

CREATE TABLE IF NOT EXISTS dba_valenzuela_anahi.auditoria_clientes (
    id BIGSERIAL PRIMARY KEY,
    fecha_hora TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    usuario_sesion VARCHAR(60) NOT NULL,
    operacion VARCHAR(10) NOT NULL,
    cliente_id BIGINT NOT NULL,
    datos_anteriores JSONB,
    datos_nuevos JSONB
);

REVOKE ALL ON TABLE dba_valenzuela_anahi.auditoria_clientes FROM PUBLIC;
