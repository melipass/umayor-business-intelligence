INSERT INTO CLIENTE (nombre, telefono)
SELECT cliente, telefono
FROM CLIENTES_ORIGINAL;

INSERT INTO PRODUCTO ("id", tipo, alto, ancho, espesor, precio)
SELECT codigo, colortipo, alto, ancho, espesor, precio
FROM PRODUCTOS_ORIGINAL;

INSERT INTO TRANSPORTE (nombre, direccion, comuna)
SELECT nombre, direccion, comuna
FROM TRANSPORTES_ORIGINAL;

/* Agrega el primer teléfono de los transportistas */
INSERT INTO TRANSPORTE_CONTACTO ("id", telefono)
SELECT a."id", SUBSTR(CAST(regexp_replace(b.telefono, '[^0-9]+', '') AS NUMBER), 0, 7)
FROM TRANSPORTE a
INNER JOIN TRANSPORTES_ORIGINAL b
ON a.nombre = b.nombre;

/* Para aquellos transportistas con más de un teléfono, agrega el 2do y 3ro,
tomando en consideración que en la data original el 1er número de los transportistas
que tienen tres teléfonos tiene un dígito menos, por lo que se debe comenzar con un
offset -1 en esos casos y por eso tomamos la substring desde el espacio 7 */
INSERT INTO TRANSPORTE_CONTACTO ("id", telefono)
SELECT
    a."id",
    CASE
        WHEN LENGTH(b.telefono) = 30
            THEN SUBSTR(CAST(regexp_replace(b.telefono, '[^0-9]+', '') AS NUMBER), 7, 7)
        WHEN LENGTH(b.telefono) = 19    
            THEN SUBSTR(CAST(regexp_replace(b.telefono, '[^0-9]+', '') AS NUMBER), 8, 7)
    END    
FROM TRANSPORTE a
INNER JOIN TRANSPORTES_ORIGINAL b
ON a.nombre = b.nombre
WHERE LENGTH(b.telefono) IN (30, 19)
UNION ALL
SELECT
    a."id",
    SUBSTR(CAST(regexp_replace(b.telefono, '[^0-9]+', '') AS NUMBER), 14, 7)
FROM TRANSPORTE a
INNER JOIN TRANSPORTES_ORIGINAL b
ON a.nombre = b.nombre
WHERE LENGTH(b.telefono) IN (30);


INSERT INTO REGION("id", nombre)
WITH data AS (SELECT DISTINCT(region) AS d_region FROM CLIENTES_ORIGINAL)
SELECT REGEXP_SUBSTR(d_region, '[^ ]+'), SUBSTR(REGEXP_SUBSTR(d_region, '\ (.*)'), 2) FROM data;


INSERT INTO COMUNA(region_id, nombre)
WITH data AS (SELECT DISTINCT(region) AS d_region, comuna FROM CLIENTES_ORIGINAL)
SELECT REGEXP_SUBSTR(d_region, '[^ ]+'), comuna
FROM data;
/* Si comparamos la tabla generada desde los clientes con las comunas de la tabla transportes,
faltan las siguientes, que como son pocas son agregadas manualmente */
INSERT INTO COMUNA (region_id, nombre) VALUES ('RM', 'Conchalí');
INSERT INTO COMUNA (region_id, nombre) VALUES ('RM', 'Lo Espejo');
INSERT INTO COMUNA (region_id, nombre) VALUES ('RM', 'Renca');


INSERT INTO DIRECCION(direccion, id_comuna)
WITH data AS (SELECT DISTINCT(region) AS d_region, comuna, direccion FROM CLIENTES_ORIGINAL ORDER BY 2,3)
SELECT a.direccion, b."id"
FROM data a
INNER JOIN COMUNA b
ON a.comuna = b.nombre
WHERE REGEXP_SUBSTR(a.d_region, '[^ ]+') = b.region_id;

INSERT INTO DIRECCION(direccion, id_comuna)
WITH d AS (SELECT direccion FROM TRANSPORTE MINUS SELECT direccion FROM DIRECCION)
SELECT DISTINCT(d.direccion), c."id" FROM d
INNER JOIN TRANSPORTE t
ON d.direccion = t.direccion
INNER JOIN COMUNA c
ON c.nombre = t.comuna;


INSERT INTO BOLETA (id_cliente, id_direccion, estado, fecha_compra, medio_pago, fecha_agendada)
WITH co_d_c AS (
    SELECT DISTINCT(co.cliente) as cliente, c."id" as id_cliente, co.mediopago as mediopago, d."id" as id_direccion, d.direccion
    FROM CLIENTES_ORIGINAL co
    INNER JOIN DIRECCION d
    ON co.direccion = d.direccion
    INNER JOIN CLIENTE c
    ON co.cliente = c.nombre)
SELECT a.id_cliente, a.id_direccion, b.estado, b.fecha, a.mediopago, NULL
FROM co_d_c a
INNER JOIN PEDIDOS_ORIGINAL b
ON b.cliente = a.cliente
GROUP BY a.id_cliente, a.id_direccion, b.estado, b.fecha, a.mediopago;

INSERT INTO BOLETA_DETALLE(id_boleta, id_producto, cantidad_vendida, monto, estado)
WITH b_c AS (
    SELECT b."id" as id_boleta, c.nombre as nombre, b.fecha_compra as fecha
    FROM BOLETA b
    INNER JOIN CLIENTE c
    ON b.id_cliente = c."id")
SELECT b_c.id_boleta, p."id", p_o.cantidad, p.precio, p_o.estado
FROM PEDIDOS_ORIGINAL p_o
INNER JOIN PRODUCTO p
ON p_o.producto = p."id"
INNER JOIN b_c
ON p_o.fecha = b_c.fecha AND p_o.cliente = b_c.nombre;