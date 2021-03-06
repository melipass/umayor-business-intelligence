CREATE TABLE CLIENTE (
    "id" NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    telefono NUMERIC(9) NOT NULL
);

CREATE TABLE PRODUCTO (
    "id" VARCHAR(20) NOT NULL PRIMARY KEY,
    tipo VARCHAR(20) NOT NULL,
    stock NUMERIC(10) DEFAULT ON NULL 0,
    precio NUMERIC(5) NOT NULL,
    alto NUMERIC(2) NOT NULL,
    ancho NUMERIC(2) NOT NULL,
    espesor NUMERIC(2) NOT NULL
);

CREATE TABLE TRANSPORTE (
    "id" NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    id_direccion NUMBER NOT NULL,
    FOREIGN KEY (id_direccion) REFERENCES DIRECCION("id")
);

CREATE TABLE TRANSPORTE_CONTACTO (
    "id" NUMBER NOT NULL,
    telefono NUMBER(7) NOT NULL,
    FOREIGN KEY ("id") REFERENCES TRANSPORTE("id")
);

CREATE TABLE TRANSPORTE_HORARIO (
    "id" NUMBER NOT NULL,
    apertura VARCHAR(5),
    cierre VARCHAR(5),
    FOREIGN KEY ("id") REFERENCES TRANSPORTE("id")
);

CREATE TABLE REGION (
    "id" VARCHAR(5) NOT NULL PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL
);    

CREATE TABLE COMUNA (
    "id" NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    region_id VARCHAR(5) NOT NULL,
    FOREIGN KEY(region_id) REFERENCES REGION("id")
);

CREATE TABLE DIRECCION (
    "id" NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    id_comuna NUMBER NOT NULL,
    direccion VARCHAR(60),
    FOREIGN KEY(id_comuna) REFERENCES COMUNA("id")
);

CREATE TABLE BOLETA (
    "id" NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    id_cliente NUMBER NOT NULL,
    id_direccion NUMBER NOT NULL,
    estado VARCHAR(10),
    fecha_compra DATE NOT NULL,
	fecha_agendada DATE NOT NULL,
    medio_pago VARCHAR(30),
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE("id"),
    FOREIGN KEY (id_direccion) REFERENCES DIRECCION("id")
);    

CREATE TABLE BOLETA_DETALLE (
    id_boleta NUMBER NOT NULL,
    id_producto VARCHAR(20) NOT NULL,
    cantidad_vendida NUMBER NOT NULL,
    monto NUMBER NOT NULL,
    estado VARCHAR(10) NOT NULL,
    FOREIGN KEY (id_boleta) REFERENCES BOLETA("id"),
    FOREIGN KEY (id_producto) REFERENCES PRODUCTO("id")
);    

CREATE TABLE ENVIO (
    "id" NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    id_boleta NUMBER NOT NULL,
    id_transporte NUMBER NOT NULL,
    fecha_entrega DATE,
    precio_envio NUMBER(5),
    FOREIGN KEY (id_boleta) REFERENCES BOLETA("id"),
    FOREIGN KEY (id_transporte) REFERENCES TRANSPORTE("id")
);

CREATE TABLE ENVIO_DETALLE (
    id_envio NUMBER NOT NULL,
    id_producto VARCHAR(20) NOT NULL,
    cantidad_enviada NUMBER NOT NULL,
    FOREIGN KEY (id_envio) REFERENCES ENVIO("id"),
    FOREIGN KEY (id_producto) REFERENCES PRODUCTO("id")
);