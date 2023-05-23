--USE MASTER;
--DROP DATABASE BDAbogadosAsoc;
CREATE DATABASE BDAbogadosAsoc;
GO
USE BDAbogadosAsoc;
GO
CREATE TABLE tblTIpoDoc
(strCod_TIDO VARCHAR(2) PRIMARY KEY NOT NULL,
 strDescripcion_TIDO varchar(25) not null);
 GO

 CREATE TABLE tblTIpoCAso
 (strCod_TICA VARCHAR(2) PRIMARY KEY NOT NULL,
 strDescripcion_TICA VARCHAR(25) NOT NULL);
 GO

 CREATE TABLE tblCLAsifTIpoCAso
 (intCod_CLAsTICA int PRIMARY KEY NOT NULL,
 strDescripcion_CLAsTICA VARCHAR(25) NOT NULL,
 strCodTICA VARCHAR(2) NOT NULL);
 GO

 CREATE TABLE tblASOciado
 (strNroDoc_ASO VARCHAR (25) PRIMARY KEY NOT NULL,
 strTipoDoc_ASO VARCHAR(2) NOT NULL,
 strNombre_ASO VARCHAR(60) NOT NULL,
 BITactivo_ASO BIT DEFAULT 1 NOT NULL);
 GO

 CREATE TABLE tblCLIente
 (strNroDoc_CLI VARCHAR(25) PRIMARY KEY NOT NULL,
 strTipoDoc_CLI VARCHAR(2) NOT NULL,
 strNombre_CLI VARCHAR(60) NOT NULL,
 strTelefono_CLI VARCHAR(20) NOT NULL);
 GO

 CREATE TABLE tblCASos
 (Id_CAS INT IDENTITY PRIMARY KEY NOT NULL,
 IdCLI_CAS VARCHAR(25) NOT NULL,
 IdASO_CAS VARCHAR(25) NOT NULL,
 dtmFecha_CAS DATETIME DEFAULT GETDATE() NOT NULL,
 intCodCLAsTICA_CAS int NOT NULL
 );
 GO

 CREATE TABLE tblCASos_DETalle
 (Id_CASDET INT IDENTITY PRIMARY KEY NOT NULL,
 IdCAS_CASDET INT NOT NULL,
 dtmFECHA_CASDET DATETIME DEFAULT GETDATE() NOT NULL,
 IdSEG_CASDET INT NOT NULL,
 strDescripcion_CASDET VARCHAR(4000) NOT NULL,
 strObservacion_CASDET VARCHAR(4000) NOT NULL);
 GO

 CREATE TABLE tblSEGuimientos
 (Id_SEG INT PRIMARY KEY NOT NULL,
 strDescripcion_SEG VARCHAR(20) NOT NULL);
 GO

 CREATE TABLE tblPreLIminares
 (Id_PLI INT PRIMARY KEY NOT NULL,
 strDescripcion_PLI VARCHAR(30) NOT NULL);
 GO

 CREATE TABLE tblPREliminares_CASo
 (Id_PRECAS INT IDENTITY PRIMARY KEY NOT NULL,
	IdCAS_PRECAS INT NOT NULL,
	IdPLI_PRECAS INT NOT NULL );
GO

ALTER TABLE tblASOciado ADD FOREIGN KEY (strTipoDoc_ASO) REFERENCES tblTIpoDOc(strCod_TIDO);
ALTER TABLE tblCLIente ADD FOREIGN KEY (strTipoDOC_CLI) REFERENCES tblTIpoDOc(strCod_TIDO);
ALTER TABLE tblCASos ADD FOREIGN KEY (IdCLI_CAS) REFERENCES tblCLIente(strNroDoc_CLI);
ALTER TABLE tblCASos ADD FOREIGN KEY (IdASO_CAS) REFERENCES tblASOciado(strNroDoc_ASO);
ALTER TABLE tblCASos ADD FOREIGN KEY (intCodCLAsTICA_CAS) REFERENCES tblCLAsifTIpoCAso(intCod_CLAsTICA);
ALTER TABLE tblCASos_DETalle ADD FOREIGN KEY (IdCAS_CASDET) REFERENCES tblCASos(Id_CAS);
ALTER TABLE tblCLAsifTIpoCAso ADD FOREIGN KEY (strCodTICA) REFERENCES tblTIpoCAso(strCod_TICA);
ALTER TABLE tblCASos_DETalle ADD FOREIGN KEY (IdSEG_CASDET) REFERENCES tblSEGuimientos(Id_SEG);
ALTER TABLE tblPREliminares_CASo ADD FOREIGN KEY (IdCAS_PRECAS) REFERENCES tblCASos(Id_CAS);
ALTER TABLE tblPREliminares_CASo ADD FOREIGN KEY (IdPLI_PRECAS) REFERENCES tblPreLIminares(Id_PLI);

