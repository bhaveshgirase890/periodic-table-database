--
-- PostgreSQL database dump
--

\connect periodic_table

DROP TABLE IF EXISTS properties;
DROP TABLE IF EXISTS elements;
DROP TABLE IF EXISTS types;

CREATE TABLE types (
    type_id integer NOT NULL,
    type character varying(30) NOT NULL
);

CREATE SEQUENCE types_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE types_type_id_seq OWNED BY types.type_id;
ALTER TABLE ONLY types ALTER COLUMN type_id SET DEFAULT nextval('types_type_id_seq'::regclass);

CREATE TABLE elements (
    atomic_number integer NOT NULL,
    symbol character varying(2) NOT NULL,
    name character varying(40) NOT NULL
);

CREATE TABLE properties (
    atomic_number integer NOT NULL,
    atomic_mass real,
    melting_point_celsius real NOT NULL,
    boiling_point_celsius real NOT NULL,
    type_id integer NOT NULL
);

INSERT INTO types VALUES (1, 'metal');
INSERT INTO types VALUES (2, 'nonmetal');
INSERT INTO types VALUES (3, 'metalloid');

INSERT INTO elements VALUES (1, 'H', 'Hydrogen');
INSERT INTO elements VALUES (2, 'He', 'Helium');
INSERT INTO elements VALUES (3, 'Li', 'Lithium');
INSERT INTO elements VALUES (4, 'Be', 'Beryllium');
INSERT INTO elements VALUES (5, 'B', 'Boron');
INSERT INTO elements VALUES (6, 'C', 'Carbon');
INSERT INTO elements VALUES (7, 'N', 'Nitrogen');
INSERT INTO elements VALUES (8, 'O', 'Oxygen');
INSERT INTO elements VALUES (9, 'F', 'Fluorine');
INSERT INTO elements VALUES (10, 'Ne', 'Neon');

INSERT INTO properties VALUES (1, 1.008, -259.1, -252.9, 2);
INSERT INTO properties VALUES (2, 4.0026, -272.2, -269, 2);
INSERT INTO properties VALUES (3, 6.94, 180.54, 1342, 1);
INSERT INTO properties VALUES (4, 9.0122, 1287, 2470, 1);
INSERT INTO properties VALUES (5, 10.81, 2075, 4000, 3);
INSERT INTO properties VALUES (6, 12.011, 3550, 4027, 2);
INSERT INTO properties VALUES (7, 14.007, -210.1, -195.8, 2);
INSERT INTO properties VALUES (8, 15.999, -218, -183, 2);
INSERT INTO properties VALUES (9, 18.998, -220, -188.1, 2);
INSERT INTO properties VALUES (10, 20.18, -248.6, -246.1, 2);

ALTER TABLE ONLY types ADD CONSTRAINT types_pkey PRIMARY KEY (type_id);
ALTER TABLE ONLY elements ADD CONSTRAINT elements_pkey PRIMARY KEY (atomic_number);
ALTER TABLE ONLY elements ADD CONSTRAINT elements_symbol_key UNIQUE (symbol);
ALTER TABLE ONLY elements ADD CONSTRAINT elements_name_key UNIQUE (name);
ALTER TABLE ONLY properties ADD CONSTRAINT properties_pkey PRIMARY KEY (atomic_number);
ALTER TABLE ONLY properties ADD CONSTRAINT properties_atomic_number_fkey FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number);
ALTER TABLE ONLY properties ADD CONSTRAINT properties_type_id_fkey FOREIGN KEY (type_id) REFERENCES types(type_id);

SELECT pg_catalog.setval('types_type_id_seq', 3, true);
