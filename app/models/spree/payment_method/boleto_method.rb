# encoding:utf-8
module Spree
  class PaymentMethod::BoletoMethod < PaymentMethod
    
    FORMATS={
      'pdf' => 'application/pdf',
      'jpg' => 'image/jpg',
      'tif' => 'image/tiff',
      'png' => 'image/png'
    }
    
    def payment_source_class
      Spree::BoletoDoc
    end

    def authorize amount, source, gateway_options
      logger.debug("Authorizing Payment: amount => #{amount}, source => #{source}, gateway_options => #{gateway_options}")
      Spree::Response.new(true, "Boletos são autorizados automaticamente")
    end
  end

  class Response
      attr_reader :params, :message, :test, :authorization, :avs_result, :cvv_result

      def success?
        @success
      end

      def test?
        @test
      end

      def fraud_review?
        @fraud_review
      end

      def initialize(success, message, params = {}, options = {})
        @success, @message, @params = success, message, params.stringify_keys
        @test = options[:test] || false
        @authorization = options[:authorization]
        @fraud_review = options[:fraud_review]
      end
    end

end
