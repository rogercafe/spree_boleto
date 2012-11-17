Spree::Order.class_eval do
  has_many :boleto_docs
  Spree::Order.state_machine.before_transition :to => :confirm,
                                               :do => :generate_boleto
  
  def payable_via_boleto?
    !!self.class.boleto_payment_method
  end
  
  def self.boleto_payment_method
    Spree::PaymentMethod.where(type: "Spree::PaymentMethod::BoletoMethod").first
  end

  def confirmation_required?
    true
  end

  def generate_boleto
    boleto_docs.first.proccess!
  end
end
