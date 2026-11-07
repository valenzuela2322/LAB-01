-- (Actividades 8 y 9): Función SECURITY DEFINER para capturar OLD y NEW
CREATE OR REPLACE FUNCTION dba_valenzuela_anahi.fn_auditoria_clientes()
RETURNS TRIGGER 
SECURITY DEFINER
SET search_path = dba_valenzuela_anahi, public, pg_temp
AS $$
BEGIN
    IF (TG_OP = 'UPDATE') THEN
        INSERT INTO dba_valenzuela_anahi.auditoria_clientes (usuario_sesion, operacion, cliente_id, datos_anteriores, datos_nuevos)
        VALUES (session_user, TG_OP, OLD.id, to_jsonb(OLD), to_jsonb(NEW));
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO dba_valenzuela_anahi.auditoria_clientes (usuario_sesion, operacion, cliente_id, datos_anteriores, datos_nuevos)
        VALUES (session_user, TG_OP, OLD.id, to_jsonb(OLD), NULL);
        RETURN OLD;
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO dba_valenzuela_anahi.auditoria_clientes (usuario_sesion, operacion, cliente_id, datos_anteriores, datos_nuevos)
        VALUES (session_user, TG_OP, NEW.id, NULL, to_jsonb(NEW));
        RETURN NEW;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Asociar el trigger a la tabla clientes
DROP TRIGGER IF EXISTS trg_auditoria_clientes ON clientes;
CREATE TRIGGER trg_auditoria_clientes
AFTER INSERT OR UPDATE OR DELETE ON clientes
FOR EACH ROW EXECUTE FUNCTION dba_valenzuela_anahi.fn_auditoria_clientes();
