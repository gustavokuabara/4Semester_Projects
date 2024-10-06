CREATE SCHEMA Musicmatic;
set search_path to Musicmatic;

create table usuario (
    cpf varchar(50) not null,
    idIndentificador int primary key,
    nome varchar(50) not null,
    email varchar(50) not null,
    rua varchar(50),
    numero int
);

create table artista (
    nome varchar(50) primary key,
    idade int not null,
    dataNascimento date not null
);

create table URL (
    linked varchar(50) primary key,
    nomeArtista varchar(50),
    foreign key (nomeArtista) references artista(nome) on update cascade on delete cascade
);

create table playlist (
    nomePlaylist varchar(50) primary key,
    IdUsuario int not null,
    descricao varchar(50),
    album varchar(50) not null,
	nomeArtista varchar(50),
    foreign key (IdUsuario) references usuario(idIndentificador) on update cascade on delete cascade,
	foreign key (nomeArtista) references artista(nome) on update cascade on delete cascade
);

create table album (
    nome varchar(50) primary key,
    numero int not null,
    IdUsuario int not null,
    numeroHit int not null,
	nomePlaylist varchar(50),
    foreign key (IdUsuario) references usuario(idIndentificador) on update cascade on delete cascade,
	foreign key (nomePlaylist) references playlist(nomePlaylist) on update cascade on delete cascade
);

create table musica (
    titulo varchar(50) primary key,
    ano int not null,
    genero varchar(50) not null,
    duracao float not null,
    nomeCriador varchar(50) not null,
    numeroDeVendas int,
    tipo varchar(50),
    foreign key (nomeCriador) references artista(nome) on update cascade on delete cascade
);

create table genero (
    IdUsuario int not null,
    nomePlaylist varchar(50),
    nomeGenero varchar(50) primary key,
    foreign key (IdUsuario) references usuario(idIndentificador) on update cascade on delete cascade,
    foreign key (nomePlaylist) references playlist(nomePlaylist) on update cascade on delete cascade
);

create table sons (
    IdUsuario int not null,
    nomePlaylist varchar(50) not null,
    titulo varchar(50) not null,
    nomeDoArtista varchar(50) not null,
    primary key (nomeDoArtista, titulo),
    foreign key (IdUsuario) references usuario(idIndentificador) on update cascade on delete cascade,
    foreign key (nomePlaylist) references playlist(nomePlaylist) on update cascade on delete cascade,
    foreign key (titulo) references musica(titulo) on update cascade on delete cascade,
    foreign key (nomeDoArtista) references artista(nome) on update cascade on delete cascade
);

create table estiloMusica (
    genero varchar(50),
    IdUsuario int,
    primary key (genero, IdUsuario),
    foreign key (genero) references genero(nomeGenero) on update cascade on delete cascade,
   	foreign key (IdUsuario) references usuario(idIndentificador) on update cascade on delete cascade
);

create table negocio (
    IdUsuario int primary key,
    CNPJ varchar(50) not null,
    foreign key (IdUsuario) references usuario(idIndentificador) on update cascade on delete cascade
);

create table hits (
    tituloMusica varchar(50) primary key,
    numero int not null,
    criador varchar(50) not null,
    foreign key (tituloMusica) references musica(titulo) on update cascade on delete cascade,
    foreign key (criador) references artista(nome) on update cascade on delete cascade
);

create table single (
    tituloMusica varchar(50) primary key,
    criador varchar(50) not null,
    foreign key (tituloMusica) references musica(titulo) on update cascade on delete cascade,
    foreign key (criador) references artista(nome) on update cascade on delete cascade
);

create table contem(
	titulo varchar(50) not null,
	idUsuario int not null,
	nomeplaylist varchar(50) not null,
	foreign key (titulo) references musica(titulo) on update cascade on delete cascade,
	foreign key (idUsuario) references usuario(IDindentificador) on update cascade on delete cascade,
	foreign key (nomePlaylist) references playlist(nomePlaylist) on update cascade on delete cascade
);

create table comprou(
	idusuario int not null,
	nomeMusica varchar(50) not null,
	foreign key(idusuario) references usuario(idIndentificador) on update cascade on delete cascade,
	foreign key(nomeMusica) references musica(titulo) on update cascade on delete cascade
);