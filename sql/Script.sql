-- pour voir toutes les tables qui existent 
SELECT * FROM USER_TABLES;

-- suppression dans l'ordre des tables : 
DROP TABLE Facture_DM ;
DROP TABLE RESERVE ;
DROP TABLE NOTE ;
DROP TABLE Client ;
DROP TABLE Periode ;
DROP TABLE Partenaire ;
DROP TABLE Chambre ;
DROP TABLE Propose ;
DROP TABLE Categorie_Chambre ;
DROP TABLE EMPLOYE ;
DROP TABLE OFFRE ;
DROP TABLE SERVICE ;
DROP TABLE Fournit;
DROP TABLE FournisseurDM;
DROP TABLE achat ;
DROP TABLE Fournitures;
DROP TABLE hotel ;



-- astuce si on arrive pas �  effacer dans le bon ordre : 
-- DROP TABLE nom_table CASCADE CONSTRAINTS;


-- Création des tables ---------------------------------------------------------
 --Table Fournitures : ENTITE
CREATE TABLE Fournitures(
NO_fourniture number(10),
nom_Fourniture varchar(50),
categorie_f varchar(100),
prix_unite number(10,2) NOT NULL,
CONSTRAINT PK_fourniture PRIMARY KEY(NO_fourniture));

Select * from Fournitures;

 --Table Fournisseur : ENTITE
CREATE TABLE FournisseurDM(
NO_fournisseurDM number(10),
nom_FDM varchar(20),
adresse_Four varchar(100),
categorie_produit_DM varchar(100),
CONSTRAINT pk_fournisseur PRIMARY KEY(NO_fournisseurDM));


 --Table Fournit : RELATION
CREATE TABLE Fournit(
NO_fourniture number(10),
NO_fournisseurDM number(10),
date_fourniture date, -- on a supprimé tarif et quantité.
CONSTRAINT PK_fournit PRIMARY KEY(NO_fourniture,NO_fournisseurDM,date_fourniture),
FOREIGN KEY (NO_fournisseurDM) REFERENCES FournisseurDM(NO_fournisseurDM),
FOREIGN KEY (NO_fourniture) REFERENCES Fournitures(NO_fourniture));


-- Table SERVICE : ENTITE
CREATE TABLE SERVICE(
No_service number(10),
petit_dej NUMBER(1) CHECK (petit_dej IN (0, 1)),
salle_sport NUMBER(1) CHECK (salle_sport IN (0, 1)),
piscine NUMBER(1) CHECK (piscine IN (0, 1)),
billard NUMBER(1) CHECK (billard IN (0, 1)),
restaurant NUMBER(1) CHECK (restaurant IN (0, 1)),
CONSTRAINT No_service PRIMARY KEY(No_service));


-- table Hotel : ENTITE
CREATE TABLE hotel (
No_hotel number(10),
nomHot VARCHAR(40),
adresse_hot VARCHAR(100),
classe_hot INT CHECK (classe_hot BETWEEN 1 AND 5),
taxe_sejour_hot number(5,2),
tarif_hot number(5,2) NOT NULL,
TVA_hot number(5,2),
No_service number(10),
CONSTRAINT PK_hotel PRIMARY KEY(No_hotel),
FOREIGN KEY (NO_service) REFERENCES Service(NO_service));



 --Table achat : RELATION
CREATE TABLE achat(
NO_fourniture number(10),
date_achat date,
quantite number(10),
No_hotel number(10),
FOREIGN KEY (NO_fourniture) REFERENCES Fournitures(NO_fourniture),
FOREIGN KEY (No_hotel) REFERENCES hotel(No_hotel),
CONSTRAINT PK_achat PRIMARY KEY(NO_fourniture,No_hotel,date_achat));


-- Table EMPLOYES : ENTITE
CREATE TABLE EMPLOYE(
No_employe number(10),
nom VARCHAR(20),
prenom VARCHAR(20),
poste VARCHAR(20),
anciennete number(5),
salaire number(10,2) NOT NULL,
type_contrat varchar(100),
No_hotel number(10),
CONSTRAINT No_employe PRIMARY KEY(No_employe),
code_respo number(10) constraint fk_no_respo REFERENCES EMPLOYE(No_employe),
FOREIGN KEY (No_hotel) REFERENCES hotel(No_hotel));


-- Table CATEGORIE : ENTITE
CREATE TABLE CATEGORIE_Chambre (
No_categorie number(10),
televiseur NUMBER(1) CHECK (televiseur IN (0, 1)),
lit_double NUMBER(2),
lit_simple NUMBER(2),
refrigerateur NUMBER(1) CHECK (refrigerateur IN (0, 1)),
balcon NUMBER(1) CHECK (balcon IN (0, 1)),
salle_bain VARCHAR(100),
capacite number(3) NOT NULL,
cout number(10,2) NOT NULL,
CONSTRAINT No_categorie PRIMARY KEY(No_categorie));


-- Propose : RELATION
CREATE TABLE PROPOSE(
No_hotel number(10),
No_categorie number(10),
CONSTRAINT PK_propose PRIMARY KEY(No_hotel,No_categorie), 
FOREIGN KEY (No_hotel) REFERENCES hotel(No_hotel),
FOREIGN KEY (No_categorie) REFERENCES CATEGORIE_Chambre(No_categorie));


--Table CHAMBRE : ENTITE
CREATE TABLE CHAMBRE (
No_chambre number(10),
numero VARCHAR(10),
No_hotel number(10),
No_categorie number(10),
etat VARCHAR(10),
CONSTRAINT PK_chambre PRIMARY KEY(No_chambre),
FOREIGN KEY (No_hotel) REFERENCES hotel(No_hotel),
FOREIGN KEY (No_categorie) REFERENCES CATEGORIE_Chambre(No_categorie));


--Table PARTENAIRE : ENTITE
CREATE TABLE PARTENAIRE(
No_Partenaire number(10),
categorie VARCHAR(50),
nom VARCHAR(50),
nombre_client number(10),
commission number(3),
reduction number(10),
CONSTRAINT No_Partenaire PRIMARY KEY(No_Partenaire));


 --Table Periode tarifaire : ENTITE
CREATE TABLE Periode(
type_periode number(2),
saison varchar(50),
type_de_jour varchar(50),
facteur_prix number(4,2) NOT NULL,
CONSTRAINT PK_periode PRIMARY KEY(type_periode));


-- Table CLIENT : ENTITE
CREATE TABLE client(
NO_client number(10),
Nom VARCHAR(40),
Prenom VARCHAR(40),
CB number(20),
adresse_C VARCHAR(100),
points_fidelite number(10),
CONSTRAINT No_client PRIMARY KEY(NO_client));


--Table Note : RELATION
CREATE TABLE NOTE(
NO_client number(10),
No_hotel number(10),
date_note date,
note INT CHECK (note BETWEEN 0 AND 5),
CONSTRAINT PK_NOTE PRIMARY KEY (NO_client, No_hotel, date_note),
FOREIGN KEY (No_hotel) REFERENCES hotel(No_hotel),
FOREIGN KEY (NO_client) REFERENCES client(NO_client));


