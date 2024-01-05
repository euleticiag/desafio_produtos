# desafio : loja que vende produtos
# autor : letícia nascimento 
    
# descrição do desafio:
# Listar todos os produtos que foram vendidos mais de 10 vezes nos últimos 30 dias.
#Calcular o valor total das vendas para cada produto.
#Ordenar os resultados pelo valor total de vendas em ordem decrescente.

use leleserv;

#criando as tabelas e inserindo os dados

CREATE TABLE Produtos (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(50),
    preco DECIMAL(10, 2),
    quantidade_em_estoque INT
);

INSERT INTO Produtos VALUES
(1, 'Produto A', 20.0, 50),
(2, 'Produto B', 15.0, 30),
(3, 'Produto C', 25.0, 40);

CREATE TABLE Vendas (
    id_venda INT PRIMARY KEY,
    data DATE,
    id_produto INT,
    quantidade INT,
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

INSERT INTO Vendas VALUES
(1, '2023-12-01', 1, 5),
(2, '2023-12-02', 2, 8),
(3, '2023-12-05', 1, 12),
(4, '2023-12-10', 3, 15),
(5, '2023-12-15', 2, 10);

#desafio 1: listar todos os produtos que foram vendidos mais de 10 vezes nos últimos 30 dias

SELECT p.id_produto, p.nome, COUNT(v.id_venda) AS total_vendas
FROM Produtos p
JOIN Vendas v ON p.id_produto = v.id_produto
WHERE v.data >= CURDATE() - INTERVAL 30 DAY
GROUP BY p.id_produto, p.nome
HAVING total_vendas > 10;

# desafio 2: calcular o valor total das vendas para cada produto

SELECT p.id_produto, p.nome, SUM(p.preco * v.quantidade) AS valor_total_vendas
FROM Produtos p
JOIN Vendas v ON p.id_produto = v.id_produto
GROUP BY p.id_produto, p.nome;

# desafio 3: ordenar os resultados pelo valor total de vendas em ordem decrescente

SELECT p.id_produto, p.nome, SUM(p.preco * v.quantidade) AS valor_total_vendas
FROM Produtos p
JOIN Vendas v ON p.id_produto = v.id_produto
GROUP BY p.id_produto, p.nome
ORDER BY valor_total_vendas DESC;

