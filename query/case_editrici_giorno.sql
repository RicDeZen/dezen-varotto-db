SELECT DISTINCT L.nome_editore AS "Casa Editrice"
FROM libro AS L
JOIN comprende AS C
ON L.isbn = C.libro
JOIN acquisto AS A
ON C.acquisto = A.numero
WHERE A.data_acquisto = XXXX;