--Table RESERVATION : RELATION (j'ai tout rajouté normalement)
CREATE TABLE RESERVE(
No_reservation number(10),
date_arrivee DATE ,
date_depart DATE , 
No_client number(10),
No_chambre number(10),
No_categorie number(10),
No_hotel number(10),
nombre_personnes number(3),
-- nombre_chambres number(3),
nombre_jours1 number(3),
nombre_jours2 number(3),
nombre_jours3 number(3),
nombre_jours4 number(3),
No_Partenaire number(10),
CONSTRAINT PK_reservation PRIMARY KEY(No_reservation, No_Partenaire, No_client, No_chambre, No_hotel, No_categorie),
FOREIGN KEY (No_client) REFERENCES client(No_client),
FOREIGN KEY (No_Partenaire) REFERENCES PARTENAIRE(No_Partenaire),
FOREIGN KEY (No_hotel) REFERENCES hotel(No_hotel),
FOREIGN KEY (No_Chambre) REFERENCES Chambre(No_Chambre),
FOREIGN KEY (No_hotel, No_categorie) REFERENCES Propose(No_hotel, No_categorie));


 --Table Periode tarifaire : ENTITE
CREATE TABLE Periode(
type_periode varchar(50),
saison varchar(50),
type_de_jour varchar(50),
facteur_prix number(4,2) NOT NULL,
CONSTRAINT PK_periode PRIMARY KEY(type_periode));





--------------------------------------------------------------------------------
-- Insertion de donnees dans la table Fournitures
INSERT INTO Fournitures VALUES (1,'Fruits frais','Alimentation', 2.99);
INSERT INTO Fournitures VALUES (2,'Légumes frais','Alimentation', 1.75);
INSERT INTO Fournitures VALUES (3,'Viande fraîche','Alimentation', 8.50);
INSERT INTO Fournitures VALUES (4,'Produits laitiers','Alimentation', 3.25);
INSERT INTO Fournitures VALUES (5,'Pains et viennoiseries','Alimentation', 1.20);
INSERT INTO Fournitures VALUES (6,'Draps de lit','Linge de maison', 20.99);
INSERT INTO Fournitures VALUES (7,'Serviettes de bain','Linge de maison', 12.75);
INSERT INTO Fournitures VALUES (8,'Couvertures','Linge de maison', 35.00);
INSERT INTO Fournitures VALUES (9,'Produits de nettoyage','Produits d''entretien', 6.10);
INSERT INTO Fournitures VALUES (10,'Consommables (papier, savon)','Produits d''entretien', 2.50);
INSERT INTO Fournitures VALUES (11,'Lits','Équipements et mobilier', 450.00);
INSERT INTO Fournitures VALUES (12,'Armoires','Équipements et mobilier', 300.00);
INSERT INTO Fournitures VALUES (13,'Bureau','Équipements et mobilier', 175.00);
INSERT INTO Fournitures VALUES (14,'Fournitures de bureau','Fournitures de bureau et de réception', 3.00);
INSERT INTO Fournitures VALUES (15,'Imprimantes','Fournitures de bureau et de réception', 125.00);

SELECT * FROM Fournitures ;

-- Insertion de donnees dans la table FournisseurDM
INSERT INTO FournisseurDM VALUES (1, 'Épicerie Deluxe', '123 Rue des Aliments', 'Alimentation');
INSERT INTO FournisseurDM VALUES (2, 'Linge de Maison', '456 Boulevard du Linge', 'Linge de maison');
INSERT INTO FournisseurDM VALUES (3, 'Entretien Pro', '789 Impasse des Produits', 'Produits d entretien');
INSERT INTO FournisseurDM VALUES (4, 'Mobilier Confort', '321 Avenue du Mobilier', 'Équipements et mobilier');
INSERT INTO FournisseurDM VALUES (5, 'Fournitures Bureau', '654 Rue des Papiers', 'Fournitures de bureau et de réception');
INSERT INTO FournisseurDM VALUES (6, 'Alimentation Fraîche', '159 Chemin des Aliments', 'Alimentation');

SELECT * FROM FournisseurDM ;

-- Insertion de donnees dans la table Fournit
INSERT INTO Fournit VALUES (1, 1,'15/03/2022');
INSERT INTO Fournit VALUES (2, 1,'17/03/2022');
INSERT INTO Fournit VALUES (3, 6,'17/03/2022');
INSERT INTO Fournit VALUES (4, 6,'20/03/2022');
INSERT INTO Fournit VALUES (5, 1,'25/03/2022');
INSERT INTO Fournit VALUES (6, 2,'25/03/2022');
INSERT INTO Fournit VALUES (1, 1,'15/04/2022');
INSERT INTO Fournit VALUES (2, 1,'17/04/2022');
INSERT INTO Fournit VALUES (3, 6,'17/04/2022');
INSERT INTO Fournit VALUES (4, 6,'20/04/2022');
INSERT INTO Fournit VALUES (5, 1,'25/04/2022');
INSERT INTO Fournit VALUES (7, 2,'01/05/2022');
INSERT INTO Fournit VALUES (1, 1,'15/05/2022');
INSERT INTO Fournit VALUES (2, 1,'17/05/2022');
INSERT INTO Fournit VALUES (3, 6,'17/05/2022');
INSERT INTO Fournit VALUES (4, 6,'20/05/2022');
INSERT INTO Fournit VALUES (5, 1,'25/05/2022');
INSERT INTO Fournit VALUES (8, 2,'15/06/2022');
INSERT INTO Fournit VALUES (1, 1,'15/06/2022');
INSERT INTO Fournit VALUES (2, 1,'17/06/2022');
INSERT INTO Fournit VALUES (3, 6,'17/06/2022');
INSERT INTO Fournit VALUES (4, 6,'20/06/2022');
INSERT INTO Fournit VALUES (5, 1,'25/06/2022');
INSERT INTO Fournit VALUES (10, 3,'01/07/2022');
INSERT INTO Fournit VALUES (11, 4,'05/07/2022');
INSERT INTO Fournit VALUES (13, 4,'01/08/2022');
INSERT INTO Fournit VALUES (14, 5,'20/09/2022');
INSERT INTO Fournit VALUES (15, 5,'15/11/2022');
INSERT INTO Fournit VALUES (6, 2,'17/05/2023');
INSERT INTO Fournit VALUES (8, 2,'01/07/2023');
INSERT INTO Fournit VALUES (12, 4,'10/09/2023');


-- Insertion de donnees dans la table SERVICE
INSERT INTO SERVICE VALUES (1, 1, 1, 1, 0, 1);
INSERT INTO SERVICE VALUES (2, 1, 1, 1, 0, 0);
INSERT INTO SERVICE VALUES (3, 1, 0, 0, 0, 1);
INSERT INTO SERVICE VALUES (4, 1, 0, 0, 1, 1);
INSERT INTO SERVICE VALUES (5, 1, 1, 0, 0, 0);
INSERT INTO SERVICE VALUES (6, 1, 0, 0, 0, 0);


-- Insertion de donnees dans la table hotel
INSERT INTO hotel VALUES (1, 'Hotel de la Plage', '20 avenue du Littoral, 06000 Nice', 4, 1.50, 3.00, 10.00, 1);
INSERT INTO hotel VALUES  (2, 'Grand Hotel', '5 place de la Comedie, 33000 Bordeaux', 5,  2.00, 7.00, 10.00, 1);
INSERT INTO hotel VALUES (3, 'Hotel des Alpes', '18 rue des Sapins, 73000 Chambery', 3, 1.00, 1.50, 10.00, 2);
INSERT INTO hotel VALUES (4, 'Hotel du Port', '42 quai des Marins, 29200 Brest', 1, 1.20, 1.00, 10.00, 4);
INSERT INTO hotel VALUES (5, 'Hotel de la Gare', '7 place de la Gare, 57000 Metz', 2, 0.80, 1.20, 10.00, 6);
INSERT INTO hotel VALUES (6, 'Hotel du Centre', '15 rue de la Republique, 69002 Lyon', 4, 1.80, 3.00, 10.00, 1);
INSERT INTO hotel VALUES (7, 'Hotel des Jardins', '28 avenue des Tilleuls, 44000 Nantes', 3, 1.10, 1.50, 10.00, 4);
INSERT INTO hotel VALUES (8, 'Hotel des Arts', '54 boulevard des Artistes, 13000 Marseille', 4,  1.60, 3.00, 10.00, 3);
INSERT INTO hotel VALUES (9, 'Hotel de la Mer', '8 quai du Port, 06230 Villefranche-sur-Mer', 3, 1.30, 1.50, 10.00, 2);
INSERT INTO hotel VALUES (10, 'Hotel des Vignes', '31 rue des Coteaux, 33500 Libourne', 2,  0.90, 1.20, 10.00, 5);

SELECT * FROM hotel;

-- Insertion de donnees dans la table achat
INSERT INTO Achat VALUES (1, '10/03/2022', 50, 1);
INSERT INTO Achat VALUES (2, '12/03/2022', 75, 10);
INSERT INTO Achat VALUES (3, '12/03/2022', 30, 10);
INSERT INTO Achat VALUES (4, '15/03/2022', 40, 10);
INSERT INTO Achat VALUES (5, '20/03/2022', 100, 1);
INSERT INTO Achat VALUES (6, '20/03/2022', 25, 2);
INSERT INTO Achat VALUES (1, '10/04/2022', 60, 2);
INSERT INTO Achat VALUES (2, '12/04/2022', 80, 1);
INSERT INTO Achat VALUES (3, '12/04/2022', 35, 1);
INSERT INTO Achat VALUES (4, '15/04/2022', 45, 1);
INSERT INTO Achat VALUES (5, '20/04/2022', 110, 1);
INSERT INTO Achat VALUES (7, '26/04/2022', 30, 2);
INSERT INTO Achat VALUES (1, '10/05/2022', 55, 3);
INSERT INTO Achat VALUES (2, '12/05/2022', 85, 9);
INSERT INTO Achat VALUES (3, '12/05/2022', 40, 9);
INSERT INTO Achat VALUES (4, '15/05/2022', 50, 9);
INSERT INTO Achat VALUES (5, '20/05/2022', 120, 1);
INSERT INTO Achat VALUES (8, '10/06/2022', 20, 2);
INSERT INTO Achat VALUES (1, '10/06/2022', 65, 4);
INSERT INTO Achat VALUES (2, '12/06/2022', 90, 1);
INSERT INTO Achat VALUES (3, '12/06/2022', 45, 8);
INSERT INTO Achat VALUES (4, '15/06/2022', 55, 8);
INSERT INTO Achat VALUES (5, '20/06/2022', 130, 8);
INSERT INTO Achat VALUES (10, '26/06/2022', 80, 3);
INSERT INTO Achat VALUES (11, '30/06/2022', 10, 4);
INSERT INTO Achat VALUES (13, '26/07/2022', 5, 4);
INSERT INTO Achat VALUES (14, '15/09/2022', 100, 5);
INSERT INTO Achat VALUES (15, '10/11/2022', 3, 5);
INSERT INTO Achat VALUES (6, '06/05/2023', 5, 6);
INSERT INTO Achat VALUES (8, '25/06/2023', 100, 7);
INSERT INTO Achat VALUES (12, '07/09/2023', 8, 8);

-- Insertion de donnees dans la table EMPLOYE
INSERT INTO EMPLOYE VALUES (1, 'Dupont', 'Jean', 'Maitre_dhotel', 10, 4500.00, 'CDI', 1, NULL);
INSERT INTO EMPLOYE VALUES (2, 'Mercier', 'Sylvie', 'Receptionniste', 5, 2200.00, 'CDI', 1, 1);
INSERT INTO EMPLOYE VALUES (3, 'Lefevre', 'Maxime', 'Bagagiste-portier', 8, 2800.00, 'CDI', 1, 2);
INSERT INTO EMPLOYE VALUES (4, 'Garcia', 'Isabelle', 'Cuisiniere', 7, 2500.00, 'CDI', 1, 2);
INSERT INTO EMPLOYE VALUES (5, 'Nguyen', 'Thi Mai', 'Femme de menage', 3, 1800.00, 'CDD', 1, 2);
INSERT INTO EMPLOYE VALUES (6, 'Moreau', 'Sophie', 'Maitre_dhotel', 12, 5000.00, 'CDI', 2, NULL);
INSERT INTO EMPLOYE VALUES (7, 'Martin', 'Francois', 'Receptionniste', 6, 2400.00, 'CDI', 2, 6);
INSERT INTO EMPLOYE VALUES (8, 'Dubois', 'Julien', 'Bagagiste-portier', 9, 3000.00, 'CDI', 2, 6);
INSERT INTO EMPLOYE VALUES (9, 'Leroy', 'Celine', 'Cuisiniere', 8, 2700.00, 'CDI', 2, 7);
INSERT INTO EMPLOYE VALUES (10, 'Blanc', 'Marie', 'Femme de menage', 4, 1900.00, 'CDD', 2, 7);
INSERT INTO EMPLOYE VALUES (11, 'Roux', 'Alain', 'Maitre_dhotel', 15, 4800.00, 'CDI', 3, NULL);
INSERT INTO EMPLOYE VALUES (12, 'Bernard', 'Pauline', 'Receptionniste', 4, 2300.00, 'CDI', 3, 11);
INSERT INTO EMPLOYE VALUES (13, 'Fabre', 'Nicolas', 'Bagagiste-portier', 5, 2900.00, 'CDI', 3, 12);
INSERT INTO EMPLOYE VALUES (14, 'Girard', 'Elodie', 'Cuisiniere', 6, 2600.00, 'CDI', 3, 12);
INSERT INTO EMPLOYE VALUES (15, 'Durand', 'Laure', 'Femme de menage', 2, 1700.00, 'CDD', 3, 12);
INSERT INTO EMPLOYE VALUES (16, 'Simon', 'Michel', 'Maitre_dhotel', 13, 4700.00, 'CDI', 4, NULL);
INSERT INTO EMPLOYE VALUES (17, 'Chevalier', 'Amelie', 'Receptionniste', 5, 2200.00, 'CDI', 4, 16);
INSERT INTO EMPLOYE VALUES (18, 'Perrin', 'Lucas', 'Bagagiste-portier', 7, 2800.00, 'CDI', 4, 17);
INSERT INTO EMPLOYE VALUES (19, 'Renard', 'Caroline', 'Cuisiniere', 6, 2500.00, 'CDI', 4, 17);
INSERT INTO EMPLOYE VALUES (20, 'Lemoine', 'Florence', 'Femme de menage', 3, 1800.00, 'CDD', 4, 17);
INSERT INTO EMPLOYE VALUES (21, 'Gauthier', 'Patrick', 'Maitre_dhotel', 11, 4900.00, 'CDI', 5, NULL);
INSERT INTO EMPLOYE VALUES (22, 'Noel', 'Laura', 'Receptionniste', 6, 2400.00, 'CDI', 5, 21);
INSERT INTO EMPLOYE VALUES (23, 'Baron', 'Vincent', 'Bagagiste-portier', 9, 3100.00, 'CDI', 5, 22);
INSERT INTO EMPLOYE VALUES (24, 'Olivier', 'Claire', 'Cuisiniere', 7, 2600.00, 'CDI', 5, 22);
INSERT INTO EMPLOYE VALUES (25, 'Bonnet', 'Julie', 'Femme de menage', 4, 1900.00, 'CDD', 5, 22);
INSERT INTO EMPLOYE VALUES (26, 'Lambert', 'Herve', 'Maitre_dhotel', 14, 5100.00, 'CDI', 6, NULL);
INSERT INTO EMPLOYE VALUES (27, 'Marchand', 'Sophie', 'Receptionniste', 5, 2300.00, 'CDI', 6, 26);
INSERT INTO EMPLOYE VALUES (28, 'Picard', 'Antoine', 'Bagagiste-portier', 10, 3200.00, 'CDI', 6, 27);
INSERT INTO EMPLOYE VALUES (29, 'Fontaine', 'Cecile', 'Cuisiniere', 8, 2700.00, 'CDI', 6, 27);
INSERT INTO EMPLOYE VALUES (30, 'Benoit', 'Lucie', 'Femme de menage', 3, 1800.00, 'CDD', 6, 27);
INSERT INTO EMPLOYE VALUES (31, 'Riviere', 'Jacques', 'Maitre_dhotel', 12, 4800.00, 'CDI', 7, NULL);
INSERT INTO EMPLOYE VALUES (32, 'Henry', 'Laetitia', 'Receptionniste', 6, 2400.00, 'CDI', 7, 31);
INSERT INTO EMPLOYE VALUES (33, 'Dupuis', 'Marc', 'Bagagiste-portier', 8, 3000.00, 'CDI', 7, 32);
INSERT INTO EMPLOYE VALUES (34, 'Blondel', 'Nathalie', 'Cuisiniere', 9, 2600.00, 'CDI', 7, 32);
INSERT INTO EMPLOYE VALUES (35, 'Poulain', 'Emma', 'Femme de menage', 4, 1800.00, 'CDD', 7, 32);
INSERT INTO EMPLOYE VALUES (36, 'Verdier', 'Pierre', 'Maitre_dhotel', 10, 4700.00, 'CDI', 8, NULL);
INSERT INTO EMPLOYE VALUES (37, 'Arnaud', 'Charlotte', 'Receptionniste', 7, 2500.00, 'CDI', 8, 36);
INSERT INTO EMPLOYE VALUES (38, 'Berger', 'Hugo', 'Bagagiste-portier', 9, 3100.00, 'CDI', 8, 37);
INSERT INTO EMPLOYE VALUES (39, 'Dumont', 'Elisa', 'Cuisiniere', 6, 2600.00, 'CDI', 8, 37);
INSERT INTO EMPLOYE VALUES (40, 'Legros', 'Anais', 'Femme de menage', 5, 1900.00, 'CDD', 8, 37);
INSERT INTO EMPLOYE VALUES (41, 'Clément', 'Damien', 'Maitre_dhotel', 14, 5200.00, 'CDI', 9, NULL);
INSERT INTO EMPLOYE VALUES (42, 'Faure', 'Morgane', 'Receptionniste', 5, 2400.00, 'CDI', 9, 41);
INSERT INTO EMPLOYE VALUES (43, 'Giraud', 'Mathieu', 'Bagagiste-portier', 7, 3000.00, 'CDI', 9, 42);
INSERT INTO EMPLOYE VALUES (44, 'Perret', 'Sophie', 'Cuisiniere', 8, 2700.00, 'CDI', 9, 42);
INSERT INTO EMPLOYE VALUES (45, 'Charpentier', 'Eve', 'Femme de menage', 3, 1800.00, 'CDD', 9, 42);
INSERT INTO EMPLOYE VALUES (46, 'Masson', 'Remi', 'Maitre_dhotel', 11, 4600.00, 'CDI', 10, NULL);
INSERT INTO EMPLOYE VALUES (47, 'Gerard', 'Anne', 'Receptionniste', 7, 2500.00, 'CDI', 10, 46);
INSERT INTO EMPLOYE VALUES (48, 'Vidal', 'Louis', 'Bagagiste-portier', 9, 3000.00, 'CDI', 10, 47);
INSERT INTO EMPLOYE VALUES (49, 'Blanchard', 'Claire', 'Cuisiniere', 10, 2800.00, 'CDI', 10, 47);
INSERT INTO EMPLOYE VALUES (50, 'Thierry', 'Lucie', 'Femme de menage', 4, 1900.00, 'CDD', 10, 47);


-- Insertion de donnees dans la table CATEGORIE_Chambre
INSERT INTO CATEGORIE_Chambre VALUES (1, 1, 1, 0, 0, 0, 'douche', 2, 43);
INSERT INTO CATEGORIE_Chambre VALUES (2, 1, 0, 2, 0, 0, 'douche', 2, 45);
INSERT INTO CATEGORIE_Chambre VALUES (3, 1, 0, 1, 1, 0, 'baignoire', 1, 48);
INSERT INTO CATEGORIE_Chambre VALUES (4, 1, 1, 0, 1, 1, 'douche et baignoire', 2, 53);
INSERT INTO CATEGORIE_Chambre VALUES (5, 0, 0, 2, 0, 0, 'douche', 2, 38);
INSERT INTO CATEGORIE_Chambre VALUES (6, 1, 0, 3, 0, 1, 'douche', 3, 60);
INSERT INTO CATEGORIE_Chambre VALUES (7, 1, 1, 0, 0, 1, 'douche', 2, 44);
INSERT INTO CATEGORIE_Chambre VALUES (8, 1, 0, 2, 1, 1, 'douche', 2, 55);
INSERT INTO CATEGORIE_Chambre VALUES (9, 1, 1, 0, 1, 0, 'douche', 2, 50);
INSERT INTO CATEGORIE_Chambre VALUES (10, 0, 0, 1, 0, 0, 'douche', 1, 30);
INSERT INTO CATEGORIE_Chambre VALUES (11, 1, 1, 1, 1, 0, 'douche', 3, 58);
INSERT INTO CATEGORIE_Chambre VALUES (12, 1, 0, 4, 0, 1, 'douche', 4, 63);
INSERT INTO CATEGORIE_Chambre VALUES (13, 1, 1, 0, 0, 1, 'baignoire', 2, 60);
INSERT INTO CATEGORIE_Chambre VALUES (14, 1, 0, 1, 0, 1, 'baignoire', 1, 36);
INSERT INTO CATEGORIE_Chambre VALUES (15, 1, 1, 1, 0, 0, 'douche', 3, 54);
INSERT INTO CATEGORIE_Chambre VALUES (16, 1, 1, 0, 1, 0, 'douche et baignoire', 2, 55);
INSERT INTO CATEGORIE_Chambre VALUES (17, 1, 1, 0, 1, 1, 'douche et baignoire', 2, 70);
INSERT INTO CATEGORIE_Chambre VALUES (18, 1, 0, 5, 0, 0, 'douche', 5, 68);

SELECT * FROM categorie_chambre ;

-- Insertion de donnees dans la table Propose :
INSERT INTO PROPOSE VALUES (1, 1);
INSERT INTO PROPOSE VALUES (1, 2);
INSERT INTO PROPOSE VALUES (1, 3);
INSERT INTO PROPOSE VALUES (1, 4);
INSERT INTO PROPOSE VALUES (2, 5);
INSERT INTO PROPOSE VALUES (2, 6);
INSERT INTO PROPOSE VALUES (2, 7);
INSERT INTO PROPOSE VALUES (2, 8);
INSERT INTO PROPOSE VALUES (2, 9);
INSERT INTO PROPOSE VALUES (2, 10);
INSERT INTO PROPOSE VALUES (3, 11);
INSERT INTO PROPOSE VALUES (3, 12);
INSERT INTO PROPOSE VALUES (3, 13);
INSERT INTO PROPOSE VALUES (3, 14);
INSERT INTO PROPOSE VALUES (4, 15);
INSERT INTO PROPOSE VALUES (4, 16);
INSERT INTO PROPOSE VALUES (5, 17);
INSERT INTO PROPOSE VALUES (5, 18);
INSERT INTO PROPOSE VALUES (5, 1);
INSERT INTO PROPOSE VALUES (5, 3);
INSERT INTO PROPOSE VALUES (5, 7);
INSERT INTO PROPOSE VALUES (5, 10);
INSERT INTO PROPOSE VALUES (6, 4);
INSERT INTO PROPOSE VALUES (6, 8);
INSERT INTO PROPOSE VALUES (6, 12);
INSERT INTO PROPOSE VALUES (6, 13);
INSERT INTO PROPOSE VALUES (6, 15);
INSERT INTO PROPOSE VALUES (6, 17);
INSERT INTO PROPOSE VALUES (7, 2);
INSERT INTO PROPOSE VALUES (7, 5);
INSERT INTO PROPOSE VALUES (7, 9);
INSERT INTO PROPOSE VALUES (7, 14);
INSERT INTO PROPOSE VALUES (8, 6);
INSERT INTO PROPOSE VALUES (8, 11);
INSERT INTO PROPOSE VALUES (8, 16);
INSERT INTO PROPOSE VALUES (9, 1);
INSERT INTO PROPOSE VALUES (9, 7);
INSERT INTO PROPOSE VALUES (9, 8);
INSERT INTO PROPOSE VALUES (9, 10);
INSERT INTO PROPOSE VALUES (9, 12);
INSERT INTO PROPOSE VALUES (10, 3);
INSERT INTO PROPOSE VALUES (10, 9);
INSERT INTO PROPOSE VALUES (10, 13);
INSERT INTO PROPOSE VALUES (10, 15);
INSERT INTO PROPOSE VALUES (10, 18);


-- Insertion de donnees dans la table CHAMBRE
INSERT INTO CHAMBRE VALUES (1, '101', 1, 1, 'libre');
INSERT INTO CHAMBRE VALUES (2, '102', 1, 1, 'occupe');
INSERT INTO CHAMBRE VALUES (3, '103', 1, 1, 'libre');
INSERT INTO CHAMBRE VALUES (4, '104', 1, 2, 'occupe');
INSERT INTO CHAMBRE VALUES (5, '105', 1, 2, 'libre');
INSERT INTO CHAMBRE VALUES (6, '106', 1, 2, 'occupe');
INSERT INTO CHAMBRE VALUES (7, '107', 1, 3, 'libre');
INSERT INTO CHAMBRE VALUES (8, '108', 1, 3, 'occupe');
INSERT INTO CHAMBRE VALUES (9, '109', 1, 3, 'libre');
INSERT INTO CHAMBRE VALUES (10, '110', 1, 4, 'occupe');
INSERT INTO CHAMBRE VALUES (11, '001', 2, 5, 'libre');
INSERT INTO CHAMBRE VALUES (12, '002', 2, 5, 'occupe');
INSERT INTO CHAMBRE VALUES (13, '003', 2, 6, 'libre');
INSERT INTO CHAMBRE VALUES (14, '104', 2, 6, 'occupe');
INSERT INTO CHAMBRE VALUES (15, '105', 2, 6, 'libre');
INSERT INTO CHAMBRE VALUES (16, '106', 2, 7, 'occupe');
INSERT INTO CHAMBRE VALUES (17, '107', 2, 7, 'occupe');
INSERT INTO CHAMBRE VALUES (18, '108', 2, 8, 'libre');
INSERT INTO CHAMBRE VALUES (19, '109', 2, 8, 'occupe');
INSERT INTO CHAMBRE VALUES (20, '110', 2, 9, 'libre');
INSERT INTO CHAMBRE VALUES (21, '201', 2, 9, 'occupe');
INSERT INTO CHAMBRE VALUES (22, '202', 2, 10, 'libre');
INSERT INTO CHAMBRE VALUES (23, '203', 2, 10, 'occupe');
INSERT INTO CHAMBRE VALUES (24, '001', 3, 11, 'libre');
INSERT INTO CHAMBRE VALUES (25, '002', 3, 11, 'occupe');
INSERT INTO CHAMBRE VALUES (26, '101', 3, 12, 'libre');
INSERT INTO CHAMBRE VALUES (27, '102', 3, 12, 'occupe');
INSERT INTO CHAMBRE VALUES (28, '201', 3, 13, 'libre');
INSERT INTO CHAMBRE VALUES (29, '202', 3, 13, 'occupe');
INSERT INTO CHAMBRE VALUES (30, '301', 3, 14, 'libre');
INSERT INTO CHAMBRE VALUES (31, '308', 3, 14, 'occupe');
INSERT INTO CHAMBRE VALUES (32, '101', 4, 15, 'libre');
INSERT INTO CHAMBRE VALUES (33, '102', 4, 15, 'occupe');
INSERT INTO CHAMBRE VALUES (34, '103', 5, 17, 'libre');
INSERT INTO CHAMBRE VALUES (35, '104', 5, 17, 'occupe');
INSERT INTO CHAMBRE VALUES (36, '105', 5, 18, 'libre');
INSERT INTO CHAMBRE VALUES (37, '106', 5, 1, 'occupe');
INSERT INTO CHAMBRE VALUES (38, '107', 5, 1, 'libre');
INSERT INTO CHAMBRE VALUES (39, '108', 5, 3, 'occupe');
INSERT INTO CHAMBRE VALUES (40, '109', 5, 3, 'libre');
INSERT INTO CHAMBRE VALUES (41, '110', 5, 7, 'occupe');
INSERT INTO CHAMBRE VALUES (42, '211', 5, 7, 'libre');
INSERT INTO CHAMBRE VALUES (43, '212', 5, 10, 'occupe');
INSERT INTO CHAMBRE VALUES (44, '213', 5, 10, 'libre');
INSERT INTO CHAMBRE VALUES (45, '001', 6, 4, 'libre');
INSERT INTO CHAMBRE VALUES (46, '002', 6, 4, 'occupe');
INSERT INTO CHAMBRE VALUES (47, '003', 6, 8, 'libre');
INSERT INTO CHAMBRE VALUES (48, '004', 6, 8, 'occupe');
INSERT INTO CHAMBRE VALUES (49, '005', 6, 12, 'libre');
INSERT INTO CHAMBRE VALUES (50, '006', 6, 12, 'occupe');
INSERT INTO CHAMBRE VALUES (51, '007', 6, 13, 'libre');
INSERT INTO CHAMBRE VALUES (52, '008', 6, 13, 'occupe');
INSERT INTO CHAMBRE VALUES (53, '009', 6, 15, 'libre');
INSERT INTO CHAMBRE VALUES (54, '010', 6, 15, 'occupe');
INSERT INTO CHAMBRE VALUES (55, '111', 6, 17, 'libre');
INSERT INTO CHAMBRE VALUES (56, '112', 6, 17, 'occupe');
INSERT INTO CHAMBRE VALUES (57, '101', 7, 2, 'occupe');
INSERT INTO CHAMBRE VALUES (58, '102', 7, 2, 'occupe');
INSERT INTO CHAMBRE VALUES (59, '103', 7, 5, 'libre');
INSERT INTO CHAMBRE VALUES (60, '104', 7, 5, 'occupe');
INSERT INTO CHAMBRE VALUES (61, '201', 7, 9, 'occupe');
INSERT INTO CHAMBRE VALUES (62, '202', 7, 9, 'occupe');
INSERT INTO CHAMBRE VALUES (63, '203', 7, 14, 'libre');
INSERT INTO CHAMBRE VALUES (64, '624', 7, 14, 'occupe');
INSERT INTO CHAMBRE VALUES (65, '001', 8, 6, 'occupe');
INSERT INTO CHAMBRE VALUES (66, '101', 8, 6, 'occupe');
INSERT INTO CHAMBRE VALUES (67, '101', 8, 11, 'libre');
INSERT INTO CHAMBRE VALUES (68, '201', 8, 11, 'occupe');
INSERT INTO CHAMBRE VALUES (69, '202', 8, 16, 'occupe');
INSERT INTO CHAMBRE VALUES (70, '301', 8, 16, 'occupe');
INSERT INTO CHAMBRE VALUES (71, '001', 9, 1, 'libre');
INSERT INTO CHAMBRE VALUES (72, '002', 9, 7, 'occupe');
INSERT INTO CHAMBRE VALUES (73, '003', 9, 7, 'occupe');
INSERT INTO CHAMBRE VALUES (74, '101', 9, 8, 'occupe');
INSERT INTO CHAMBRE VALUES (75, '102', 9, 10, 'libre');
INSERT INTO CHAMBRE VALUES (76, '102', 10, 1, 'libre');
INSERT INTO CHAMBRE VALUES (77, '102', 10, 2, 'occupe');
INSERT INTO CHAMBRE VALUES (78, '102', 10, 15, 'occupe');
INSERT INTO CHAMBRE VALUES (79, '102', 10, 15, 'occupe');
INSERT INTO CHAMBRE VALUES (80, '102', 10, 15, 'occupe');

-- Insertion de donnees dans la table PARTENAIRE
INSERT INTO PARTENAIRE VALUES (1, 'Agence de voyage', 'ABC Travel', 100, 0.1 , 0.95);
INSERT INTO PARTENAIRE VALUES (2, 'Entreprise', 'XYZ Corp', 50, 0.08, 0.97);
INSERT INTO PARTENAIRE VALUES (3, 'Associations', 'Les Amis du Voyage', 80, 0.07, 0.98);
INSERT INTO PARTENAIRE VALUES (4, 'Agence de voyage', 'Voyage Plus', 70, 0.09, 0.96);
INSERT INTO PARTENAIRE VALUES (5, 'Entreprise', 'Acme Inc', 30, 0.06, 0.99);
INSERT INTO PARTENAIRE VALUES (6, 'Associations', 'Club des Randonneurs', 60, 0.08, 0.97);
INSERT INTO PARTENAIRE VALUES (7, 'Agence de voyage', 'Globetrek', 90, 0.1, 0.95);
INSERT INTO PARTENAIRE VALUES (8, 'Entreprise', 'Techno Solutions', 40, 0.07, 0.98);
INSERT INTO PARTENAIRE VALUES (9, 'Associations', 'Vacances pour Tous', 75, 0.09, 0.96);
INSERT INTO PARTENAIRE VALUES (10, 'Agence de voyage', 'Passion Voyages', 65, 0.08, 0.97);

-- Insertion de donnees dans la table Type_periode
INSERT INTO Periode VALUES (1, 'haute', 'we_ferie', 1.70);
INSERT INTO Periode VALUES (2, 'haute', 'semaine', 1.50);
INSERT INTO Periode VALUES (3, 'basse', 'we_ferie', 1.20) ;
INSERT INTO Periode VALUES (4, 'basse', 'semaine', 1.00);

-- Insertion de donnees dans la table client
select * from client;
INSERT INTO client VALUES (1, 'Dupont', 'Jean', 1234567890123456, '12 rue des Roses, 75000 Paris', 50);
INSERT INTO client VALUES (2, 'Mercier', 'Sylvie', 2345678901234567, '25 boulevard des Fleurs, 69000 Lyon', 250);
INSERT INTO client VALUES  (3, 'Lefevre', 'Maxime', 3456789012345678, '7 impasse des Tulipes, 33000 Bordeaux', 15);
INSERT INTO client VALUES  (4, 'Garcia', 'Isabelle', 4567890123456789, '42 avenue des Mimosas, 13000 Marseille', 0);
INSERT INTO client VALUES  (5, 'Nguyen', 'Thi Mai', 5678901234567890, '19 rue des Cerisiers, 44000 Nantes', 30);
INSERT INTO client VALUES  (6, 'Moreau', 'Sophie', 6789012345678901, '6 place de lhorloge, 75012 Paris', 35);
INSERT INTO client VALUES  (7, 'Martin', 'Francois', 7890123456789012, '38 boulevard de la Gare, 69100 Villeurbanne', 0);
INSERT INTO client VALUES  (8, 'Dubois', 'Julien', 8901234567890123, '9 rue des Peupliers, 44100 Nantes', 0);
INSERT INTO client VALUES  (9, 'Leroy', 'Celine', 9012345678901234, '24 chemin des Chenes, 06000 Nice', 0);
INSERT INTO client VALUES (10, 'Blanc', 'Marie', 0123456789012345, '17 allee des Tilleuls, 33000 Bordeaux', 0);
INSERT INTO client VALUES (11, 'Perrin', 'Marc', 1239874563214567, '15 avenue Victor Hugo, 75016 Paris', 100);
INSERT INTO client VALUES (12, 'Roche', 'Emilie', 2233445566778899, '12 rue Saint-Honoré, 34000 Montpellier', 0);
INSERT INTO client VALUES (13, 'Fontaine', 'Claire', 3344556677889900, '22 rue de la République, 31000 Toulouse', 200);
INSERT INTO client VALUES (14, 'Giraud', 'Thomas', 4455667788990011, '28 place Bellecour, 69002 Lyon', 50);
INSERT INTO client VALUES (15, 'Adam', 'Lucie', 5566778899001122, '3 rue des Jardins, 67000 Strasbourg', 0);
INSERT INTO client VALUES (16, 'Chevalier', 'Nicolas', 6677889900112233, '18 rue du Faubourg, 59000 Lille', 75);
INSERT INTO client VALUES (17, 'Renard', 'Pauline', 7788990011223344, '45 rue de Bretagne, 44000 Nantes', 0);
INSERT INTO client VALUES (18, 'Barbier', 'Julien', 8899001122334455, '33 boulevard Carnot, 13008 Marseille', 120);
INSERT INTO client VALUES (19, 'Moulin', 'Sophie', 9900112233445566, '10 place Masséna, 06000 Nice', 60);
INSERT INTO client VALUES (20, 'Girard', 'Antoine', 1011223344556677, '7 rue de la Liberté, 21000 Dijon', 0);
INSERT INTO client VALUES (21, 'Lopez', 'Isabel', 1122334455667788, '5 avenue de la République, 75011 Paris', 25);
INSERT INTO client VALUES (22, 'Fernandez', 'Carlos', 2233445566778899, '9 rue Saint-Jean, 84000 Avignon', 0);
INSERT INTO client VALUES (23, 'Schneider', 'Hélène', 3344556677889900, '12 rue d’Alsace, 68000 Colmar', 80);
INSERT INTO client VALUES (24, 'Dubois', 'Pierre', 4455667788990011, '19 allée des Cyprès, 76000 Rouen', 0);
INSERT INTO client VALUES (25, 'Benoit', 'Camille', 5566778899001122, '14 rue de la Paix, 25000 Besançon', 110);
INSERT INTO client VALUES (26, 'Rey', 'Mathilde', 6677889900112233, '28 boulevard Haussmann, 75009 Paris', 90);
INSERT INTO client VALUES (27, 'Marchand', 'Hugo', 7788990011223344, '16 place de la Comédie, 33000 Bordeaux', 0);
INSERT INTO client VALUES (28, 'Lemoine', 'Chloé', 8899001122334455, '21 rue Saint-Sauveur, 44000 Nantes', 130);
INSERT INTO client VALUES (29, 'Carpentier', 'Julien', 9900112233445566, '27 rue Lafayette, 59000 Lille', 45);
INSERT INTO client VALUES (30, 'Dupuy', 'Manon', 1011223344556677, '18 rue du Bac, 75007 Paris', 0);


-- Insertion de donnees dans la table NOTE
INSERT INTO NOTE VALUES (1, 1, '05/06/2023', 4);
INSERT INTO NOTE VALUES (2, 1, '22/07/2023', 5);
INSERT INTO NOTE VALUES (3, 1, '25/08/2023', 3);
INSERT INTO NOTE VALUES (4, 1, '07/09/2023', 4);
INSERT INTO NOTE VALUES (5, 2, '07/09/2023', 5);
INSERT INTO NOTE VALUES (6, 2, '16/11/2023', 4);
INSERT INTO NOTE VALUES (7, 2, '01/01/2024', 4);
INSERT INTO NOTE VALUES (8, 2, '10/01/2024', 3);
INSERT INTO NOTE VALUES (9, 2, '19/02/2024', 5);
INSERT INTO NOTE VALUES (10, 2, '07/03/2024', 4);
INSERT INTO NOTE VALUES (11, 3, '20/04/2024', 5);
INSERT INTO NOTE VALUES (12, 4, '15/05/2024', 3);
INSERT INTO NOTE VALUES (13, 5, '05/07/2024', 4);
INSERT INTO NOTE VALUES (14, 5, '20/07/2024', 2);
INSERT INTO NOTE VALUES (15, 5, '15/08/2024', 4);
INSERT INTO NOTE VALUES (16, 6, '15/09/2024', 5);
INSERT INTO NOTE VALUES (17, 7, '25/10/2024', 3);
INSERT INTO NOTE VALUES (18, 7, '10/11/2024', 4);
INSERT INTO NOTE VALUES (19, 8, '05/01/2025', 2);
INSERT INTO NOTE VALUES (20, 8, '15/01/2025', 5);


-- Insertion de donnees dans la table RESERVE
INSERT INTO RESERVE VALUES (1, '01/06/2023', '05/06/2023', 1, 1, 1, 1, 2, 2, 3, 0, 0, 1);
INSERT INTO RESERVE VALUES (2, '15/07/2023', '22/07/2023', 2, 4, 2, 1, 3, 3, 5, 0, 0, 2);
INSERT INTO RESERVE VALUES (3, '15/07/2023', '25/08/2023', 3, 7, 3, 1, 1, 12, 26, 0, 0, 3);
INSERT INTO RESERVE VALUES (4, '01/09/2023', '07/09/2023', 4, 10, 4, 1, 2, 0, 0, 2, 5, 4);
INSERT INTO RESERVE VALUES (5, '01/09/2023', '07/09/2023', 5, 14, 6, 2, 3, 0, 0, 2, 5, 5);
INSERT INTO RESERVE VALUES (6, '10/11/2023', '16/11/2023', 6, 16, 7, 2, 4, 0, 0, 2, 5, 6);
INSERT INTO RESERVE VALUES (7, '25/12/2023', '01/01/2024', 7, 17, 7, 2, 2, 4, 4, 0, 0, 7);
INSERT INTO RESERVE VALUES (8, '05/01/2024', '10/01/2024', 8, 19, 8, 2, 3, 0, 0, 2, 4, 8);
INSERT INTO RESERVE VALUES (9, '14/02/2024', '19/02/2024', 9, 22,10, 2,1, 0,0 , 2,4, 9);
INSERT INTO RESERVE VALUES (10, '01/03/2024', '07/03/2024', 10, 23, 10, 2, 2, 0, 0, 2, 5, 10);
INSERT INTO RESERVE VALUES (11, '10/04/2024', '20/04/2024', 11, 26, 12, 3,4, 0, 0, 3, 8, 1);
INSERT INTO RESERVE VALUES (12, '01/05/2024', '15/05/2024', 12, 32, 15, 4,3, 0, 0,6, 9, 4);
INSERT INTO RESERVE VALUES (13, '20/06/2024', '05/07/2024', 13, 34, 17, 5,5, 4, 12, 0, 0, 7);
INSERT INTO RESERVE VALUES (14, '10/07/2024', '20/07/2024', 14, 37, 1, 5,2, 3, 8, 0, 0, 2);
INSERT INTO RESERVE VALUES (15, '01/08/2024', '15/08/2024', 15, 43, 10, 5,3, 4,11, 0, 0, 6);
INSERT INTO RESERVE VALUES (16, '01/09/2024', '15/09/2024', 16, 46, 4, 6,4, 0, 0, 5, 10, 8);
INSERT INTO RESERVE VALUES (17, '15/10/2024', '25/10/2024', 17, 59, 5, 7,1, 0, 0, 2, 9, 3);
INSERT INTO RESERVE VALUES (18, '01/11/2024', '10/11/2024', 18, 61, 9, 7,2, 0, 0, 5, 5, 5);
INSERT INTO RESERVE VALUES (19, '20/12/2024', '05/01/2025', 19, 65,6, 8,4, 9, 8, 0, 0, 9);
INSERT INTO RESERVE VALUES (20, '01/01/2025', '15/01/2025', 20, 67, 11, 8,3, 5, 10, 0, 0, 10);


-- Insertion de donnees dans la table Facture





-- ----------------------------------------------------------------------
-- Questions : 
-- Q0 : facture - Nous allons créer plusieurs colonnes dans la table Réserve pour connaître le montant �  payer des différentes réservations effectuées par les clients.
-- A chaque étape on arrondira �  l'unité.
-- Q0.a
-- Rajouter les colonnes "facture_nuit", "facture_sejour" et "facture_finale".
ALTER TABLE Reserve
ADD facture_nuit number(8,3);

SELECT * FROM Reserve;

-- ALTER TABLE Reserve
-- DROP COLUMN facture_nuit;


ALTER TABLE Reserve
ADD facture_sejour number(8,3);

-- ALTER TABLE Reserve
-- DROP COLUMN facture_sejour;


ALTER TABLE Reserve
ADD facture_finale number(8,3);

-- ALTER TABLE Reserve
-- DROP COLUMN facture_finale;

-- Q0.b
-- Remplir la colonne facture_nuit de telle sorte qu'elle soit égale au produit du coût de la nuitee par le tarif de l'hôtel.
UPDATE Reserve R
SET facture_nuit = (
    SELECT ROUND(C.cout * (1 + H.TVA_hot / 100) * H.tarif_hot, 0)
    FROM Categorie_chambre C
    JOIN hotel H ON R.No_hotel = H.No_hotel
    WHERE R.No_categorie = C.No_categorie
);


-- Q1.c
-- Remplir la colonne facture_sejour en multipliant par la réduction due au partenaire, et par le nombre de jours passé selon chaque type de catégorie.
-- La table PERIODE n'etant pas rattachee, inscrivez directement le multiplicateur correspondant pour chaque type de jour.
UPDATE Reserve R
SET facture_sejour = (
    SELECT ROUND(R.facture_nuit * P.reduction * (R.nombre_jours1*1.7 + R.nombre_jours2*1.5 + R.nombre_jours3*1.2 + R.nombre_jours4*1.0), 0)
    FROM Partenaire P
    WHERE R.No_partenaire = P.No_partenaire
);

-- Q0.d
-- Replir la colonne facture_finale en soustrayant les points fidélité (�  diviser par 10) et en ajoutant la taxe de séjour.
-- Elle se calcule en multipliant le nombre de personnes de la réservation par la taxe correspondante de l'hôtel, par le nombre total de jours du séjour.
UPDATE Reserve R
SET facture_finale = (
    SELECT ROUND(R.facture_sejour - C.points_fidelite*0.1 + R.nombre_personnes * H.taxe_sejour_hot * (R.nombre_jours1 + R.nombre_jours2 + R.nombre_jours3 + R.nombre_jours4), 0)
    FROM Client C, Hotel H
    WHERE R.No_client = C.No_client
    AND R.No_hotel = H.No_Hotel
);


 --Question 1 : Quelles sont les catégories de chambres proposées par l'hôtel "Hotel de la Plage" ?
Select No_categorie FROM Hotel H, Propose P
Where H.nomHOT = 'Hotel de la Plage'
AND H.No_hotel = P.No_hotel;

-- Question 2 : Quels sont les clients (nom, prenom) qui ont réservé une chambre dans l'hôtel "Grand Hotel" pendant la période haute ?
SELECT client.Nom, client.Prenom
FROM client, RESERVE, hotel, Periode
WHERE client.NO_client = RESERVE.No_client
AND RESERVE.No_hotel = hotel.No_hotel
AND (RESERVE.nombre_jours2 > 0 OR RESERVE.nombre_jours1 > 0)
AND hotel.nomHot = 'Grand Hotel'
AND Periode.saison = 'haute'
AND Periode.type_de_jour = 'semaine';


-- Question 3 : Classez les hotels selon leur taux d'occupation, et donnez avec ça le salaire et le nom des maîtres dhôtels responsables.
SELECT h.No_hotel, h.nomHot, 
       COUNT(c.No_chambre) AS total_chambres,
       SUM(CASE WHEN c.etat = 'occupe' THEN 1 ELSE 0 END) AS chambres_occupees,
       ROUND((SUM(CASE WHEN c.etat = 'occupe' THEN 1 ELSE 0 END) / COUNT(c.No_chambre)) * 100, 2) AS taux_occupation,
       e.nom, e.salaire
FROM hotel h
JOIN chambre c ON h.No_hotel = c.No_hotel
LEFT JOIN employe e ON h.No_hotel = e.No_hotel AND e.poste = 'Maitre_dhotel'
GROUP BY h.No_hotel, h.nomHot, e.nom, e.salaire
ORDER BY taux_occupation DESC;


-- Question 4 : donnez une augmentation de 3% au maître de l'hôtel le plus occupé (donc le 8), de 2% �  ses subordonnés directs, de 1% aux autres employés.
UPDATE EMPLOYE -- Mise �  jour des salaires du maître d'hôtel
SET salaire = salaire * 1.03
WHERE poste = 'Maitre_dhotel' AND No_hotel = 8;

UPDATE EMPLOYE --  subordonnés directs
SET salaire = salaire * 1.02
WHERE code_respo IN (SELECT No_employe FROM EMPLOYE WHERE poste = 'Maitre_dhotel' AND No_hotel = 8);

UPDATE EMPLOYE -- les autres employés
SET salaire = salaire * 1.01
WHERE poste <> 'Maitre_dhotel' AND code_respo NOT IN (SELECT No_employe FROM EMPLOYE WHERE poste = 'Maitre_dhotel' AND No_hotel = 8)
AND No_hotel = 8;


-- Question 5 : Un client voudrait parmi vos hôtels 3 ou 4 étoile réserver une chambre pour 2 avec juste un lit double, télé et baignoire (a minima).
-- Proposez-lui les hôtel et les numéros de chambre correspondants, ainsi que l'identifiant des chambres et des catégories retenues.
select CH.numero, CH.No_chambre, H.nomHOT, c.No_categorie FROM Chambre Ch, Hotel H, Categorie_chambre C
WHERE (H.classe_HOT = 3 OR H.classe_HOT = 4)
AND CH.etat = 'libre'
AND C.televiseur = 1 AND C.lit_double = 1 AND C.lit_simple = 0 AND (C.salle_bain = 'baignoire' OR C.salle_bain = 'douche et baignoire')
AND CH.NO_hotel = H.No_hotel
AND CH.No_categorie = C.No_categorie;


-- Question 6 : Classer (ascendant) les hôtels en fonction du nombre de personnes qu'ils peuvent théoriquement accueillir au maximum. Donner aussei leur classe : 
SELECT H.classe_hot, H.nomHot, SUM(C.capacite) AS capacite_max
FROM Hotel H
JOIN CHAMBRE CH ON H.No_hotel = CH.No_hotel
JOIN CATEGORIE_Chambre C ON CH.No_categorie = C.No_categorie
GROUP BY H.classe_hot, H.nomHot
ORDER BY capacite_max ASC;

 -- sans jointure : 
 SELECT H.classe_hot, H.nomHot, SUM(C.capacite) AS capacite_max
FROM Hotel H, CHAMBRE CH, CATEGORIE_Chambre C
WHERE H.No_hotel = CH.No_hotel
AND CH.No_categorie = C.No_categorie
GROUP BY H.classe_hot, H.nomHot
ORDER BY capacite_max ASC;


--Question 7 : Quels sont les services proposés par les hôtels de catégorie 4 étoiles (rappelez leur nom)?
SELECT H.nomHOT, S.petit_dej, S.salle_sport, S.piscine, S.billard, S.restaurant
FROM SERVICE S
INNER JOIN Hotel H ON S.No_service = H.No_service
WHERE H.classe_hot = 4;


-- Question 8 : Donner le nom des hotels dont le prix moyen d'un achat est superieur �  la moyenne du prix d'un achat.
SELECT H.nomHOT FROM hotel H
WHERE H.No_hotel IN (SELECT A.No_hotel FROM achat A
    GROUP BY A.No_hotel
    HAVING AVG(A.quantite) > (SELECT AVG(quantite) FROM achat));


-- Question 9 : Quels sont les partenaires qui ont amené les clients donnant en moyenne les meilleures notes? Classez-les selon, et baissez d'1% la commission du partenaire qui apporte les plus faibles notes.
SELECT P.nom, AVG(N.note) AS avg_note
FROM Reserve R
INNER JOIN Client C ON R.No_Client = C.No_Client
INNER JOIN Note N ON N.No_Client = C.No_Client
INNER JOIN Partenaire P ON R.No_Partenaire = P.No_Partenaire
GROUP BY P.No_Partenaire, P.nom
ORDER BY avg_note DESC;

UPDATE Partenaire
SET commission = commission - 0.1
WHERE nom = 'Les Amis du Voyage';


-- Question 10 : Trouver les chambres les plus souvent réservées et afficher leur numéro, catégorie, et hôtel associé
SELECT 
    c.No_chambre, cc.No_categorie, h.nomHot AS, COUNT(r.No_chambre) AS Nombre_Reservations
FROM CHAMBRE c
INNER JOIN RESERVE r ON c.No_chambre = r.No_chambre
INNER JOIN CATEGORIE_Chambre cc ON c.No_categorie = cc.No_categorie
INNER JOIN hotel h ON c.No_hotel = h.No_hotel
GROUP BY c.No_chambre, cc.No_categorie, h.nomHot
HAVING COUNT(r.No_chambre) = (
    SELECT MAX(COUNT(No_chambre)) FROM RESERVE GROUP BY No_chambre)
ORDER BY Nombre_Reservations DESC;