-- 1.Selecione todas as peças produzidas na última semana.
SELECT
	maquinas.nome,
    SUM(ordem.qtdParaProduzir)
FROM
	pecas
JOIN
	ordensDeProducao AS ordem
ON
	pecas.pk_idPeca = ordem.fk_idPeca
JOIN
	historicoProducao AS historico
ON
	ordem.pk_idOrdem = historico.fk_idOrdem
JOIN
	maquinas
ON 
	historico.fk_idMaquina = maquinas.pk_idMaquina
WHERE
	statusOrdem = "Concluído"
GROUP BY
	maquinas.nome;

-- 3.Liste todas as manutenções programadas para este mês.
SELECT
	*
FROM
	manutencoesProgramadas
WHERE
	month(dataProgramada) = 12;

-- 4.Encontre os operadores que estiveram envolvidos na produção de uma peça específica.
SELECT
	operadores.nome,
    pecas.descricao
FROM
	pecas
JOIN
	ordensDeProducao AS ordem
ON
	pecas.pk_idPeca = ordem.fk_idPeca
JOIN
	historicoProducao AS historico
ON
	ordem.pk_idOrdem = historico.fk_idOrdem
JOIN
	operadores
ON
	historico.fk_idOperador = operadores.pk_idOperador
WHERE
	pecas.descricao = "Mangote flexível";

-- 5.Classifique as peças por peso em ordem decrescente.
SELECT
	descricao,
	CASE
		WHEN pesoUnidade = 'Ton' THEN pesoNum * 1000
        WHEN pesoUnidade = 'g' THEN pesoNum /1000
        WHEN pesoUnidade = 'kg' THEN pesoNum  
    END AS pesoKG
FROM
	pecas
ORDER BY
	pesoKG DESC;

-- 6.Encontre  a  quantidade  total  de  peças  rejeitadas  em  um  determinado período.
SELECT * FROM rejeicoes order by dataRejeicao asc;
SELECT
	COUNT(pk_idPeca) AS qtdPecasRejeitadas
FROM
	pecas
JOIN
	rejeicoes
ON
	pecas.pk_idPeca = rejeicoes.fk_idPeca
WHERE
	rejeicoes.dataRejeicao BETWEEN "2023-07-01" AND "2023-09-30";

-- 7.Liste os fornecedores de matérias-primas em ordem alfabética.
SELECT
	nome
FROM
	fornecedores
ORDER BY
	nome;

-- 8.Encontre o número total de peças produzidas por tipo de material.
SELECT
	material,
    COUNT(descricao) AS totalProduzido
FROM
	pecas
GROUP BY
	material;

-- 9.Selecione as matérias-primas que estão abaixo do nível mínimo de estoque.
SELECT
	pk_idMateriaPrima,
    fk_idFornecedor,
    descMateriaPrima,
    qtdEstoque
FROM
	materiasPrimas
WHERE
	qtdEstoque < 100;

-- 10.Liste  as  máquinas  que  não  passaram  por  manutenção  nos  últimos  três meses.
SELECT month(curdate());
SELECT
	*
FROM
	maquinas
WHERE
	ultimaManutencao < curdate() - interval 3 month;

-- 11.Encontre a média de tempo de produção por tipo de peça. -- falar com o professor
SELECT
	*
FROM
	pecas
JOIN
	ordensDeProducao AS ordem
ON
	pecas.pk_idPeca = ordem.fk_idPeca;

-- 12.Identifique as peças que passaram por inspeção nos últimos sete dias.
SELECT
	*
FROM
	inspecoes
WHERE
	dataInspecao > curdate() - interval 7 day; -- pode aumentar para 30 dias de intervalo para fim de teste

-- 13.Encontre  os  operadores  mais  produtivos  com  base  na  quantidade  de peças produzidas.
SELECT
	operadores.nome,
    SUM(qtdParaProduzir) AS quantidadeProduzida
FROM
	operadores
JOIN
	historicoProducao AS hist
ON
	operadores.pk_idOperador = hist.fk_idOperador
JOIN
	ordensDeProducao AS ordem
ON
	hist.fk_idOrdem = ordem.pk_idOrdem
GROUP BY
	operadores.nome
ORDER BY
	quantidadeProduzida DESC
LIMIT 5;

-- 14.Liste as peças produzidas em um determinado período com detalhes de data e quantidade.
SELECT
	pecas.descricao AS nome,
    qtdParaProduzir AS qtdProduzida,
    dataInicio,
    dataConclusao
FROM
	pecas
JOIN
	ordensDeProducao AS ordem
ON
	pecas.pk_idPeca = ordem.fk_idPeca
WHERE
	dataInicio = "2023-01-23" AND dataConclusao = "2023-06-05";

-- 15.Identifique os fornecedores com as entregas mais frequentes de matérias-primas. -- falar com o professor
SELECT
	*
FROM
	fornecedores
JOIN
	materiasPrimas AS materia
ON
	fornecedores.pk_idFornecedor = materia.fk_idFornecedor;

-- 16.Encontre o número total de peças produzidas por cada operador.
SELECT
	operadores.nome,
    SUM(qtdParaProduzir) AS quantidadeProduzida
FROM
	operadores
JOIN
	historicoProducao AS hist
ON
	operadores.pk_idOperador = hist.fk_idOperador
JOIN
	ordensDeProducao AS ordem
ON
	hist.fk_idOrdem = ordem.pk_idOrdem
GROUP BY
	operadores.nome;

-- 17.Liste as peças que passaram por inspeção e foram aceitas.
SELECT
	pecas.descricao AS nome,
    aceitacoes.dataAceitacao,
    aceitacoes.observacoes
FROM
	pecas
JOIN
	aceitacoes
ON
	pecas.pk_idPeca = aceitacoes.fk_idPeca;

-- 18.Encontre  as  manutenções  programadas  para  as  máquinas  no  próximo mês.
SELECT
	*
FROM
	manutencoesProgramadas
WHERE
	year(dataProgramada) = year(curdate()) AND month(dataProgramada) = month(curdate()) + 1;

-- 19.Calcule o custo total das manutenções realizadas no último trimestre.
SELECT
	dataManutencao,
    SUM(custosManutencao) AS custoTotal
FROM
	historicoManutencoes
WHERE
	dataManutencao > curdate() - interval 3 month
GROUP BY
	dataManutencao;

-- 20.Identifique  as  peças  produzidas  com  mais  de  10%  de  rejeições  nos últimos dois meses. -- falar com o professor
SELECT
	*
FROM
	rejeicoes
order by
	fk_idPeca