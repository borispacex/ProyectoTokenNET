CREATE DATABASE dbprueba;

USE dbprueba;

CREATE TABLE Usuario(
	IdUsuario int primary key identity,
	NombreUsuario varchar(20),
	Clave varchar(20)
);

INSERT INTO Usuario(NombreUsuario, Clave) VALUES
('admin', 'admin');

SELECT * FROM Usuario;

-- PARA EL REFRESHTOKEN
CREATE TABLE HistorialRefreshToken(
	IdHistorialToken int primary key identity,
	idUsuario int references Usuario(IdUsuario),
	Token varchar(500),
	RefreshToken varchar(200),
	FechaCreacion datetime,
	FechaExpiracion datetime,
	EsActivo AS ( iif(FechaExpiracion < getdate(), convert(bit,0), convert(bit,1)) ) --columna calculada

);