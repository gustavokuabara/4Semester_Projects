set search_path to Musicmatic;

INSERT INTO usuario (cpf,idIndentificador,nome,email,rua,numero)
VALUES (12332112312, 1, 'Rogerio', 'RogerioCareca@gmail.com','Rua 1',1233),
(12345678912, 2, 'Felipe', 'FelipeCalvo@gmail.com','Rua 3',333),
(98765432198, 3, 'Jeferson', 'JefersonCaminhoes@gmail.com','Rua 6',662),
(12312312312, 4, 'Caze', 'CazeMentiroso@gmail.com','Rua 12',540),
(45678932112, 5, 'Eduardo', 'EduardoManhoso@gmail.com','Rua 6',690),
(32132132132, 6, 'Gustavo', 'GustavoKu@gmail.com','Rua 10',3322),
(75757575757, 7, 'Carlos', 'CarlosLindo@gmail.com','Rua 1',1233),
(32321233232, 8, 'CazeNamorada', 'CazeNamorada@gmail.com','Rua 12',540),
(99999999999, 9, 'Amanda', 'Amandabomba@gmail.com','Rua 9',4321),
(10101010101, 10, 'Trem', 'TremBolona@gmail.com','Rua 14',99);

INSERT INTO artista (nome, idade, dataNascimento)
VALUES ('Sandra',30,'1994-03-20'),
('Luisinho',22,'2002-01-10'),
('Alberto',20,'2003-08-21'),
('Chico',67,'1956-05-18'),
('Rosa',47,'1976-09-30'),
('Carlinhos',30,'1993-07-23'),
('Coins',70,'1953-07-04'),
('Teu',22,'2001-09-30'),
('Primo',33,'1990-10-11'),
('Cavalo',44,'1979-06-09');

INSERT INTO URL (linked, nomeArtista)
VALUES ('http://youtube.com/Sandra', 'Sandra'),
('http://youtube.com/Luisinho', 'Luisinho'),
('http://youtube.com/Alberto', 'Alberto'),
('http://youtube.com/Chico', 'Chico'),
('http://youtube.com/Rosa', 'Rosa'),
('http://youtube.com/Carlinhos', 'Carlinhos'),
('http://youtube.com/Coins', 'Coins'),
('http://youtube.com/Teu', 'Teu'),
('http://youtube.com/Primo', 'Primo'),
('http://youtube.com/Cavalo', 'Cavalo');

INSERT INTO playlist (nomePlaylist, IdUsuario, descricao, album, nomeArtista)
VALUES ('PlaylistBoa', 6, 'Musicas boas', 'Album1', 'Sandra'),
('PlaylistRuim', 6, 'Musicas ruins', 'Album2', 'Sandra'),
('PlaylistdoCaze1', 4, 'Musicas ruins', 'Album3', 'Alberto'),
('PlaylistdoCaze2', 4, 'Musicas horriveis', 'Album4', 'Chico'),
('PlaylistdoCaze3', 4, 'Musicas insuportaveis', 'Album5', 'Coins'),
('PlaylistEduardo1', 5, 'Musicas boas', 'Album6', 'Sandra'),
('PlaylistEduardo2', 5, 'Musicas ruins', 'Album7', 'Teu'),
('PlaylistTeu', 8, 'Musicas que o Caze curte', 'Album8', 'Alberto'),
('PlaylistTrem1', 10, 'Musicas para treino', 'Album9', 'Primo'),
('PlaylistTrem2', 10, 'Musicas para treino', 'Album10', 'Cavalo');

INSERT INTO album (nome, numero, IdUsuario, numeroHit, nomePlaylist)
VALUES ('Album1', 1, 6, 8, 'PlaylistBoa'),
('Album2', 2, 6, 4, 'PlaylistRuim'),
('Album3', 3, 4, 5, 'PlaylistdoCaze1'),
('Album4', 4, 4, 5, 'PlaylistdoCaze2'),
('Album5', 5, 4, 7, 'PlaylistdoCaze3'),
('Album6', 6, 5, 10, 'PlaylistEduardo1'),
('Album7', 7, 5, 4, 'PlaylistEduardo2'),
('Album8', 8, 8, 5, 'PlaylistTeu'),
('Album9', 9, 10, 10, 'PlaylistTrem1'),
('Album10', 10, 10, 12, 'PlaylistTrem2');

