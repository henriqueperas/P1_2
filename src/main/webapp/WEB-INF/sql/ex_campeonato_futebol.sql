CREATE DATABASE ex_campeonato_futebol
GO
USE ex_campeonato_futebol

CREATE TABLE times(
codigoTime		INT	NOT NULL,
nomeTime		VARCHAR(30)	NOT NULL,
cidade			VARCHAR(30)	NOT NULL,
estadio			VARCHAR(30)	NOT NULL,
juntosNão		BIT	NOT NULL,
PRIMARY KEY(codigoTime)
)
GO
CREATE TABLE grupos(
codigoGrupo INT NOT NULL,
codigoTimeG INT	NOT NULL,
grupo	CHAR(1)	NOT NULL	CHECK(grupo = 'A' OR grupo = 'B' OR grupo = 'C' OR grupo = 'D')
PRIMARY KEY(codigoGrupo)
FOREIGN KEY(codigoTimeG) REFERENCES times(codigoTime)
)
GO
CREATE TABLE jogos(
codigoJogo		INT	NOT NULL,
codigoTime1	INT NULL,
codigoTime2	INT NULL,
golsTime1	INT	NULL,
golsTime2	INT	NULL,
data_jogo	DATE NULL,
PRIMARY KEY(codigoJogo),
FOREIGN KEY(codigoTime1) REFERENCES times(codigoTime),
FOREIGN KEY(codigoTime2) REFERENCES times(codigoTime)
)
GO
INSERT INTO times VALUES
(1,'Botafogo-SP','Ribeirão Preto','Santa Cruz', 0),
(2,'Corinthians','São Paulo','Neo Quimica Arena', 1),
(3,'Ferroviária','Araraquara','Fonte Luminosa', 0),
(4,'Guarani','Campinas','Brinco de ouro', 0),
(5,'Inter de Limeira','Limeira','Limeirão', 0),
(6,'Ituano','Itu','Novelli Júnior', 0),
(7,'Mirassol','Mirassol','José Maria de Campos Maia', 0),
(8,'Novorizontino','Novo Horizonte','Jorge Ismael de Biasi', 0),
(9,'Palmeiras','São Paulo','Allianz Parque', 1),
(10,'Ponte Preta','Capinas','Moisés Lucarelli', 0),
(11,'Red Bull Bragantino','Bragança Paulista','Nabi Abi Chedid', 0),
(12,'Santo André','Santo André','Bruno José Daniel', 0),
(13,'Santos','Santos','Vila Belmiro', 1),
(14,'São Bento','Sorocaba','Walter Ribeiro', 0),
(15,'São Caetano','São Caetano do sul','Anacietto Campanella', 0),
(16,'São Paulo','São Paulo','Morumbi', 1)

DELETE grupos
DELETE times
DELETE jogos

--DIVIDE OS TIMES EM 4 GRUPOS
CREATE PROCEDURE sp_separa_grupos(@saida VARCHAR(50) OUTPUT)
	AS
		DECLARE @interLoop INT, @interJunto INT, @juntosNão INT, @escolha INT, @grupos CHAR(1), @interGrupo CHAR(4), @interG INT, @interG2 INT, @valido INT

		SET @interLoop = 1
		SET @interJunto = 1
		SET @interGrupo = 'ABCD'
		SET @interG = 1
		
		--coloca primeiro queles que não podem ficar juntos nos grupos
		WHILE (@interLoop <= 16)
		BEGIN
			--confere se ele pode ou não ser o unico do grupo
			SELECT @juntosNão = juntosNão FROM times WHERE @interLoop = codigoTime
			SET @grupos = SUBSTRING(@interGrupo,@interG,1)
			IF(@juntosNão = 1)
			BEGIN
				INSERT INTO grupos VALUES (@interJunto, @interLoop, @grupos)
				SET @interG = @interG + 1
				SET @interJunto = @interJunto + 4
			END
			SET @interLoop = @interLoop + 1
		END
		
		SET @interLoop = 1
		SET @interG = 1
		SET @interG2 = 1
		
		--coloca o restante, verificando queles que já estão, sem repetir
		WHILE (@interLoop <= 16)
		BEGIN
			IF(@interLoop = 1 OR @interLoop = 5 OR @interLoop = 9 OR @interLoop = 13)
			BEGIN
				SET @interLoop = @interLoop + 1
			END
			ELSE
			BEGIN
				SET @grupos = SUBSTRING(@interGrupo,@interG,1)
				SET @escolha = CAST(FLOOR(RAND()*(16)+1) AS INT)
				--confere se já existe um repetido
				SELECT @valido = 1 FROM grupos WHERE @escolha = codigoTimeG
				IF(@valido = 0)
				BEGIN
					INSERT INTO grupos VALUES (@interLoop, @escolha, @grupos)
					SET @interG2 = @interG2 + 1
					SET @interLoop = @interLoop + 1
				END
			END
			SET @valido = 0
			IF(@interG2 = 4)
			BEGIN
				SET @interG = @interG + 1
				SET @interG2 = 1
			END
		END
		SET @saida = 'times separados com sucesso'

