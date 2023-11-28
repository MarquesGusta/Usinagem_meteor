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
-- 7.Liste os fornecedores de matérias-primas em ordem alfabética.
-- 8.Encontre o número total de peças produzidas por tipo de material.
-- 9.Selecione as peças que estão abaixo do nível mínimo de estoque.
-- 10.Liste  as  máquinas  que  não  passaram  por  manutenção  nos  últimos  três meses.
-- 11.Encontre a média de tempo de produção por tipo de peça.
-- 12.Identifique as peças que passaram por inspeção nos últimos sete dias.
-- 13.Encontre  os  operadores  mais  produtivos  com  base  na  quantidade  de peças produzidas.
-- 14.Liste as peças produzidas em um determinado período com detalhes de data e quantidade.
-- 15.Identifique os fornecedores com as entregas mais frequentes de matérias-primas.
-- 16.Encontre o número total de peças produzidas por cada operador.
-- 17.Liste as peças que passaram por inspeção e foram aceitas.
-- 18.Encontre  as  manutenções  programadas  para  as  máquinas  no  próximo mês.
-- 19.Calcule o custo total das manutenções realizadas no último trimestre.
-- 20.Identifique  as  peças  produzidas  com  mais  de  10%  de  rejeições  nos últimos dois meses.