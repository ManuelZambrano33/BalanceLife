CREATE DATABASE BalanceLife;
USE BalanceLife;

-- Tabla USUARIO
CREATE TABLE USUARIO (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL,
    fecha_registro DATE DEFAULT (CURRENT_TIMESTAMP),
    peso FLOAT CHECK (peso > 0),
    altura FLOAT CHECK (altura > 0),
    edad INT CHECK (edad > 0),
    genero VARCHAR(20),
    meta_diaria_agua FLOAT CHECK (meta_diaria_agua > 0),
    meta_horas_sueno INT CHECK (meta_horas_sueno > 0),
    nivel INT DEFAULT 1,
    puntos INT DEFAULT 0
);

-- Tabla AVATAR
CREATE TABLE AVATAR (
    id_avatar INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT UNIQUE,
    color_piel VARCHAR(50),
    genero VARCHAR(20),
    color_ojos VARCHAR(50),
    color_cabello VARCHAR(50),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);

-- Tabla VESTUARIO
CREATE TABLE VESTUARIO (
    id_vestuario INT AUTO_INCREMENT PRIMARY KEY,
    tipo_a VARCHAR(50) NOT NULL
);

-- Tabla ITEM
CREATE TABLE ITEM (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio INT CHECK (precio >= 0),
    id_vestuario INT,
    FOREIGN KEY (id_vestuario) REFERENCES VESTUARIO(id_vestuario)
);

-- Tabla COMPRA
CREATE TABLE COMPRA (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_item INT,
    fecha_compra DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_item) REFERENCES ITEM(id_item)
);

-- Tabla ABSTRACT_HABITO
CREATE TABLE ABSTRACT_HABITO (
    id_habito INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(500),
    id_usuario INT,
    frecuencia VARCHAR(50),
    fecha DATE,
    estado VARCHAR(50),
    tipo VARCHAR(50) NOT NULL CHECK (tipo IN ('HIDRATACION', 'SUENO', 'ALIMENTACION', 'ACTIVIDAD_FISICA')),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);

-- Tabla REGISTRO_HIDRATACION
CREATE TABLE REGISTRO_HIDRATACION (
    id_registro INT AUTO_INCREMENT PRIMARY KEY,
    id_habito INT,
    cantidad_agua FLOAT CHECK (cantidad_agua > 0),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_habito) REFERENCES ABSTRACT_HABITO(id_habito) ON DELETE CASCADE
);

-- Tabla REGISTRO_SUENO
CREATE TABLE REGISTRO_SUENO (
    id_registro INT AUTO_INCREMENT PRIMARY KEY,
    id_habito INT,
    horas_dormidas INT CHECK (horas_dormidas > 0),
    calidad_sueno INT CHECK (calidad_sueno BETWEEN 1 AND 10),
    fecha_inicio DATETIME,
    fecha_fin DATETIME,
    FOREIGN KEY (id_habito) REFERENCES ABSTRACT_HABITO(id_habito) ON DELETE CASCADE
);

-- Tabla REGISTRO_ALIMENTACION
CREATE TABLE REGISTRO_ALIMENTACION (
    id_registro INT AUTO_INCREMENT PRIMARY KEY,
    id_habito INT,
    cantidad FLOAT CHECK (cantidad > 0),
    calorias INT CHECK (calorias >= 0),
    tipo_comida VARCHAR(100),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_habito) REFERENCES ABSTRACT_HABITO(id_habito) ON DELETE CASCADE
);

-- Tabla REGISTRO_ACTIVIDAD_FISICA
CREATE TABLE REGISTRO_ACTIVIDAD_FISICA (
    id_registro INT AUTO_INCREMENT PRIMARY KEY,
    id_habito INT,
    distancia FLOAT CHECK (distancia >= 0),
    pasos INT CHECK (pasos >= 0),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_habito) REFERENCES ABSTRACT_HABITO(id_habito) ON DELETE CASCADE
);

-- Tabla DESAFIO
CREATE TABLE DESAFIO (
    id_desafio INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    recompensa VARCHAR(100),
    estado VARCHAR(50),
    descripcion VARCHAR(500),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);

-- Tabla MINIJUEGO
CREATE TABLE MINIJUEGO (
    id_minijuego INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50),
    puntuacion INT DEFAULT 0,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);

-- Tabla LOGRO
CREATE TABLE LOGRO (
    id_logro INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(500),
    fecha_desbloqueo DATE,
    puntos_ganados INT CHECK (puntos_ganados >= 0),
    id_usuario INT,
    estado BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);
-- Índices para optimizar consultas
CREATE INDEX idx_usuario_email ON USUARIO(email);
CREATE INDEX idx_avatar_usuario ON AVATAR(id_usuario);
CREATE INDEX idx_habito_usuario ON ABSTRACT_HABITO(id_usuario);
CREATE INDEX idx_desafio_usuario ON DESAFIO(id_usuario);
CREATE INDEX idx_minijuego_usuario ON MINIJUEGO(id_usuario);
CREATE INDEX idx_logro_usuario ON LOGRO(id_usuario);

SHOW TABLES;
SELECT * FROM ABSTRACT_HABITO;