DECLARE @out VARCHAR(40)
DELETE FROM grupos
EXEC sp_separa_grupos @out OUTPUT
PRINT @out

SELECT * FROM grupos
SELECT * FROM grupos ORDER BY codigoTimeG

SELECT g.codigoGrupo, t.nomeTime, t.cidade, t.estadio, g.grupo FROM grupos g, times t WHERE g.codigoTimeG = t.codigoTime

--SEPARA O DIA QUE IRA ACONTECER AS PARTIDAS
CREATE PROCEDURE sp_separa_datas (@saida VARCHAR(40) OUTPUT)
AS
		--SEPARA OS DIAS DOS JOGOS
		DECLARE @dia DATE,@dia2 DATE, @interLoop4 INT, @interLoop5 INT, @interLoopR INT, @interLoopR2 INT, @interdia INT, @interdia2 INT, @interSeparaDia INT

		--dia que começa, domingo 23/01

		SET @dia = '2022-01-23'
		SET @dia2 = '2022-01-26' 
		SET @interLoop4 = 1
		SET @interLoopR = 1
		SET @interLoopR2 = 4
		SET @interdia = 0
		SET @interdia2 = 0

		--vai ser complicado explicar como eu fiz isso
		--no loop 1 ao 8 e 13 ao 16 é dado uma data, com 13 jogos de diferença na lista do 1 ao 8 e 9 jogos de diferença na lista do 13 ao 16
		--no resto fiz um esquema para não repetir as datas, basicamente isso
		WHILE(@interLoop4 <= 24)
		BEGIN
			IF(@interLoop4 <= 12)
			BEGIN
				--define quantos jogos vão ser pulados na lista 
				SET @interSeparaDia = 13
				--apartie de qual vai começar 
				SET @interLoop5 = @interLoop4
			END
			ELSE IF(@interLoop4 > 12 AND @interLoop4 <= 20)
			BEGIN
				SET @interSeparaDia = 9
				SET @interLoop5 = @interLoop4 + 36
			END
			ELSE IF(@interLoop4 > 20 AND @interLoop4 <= 24)
			BEGIN
				SET @interSeparaDia = 5
				SET @interLoop5 = @interLoop4 + 60
			END
			--se for impar é domingo e par quarta
			IF(@interLoop4 % 2 = 1)
			BEGIN
				WHILE(@interLoopR <= 4)
				BEGIN
					UPDATE jogos SET data_jogo = DATEADD(DAY, 7 * @interdia, @dia) WHERE @interLoop5 = codigoJogo
					IF(@interLoopR = @interLoopR2)
					BEGIN
						SET @interLoop5 = @interLoop5 + 1
					END
					ELSE
					BEGIN
						SET @interLoop5 = @interLoop5 + @interSeparaDia
					END
					SET @interLoopR = @interLoopR + 1
				END
				SET @interdia = @interdia + 1
			END
			ELSE
			BEGIN	
				WHILE(@interLoopR <= 4)
				BEGIN
					UPDATE jogos SET data_jogo = DATEADD(DAY, 7 * @interdia2, @dia2) WHERE @interLoop5 = codigoJogo
					IF(@interLoopR = @interLoopR2)
					BEGIN
						SET @interLoop5 = @interLoop5 + 1
					END
					ELSE
					BEGIN
						SET @interLoop5 = @interLoop5 + @interSeparaDia
					END
					SET @interLoopR = @interLoopR + 1
				END
				SET @interdia2 = @interdia2 + 1
			END
			-- o esquema que ue falei
			-- nem sei explicar direito como isso funciona
			-- mas ele basicamente a partir de um tanto de vezes ao inves de pular como estava pulando antes
			-- apenas passa para o proximo, isso evitar ter dois jogos na mesma data, porem esse esquema não é nada flexivel
			IF(@interLoop4 > 8 AND @interLoop4 <= 12)
			BEGIN
				SET @interLoopR2 = @interLoopR2 - 1
			END
			ELSE IF(@interLoop4 > 16)
			BEGIN
				SET @interLoopR2 = @interLoopR2 - 1
			END
			-- a partir desse ele recomeça
			IF(@interLoop4 = 13 OR @interLoop4 = 20)
			BEGIN
				SET @interLoopR2 = 4
			END
			SET @interLoopR = 1
			SET @interLoop4 = @interLoop4 + 1
		END
		SET @saida = 'partidas criadas com sucesso'

