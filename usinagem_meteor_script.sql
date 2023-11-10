CREATE DATABASE usinagem_meteor;

USE usinagem_meteor;

DROP DATABASE usinagem_meteor;

CREATE TABLE pecas(
	pk_idPeca 		int PRIMARY KEY,
    descricao 		varchar(120) NOT NULL,
    material 		varchar(300) NOT NULL,
    peso 			decimal(4,2) NOT NULL,
    dimensoes		varchar(12) NOT NULL,
    unidade 		enum("mm", "cm", "m", "pol")
    -- CHECK(dimensoes LIKE"----/----/----")
);

CREATE TABLE endereco(
	pk_cep 		char(8) PRIMARY KEY,
    uf 			CHAR(2) NOT NULL,
    cidade 		VARCHAR(100) NOT NULL,
    nomeRua 	varchar(200)NOT NULL,
    bairro 		varchar(120) NOT NULL
);

CREATE TABLE fornecedores(
	pk_idFornecedor 	int PRIMARY KEY,
    fk_cep 				char(8) NOT NULL,
    numEndereco 		int NOT NULL,
    nome 				varchar(100) NOT NULL,
    numTelefone 		varchar(12) NOT NULL,
    cnpj 				char(14) NOT NULL,
    avaliacao 			decimal(1,1) NOT NULL
);

CREATE TABLE materiasPrimas(
	pk_idMateriaPrima 		int PRIMARY KEY,
    fk_idPeca 				int NOT NULL,
    fk_idFornecedor 		int NOT NULL,
    descMateriaPrima 		varchar(120) NOT NULL,
    qtdEstoque 				int NOT NULL,
    dataUltimaCompra 		date NOT NULL
);

CREATE TABLE inspecoes(
	pk_idInspecao 		int PRIMARY KEY,
    fk_idPeca 			int NOT NULL,
    dataInspecao 		date NOT NULL,
    observacoes 		varchar(500) NOT NULL,
    resultado			enum("Aceito", "Rejeitado")
);

CREATE TABLE clientes(
	pk_idCliente 	int PRIMARY KEY,
    fk_cep 			char(8) NOT NULL,
    numEndereco		int NOT NULL,
    nome 			varchar(120) NOT NULL,
    numTelefone 	varchar(12) NOT NULL
);

CREATE TABLE aceitacoes(
	pk_idAceitacao 		int PRIMARY KEY,
    fk_idPeca 			int NOT NULL,
    fk_idCliente		int NOT NULL,
    dataAceitacao 		date NOT NULL,
    observacoes 		varchar(500) NOT NULL
);

CREATE TABLE rejeicoes(
	pk_idRejeicao 		int PRIMARY KEY,
    fk_idPeca 			int NOT NULL,
    motivo 				varchar(500) NOT NULL,
    dataRejeicao 		date NOT NULL,
    acoesCorretivas 	varchar(500) NOT NULL
);

CREATE TABLE ordensDeProducao(
	pk_idOrdem 			int PRIMARY KEY,
    fk_idPeca 			int NOT NULL,
    qtdParaProduzir 	int NOT NULL,
    dataInicio 			date NOT NULL,
    dataConclusao 		date NOT NULL,
    statusOrdem 		enum("Em espera", "Em produção", "Concluído")
);

CREATE TABLE maquinas(
	pk_idMaquina 			int PRIMARY KEY,
    nome 					varchar(120) NOT NULL,
    descricao 				varchar(300) NOT NULL,
    capacidadeMaxima 		varchar(100) NOT NULL,
    -- unidade 				enum("Grama(s)", "Quilo(s)", "Tonelada(s)"),  // perguntar se isso é uma boa ideia ou não
    ultimaManutencao 		date NOT NULL
);

CREATE TABLE operadores(
	pk_idOperador 		int PRIMARY KEY,
    nome				varchar(120) NOT NULL,
    especializacao 		varchar(120) NOT NULL,
	disponibilidade 	enum("Manhã/Tarde", "Tarde/Noite")
);

CREATE TABLE equipamentos(
	pk_idEquipamento 		int PRIMARY KEY,
    nome 					varchar(120) NOT NULL,
    descricao 				varchar(300) NOT NULL,
    dataAquisicao 			date NOT NULL
);

CREATE TABLE manutencoesProgramadas(
	pk_idManutencao 	int PRIMARY KEY,
    fk_idEquipamento 	int NOT NULL,
    tipoManutencao		enum("Preventiva", "Corretiva", "Preditiva", "Prescritiva", "Detectiva", "Produtiva total"),
    dataProgramada 		date NOT NULL,
    responsavel 		varchar(120) NOT NULL
);

CREATE TABLE historicoManutencoes(
	pk_idManutencao 	int PRIMARY KEY,
    fk_idEquipamento 	int NOT NULL,
    tipoManutencao		enum("Preventiva", "Corretiva", "Preditiva", "Prescritiva", "Detectiva", "Produtiva total"),
    dataManutencao 		date NOT NULL,
    custosManutencao 	decimal(6,2) NOT NULL
);

CREATE TABLE historicoProducao(
	fk_idMaquina 		int NOT NULL,
    fk_idOperador 		int NOT NULL,
    fk_idEquipamento 	int NOT NULL
);