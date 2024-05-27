# Proyecto ETL Jardinería

Este proyecto consiste en la extracción, transformación y carga (ETL) de datos para la base de datos de Jardinería, con el objetivo de crear un Data Mart que facilite el análisis de los datos.

## Estructura del Proyecto

La estructura de carpetas del proyecto es la siguiente:

```plaintext
ETL-Jardineria/
├── docs/
│   ├── informes/
│   │   └── informe_proceso_etl.md
│   └── diagramas/
│       └── modelo_estrella.png
├── sql/
│   ├── extraccion/
│   │   └── extraccion_datos.sql
│   ├── transformacion/
│   │   └── transformacion_datos.sql
│   └── carga/
│       └── carga_datamart.sql
├── scripts/
│   └── script_etl.sh
└── pruebas_calidad/
    ├── pruebas_integridad.sql
    ├── pruebas_consistencia.sql
    └── reporte_calidad_datos.md

## Proceso ETL
1. Extracción de Datos
Utilizamos consultas SQL para extraer los datos relevantes de la base de datos origen y cargarlos en las tablas de staging. La consulta de extracción se encuentra en sql/extraccion/extraccion_datos.sql.

Ejemplo de consulta de extracción:
-- Extraer de la fecha, fecha año, trimestre, mes, día
SELECT 
    CONVERT(date, fecha_pedido) AS Fecha_pedido, 
    CONVERT(int, DATEPART(year, fecha_pedido)) AS anio,
    CONVERT(int, DATEPART(QUARTER, fecha_pedido)) AS Trimestre,
    CONVERT(varchar, DATEPART(MONTH, fecha_pedido)) AS Mes,
    CONVERT(int, DATEPART(DAY, fecha_pedido)) AS Dia
FROM pedido;

2. Transformación de Datos
Aplicamos técnicas de transformación de datos, como limpieza, normalización y enriquecimiento, utilizando consultas SQL ubicadas en sql/transformacion/transformacion_datos.sql.

Ejemplo de transformación de datos:

sql

-- Normalizar los nombres de los productos
USE datamar_jardineria;
UPDATE DIMproducto
SET nombre = TRIM(UPPER(nombre))
WHERE nombre IS NOT NULL;

3. Carga de Datos
Los datos transformados se cargan en el Data Mart final utilizando las consultas en sql/carga/carga_datamart.sql.

Ejemplo de eliminación de datos anteriores y carga de nuevos datos:
-- Eliminar datos del Data Mart
DELETE FROM DIMcliente;
DELETE FROM DIMempleado;
DELETE FROM DIMproducto;
DELETE FROM DIMtiempo;
DELETE FROM TBL_hecho_ventas;

4. Verificación de la Calidad de Datos
Realizamos pruebas para verificar la integridad y consistencia de los datos. Las pruebas se documentan en pruebas_calidad/pruebas_integridad.sql y pruebas_calidad/pruebas_consistencia.sql, con un reporte detallado en pruebas_calidad/reporte_calidad_datos.md.

Ejemplo de pruebas de verificación de consistencia:
-- Verificar la consistencia de datos
USE datamar_jardineria;
SELECT nombre, categoria, COUNT(*) AS cantidad
FROM DIMproducto
GROUP BY nombre, categoria
HAVING COUNT(*) > 1;

Verificación de la carga de datos:
-- Verificar que los datos se hayan cargado correctamente
SELECT 
    (SELECT COUNT(*) FROM TBL_hecho_ventas) AS 'Registros en TBL_hecho_ventas',
    (SELECT COUNT(*) FROM DIMcliente) AS 'Registros en DIMcliente',
    (SELECT COUNT(*) FROM DIMempleado) AS 'Registros en DIMempleado',
    (SELECT COUNT(*) FROM DIMproducto) AS 'Registros en DIMproducto',
    (SELECT COUNT(*) FROM DIMtiempo) AS 'Registros en DIMtiempo';

Licencia
Este proyecto está licenciado bajo los términos de la Licencia MIT.