--CRIA PARTIDA PARA TODOS OS TIMES EM SEUS GRUPOS
CREATE PROCEDURE sp_cria_partidas (@saida VARCHAR(40) OUTPUT)
	AS
		DECLARE @interLoop1 INT,@interLoop2 INT,@interLoop3 INT, @interTime1 INT, @interTime2 INT, @interSeparaG INT, @interSeparaG2 INT, @interVerificaG CHAR(1)

		SET @interLoop1 = 1
		SET @interLoop2 = 1
		SET @interTime2 = 1

		--SEPARA QUEM VAI JOGAR COM QUEM
		WHILE (@interLoop2 <= 12)
		BEGIN
			SELECT @interTime1 = codigoTimeG, @interVerificaG = grupo FROM grupos WHERE @interLoop2 = codigoGrupo
			IF(@interVerificaG = 'A')
			BEGIN
				SET @interSeparaG = 12
				SET @interLoop3 = 5
			END
			ELSE IF(@interVerificaG = 'B')
			BEGIN
				SET @interSeparaG = 8
				SET @interLoop3 = 9
			END
			ELSE IF(@interVerificaG = 'C' OR @interVerificaG = 'D')
			BEGIN
				SET @interSeparaG = 4
				SET @interLoop3 = 13
			END
			WHILE (@interTime2 <= @interSeparaG)
			BEGIN
				SELECT @interSeparaG2 = codigoTimeG FROM grupos WHERE @interLoop3 = codigoGrupo
				INSERT INTO jogos VALUES (@interLoop1, @interTime1, @interSeparaG2, NULL, NULL, NULL)
				SET @interTime2 = @interTime2 + 1
				SET @interLoop1 = @interLoop1 + 1
				SET @interLoop3 = @interLoop3 + 1
			END
			SET @interTime2 = 1
			SET @interLoop2 = @interLoop2 + 1
		END
		EXEC sp_separa_datas @saida
		SET @saida = 'partidas criadas com sucesso'

DECLARE @out VARCHAR(40)
DELETE FROM jogos
EXEC sp_cria_partidas @out OUTPUT
PRINT @out

DELETE jogos

SELECT * FROM grupos
SELECT * FROM jogos
SELECT * FROM jogos ORDER BY data_jogo

CREATE TRIGGER t_grupos ON grupos
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	ROLLBACK TRANSACTION --Desfaz o último comando DML
	RAISERROR('Os grupos não podem ser inseridos, auterados e deletados', 16, 1)
END

CREATE TRIGGER t_times ON times
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	ROLLBACK TRANSACTION --Desfaz o último comando DML
	RAISERROR('Os times não podem ser inseridos, auterados e deletados', 16, 1)
END

CREATE TRIGGER t_jogos ON jogos
AFTER INSERT, DELETE
AS
BEGIN
	ROLLBACK TRANSACTION --Desfaz o último comando DML
	RAISERROR('Os jogos não podem ser inseridos e deletados', 16, 1)
END

DROP TRIGGER t_grupos
DISABLE TRIGGER t_grupos ON grupos
ENABLE TRIGGER t_grupos ON grupos

DROP TRIGGER t_times
DISABLE TRIGGER t_times ON times
ENABLE TRIGGER t_times ON times