INSERT INTO tblTIpoDOc VALUES ('CC','Cedula de Ciudadania'),('NI','NIT'),('NU','NUIP'),
	('RU', 'RUT'), ('CE','Cedula de Extranjeria'),('PA', 'Pasaporte'),
	('TI','Tarjeta de Identidad'), ('RC','Registro Civil');

INSERT INTO tblTIpoCAso VALUES ('CI','Civil'),('PE','Penal'),
	('CA','Contencioso/Admtivo'),('LA','Laboral');

INSERT INTO tblCLAsifTIpoCAso VALUES (1,'Separacion','CI'),(2,'Divorcio','CI'),(3,'Deuda','CI'),
	(4,'Danos y perjuicios','CI'), (5,'Falta de Pagos','CI'), (6,'Otro','CI'), (7,'Robo','PE'),
	(8,'Asesinato','PE'), (9,'Falsificacion','PE'), (10,'Trafico de Drogas','PE'),
	(11,'Peculado','PE'), (12,'Otro','PE'), (13,'Actos de Gestion','CA'),
	(14,'Actos de autoridad','CA'), (15,'Despido','LA'), (16,'Sanciones','LA'),
	(17,'Jubilacion','LA'), (18,'Orfandad','LA'), (19,'Acoso','LA'), (20,'Otro','LA');

INSERT INTO tblASOciado VALUES ('702040','CC','Beatriz Zuluaga Ramirez',1),
	('909090','CE','Robert Higgin Towers',1), ('702020','CC','Juan P. Cardona A.',1);

INSERT INTO tblCLIente VALUES ('70500600','CC','Maria Jose Tobon Lopez','317 4202020'),
	('800100100','NI','Almacenes Don Juaco Ltda','2303030');

INSERT INTO tblSEGuimientos VALUES (1,'Preambulo'),(2,'Indagacion'),
	(3,'Radicacion'), (4,'Consulta'), (5,'Recoleccion'), (6,'Juicio'), (7,'Cerrado');

INSERT INTO tblPreLIminares VALUES (1,'Llamada a Policia'),(2,'Denunciado'),
	(3,'Sospechosos Detenidos'),  (4,'Personas con Cargos');

GO

--=================Relacionada con: tblTIpoDOc======================
CREATE PROCEDURE USP_TIpoDOc_BuscarGeneral
AS
	BEGIN
		SELECT strCod_TIDO Clave, strDescripcion_TIDO AS Dato
		FROM tblTIpoDOc
	ORDER BY strDescripcion_TIDO
	END
	-- Exec USP_TIpoDOc_BuscarGeneral;
GO
--Exec USP_tblTIpoDOc_BuscarGeneral

--=================Relacionada con: tblASOciado=================
CREATE PROCEDURE USP_Asoc_BuscarGeneral
AS
	BEGIN
		SELECT strNroDoc_ASO AS NroDoc, strTipoDoc_ASO AS TipoDoc,
		strNombre_ASO AS Nombre, bitActivo_ASO AS Activo
		FROM tblASOciado
	ORDER BY Nombre
	--Exec USP_Asoc_BuscarGeneral;
	END
GO

CREATE PROCEDURE USP_Asoc_BuscarXcodigo
@strCodigo Varchar(20)
AS 
	BEGIN
	SELECT strNroDoc_ASO AS NroDoc, strTipoDoc_ASO AS TipoDoc,
		strNombre_ASO AS Nombre, bitActivo_ASO AS Activo
	FROM tblASOciado
	ORDER BY Nombre
	--EXEC USP_Asoc_BuscarXcodigo 702040;
	END
GO