INSERT INTO musica (titulo, ano, genero, duracao, nomeCriador, numeroDeVendas, tipo)
VALUES ('Musica1', 2020, 'Pop', 3.51, 'Sandra', 1000, NULL),
('Musica2', 2023, 'Rock', 4.01, 'Sandra', 2, NULL),
('Musica3', 2022, 'Funk', 2.30, 'Chico', 23, NULL),
('Musica4', 2014, 'Pop', 3.51, 'Teu', 467, NULL),
('Musica5', 2012, 'Eletronica', 3.51, 'Alberto', 2333, NULL),
('Musica6', 2010, 'Funk', 2.20, 'Coins', 4, NULL),
('Musica7', 2023, 'Hardbass', 5.02, 'Primo', 10000, NULL),
('Musica8', 2024, 'Funk', 3.00, 'Primo', 987, NULL),
('Musica9', 2010, 'Sertanejo', 4.00, 'Primo', 3456, NULL),
('Musica10', 2003, 'Classica', 3.22, 'Cavalo', 1, NULL),
('Musica11', 2001, 'Pop', 3.33, 'Sandra', 444, NULL),
('Musica12', 1932, 'Rock', 3.48, 'Luisinho', 32, NULL),
('Musica13', 1999, 'Funk', 2.59, 'Chico', 1032, NULL),
('Musica14', 1998, 'Pop', 3.54, 'Teu', 50645, NULL),
('Musica15', 2003, 'Eletronica', 3.27, 'Alberto', 1000323, NULL),
('Musica16', 2004, 'Sertanejo', 4.23, 'Coins', 243056, NULL),
('Musica17', 2005, 'Funk', 3.33, 'Primo', 2003236, NULL),
('Musica18', 2010, 'Sertanejo', 4.01, 'Carlinhos', 0, NULL),
('Musica19', 2020, 'Classica', 7.32, 'Rosa', 3245, NULL),
('Musica20', 2024, 'Classica', 5.59, 'Cavalo', 456, NULL);

INSERT INTO genero (IdUsuario, nomePlaylist, nomeGenero)
VALUES (6, 'PlaylistBoa', 'Pop'),
(6, 'PlaylistRuim', 'Rap'),
(4, 'PlaylistdoCaze1', 'Funk'),
(4, 'PlaylistdoCaze2', 'Gospel'),
(4, 'PlaylistdoCaze3', 'Jazz'),
(5, 'PlaylistEduardo1', 'Sertanejo'),
(5, 'PlaylistEduardo2', 'Hardbass'),
(8, 'PlaylistTeu', 'Classica'),
(10, 'PlaylistTrem1', 'Rock'),
(10, 'PlaylistTrem2', 'Eletronica');

INSERT INTO sons (IdUsuario, nomePlaylist, titulo, nomeDoArtista)
VALUES (6, 'PlaylistBoa', 'Musica1', 'Sandra'),
(6, 'PlaylistRuim', 'Musica2', 'Sandra'),
(4, 'PlaylistdoCaze1', 'Musica3', 'Chico'),
(4, 'PlaylistdoCaze2', 'Musica4', 'Teu'),
(4, 'PlaylistdoCaze3', 'Musica5', 'Alberto'),
(5, 'PlaylistEduardo1', 'Musica6', 'Chico'),
(5, 'PlaylistEduardo2', 'Musica7', 'Primo'),
(8, 'PlaylistTeu', 'Musica8', 'Primo'),
(10, 'PlaylistTrem1', 'Musica9', 'Primo'),
(10, 'PlaylistTrem2', 'Musica10', 'Cavalo');

INSERT INTO estiloMusica (genero, IdUsuario)
VALUES ('Pop', 1),
('Rap', 2),
('Funk', 3),
('Gospel', 4),
('Jazz', 5),
('Sertanejo', 6),
('Hardbass', 7),
('Classica', 8),
('Rock', 9),
('Eletronica', 10);

INSERT INTO negocio (IdUsuario, CNPJ)
VALUES (1, '12312312312312'),
(2, '45645645645645'),
(3, '78978978978978'),
(4, '00000000000001'),
(5, '00000000000002'),
(6, '32132132132132'),
(7, '65465465465465'),
(8, '00000000000002'),
(9, '00000000000003'),
(10, '00000000000004');

INSERT INTO hits (tituloMusica, numero, criador)
VALUES ('Musica1', 1, 'Sandra'),
('Musica2', 2, 'Luisinho'),
('Musica3', 3, 'Chico'),
('Musica4', 4, 'Teu'),
('Musica5', 5, 'Alberto'),
('Musica6', 6, 'Coins'),
('Musica7', 7, 'Primo'),
('Musica8', 8, 'Carlinhos'),
('Musica9', 9, 'Rosa'),
('Musica10', 10, 'Cavalo');


INSERT INTO single (tituloMusica, criador)
VALUES ('Musica11', 'Sandra'),
('Musica12', 'Luisinho'),
('Musica13', 'Chico'),
('Musica14', 'Teu'),
('Musica15', 'Alberto'),
('Musica16', 'Coins'),
('Musica17', 'Primo'),
('Musica18', 'Carlinhos'),
('Musica19', 'Rosa'),
('Musica20', 'Cavalo');

INSERT INTO comprou (idusuario, nomeMusica)
VALUES (6, 'Musica1'),
(6, 'Musica2'),
(4, 'Musica3'),
(5, 'Musica4'),
(5, 'Musica5'),
(4, 'Musica6'),
(4, 'Musica7'),
(8, 'Musica8'),
(10, 'Musica9'),
(10, 'Musica10');

INSERT INTO contem (titulo, idUsuario, nomePlaylist)
VALUES ('Musica1', 6, 'PlaylistBoa'),
('Musica2', 6, 'PlaylistRuim'),
('Musica3', 4, 'PlaylistdoCaze1'),
('Musica6', 4, 'PlaylistdoCaze2'),
('Musica7', 4, 'PlaylistdoCaze3'),
('Musica4', 5, 'PlaylistEduardo1'),
('Musica5', 5, 'PlaylistEduardo2'),
('Musica8', 8, 'PlaylistTeu'),
('Musica9', 10, 'PlaylistTrem1'),
('Musica10', 10, 'PlaylistTrem2');