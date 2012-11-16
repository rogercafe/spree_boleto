# Spree Boleto

Uma extensão do [Spree](http://spreecommerce.com) para permitir pagamentos utilizando boletos.

Este é um trabalho em estágio inicial de desenvolvimento e ainda não funcional.
Meu fork do codigo original visa habilitar pagamento a vista usando boleto.

## Code Climate
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/rogercafe/spree_boleto)

## Instalação

Adicione spree ao gemfile da sua aplicação, e também:
    gem 'spree_boleto', :git => 'git://github.com/rogercafe/spree_boleto.git'

Rode a task de instalação:

    rails generate spree_boleto:install
	
## Configuração
	
Após feita a instalação e migração, acesse a administração do spree, vá em Configuração -> Métodos de Pagamento e adicione um novo método selecionando `Spree::PaymentMethod::BoletoMethod`.
    
## TODO
    - Preencher essa lista


## Contribuindo

Caso queira contribuir, faça um fork desta gem no [github](https://github.com/angelim/spree_boleto), corriga o bug/ adicione a feature desejada e faça um merge request.

## Sobre

Desenvolvida por [Alexandre Angelim](mailto:angelim@angelim.com.br)
Baseado no desenvolvimento de: [Stefano Diem Benatti](mailto:stefano@heavenstudio.com.br)