CREATE PROCEDURE USP_Asoc_Grabar
@strCodigo VARCHAR(20),
@strTipo VARCHAR(2),
@strNombre VARCHAR(60),
@bitActivo Bit
AS
	BEGIN
	IF EXISTS (SELECT * FROM tblASOciado
			WHERE strNroDoc_ASO = @strCodigo OR
			  strNombre_ASO = @strNombre)
		BEGIN
			SELECT -1 AS Rpta
			RETURN
		END
	ELSE
		BEGIN
			BEGIN TRANSACTION tx
				INSERT INTO tblASOciado
					VALUES (@strCodigo, @strTipo, @strNombre, @bitActivo);
				IF (@@ERROR > 0)
					BEGIN
						ROLLBACK TRANSACTION tx
						SELECT 0 AS Rpta
						RETURN
					END
				COMMIT TRANSACTION tx
				SELECT @strCodigo AS Rpta
				RETURN
			END
		-- EXEC USP_Asoc_Grabar '70500600','CC','Juan Aristizabal',1;
		--EXEC USP_Asoc_BuscarXcodigo 70500600;
	END
GO

CREATE PROCEDURE USP_Asoc_Modificar
@strCodigo VARCHAR(20),
@strTipo VARCHAR(2),
@strNombre VARCHAR(60),
@bitActivo BIT
AS
	BEGIN
	IF EXISTS (SELECT * 
				FROM tblASOciado
			   WHERE strNroDoc_ASO <> @strCodigo AND
					 strNombre_ASO = @strNombre)
		BEGIN
			SELECT -1 AS Rpta
			RETURN
		END
	ELSE
		BEGIN
			BEGIN TRANSACTION tx
				UPDATE tblASOciado
					SET strTipoDoc_ASO = @strTipo,
						strNombre_ASO = @strNombre,
						BITactivo_ASO = @bitActivo
					WHERE strNroDoc_ASO = @strCodigo
				IF (@@ERROR > 0)
				BEGIN
					ROLLBACK TRANSACTION tx
					SELECT 0 AS Rpta
					RETURN
				END
				COMMIT TRANSACTION tx
				SELECT @strCodigo AS Rpta
				RETURN
			END
			-- EXEC USP_Asoc_Modificar '70500600','CE','Juan P. Aristizabal C.,1;
			-- EXEC USP_Asoc_BuscarXcodigo 70500600;
	END
GO

CREATE PROCEDURE USP_Asoc_LlenarCombo
AS
	BEGIN
		SELECT strNroDoc_ASO AS Clave, strNombre_ASO AS Dato
			FROM tblASOciado
		ORDER BY strNombre_ASO
		-- EXEC USP_Asoc_LlenarCombo;
	END
GO

--=================Relacionada con: tblTIpoCAso======================
CREATE PROCEDURE USP_TipoCaso_BuscarGeneral
AS
	BEGIN
		SELECT strCod_TICA AS Clave, strDescripcion_TICA AS Dato
			FROM tblTIpoCAso
		ORDER BY strDescripcion_TICA
		-- EXEC USP_TipoCaso_BuscarGeneral;
	END
GO

--=================Relacionada con: tblCLAsifTIpoCAso======================
CREATE PROCEDURE USP_tblCLAsifTIpoCAso_BuscarGeneral
@strCodigo VARCHAR(2)
AS
	BEGIN
	SELECT intCod_CLAsTICA AS Clave,
			strDescripcion_CLAsTICA AS Dato
		FROM tblCLAsifTIpoCAso
		WHERE strCodTICA = @strCodigo
	ORDER BY Clave ASC
	-- EXEC USP_tblCLAsifTIpoCAso_BuscarGeneral 'LA';
	END
GO

--=================Relacionada con: tblCLIente======================
CREATE PROCEDURE USP_Cliente_BuscarCliente
@strCodigo VARCHAR(20)
AS
	BEGIN
	SELECT strNombre_CLI  AS Cliente
		FROM tblCLIente
	WHERE strNroDoc_CLI = @strCodigo
	-- EXEC USP_Cliente_BuscarCliente 70500600;
	END
GO

