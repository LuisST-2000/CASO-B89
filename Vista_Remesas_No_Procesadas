CREATE VIEW Cantidad_Remesas_No_Procesadas AS
SELECT merchant.nombre, COUNT(*) FROM Datos_Remesa dr
INNER JOIN  Remesas remesa
ON remesa.merchant_remesa_id = dr.id_merchant_remesa
INNER JOIN Merchants merchant
ON merchant.id_merchant = dr.merchant_id
WHERE estado <> 'procesado' and fecha_estado like '2024-08%'
GROUP BY merchant.nombre
