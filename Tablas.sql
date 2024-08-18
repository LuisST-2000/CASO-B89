-- Tabla Personas
CREATE TABLE Personas (
    id_persona INT AUTO_INCREMENT PRIMARY KEY,
    tipo_documento VARCHAR(255),
    numero_documento INT,
    nombres VARCHAR(255),
    email VARCHAR(255),
    telefono INT,
    UNIQUE(id_persona, numero_documento)
);

-- Tabla Merchants
CREATE TABLE Merchants (
    id_merchant INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) UNIQUE
);

-- Tabla Cuenta_Bancaria
CREATE TABLE Cuenta_Bancaria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    beneficiario_id INT,
    numero_cuenta VARCHAR(255),
    banco VARCHAR(255),
    FOREIGN KEY (beneficiario_id) REFERENCES Personas(id_persona)
);

-- Tabla Datos_Remesa
CREATE TABLE Datos_Remesa (
    id_merchant_remesa INT AUTO_INCREMENT PRIMARY KEY,
    merchant_id INT,
    remitente_id INT,
    beneficiario_id INT,
    FOREIGN KEY (merchant_id) REFERENCES Merchants(id_merchant),
    FOREIGN KEY (remitente_id) REFERENCES Personas(id_persona),
    FOREIGN KEY (beneficiario_id) REFERENCES Personas(id_persona)
);

-- Tabla Remesas
CREATE TABLE Remesas (
    id_remesa INT AUTO_INCREMENT PRIMARY KEY,
    merchant_remesa_id INT,
    beneficiario_num_cuenta_id INT,
    monto DECIMAL(10, 2),
    moneda CHAR(3),
    estado ENUM('pendiente', 'procesado', 'no procesado'),
    fecha_estado DATE,
    FOREIGN KEY (merchant_remesa_id) REFERENCES Datos_Remesa(id_merchant_remesa),
    FOREIGN KEY (beneficiario_num_cuenta_id) REFERENCES Cuenta_Bancaria(id)
);


ALTER TABLE `Datos_Remesa` AUTO_INCREMENT = 100;