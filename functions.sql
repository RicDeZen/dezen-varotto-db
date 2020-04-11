/*
	Query 1
*/
CREATE FUNCTION dipendente_piu_vendite ()
RETURNS TABLE(
	"Codice Fiscale" tipo_codice_fiscale,
	"Nome" character varying(20),
	"Cognome" character varying(20)
) AS $$
    SELECT A.dipendente AS "Codice Fiscale", D.nome AS "Nome", D.cognome AS "Cognome"
	FROM acquisti_per_dipendente AS A
	JOIN dipendente AS D
	ON A.dipendente = D.cf
	WHERE acquisti IN (SELECT MAX(acquisti) FROM acquisti_per_dipendente);
$$ LANGUAGE SQL;

/*
	Query 2
*/
CREATE FUNCTION fornitore_miglior_prezzo (book tipo_codice_isbn)
RETURNS TABLE("Fornitore" tipo_partita_iva, "Prezzo" numeric) AS $$
	SELECT fornitore AS "Fornitore", prezzo AS "Prezzo"
	FROM catalogo
	WHERE libro = book
	AND prezzo IN (
    	SELECT MIN(prezzo)
    	FROM catalogo
    	WHERE libro = book
	);
$$ LANGUAGE SQL;

/*
	Query 3
*/
CREATE FUNCTION genere_piu_venduto ()
RETURNS TABLE(
	"Genere più venduto" character varying,
	"Descrizione" text,
	"Vendite" bigint
) AS $$
    SELECT G.nome AS "Genere più venduto", G.descrizione AS "Descrizione", V.quantita AS "Vendite"
	FROM vendite_per_genere AS V
	JOIN genere AS G
	ON G.nome = V.genere
	WHERE V.quantita IN (
    	SELECT MAX(quantita) FROM vendite_per_genere
	);
$$ LANGUAGE SQL;

/*
	Query 4
*/
CREATE FUNCTION case_editrici_vendite (giorno date)
RETURNS TABLE("Casa Editrice" character varying(20)) AS $$
    SELECT DISTINCT L.nome_editore AS "Casa Editrice"
		FROM libro AS L
		JOIN comprende AS C
		ON L.isbn = C.libro
		JOIN acquisto AS A
		ON C.acquisto = A.numero
	  WHERE A.data_acquisto = giorno;
$$ LANGUAGE SQL;

/*
	Query 7
*/
CREATE FUNCTION bilancio () RETURNS numeric(11,2) AS $$
	SELECT
		(SELECT SUM(importo) FROM acquisto) -
		(SELECT SUM(importo) FROM ordine) -
		(SELECT SUM(stipendio) FROM dipendente)
	AS "Bilancio";
$$ LANGUAGE SQL;

/*
	Query 8
*/
CREATE FUNCTION libri_genere (book tipo_codice_isbn)
RETURNS TABLE(
	"ISBN" tipo_codice_isbn,
	"Titolo" character varying,
	"Collana" character varying
) AS $$
    SELECT DISTINCT L.isbn AS "ISBN", L.titolo AS "Titolo", L.nome_collana AS "Collana"
	FROM appartiene AS A
	JOIN libro AS L
	ON A.libro = L.isbn
	WHERE A.genere = book;
$$ LANGUAGE SQL;
