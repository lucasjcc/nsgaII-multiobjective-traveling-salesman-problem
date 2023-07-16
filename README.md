# ALGORITMO GENÉTICO APLICADO AO PROBLEMA DO CAIXEIRO VIAJANTE MULTIOBJETIVO

## Nota inicial
Este trabalho foi desenvolvido e apresentado na disciplina de *Otimização Multiobjetivo* do Programa de Pós-Graduação em Engenharia Elétrica da Universidade Federal de Minas Gerais.

## Resumo
Apesar de fácil descrição, o Problema do Caixeiro Viajante apresenta um elevado grau de complexidade computacional. Devido à grande aplicabilidade dos conceitos envolvidos neste problema, algoritmos vêm sendo desenvolvidos com o intuito de solucioná-lo. Neste trabalho é desenvolvida uma metodologia de otimização multiobjetivo baseada no algoritmo genético NSGA-II, visando otimizar o problema. Posteriormente, é feita uma análise com o uso de indicadores para medir a qualidade destas soluções.

## Introdução
O problema matemático relacionado para o Problema do Caixeiro Viajante (PCV) foi tratado em 1857, pelo matemático irlandês Sir Willian Rowan Hamilton, que propôs um jogo montado sobre um dodecaedro, onde cada vértice estava associado a uma cidade importante da época, que denominou Around the World. O desafio proposto pelo jogo consistia em encontrar uma rota através dos vértices do dodecaedro que iniciasse e terminasse em uma mesma cidade sem nunca repetir uma visita. Uma solução, para jogo de Hamilton, passou a ser denominada de ciclo hamiltoniano, em sua homenagem.

O PCV tem sido muito utilizado no experimento de diversos métodos de otimização por ser, principalmente, um problema de fácil descrição e compreensão, grande dificuldade de solução, uma vez que é NP-Árduo, e larga aplicabilidade, com grande aplicação em problemas de transporte e logística, perfuração de placas de circuito impresso, revisão de motores de turbina a gás, cristalografia de raio-X, fiação de computadores, problema da ordem de coleta em armazéns, roteamento de veículos, dentre outros.

## Modelagem do problema do caixeiro viajante
Matematicamente, o PCV é descrito como um grafo $G = (V,E)$, onde $V = {1,...,n}$ é o conjunto dos vértices do grafo (cada um representando uma cidade) e $E = {(i,j)| i, j = 1,...,n}$ é um conjunto de arcos ligando esses vértices (representando um caminho entre pares de cidades). Associado a cada arco existe um custo(distância entre as cidades), tal que. A variável bináriasomente receberá o valor 1 se a aresta $(i,j) ∈ E$ for escolhida para pertencer ao tour, e 0 caso contrário O problema consiste na determinação de um caminho hamiltoniano de custo mínimo sobre G.

O PCV multiobjetivo consiste em um grafo $G = (V, E, w)$, onde $V$ é o conjunto de vértices, $E$ o conjunto de arestas e $w$ é uma função que atribui a cada aresta $(e_{ij} ∈ E)$ um vetor $(w_{ij}^{1},...,w_{ij}^{M})$. Cada elemento corresponde a um determinado peso, de métricas diferentes, por exemplo, distância e o tempo para uma aresta de um problema biobjetivo. 

O PVC proposto por este trabalho consistem encontrar o ciclo hamiltoniano que minimiza o tempo e a distância gastos para, saindo de uma cidade $x$, visitar outras 249 cidades e voltar a $x$.

<hr>

## Como rodar o projeto
O arquivo principal do projeto chama-se `NSGAII.m`. Para rodar o projeto, basta configurar as variáveis parâmetros dentro deste arquivo é chamá-lo no `prompt` de comando.

<hr>

## Detalhamento
Para maiores detalhes, basta acessar ao arquivo *pdf* presente na pasta arquivo deste projeto.
