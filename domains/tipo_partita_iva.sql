CREATE DOMAIN tipo_partita_iva AS CHAR(11)
CHECK (VALUE SIMILAR TO '[0-9]{11}');
