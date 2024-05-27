--Extraer de la fecha,fecha año, trimestre,mes,dia
select CONVERT(date,fecha_pedido) as Fecha_pedido, CONVERT(int,DATEPART(year,fecha_pedido)) as anio,
					CONVERT(int,DATEPART(QUARTER,fecha_pedido)) as Trimestre,
					CONVERT(varchar,DATEPART(MONTH,fecha_pedido)) as Mes,
					CONVERT(int,DATEPART(DAY,fecha_pedido)) as Dia					  
from pedido


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
