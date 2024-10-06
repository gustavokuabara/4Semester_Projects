--função adicionar musica a playlist
SET Search_path TO Musicmatic;

CREATE OR REPLACE FUNCTION add_playlist(id_us INT, nome_play VARCHAR, nome_mus VARCHAR)
RETURNS VARCHAR
LANGUAGE PLPGSQL
AS 
$$
DECLARE
    nm VARCHAR;
    msg VARCHAR;
BEGIN
    
	SELECT cm.nomeMusica
    	INTO nm
    	FROM COMPROU cm
    	WHERE cm.idUsuario = id_us AND cm.nomeMusica = nome_mus;
	
	IF nm IS NOT NULL THEN
        SELECT ct.titulo
        	INTO nm
        	FROM CONTEM ct
       		WHERE ct.idUsuario = id_us AND 
		          ct.nomePlaylist = nome_play AND 
			      ct.titulo = nome_mus;
    
		IF nm IS NULL THEN
			INSERT INTO contem (titulo, idUsuario, nomePlaylist)
			VALUES (nome_mus, id_us, nome_play);
			msg := nome_mus || ' FOI ADICIONADA NA PLAYLIST';
		ELSE
			msg := 'A MUSICA ' || nome_mus || ' JÁ ESTÁ NA PLAYLIST';
		END IF;
	
	ELSE
		msg := 'A MUSICA ' || nome_mus || ' NÃO FOI ADQUIRIDA';
	END IF;

    RETURN msg;
END;
$$;





--função aquisição, altera numero de vendas
SET Search_path TO Musicmatic;

CREATE OR REPLACE FUNCTION comprar_musica(id_us INT, nome_mus VARCHAR)
RETURNS VARCHAR
LANGUAGE PLPGSQL
AS
$$

DECLARE
	    nom VARCHAR;
		msg VARCHAR;

BEGIN

	SELECT titulo
		INTO nom
		FROM MUSICA 
		WHERE titulo = nome_mus;
	
	IF nom IS NOT NULL AND NOT EXISTS (SELECT 1 FROM COMPROU cp WHERE cp.nomeMusica = nome_mus AND cp.idusuario = id_us)THEN
	
		UPDATE MUSICA
			SET numeroDeVendas = numeroDeVendas + 1
			WHERE nom = titulo;
			
		INSERT INTO COMPROU(idusuario, nomeMusica) VALUES (id_us, nome_mus);
		
		msg := 'MUSICA ' || nome_mus || ' COMPRADA';
		
	ELSE
		msg := 'MUSICA ' || nome_mus || ' NÃO ESTÁ DISPONIVEL';
		
	END IF;
		
	RETURN msg;

END;
$$






--função para adicionar mais músicas
SET Search_path TO Musicmatic;
 
CREATE OR REPLACE FUNCTION gatilho_addmusica()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS 
$$
 
BEGIN
	IF NOT EXISTS(SELECT 1 FROM HITS h WHERE h.tituloMusica = NEW.titulo) THEN
		RAISE EXCEPTION 'NÃO É POSSIVEL ADICIONAR ESSA MUSICA';
	END IF;
	IF NOT EXISTS(SELECT 1 FROM COMPROU cc WHERE NEW.idUsuario = cc.idusuario AND cc.nomeMusica = NEW.titulo) THEN
		RAISE EXCEPTION 'A MUSICA NÃO FOI COMPRADA';
	END IF;
	IF EXISTS(SELECT 1 FROM CONTEM ct WHERE NEW.idUsuario = ct.idUsuario AND NEW.titulo = ct.titulo AND NEW.nomePlaylist = ct.nomePlaylist) THEN
		RAISE EXCEPTION 'A MUSICA JÁ FOI ADICIONADA';
	END IF;
	
	RETURN NEW;
 
END;
$$;
 
 
CREATE OR REPLACE TRIGGER gatilho_addmusica
BEFORE INSERT ON CONTEM
FOR EACH ROW
EXECUTE PROCEDURE gatilho_addmusica();





