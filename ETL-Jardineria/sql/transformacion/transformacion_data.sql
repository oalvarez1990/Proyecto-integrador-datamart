--Consultar nombre producto y categoria asigngada
select distinct pro.nombre as Producto, cat.Desc_Categoria as Categoria

from producto pro inner join Categoria_producto cat on (pro.Categoria= cat.Id_Categoria)

-- consultar cliente 
select distinct nombre_cliente,ciudad,pais 
from cliente

--consulta empleado
select distinct nombre as Nombre,apellido1 as Apellido
from empleado

--Extraer de la fecha,fecha año, trimestre,mes,dia
select CONVERT(date,fecha_pedido) as Fecha_pedido, CONVERT(int,DATEPART(year,fecha_pedido)) as anio,
					CONVERT(int,DATEPART(QUARTER,fecha_pedido)) as Trimestre,
					CONVERT(varchar,DATEPART(MONTH,fecha_pedido)) as Mes,
					CONVERT(int,DATEPART(DAY,fecha_pedido)) as Dia					  
from pedido

--Llenar la data tabla de hechos 
use datamar_jardineria
SELECT 
    dimC.id AS ID_cliente,
    dimT.id AS ID_tiempo,
    dimP.id AS ID_producto,
    dimE.id AS ID_empleado,
    dp.cantidad,
    dp.precio_unidad,
    dp.cantidad * dp.precio_unidad AS Total
FROM jardineria.dbo.detalle_pedido dp
INNER JOIN jardineria.dbo.pedido p ON dp.ID_pedido = p.ID_pedido
INNER JOIN jardineria.dbo.producto prod ON dp.ID_producto = prod.ID_producto
INNER JOIN jardineria.dbo.cliente c ON p.ID_cliente = c.ID_cliente
INNER JOIN jardineria.dbo.empleado e ON c.ID_empleado_rep_ventas = e.ID_empleado
-- Dimensiones
INNER JOIN datamar_jardineria.dbo.DIMcliente dimC ON c.ID_cliente = dimC.id
INNER JOIN datamar_jardineria.dbo.DIMproducto dimP ON prod.ID_producto = dimP.id
INNER JOIN datamar_jardineria.dbo.DIMempleado dimE ON e.ID_empleado = dimE.id
INNER JOIN datamar_jardineria.dbo.DIMtiempo dimT ON p.fecha_pedido = dimT.fecha

--
use datamar_jardineria
SELECT 
    dimC.id AS ID_cliente, 
    dimT.id AS ID_tiempo, 
    dimP.id AS ID_producto, 
    dimE.id AS ID_empleado, 
    dp.cantidad, 
    dp.precio_unidad, 
    dp.cantidad * dp.precio_unidad AS total
FROM jardineria.dbo.detalle_pedido dp
INNER JOIN jardineria.dbo.pedido p ON dp.ID_pedido = p.ID_pedido
INNER JOIN jardineria.dbo.producto prod ON dp.ID_producto = prod.ID_producto
INNER JOIN jardineria.dbo.cliente c ON p.ID_cliente = c.ID_cliente
INNER JOIN jardineria.dbo.empleado e ON c.ID_empleado_rep_ventas = e.ID_empleado

-- Dimensiones
INNER JOIN datamar_jardineria.dbo.DIMcliente dimC ON c.ID_cliente = dimC.id
INNER JOIN datamar_jardineria.dbo.DIMproducto dimP ON prod.ID_producto = dimP.id
INNER JOIN datamar_jardineria.dbo.DIMempleado dimE ON e.ID_empleado = dimE.id
INNER JOIN datamar_jardineria.dbo.DIMtiempo dimT ON p.fecha_pedido = dimT.fecha;





--Eliminar datos del datamart
delete from DIMcliente
delete from DIMempleado
delete from DIMproducto
delete from DIMtiempo
delete from TBL_hecho_ventas

--Verificar la consistencia de datos 
USE datamar_jardineria;
SELECT nombre, categoria, COUNT(*) AS cantidad
FROM DIMproducto
GROUP BY nombre, categoria
HAVING COUNT(*) > 1;

--normalizar los nombres de los productos
USE datamar_jardineria;
UPDATE DIMproducto
SET nombre = TRIM(UPPER(nombre))
WHERE nombre IS NOT NULL;

-- Verificar que los datos se hayan cargado correctamente
SELECT 
    (SELECT COUNT(*) FROM TBL_hecho_ventas) AS 'Registros en TBL_hecho_ventas',
    (SELECT COUNT(*) FROM DIMcliente) AS 'Registros en DIMcliente',
    (SELECT COUNT(*) FROM DIMempleado) AS 'Registros en DIMempleado',
    (SELECT COUNT(*) FROM DIMproducto) AS 'Registros en DIMproducto',
    (SELECT COUNT(*) FROM DIMtiempo) AS 'Registros en DIMtiempo';
