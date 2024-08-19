CREATE VIEW informacion_Clientes_Mas_Remesas AS
SELECT beneficiario.nombres, COUNT(*) FROM Remesas r
INNER JOIN Cuenta_Bancaria cb
ON r.beneficiario_num_cuenta_id = cb.id
INNER JOIN Personas beneficiario
ON cb.beneficiario_id = beneficiario.id_persona
WHERE fecha_estado LIKE '2024-08%'
GROUP BY beneficiario.nombres
ORDER BY count(*) DESC
LIMIT 10