--=================Relacionada con: tblCASos_DETalle======================
CREATE PROCEDURE USP_Caso_BuscarDetalle_X_Caso
@intCaso INT
AS 
BEGIN
	SELECT CONVERT (VARCHAR(12), dtmFecha_CASDET, 103) AS Fecha,
					Id_CASDET AS CodSeg,
					strDescripcion_SEG AS Seguimiento,
					strDescripcion_CASDET AS Descriopcion,
					strObservacion_CASDET AS Observacion
	FROM tblCASos_DETalle
		INNER JOIN tblSEGuimientos ON IdSEG_CASDET = Id_SEG
	WHERE IdCAS_CASDET = @intCaso
	-- EXEC USP_Caso_BuscarDetalle_X_Caso '1';
END
GO

CREATE PROCEDURE USP_Caso_GrabarDetalle
@IdCaso INT,
@IdSeg INT,
@Descripcion VARCHAR(4000),
@Observaciones VARCHAR(4000)
AS
BEGIN
	BEGIN TRANSACTION tx
		INSERT INTO tblCASos_DETalle (IdCAS_CASDET,
					IdSEG_CASDET, strDescripcion_CASDET,
					strObservacion_CASDET)
		VALUES (@IdCaso, @IdSeg, @Descripcion,@Observaciones);
		IF (@@ERROR >0)
			BEGIN
			ROLLBACK TRANSACTION tx
			SELECT 0 AS Rpta
			RETURN
			END
		COMMIT TRANSACTION tx
		SELECT @IdCaso AS Rpta
		RETURN
		-- EXEC USP_Caso_GrabarDetalle 1,1,'Posible asesinato',Por vengaza';
		-- EXEC USP_Caso_GrabarDetalle 1,2,'Consulta a testigos','a machete';
END
GO

CREATE PROCEDURE USP_Caso_BorrarDetalle
@intIdDet INT
AS
BEGIN TRANSACTION tx
	DELETE FROM tblCASos_DETalle
		WHERE Id_CASDET = @intIdDet;
	IF (@@ERROR > 0)
		BEGIN
			ROLLBACK TRANSACTION tx
			SELECT 0 AS Rpta
			RETURN
		END
	COMMIT TRANSACTION tx
	SELECT @intIdDet AS Rpta
	RETURN
	-- EXEC USP_Caso_BorrarDetalle
GO

--=================Relacionada con: tblCASos======================
CREATE PROCEDURE USP_CasoBuscarxCodigo
@intCaso INT
AS 
	BEGIN
	SELECT Id_CAS AS Cod,
		   CONVERT(VARCHAR(10),dtmFecha_CAS, 103) AS Fecha,
		   IdASO_CAS AS Asoc, IdCLI_CAS AS NroDoc,
		   strNombre_CLI AS Cliente,
		   strCod_TICA AS TipoCaso,
		   intCod_CLAsTICA AS TipoCAso_Caso
		FROM tblCASos
			INNER JOIN tblCLIente ON strNroDoc_CLI = IdCLI_CAS
			INNER JOIN tblCLAsifTIpoCAso ON intCod_CLAsTICA = intCod_CLAsTICA
			INNER JOIN tblTIpoCAso ON strCodTICA = strCod_TICA
		WHERE Id_CAS = @intCaso
		EXEC USP_Caso_BuscarDetalle_X_Caso @intCaso;
		--EXEC USP_CasoBuscarxCodigo 1;
	END
GO

CREATE PROCEDURE USP_Caso_Grabar
@IdCli VARCHAR(20),
@IdAsoc VARCHAR(20),
@intTipoCasoCaso INT
AS 
	BEGIN
		BEGIN TRANSACTION tx
			INSERT INTO tblCASos(IdCLI_CAS, IdASO_CAS,
						dtmFecha_CAS, intCodCLAsTICA_CAS)
				VALUES (@IdCli,@IdAsoc,GETDATE(),@intTipoCasoCaso);
			IF(@@ERROR > 0)
				BEGIN
					ROLLBACK TRANSACTION tx
					SELECT 0 AS Rpta
					RETURN
				END
			COMMIT TRANSACTION tx
			SELECT @@IDENTITY AS Rpta
			RETURN
			-- EXEC USP_Caso_Grabar '70500600','702020',8;
	END
GO