DROP TRIGGER t_jogos
DISABLE TRIGGER t_jogos ON jogos
ENABLE TRIGGER t_jogos ON jogos

SELECT * FROM grupos
SELECT * FROM jogos
SELECT * FROM times

-- entra o nome do grupo

CREATE FUNCTION fn_grupo(@nome_grupo_e VARCHAR(1))
RETURNS @grupo TABLE(
nome_time				VARCHAR(80),
num_jogos_disputados	INT,
vitorias				INT,
empates					INT,
derrotas				INT,
gols_marcados			INT,
gols_sofridos			INT,
saldo_gols				INT,
pontos					INT
)
AS
BEGIN
	DECLARE @codigoJogo_e INT, @gols_m INT, @gols_s INT, @saldo_gols INT, @jogos_d INT, @gols_t1 INT, @gols_t2 INT,  @inter_t1 INT, @inter_t2 INT, @limite INT
	DECLARE @vitoria INT, @derrota INT, @empate INT, @interloop INT, @ponto INT, @interloop2 INT, @codigoGrupo INT, @nome_time_e VARCHAR (80)
	SET @interloop2 = 1
	SELECT @codigoJogo_e = codigoTimeG, @codigoGrupo = codigoGrupo FROM grupos WHERE  @nome_grupo_e = grupo
	WHILE(@interloop2 <= 4)
	BEGIN
		SET @gols_m = 0
		SET @gols_s = 0
		SET @interloop = 1
		SET @limite = 100
		SET @vitoria = 0
		SET @derrota = 0
		SET @empate = 0
		SET @ponto = 0
		SET @jogos_d = 0
		SET @inter_t1 = 0
		SET @inter_t2 = 0
		--pega o nome do time
		SELECT @nome_time_e = nomeTime FROM times WHERE @codigoJogo_e = codigoTime
		-- conta as vitorias, derrotas e os empates
		SELECT @inter_t1 = COUNT(codigoJogo) FROM jogos WHERE @codigoJogo_e = codigoTime1
		SELECT @inter_t2 = COUNT(codigoJogo) FROM jogos WHERE @codigoJogo_e = codigoTime2
		WHILE(@interloop <= @inter_t1)
		BEGIN
			SELECT @gols_t1 = golsTime1, @gols_t2 = golsTime2, @limite = codigoJogo FROM jogos WHERE @codigoJogo_e = codigoTime1 AND codigoJogo < @limite
			IF(@gols_t1 IS NOT NULL)
			BEGIN
				SET @jogos_d = @jogos_d + 1
			END
			IF(@gols_t1 > @gols_t2)
			BEGIN
				SET @vitoria = @vitoria + 1
			END
			ELSE IF (@gols_t1 < @gols_t2)
			BEGIN
				SET @derrota = @derrota + 1
			END
			ELSE IF (@gols_t1 = @gols_t2)
			BEGIN
				SET @empate = @empate + 1
			END
			SET @interloop = @interloop + 1
		END
		SET @interloop = 1
		SET @limite = 100
		WHILE(@interloop <= @inter_t2)
		BEGIN
			SELECT @gols_t1 = golsTime1, @gols_t2 = golsTime2, @limite = codigoJogo FROM jogos WHERE @codigoJogo_e = codigoTime2 AND codigoJogo < @limite
			-- conta o numero de jogos
			IF(@gols_t2 IS NOT NULL)
			BEGIN
				SET @jogos_d = @jogos_d + 1
			END
			IF(@gols_t1 < @gols_t2)
			BEGIN
				SET @vitoria = @vitoria + 1
			END
			ELSE IF (@gols_t1 > @gols_t2)
			BEGIN
				SET @derrota = @derrota + 1
			END
			ELSE IF (@gols_t1 = @gols_t2)
			BEGIN
				SET @empate = @empate + 1
			END
			SET @interloop = @interloop + 1
		END
		-- contagem de pontos
		SET @ponto = (@vitoria * 3) + @empate
		-- junta os gols marcados e os gols sofridos
		SELECT @gols_m = @gols_m + golsTime1 FROM jogos WHERE @codigoJogo_e = codigoTime1 AND golsTime1 IS NOT NULL
		SELECT @gols_s = @gols_s + golsTime2 FROM jogos WHERE @codigoJogo_e = codigoTime1 AND golsTime2 IS NOT NULL
		SELECT @gols_s = @gols_s + golsTime1 FROM jogos WHERE @codigoJogo_e = codigoTime2 AND golsTime1 IS NOT NULL
		SELECT @gols_m = @gols_m + golsTime2 FROM jogos WHERE @codigoJogo_e = codigoTime2 AND golsTime2 IS NOT NULL
		-- cria o saldo de gols
		SET @saldo_gols = @gols_m - @gols_s
		-- retorna
		INSERT INTO @grupo 
		SELECT @nome_time_e, @jogos_d, @vitoria, @empate, @derrota, @gols_m, @gols_s, @saldo_gols, @ponto
		SELECT @codigoJogo_e = codigoTimeG, @codigoGrupo = codigoGrupo FROM grupos WHERE  @nome_grupo_e = grupo AND codigoGrupo < @codigoGrupo
		SET @interloop2 = @interloop2 + 1
	END
	RETURN
