#encoding: utf-8
class Spree::SpreeBoletoConfiguration < Spree::Preferences::Configuration
  preference :cedente, :string, :default => "Nome loja" 
  preference :documento_cedente, :string, :default => "12345678912"
  preference :sacado_documento, :string, :default  =>"12345678900"
  preference :agencia, :string, :default  =>"4042"
  preference :convenio, :string, :default  =>"1238798"
  preference :numero_documento, :string, :default  =>"102008"
  preference :conta_corrente, :string, :default  =>"61900"
  preference :dias_vencimento, :integer, :default  =>5
  preference :instrucao1, :string, :default  =>"Pagável na rede bancária até a data de vencimento."
  preference :instrucao2, :string, :default  =>"Juros de mora de 2.0% mensal(R$ 0,09 ao dia)"
  preference :instrucao3, :string, :default  =>"DESCONTO DE R$ 29,50 APÓS 05/11/2006 ATÉ 15/11/2006"
  preference :instrucao4, :string, :default  =>"NÃO RECEBER APÓS 15/11/2006"
  preference :instrucao5, :string, :default  =>"Após vencimento pagável somente nas agências do Banco do Brasil"
  preference :instrucao6, :string, :default  =>"ACRESCER R$ 4,00 REFERENTE AO BOLETO BANCÁRIO"
end