--função indicação linkar usuários com playlist de mesmo genero/estilo
SET Search_path TO Musicmatic;

CREATE OR REPLACE FUNCTION mesmo_genero_playlist(id_us INT)
RETURNS TABLE(nome_play VARCHAR)
LANGUAGE PLPGSQL
AS 
$$

BEGIN

	RETURN QUERY
	SELECT DISTINCT g1.nomePlaylist
		FROM GENERO g1
		INNER JOIN GENERO g2 ON g1.nomeGenero = g2.nomeGenero
		WHERE g1.IdUsuario <> g2.IdUsuario AND
			  g2.IdUsuario = id_us;
		  
END;
$$;





--função para calcular o tempo da playlist
SET Search_path TO Musicmatic;

CREATE OR REPLACE FUNCTION pl_duracao(idd INT, nomep VARCHAR)
RETURNS REAL
LANGUAGE PLPGSQL
AS 
$$

DECLARE
		tempo REAL := 0.0;

BEGIN

	SELECT SUM(mc.duracao)
		INTO tempo
		FROM MUSICA mc, CONTEM cc
		WHERE idd = cc.idUsuario AND
		      mc.titulo = cc.titulo AND
			  cc.nomePlaylist = nomep;

	RETURN tempo;

END;
$$;

SET Search_path TO Musicmatic;



-- Altera a funcao comprar_musica para adicionar nota e fazer sua soma com a nota presente e dividir por 2
ALTER FUNCTION comprar_musica(id_us INT, nome_mus VARCHAR)
RETURNS VARCHAR
LANGUAGE PLPGSQL
AS
$$
DECLARE
    nom VARCHAR;
    msg VARCHAR;
    nota_atual FLOAT;
    nova_nota FLOAT;
BEGIN
    SELECT titulo, nota
    INTO nom, nota_atual
    FROM MUSICA 
    WHERE titulo = nome_mus;

    IF nom IS NOT NULL AND NOT EXISTS (SELECT 1 FROM COMPROU cp WHERE cp.nomeMusica = nome_mus AND cp.idusuario = id_us) THEN
        UPDATE MUSICA
        SET numeroDeVendas = numeroDeVendas + 1
        WHERE titulo = nom;
        nova_nota := (nota_atual + nota_mus) / 2;
        UPDATE MUSICA
        SET nota = nova_nota
        WHERE titulo = nom;

        INSERT INTO COMPROU(idusuario, nomeMusica) VALUES (id_us, nome_mus);

        msg := 'MUSICA ' || nome_mus || ' COMPRADA E NOTA ATUALIZADA PARA ' || nova_nota;

    ELSE
        msg := 'MUSICA ' || nome_mus || ' NÃO ESTÁ DISPONÍVEL';
    END IF;

    RETURN msg;
END;
$$;




--trigger para calcular o tipo da musica
SET SEARCH_PATH TO Musicmatic;

CREATE OR REPLACE FUNCTION gatilho_tipo()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS
$$
	
BEGIN
	
	IF (EXTRACT(YEAR FROM CURRENT_DATE) - NEW.ano) < 1 THEN
        NEW.tipo := 'Lançamento';
		
	ELSIF (EXTRACT(YEAR FROM CURRENT_DATE) - NEW.ano) > 10 THEN
        NEW.tipo := 'Antiga';
	
    ELSIF NEW.numeroDeVendas > 1000000 THEN
        NEW.tipo := 'Estourada';
			
    ELSIF NEW.numeroDeVendas BETWEEN 5000 AND 20000 THEN
        NEW.tipo := 'Underground';
		
    END IF;
	
    RETURN NEW;
	
END;
$$;

CREATE OR REPLACE TRIGGER gatilho_tipo
BEFORE INSERT OR UPDATE ON MUSICA
FOR EACH ROW
EXECUTE PROCEDURE gatilho_tipo();

