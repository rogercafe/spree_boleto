Spree::CheckoutController.class_eval do
  alias_method :original_object_params, :object_params
  
  
  def object_params
    if @order.payment?
      return original_object_params unless params[:order][:payments_attributes].first[:payment_method_id].to_i == Spree::Order.boleto_payment_method.id
      instalments = 1
      instalment_amount = (@order.total/instalments.to_i)
      payment_method_id = params[:order][:payments_attributes].first[:payment_method_id]
      params[:order][:payments_attributes] = []
      acc_amount = 0.to_f
      instalments.times do |index|
        amount = (index+1) == instalments ? (@order.total-acc_amount).to_f : instalment_amount
        amount = amount.round(2)
        acc_amount += amount
        params[:order][:payments_attributes] << {
          :payment_method_id => payment_method_id, 
          :amount => amount, 
          :state => "pending",
          :source_attributes => {
            :order_id => @order.id,
            :due_date => Date.today + index.month + 3,
            :amount => amount,
            :status => "pending"
          }
        }
        boleto = Spree::BoletoDoc.new
        boleto.process! @order.payment
      end
    end
    params[:order].delete(:state)
    params[:order]
  end
end

