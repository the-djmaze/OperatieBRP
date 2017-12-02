/**
 * Read before you start: https://qntm.org/support
 *
 * The big difference:
 *   A person is not always a human, therefore you will find "human" in this schema.
 *   Hey: https://www.youtube.com/watch?v=L3wKzyIN1yk
 *
 *   Everything has a prefix and '_' instead of CamelCase.
 *
 *   The prefixes are there so you can easily create, read, join and understand relations.
 *
 *   CamelCase in databases is BAD practice, this is not your fault.
 *   Read: https://dev.mysql.com/doc/refman/5.7/en/identifier-case-sensitivity.html
 */

CREATE TABLE genders
(
	gender_id TINYINT NOT NULL,
	gender_name VARCHAR(32),
	PRIMARY KEY (gender_id)
);
INSERT INTO genders VALUES
   (0, 'Onbekend'),
   (1, 'Man'),
   (2, 'Vrouw'),
   (3, 'Intersekse');

/**
 * Kern.SrtNLReisdoc
 */

CREATE TABLE document_types (
	document_type_id          SERIAL NOT NULL,
	document_type_description VARCHAR(250) NOT NULL,
	PRIMARY KEY (document_type_id),
	UNIQUE (document_type_description)
);

INSERT INTO document_types VALUES
   (0, 'Onbekend'),
   (1, 'Reisdocument'),
   (2, 'Rijbewijs'),
   (3, 'Vaarbewijs');

CREATE TABLE documents (
	document_id          SERIAL NOT NULL,
	document_type_id     INTEGER NOT NULL,
	country_code         SMALLINT NOT NULL COMMENT 'ISO 3166-1 number',
	document_code        VARCHAR(2) NOT NULL,
	document_description VARCHAR(250) NOT NULL,
	document_dtstart     INTEGER NOT NULL COMMENT 'Ymd',
	document_dtend       INTEGER NOT NULL COMMENT 'Ymd',
	PRIMARY KEY (document_id),
	UNIQUE (document_type, country_code, document_code),
	UNIQUE (document_description)
);

INSERT INTO documents VALUES
   (0,  1, 528, '?', 'Onbekend', 0, 0),
   (1,  1, 528, 'BJ', 'Identiteitskaart (toeristenkaart) BJ', 19920401, 19950101),
   (2,  1, 528, 'EK', 'Europese identiteitskaart', 19950101, 20011001),
   (3,  1, 528, 'IA', 'Identiteitskaart (toeristenkaart) A', 0, 19920101),
   (4,  1, 528, 'IB', 'Identiteitskaart (toeristenkaart) B', 0, 19950101),
   (5,  1, 528, 'IC', 'Identiteitskaart (toeristenkaart) C', 0, 19920101),
   (6,  1, 528, 'ID', 'Gemeentelijke Identiteitskaart', 19930101, 19950101),
   (7,  1, 528, 'KE', 'Kaart met paspoortboekje, 64 pag.', 19920101, 19920101),
   (8,  1, 528, 'KN', 'Kaart met paspoortboekje, 32 pag.', 19920101, 19920101),
   (9,  1, 528, 'KZ', 'Kaart zonder paspoortboekje', 19920101, 19920101),
   (10, 1, 528, 'LP', 'Laissez-passer', 19950101, 0),
   (11, 1, 528, 'NB', 'Nooddocument (model reisdocument vreemdelingen)', 19950101, 20010401),
   (12, 1, 528, 'NI', 'Nederlandse identiteitskaart', 20011001, 0),
   (13, 1, 528, 'NN', 'Noodpaspoort (model nationaal paspoort)', 19950101, 0),
   (14, 1, 528, 'NP', 'Noodpaspoort', 0, 19950101),
   (15, 1, 528, 'NV', 'Nooddocument (model reisdocument vluchtelingen)', 19950101, 20010401),
   (16, 1, 528, 'PB', 'Reisdocument voor vreemdelingen', 0, 0),
   (17, 1, 528, 'PD', 'Diplomatiek paspoort', 0, 0),
   (18, 1, 528, 'PF', 'Faciliteitenpaspoort', 0, 0),
   (19, 1, 528, 'PN', 'Nationaal paspoort', 0, 0),
   (20, 1, 528, 'PV', 'Reisdocument voor vluchtelingen', 0, 0),
   (21, 1, 528, 'PZ', 'Dienstpaspoort', 0, 0),
   (22, 1, 528, 'R1', 'Reisdocument ouder1', 20010201, 0),
   (23, 1, 528, 'R2', 'Reisdocument ouder2', 20010201, 0),
   (24, 1, 528, 'RD', 'Reisdocument voogd', 0, 0),
   (25, 1, 528, 'RM', 'Reisdocument moeder', 0, 20010201),
   (26, 1, 528, 'RV', 'Reisdocument vader', 0, 20010201),
   (27, 1, 528, 'TE', 'Tweede paspoort (zakenpaspoort)', 19920401, 0),
   (28, 1, 528, 'TN', 'Tweede paspoort', 19920401, 0),
   (29, 1, 528, 'ZN', 'Nationaal paspoort (zakenpaspoort)', 19920401, 0),
   (30, 2, 528, 'RB', 'Rijbewijs', 0, 0);
   (31, 2, 528, 'IR', 'Internationaal rijbewijs', 0, 0),
   (32, 3, 528, 'KV', 'Klein vaarbewijs', 0, 0),
   (33, 3, 528, 'GP', 'Grootpleziervaartbewijs', 0, 0),
   (34, 3, 528, 'BG', 'Beperkt groot vaarbewijs', 0, 0),
   (35, 3, 528, 'BV', 'Groot vaarbewijs', 0, 0);

