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
      @boleto.cedente = Spree::Boleto::Config.preferred(:cedente)
      @boleto.documento_cedente = Spree::Boleto::Config.preferred(:documento_cedente)
      @boleto.sacado = order.name
      @boleto.sacado_documento = Spree::Boleto::Config.preferred(:sacado_documento)
      @boleto.valor = order.total
      @boleto.agencia = Spree::Boleto::Config.preferred(:agencia)
      @boleto.convenio = Spree::Boleto::Config.preferred(:convenio)
      @boleto.numero_documento = Spree::Boleto::Config.preferred(:numero_documento)
      @boleto.conta_corrente = Spree::Boleto::Config.preferred(:conta_corrente)
      @boleto.dias_vencimento = Spree::Boleto::Config.preferred(:dias_vencimento)
      @boleto.data_documento = Date.today
      @boleto.instrucao1 = Spree::Boleto::Config.preferred(:instrucao1)
      @boleto.instrucao2 = Spree::Boleto::Config.preferred(:instrucao2)
      @boleto.instrucao3 = Spree::Boleto::Config.preferred(:instrucao3)
      @boleto.instrucao4 = Spree::Boleto::Config.preferred(:instrucao4)
      @boleto.instrucao5 = Spree::Boleto::Config.preferred(:instrucao5)
      @boleto.instrucao6 = Spree::Boleto::Config.preferred(:instrucao6)
      @boleto.sacado_endereco = order.bill_address.full_address
      @boleto.vencimento_fixo = 1.days.from_now
      self.payload = @boleto
      self.document_number = @boleto.numero_documento
      self.status = "pending"
      save
      order.payment.pend
    end
    
    def actions
      %w{capture void}
    end

    def pending?
      status == "pending"
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
