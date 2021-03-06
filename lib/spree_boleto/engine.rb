module Spree
  module Boleto
    class Engine < Rails::Engine
      engine_name 'spree_boleto'
    
      initializer "spree.register.boleto_method", after: "spree.register.payment_methods" do |app|
        app.config.spree.payment_methods << Spree::PaymentMethod::BoletoMethod
      end

      initializer "spree.spree_boleto.preferences", :after => "spree.environment" do |app|
        Spree::Boleto::Config = Spree::SpreeBoletoConfiguration.new
      end
          
      config.autoload_paths += %W(#{config.root}/lib)
    
      # use rspec for tests
      config.generators do |g|
        g.test_framework :rspec
      end
    
      def self.activate
        Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
          Rails.configuration.cache_classes ? require(c) : load(c)
        end
      end
    
      config.to_prepare &method(:activate).to_proc
    end
  end
end
