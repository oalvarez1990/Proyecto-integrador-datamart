use Staging
MERGE DIMTiempo AS target
USING (
    SELECT 
        fecha_entrega,
        YEAR(fecha_entrega) AS Anio,
        DATEPART(QUARTER, fecha_entrega) AS Trimestre,
        DATEPART(WEEK, fecha_entrega) AS Semana,
        MONTH(fecha_entrega) AS Mes,
        DAY(fecha_entrega) AS dia
    FROM 
        DIMTiempo
    WHERE 
        fecha_entrega IS NOT NULL
) AS source
ON target.fecha_entrega = source.fecha_entrega
WHEN MATCHED THEN
    UPDATE SET 
        target.Anio = source.Anio,
        target.Trimestre = source.Trimestre,
        target.Semana = source.Semana,
        target.Mes = source.Mes,
        target.dia = source.dia
WHEN NOT MATCHED THEN
    INSERT (fecha_entrega, Anio, Trimestre, Semana, Mes, dia)
    VALUES (source.fecha_entrega, source.Anio, source.Trimestre, source.Semana, source.Mes, source.dia);
