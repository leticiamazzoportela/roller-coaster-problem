# The Roller Coaster Problem

Este repósito apresenta a implementação do problema "Roller Coaster Problem" usando a linguagem Swift.

### Descrição do problema

Suponha que haja *n* passageiros em um carro de montanha-russa. Os passageiros esperam repetidamente para andar no carro, que pode acomodar no máximo *C* passageiros, onde *C < n*, no entanto, o carro pode percorrer a pista apenas quando estiver cheio. Depois de terminar um passeio, cada passageiro anda pelo parque de diversões antes de retornar à montanha-russa para andar no carro novamente. Além disso, por razões de segurança, o carro monta apenas *T* vezes e depois dispara.

Sendo assim, sabe-se o seguinte:

* O carro sempre anda com exatamente *C* passageiros;
* Nenhum passageiro pulará do carro enquanto ele estiver funcionando;
* Nenhum passageiro pulará no carro enquanto o carro estiver funcionando;
* Nenhum passageiro solicitará outra carona antes que possa descer do carro

### Implementação

A implementação feita em Swift usa um semáforo para o carrinho, o qual é limitado por uma determinada quantidade de threads. Para cada passageiro do parque é disparada uma thread, e quando os assentos disponíveis do carrinho esgotam, o carrinho começa a andar. Após um certo tempo, os passageiros são liberados do carrinho.

Caso a quantidade de passageiros querendo andar no carrinho seja superior à capacidade do carrinho, esses passageiros vão para uma fila de espera, então, caso o limite de voltas por dia do carrinho não tenha sido atingido e, além disso, o número de passageiros na fila seja igual ou superior à capacidade do carrinho, então o carrinho iniciará uma nova volta.

A quantidade de passageiros no parque é gerada de forma aleatória toda vez que a montanha-russa inicia sua operação.

### Instruções de execução

O código pode ser executado pelo Xcode, através da criação de um playground. Caso não haja um mac para usar o Xcode, o código pode ser executado pelo site <https://repl.it/languages/swift>. Basta colocar o código lá e, após fechar a classe, instanciá-la da seguinte forma:

```
RollerCoaster().initRollerCoaster()
```
