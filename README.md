# Spree Boleto

Uma extensão do [Spree](http://spreecommerce.com) para permitir pagamentos utilizando boletos.
Meu fork do codigo original visa habilitar pagamento à vista usando boleto.
Por enquanto está sendo gerado apenas boleto do Bradesco, mas esse boleto *ainda não foi homologado*

## Code Climate
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/rogercafe/spree_boleto)

## Instalação

Adicione spree ao gemfile da sua aplicação, e também:
    gem 'spree_boleto', :git => 'git://github.com/rogercafe/spree_boleto.git'

Rode a task de instalação:

    rails generate spree_boleto:install
	
## Configuração
	
Após feita a instalação e migração, acesse a administração do spree, vá em Configuração -> Métodos de Pagamento e adicione um novo método selecionando `Spree::PaymentMethod::BoletoMethod`.

Essa extensão possui as seguintes preferencias na acessíveis através de Spree::Boleto::Config :

 * cedente
 * documento_cedente
 * sacado_documento
 * agencia
 * convenio
 * numero_documento
 * conta_corrente
 * dias_vencimento
 * instrucao1
 * instrucao2
 * instrucao3
 * instrucao4
 * instrucao5
 * instrucao6
    
## TODO
    - Preencher essa lista


## Contribuindo

Caso queira contribuir, faça um fork desta gem no [github](https://github.com/angelim/spree_boleto), corriga o bug/ adicione a feature desejada e faça um merge request.

## Sobre

Desenvolvida por [Alexandre Angelim](mailto:angelim@angelim.com.br)
Baseado no desenvolvimento de: [Stefano Diem Benatti](mailto:stefano@heavenstudio.com.br)