/**
 * What is the best term: state, status, condition or situation?
 */
CREATE TABLE human_statuses
(
	human_status_id   SERIAL NOT NULL,
	human_status_name VARCHAR(32),
	PRIMARY KEY (human_status_id)
);
INSERT INTO human_statuses VALUES
   (0, 'Onbekend'),
   (1, 'Geboren'),
   (2, 'Overleden'),
   (3, 'Vermist'),
   (4, 'Gevonden'),
   (5, 'Geëmigreerd'),
   (6, 'Vertrokken');

CREATE TABLE humans
(
	human_id                BIGSERIAL NOT NULL,
	gender_id               TINYINT NOT NULL,
/*	gender_preferred_pronouns TINYINT NOT NULL COMMENT '0 = None, 1 = Man, 2 = Woman, 3 = Neutral',*/
	human_uid               VARCHAR(32) NOT NULL COMMENT 'In Netherlands BSN / Citizen Service Number',
	human_givenname         VARCHAR(100) NOT NULL COMMENT 'Dutch voornaam',
	human_surname           VARCHAR(100) NOT NULL COMMENT 'Dutch achternaam',
	human_nickname          VARCHAR(100) NOT NULL COMMENT 'Dutch roepnaam',
	human_status_id         INT NOT NULL COMMENT 'current status',
	human_birth_date        DATE NOT NULL,
	PRIMARY KEY (human_id)
);

CREATE TABLE humans_status_history
(
	human_id              BIGINT NOT NULL,
	human_status_id       INT NOT NULL,
	human_status_date     DATE NOT NULL COMMENT 'Date it happened',
	human_status_time     TIME NOT NULL COMMENT 'Time it happened',
	human_status_locality VARCHAR(128) NULL COMMENT 'Where it happened',
	country_code          SMALLINT NOT NULL COMMENT 'In/to which country. ISO 3166-1 number',
	human_status_verified TINYINT NOT NULL COMMENT 'when 0 it is not officialy verified',
	human_status_ts       TIMESTAMP NOT NULL COMMENT 'Date and time of entry',

	KEY (human_id, human_status_id)
);


/**
 * Kern.His_PersReisdoc
 */

CREATE TABLE humans_documents (
	human_document_id    BIGSERIAL NOT NULL,
	human_id             BIGINT NOT NULL,
	document_id          INT NOT NULL,
	human_document_start INT NOT NULL COMMENT 'Ymd',
	human_document_end   INT NOT NULL COMMENT 'Ymd',
	human_document_uid   VARCHAR(32) NOT NULL COMMENT 'The unique document number',
	PRIMARY KEY (human_document_id)
/*
   ID                            Bigint                        GENERATED BY DEFAULT AS SEQUENCE Kern.seq_His_PersReisdoc  NOT NULL,
   PersReisdoc                   Bigint                        NOT NULL,
   TsReg                         Timestamp with time zone      NOT NULL,
   ActieInh                      Bigint                        NOT NULL,
   TsVerval                      Timestamp with time zone      ,
   ActieVerval                   Bigint                        ,
   NadereAandVerval              Varchar(1)                    CHECK (NadereAandVerval IN ('O','S'))  ,
   ActieVervalTbvLevMuts         Bigint                        ,
   IndVoorkomenTbvLevMuts        Boolean                       CHECK (IndVoorkomenTbvLevMuts IN (true))  ,
   Nr                            Varchar(9)                    NOT NULL,
   AutVanAfgifte                 Varchar(6)                    NOT NULL,
   DatIngangDoc                  Integer                       NOT NULL,
   DatEindeDoc                   Integer                       NOT NULL,
   DatUitgifte                   Integer                       NOT NULL,
   DatInhingVermissing           Integer                       ,
   AandInhingVermissing          Smallint                      ,
   CONSTRAINT pk_His_PersReisdoc PRIMARY KEY (ID)
*/
);

/**
 * Relations, Correlations or Relationships?
 * The entries may be multiple, for example a human changed from man to woman.
 * The human wants to be recognized as the mother, but one of the children
 * prefers to keep the human as father.
 * The correspondation to the human should say woman.
 * The correspondation to the child should say father or just NOT mention it.
 * Example:
 *    [ 1 | 2 | 1 | 19900101 | 19940101 ] father
 *    [ 1 | 2 | 2 | 19940101 |        0 ] now mother
 *    [ 1 | 3 | 1 | 19900101 |        0 ] stays father
 */

CREATE TABLE human_relations (
	human_relation_id          SERIAL NOT NULL,
	human_relation_description VARCHAR(250) NOT NULL,
	PRIMARY KEY (human_relation_id)
);

INSERT INTO human_relations VALUES
   (0, 'Onbekend'),
   (1, 'Biologische Vader'),
   (2, 'Biologische Moeder'),
   (3, 'Adoptie Vader'),
   (4, 'Adoptie Moeder'),
   (5, 'Geregistreerd Partnerschap'),
   (6, 'Gehuwd');

CREATE TABLE humans_relations (
	human_id_1           BIGINT NOT NULL,
	human_id_2           BIGINT NOT NULL,
	human_relation_id    INT NOT NULL COMMENT 'The relation of #1 to #2, like #1 is the father of #2',
	human_relation_start INT NOT NULL COMMENT 'Ymd',
	human_relation_end   INT NOT NULL DEFAULT 0 COMMENT 'Ymd or 0 when not set'
);
