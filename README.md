# marvel_comics

## O Projeto

O projeto consiste em consumir a API da Marvel, como solicitado no desafio, 
onde são obtidos os dados relacionados aos quadrinhos.


## Solução Adotada

No projeto foi usada a arquitetura MVC, sendo a solução que achei 
adequada para o projeto, pois com MVC o código fica mais organizado e 
também mais fácil de fazer novas implementações, por sua divisão em 
camadas.
Foi 
usado Provider para disponibilizar algumas informações em diversas telas. 
Async/Await para 
requisições assíncronas.

## Funcionamento do App
O aplicativo funciona da seguinte forma:

- Exibe uma listagem com os quadrinhos, podendo ser filtrado pelo título do 
  quadrinho em um campo na parte superior da listagem.
  
- O usuário clica no quadrinho, onde são mostradas duas opções: __adicionar ao 
  carrinho__ e __mostrar os detalhes do quadrinho__.
  - Ao __adicionar ao carrinho__ um ícone na AppBar irá indicar a quantidade de 
    quadrinhos adicionados no carrinho de compras.
    
  - Ao __mostrar detalhes do quadrinho__ será aberta uma tela com informações 
    adicionais sobre o mesmo.

- Ao clicar no ícone do carrinho na AppBar o usuário será levado para a tela 
  de __finalização de compras__.

- Na tela de __finalização de compras__ o usuário poderá esvaziar o carrinho ou 
  remover algum quadrinho.

- Para finalizar o usuário vai clicar no botão __Send Me__, onde será 
  solicitado o endereço para entrega. Será aberta uma tela do 
  Google Maps na qual o usuário pode selecionar no mapa a localização de 
  entrega ou digitar o endereço no campo de pesquisa.
  
## Instruções para executar o projeto
- Será necessário fazer um cadastro no site da Marvel para obter as chaves 
  para uso da [Marvel API](https://developer.marvel.com/).

- Criar um arquivo .env na raíz do projeto contendo API_KEY=Your public key 
  e PRIVATE_KEY=Your private key, obtidas no passo anterior.
  
- Para usar o google maps foi usado o pacote [Google Maps Flutter](https://pub.dev/packages/google_maps_flutter). Basta seguir as instruções 
  de uso mostradas no site.
  
- Abrir o projeto e ir até o arquivo android/app/src/main/AndroidManifest.xml e onde tem GOOGLE_API_KEY_HERE substitui pela chave do google, obtida 
  no passo anterior.
  
- No terminal ou na IDE executar o _flutter pub get_.

- Executar o projeto.
  
