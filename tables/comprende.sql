CREATE TABLE comprende
(
    libro tipo_codice_isbn NOT NULL,
    acquisto integer NOT NULL,
    quantita smallint NOT NULL,
    CONSTRAINT include_pkey PRIMARY KEY (libro, acquisto),
    CONSTRAINT include_acquisto_fkey FOREIGN KEY (acquisto)
        REFERENCES acquisto (numero) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT include_libro_fkey FOREIGN KEY (libro)
        REFERENCES libro (isbn) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT quantita_positiva CHECK (quantita > 0)
);
