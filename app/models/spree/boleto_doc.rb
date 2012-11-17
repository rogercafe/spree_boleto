#encoding: utf-8
module Spree
  class BoletoDoc < ActiveRecord::Base
    # status: issued, cancelled, paid
    serialize :payload
    has_one :payment, :as => :source
    belongs_to :order

    attr_accessible :vencimento_fixo, :state, :order_id, :order
    
    [:pending, :cancelled, :paid].each do |state|
      scope state, where("status = ?", state.to_s)
    end
    scope :active, where("status != ?", "cancelled")

    def proccess!
      @boleto = Brcobranca::Boleto::Bradesco.new
      @boleto.cedente = "Nome loja" 
      @boleto.documento_cedente = "12345678912"
      @boleto.sacado = order.name
      @boleto.sacado_documento = "12345678900"
      @boleto.valor = order.payment_total
      @boleto.agencia = "4042"
      @boleto.convenio = "1238798"
      @boleto.numero_documento = "102008"
      @boleto.conta_corrente = "61900"
      @boleto.dias_vencimento = 5
      @boleto.data_documento = Date.today
      @boleto.instrucao1 = "Pagável na rede bancária até a data de vencimento."
      @boleto.instrucao2 = "Juros de mora de 2.0% mensal(R$ 0,09 ao dia)"
      @boleto.instrucao3 = "DESCONTO DE R$ 29,50 APÓS 05/11/2006 ATÉ 15/11/2006"
      @boleto.instrucao4 = "NÃO RECEBER APÓS 15/11/2006"
      @boleto.instrucao5 = "Após vencimento pagável somente nas agências do Banco do Brasil"
      @boleto.instrucao6 = "ACRESCER R$ 4,00 REFERENTE AO BOLETO BANCÁRIO"
      @boleto.sacado_endereco = order.bill_address.full_address
      @boleto.vencimento_fixo = due_date
      self.payload = @boleto
      self.document_number = @boleto.numero_documento
      save
      #payment.pend
    end
    
    def actions
      %w{capture void}
    end

    # Indicates whether its possible to capture the payment
    def can_capture?(payment)
      ['processing', 'checkout', 'pending'].include?(payment.state)
    end

    # Indicates whether its possible to void the payment.
    def can_void?(payment)
      payment.state != 'void'
    end

    def capture(payment)
      update_attribute(:status, "paid")
      payment.complete
      true
    end

    def void(payment)
      update_attribute(:status, "cancelled")
      payment.void
      true
    end
  end
end