CREATE PROCEDURE USP_Caso_Modificar
@IdCodigo INT,
@IdAsoc VARCHAR(20),
@IdCliente VARCHAR(20),
@intTipoCasoCaso INT
AS 
	BEGIN
		BEGIN TRANSACTION tx
			UPDATE tblCASos
				SET IdCLI_CAS = @IdCliente,
					IdASO_CAS = @IdAsoc,
					intCodCLAsTICA_CAS = @intTipoCasoCaso
			WHERE Id_CAS = @IdCodigo
			DELETE FROM tblPREliminares_CASo
				WHERE IdCAS_PRECAS = @IdCodigo
			IF (@@ERROR > 0)
				BEGIN
					ROLLBACK TRANSACTION tx
					SELECT 0 AS Rpta
					RETURN
				END
			COMMIT TRANSACTION tx
			SELECT @IdCodigo AS Rpta
			RETURN
			-- EXEC USP_Caso_Modificar 1,'70500600','702020',9
	END
GO

CREATE PROCEDURE USP_Caso_BuscarCasos_X_Cliente
@strCodigo VARCHAR(20)
AS
	BEGIN
		SELECT Id_CAS AS Caso,
			   CONVERT(VARCHAR(10), dtmFecha_CAS,103) AS Fecha,
			   strDescripcion_TICA +'->'+
			   strDescripcion_CLAsTICA AS Tipo_Caso,
			   strNombre_ASO AS Abogado
			FROM tblCASos
				INNER JOIN tblASOciado ON strNroDoc_ASO = IdASO_CAS
				INNER JOIN tblCLAsifTIpoCAso ON intCodCLAsTICA_CAS = intCod_CLAsTICA
				INNER JOIN tblTIpoCAso ON strCodTICA = strCod_TICA
			WHERE IdCLI_CAS = @strCodigo
		ORDER BY Caso DESC
		-- EXEC USP_Caso_BuscarCasos_X_Cliente '70500600;
	END
GO

--=================Relacionada con: tblPreLiminares======================
CREATE PROCEDURE USP_Preliminares_BuscarGeneral
AS
	BEGIN
		SELECT Id_PLi AS Clave, strDescripcion_PLI AS Dato
			FROM tblPreLIminares
		ORDER BY Clave
	-- EXEC USP_Preliminares_BuscarGeneral;
	END
GO

--=================Relacionada con: tblPREliminares_CASo======================
CREATE PROCEDURE USP_Caso_GrabarPreliminares
@IdCaso INT,
@IdPreliminar INT
AS 
	BEGIN
		INSERT INTO tblPREliminares_CASo
			(IdCAS_PRECAS,IdPLI_PRECAS)
		VALUES (@IdCaso,@IdPreliminar)
		IF (@@ERROR > 0)
			BEGIN
				ROLLBACK TRANSACTION tx
			END
		COMMIT TRANSACTION tx
		RETURN
		-- EXEC USP_Caso_GrabarPreliminares 1,2;
		-- EXEC USP_Caso_GrabarPreliminares 1,4;
	END
GO

CREATE PROCEDURE USP_Preliminares_X_caso
@IdCaso INT
AS
	BEGIN
		SELECT IdPLI_PRECAS AS Clave
			FROM tblPREliminares_CASo
		WHERE IdCAS_PRECAS = @IdCaso
		ORDER BY Clave ASC
		-- EXEC USP_Preliminares_X_caso 3;
	END
GO

CREATE PROCEDURE USP_Caso_BuscarInicialesXCodigo
@intCaso INT
AS
	BEGIN
		SELECT Id_PRECAS IdCasoPreli, IdPLI_PRECAS IdPrelim
			FROM tblPREliminares_CASo
		WHERE IdCAS_PRECAS = @intCaso
		-- EXEC USP_Caso_BuscarInicialesXCodigo 3;
	END
GO

--=================Relacionada con: tblPREliminares_CASo======================
CREATE PROCEDURE USP_Seguimiento_BuscarGeneral
AS
	BEGIN
		SELECT Id_SEG AS Clave, strDescripcion_SEG AS Dato
			FROM tblSEGuimientos
		ORDER BY Id_SEG
	-- EXEC USP_Seguimiento_BuscarGeneral;
	END
GO