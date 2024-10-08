DELIMITER $$

CREATE PROCEDURE InsertarRemesa(

    IN p_nombre_merchant VARCHAR(100),
    
    IN p_tipo_documento_remitente VARCHAR(10),
    IN p_numero_documento_remitente INT,
    IN p_nombres_remitente VARCHAR(100),
    IN p_email_remitente VARCHAR(100),
    IN p_telefono_remitente INT,
    
    IN p_tipo_documento_beneficiario VARCHAR(10),
    IN p_numero_documento_beneficiario INT,
    IN p_nombres_beneficiario VARCHAR(100),
    IN p_email_beneficiario VARCHAR(100),
    IN p_telefono_beneficiario INT,
    IN p_numero_cuenta_beneficiario VARCHAR(20),
    IN p_banco_beneficiario VARCHAR(50),
    
    IN p_monto DECIMAL(10,2),
    IN p_moneda CHAR(3),
    IN p_estado VARCHAR(15),
    IN p_fecha_estado DATE
)
BEGIN
    DECLARE merchant_id INT;
    DECLARE remitente_id INT;
    DECLARE beneficiario_id INT;
    DECLARE beneficiario_cuenta_id INT;
    DECLARE merchant_remesa_id INT;

    SELECT id_merchant INTO merchant_id
    FROM Merchants
    WHERE nombre = p_nombre_merchant;
    
    IF merchant_id IS NULL THEN
      INSERT INTO Merchants (nombre)
      VALUES (p_nombre_merchant);
      SET merchant_id = LAST_INSERT_ID();
    
    ELSE 
      SET merchant_id = merchant_id;
    END IF;
    
    -- Remitente en la Tabla Personas
    SELECT id_persona INTO remitente_id
    FROM Personas
    WHERE nombres = p_nombres_remitente;

    IF remitente_id IS NULL THEN
        INSERT INTO Personas (tipo_documento, numero_documento, nombres, email, telefono)
        VALUES (p_tipo_documento_remitente, p_numero_documento_remitente, p_nombres_remitente, p_email_remitente, p_telefono_remitente);
        SET remitente_id = LAST_INSERT_ID();
    ELSE
        SET remitente_id = remitente_id;
    END IF;

    -- Beneficiario en la tabla Personas
    SELECT id_persona INTO beneficiario_id
    FROM Personas
    WHERE nombres = p_nombres_beneficiario;

    IF beneficiario_id IS NULL THEN
        INSERT INTO Personas (tipo_documento, numero_documento, nombres, email, telefono)
        VALUES (p_tipo_documento_beneficiario, p_numero_documento_beneficiario, p_nombres_beneficiario, p_email_beneficiario, p_telefono_beneficiario);
        SET beneficiario_id = LAST_INSERT_ID();
    ELSE
        -- Si ya existe, devolver el id existente
        SET beneficiario_id = beneficiario_id;
    END IF;

    -- Insertar la Cuenta Bancaria del Beneficiario
    SELECT id INTO beneficiario_cuenta_id
    FROM Cuenta_Bancaria
    WHERE numero_cuenta = p_numero_cuenta_beneficiario AND banco = p_banco_beneficiario;

    IF beneficiario_cuenta_id IS NULL THEN
        INSERT INTO Cuenta_Bancaria (beneficiario_id, numero_cuenta, banco)
        VALUES (beneficiario_id, p_numero_cuenta_beneficiario, p_banco_beneficiario);
        SET beneficiario_cuenta_id = LAST_INSERT_ID();
    END IF;

    -- Insertar el Merchant y la Remesa en Merchant_Remesa
    INSERT INTO Datos_Remesa (merchant_id, remitente_id, beneficiario_id)
    VALUES (merchant_id, remitente_id, beneficiario_id);
    
    -- Obtener el id de Merchant_Remesa
    SET merchant_remesa_id = LAST_INSERT_ID();
    
    -- Insertar la Remesa en la tabla Remesas
    INSERT INTO Remesas (merchant_remesa_id, beneficiario_num_cuenta_id, monto, moneda, estado, fecha_estado)
    VALUES (merchant_remesa_id, beneficiario_cuenta_id, p_monto, p_moneda, p_estado, p_fecha_estado);
    
END$$

DELIMITER ;