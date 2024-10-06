--Selecionar musicas antigas de um estilo musical e musico especifico
SELECT *
FROM musica
WHERE genero = 'genero Y' AND nomeCriador = 'estilo X' AND ano < 2000;

--Selecionar playlists de um tipo de genero e de um usuario especifico 
SELECT *
FROM playlist
WHERE nomePlaylist IN (SELECT nomePlaylist FROM genero WHERE nomeGenero = 'genero Y') 
AND IdUsuario = valor a ser escolhido;

--Listar as 10 musicas mais vendidas
SELECT *
FROM musica
ORDER BY numeroDeVendas DESC
LIMIT 10;

--Listar as 10 musicas mais fracassadas
SELECT *
FROM musica
ORDER BY numeroDeVendas ASC 
LIMIT 10;

--Listar o tipo de genero que aparece em maior quantidade em playlists
SELECT genero, COUNT(*) AS totalPlaylistGenero
FROM genero
GROUP BY genero
ORDER BY totalplayListgenero DESC
LIMIT 1;

--Listar o musico com maior numero de musicas vendindidas
SELECT nomeCriador, SUM(numeroDeVendas) AS TotalDeVenda
FROM musica
GROUP BY nomeCriador
ORDER BY TotalDeVenda DESC
LIMIT 1;

--Listar musicas mais velhas
SELECT *
FROM musica
ORDER BY ano
LIMIT 10;

--Lisra playlists com mais mais minutagem 
SELECT pl.nomePlaylist, SUM(musica.duracao) AS minutagem
FROM playlist pl
JOIN sons ON pl.nomePlaylist = sons.nomePlaylist
JOIN musica ON sons.titulo = musica.titulo
GROUP BY pl.nomePlaylist
ORDER BY minutagem DESC
LIMIT 10;

--Listar 10 musicas com mais minutagem e 10 mais curtas
SELECT titulo, duracao
FROM musica
ORDER BY duracao DESC
LIMIT 10)
UNION ALL
(SELECT titulo, duracao
FROM musica
ORDER BY duracao
LIMIT 10;

WITH usuarioGastador AS (
    SELECT IdUsuario, totalCompradas
    FROM (
        SELECT IdUsuario, COUNT(*) AS totalCompradas,
               ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS rn
        FROM comprou
        GROUP BY IdUsuario
    ) sub
    WHERE rn = 1
) 
 
--Listar usuario com mais musicas compradas e quais musicas 
SELECT cp.IdUsuario, cp.nomeMusica
FROM comprou cp
JOIN usuarioGastador ON cp.IdUsuario = usuarioGastador.IdUsuario;

--Alteração para adição de comentario e avaliação sobre a musica
ALTER TABLE musica
ADD COLUMN comentarios varchar(50),
ADD COLUMN avaliacao DECIMAL(3, 2);

--Alteração para adição do estado do artista, sendo aposentado = TRUE o artista ja se aposentou
ALTER TABLE artista
ADD COLUMN aposentado BOOLEAN DEFAULT FALSE;