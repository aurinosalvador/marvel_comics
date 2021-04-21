# marvel_comics

## O Projeto

O projeto consistem em consumir a API da Marvel, como solicitada no desafio, 
onde obtemos as informações relacionadas aos quadrinhos.


## Solução Adotada

No projeto foi usada a arquitetura MVC, pois foi a solução que achei mais 
adequada para o projeto, caso seja preciso fazer alterações será mais 
simples, pois está divido em camadas. Foi usado Provider para disponibilizar algumas informações nas variadas telas, Async/Await para 
requisições assíncronas.

## Funcionamento do App
O aplicativo funciona da seguinte forma:

- Exibe uma Listagem com os Quadrinhos, podendo ser filtrado pelo título do 
  quadrinho em um campo na parte superior da listagem.
  
- O usuário clica no quadrinho, onde é mostrada duas opções: Adicionar ao 
  carrinho e Mostrar os detalhes do quadrinho.
  - Ao Adicionar ao carrinho um ícone na AppBar irá indicar a quantidade de 
    quadrinhos adicionados no carrinho de compras.
    
  - Ao Mostrar detalhes do quadrinho será aberta uma tela com informações 
    adicionais sobre o mesmo.

- Ao clicar no ícone do carrinho na AppBar o usuário será levado para a tela 
  de Finalização de compras.

- Na tela de Finalização de compra o usuário poderá esvaziar o carrinho ou 
  remover algum quadrinho, assim como desejar.

- Para finalizar o usuário vai clicar no botão "Send Me", onde será 
  solicitado ao utilizador o endereço para entrega, será aberta uma tela do 
  Google maps onde o usuário pode selecionar no mapa a localização de 
  entrega ou digitar o seu endereço num campo de pesquisa.
  
## Instruções para executar o projeto
- Será necessário fazer um cadastro no site da Marvel para obter as chaves 
  para uso da [Marvel API](https://developer.marvel.com/).

- Criar um arquivo .env na raíz do projeto contendo API_KEY=Your public key 
  e PRIVATE_KEY=Your private key, obtidas no passo anterior.
  
- Para usar o google maps foi usado o pacote [Google Maps Flutter]
  (https://pub.dev/packages/google_maps_flutter). Basta seguir as instruções 
  de uso mostradas no site.
  
- Abrir o projeto e ir até o arquivo android/app/src/main/AndroidManifest.xml e onde tem GOOGLE_API_KEY_HERE substitui pela chave do google, obtida 
  no passo anterior.

- Executar o projeto.
  