END

UPDATE jogos SET golsTime1 = NULL
UPDATE jogos SET golsTime2 = NULL

DROP FUNCTION fn_grupo

SELECT * FROM jogos ORDER BY data_jogo, codigoJogo
SELECT * FROM dbo.fn_grupo('a') ORDER BY pontos DESC
SELECT * FROM dbo.fn_grupo('b') ORDER BY pontos DESC
SELECT * FROM dbo.fn_grupo('c') ORDER BY pontos DESC
SELECT * FROM dbo.fn_grupo('d') ORDER BY pontos DESC
SELECT codigoTime, nomeTime FROM times
SELECT * FROM grupos

DECLARE @out VARCHAR(100)
EXEC sp_insere_gols 1,2,4,2,3,4,1,3,'23/01/2022', @out OUTPUT
PRINT @out

CREATE FUNCTION fn_campeonato()
RETURNS @campeonato TABLE(
nome_time				VARCHAR(80),
num_jogos_disputados	INT,
vitorias				INT,
empates					INT,
derrotas				INT,
gols_marcados			INT,
gols_sofridos			INT,
saldo_gols				INT,
pontos					INT
)
AS
BEGIN
	INSERT INTO @campeonato
	SELECT * FROM dbo.fn_grupo('a')
	INSERT INTO @campeonato
	SELECT * FROM dbo.fn_grupo('b')
	INSERT INTO @campeonato
	SELECT * FROM dbo.fn_grupo('c')
	INSERT INTO @campeonato
	SELECT * FROM dbo.fn_grupo('d')
	RETURN
END

SELECT * FROM dbo.fn_campeonato() ORDER BY pontos DESC

CREATE FUNCTION fn_rebaixamento()
RETURNS @rebaixamento TABLE(
nomeTime	VARCHAR(30)
)
AS
BEGIN

	INSERT INTO @rebaixamento
	SELECT TOP 2 nome_time FROM dbo.fn_campeonato() ORDER BY pontos, saldo_gols ASC
	RETURN
END

SELECT * FROM dbo.fn_rebaixamento()

CREATE FUNCTION fn_quartas_final()
RETURNS @quartas_final TABLE(
nomeTime	VARCHAR(30)
)
AS
BEGIN

	INSERT INTO @quartas_final
	SELECT TOP 2 nome_time FROM dbo.fn_grupo('a')ORDER BY pontos DESC
	INSERT INTO @quartas_final
	SELECT TOP 2 nome_time FROM dbo.fn_grupo('b')ORDER BY pontos DESC
	INSERT INTO @quartas_final
	SELECT TOP 2 nome_time FROM dbo.fn_grupo('c')ORDER BY pontos DESC
	INSERT INTO @quartas_final
	SELECT TOP 2 nome_time FROM dbo.fn_grupo('d')ORDER BY pontos DESC

	RETURN
END

SELECT * FROM dbo.fn_quartas_final()


SELECT g.codigoGrupo, t.nomeTime, t.cidade, t.estadio, g.grupo FROM grupos g, times t WHERE g.codigoTimeG = t.codigoTime

SELECT g.codigoGrupo, t.nomeTime, t.cidade, t.estadio, g.grupo FROM grupos g, times t WHERE g.codigoTimeG = t.codigoTime AND g.grupo = 'A'
SELECT * FROM jogos ORDER BY data_jogo