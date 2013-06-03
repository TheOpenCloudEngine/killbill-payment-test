require 'date'

require 'killbill/payment'

module PaymentTest
  class PaymentPlugin < Killbill::Plugin::Payment


    def start_plugin
      super
    end

    def initialize(*args)
      @raise_exception = false
      super(*args)
    end

    def get_name
    end

    def process_payment(kb_account_id, kb_payment_id, kb_payment_method_id, amount_in_cents, currency, call_context, options = {})
      # Make an API call from the payment call
      account = @kb_apis.get_account_by_id(kb_account_id)
      puts "process_payment got ACCOUNT #{account.inspect}"
      Killbill::Plugin::Model::PaymentInfoPlugin.new(amount_in_cents, DateTime.now, DateTime.now, Killbill::Plugin::Model::PaymentPluginStatus.new(:PROCESSED), "gateway_error", "gateway_error_code", nil, nil)
    end

    def get_payment_info(kb_account_id, kb_payment_id, tenant_context, options = {})
        Killbill::Plugin::Model::PaymentInfoPlugin.new(0, DateTime.now, DateTime.now, Killbill::Plugin::Model::PaymentPluginStatus.new(:PROCESSED), "gateway_error", "gateway_error_code", nil, nil)
    end

    def process_refund(kb_account_id, kb_payment_id, amount_in_cents, currency, call_context, options = {})
      Killbill::Plugin::Model::RefundInfoPlugin.new(amount_in_cents, DateTime.now, DateTime.now, Killbill::Plugin::Model::RefundPluginStatus.new(:PROCESSED), "gateway_error", "gateway_error_code", nil)
    end

    def get_refund_info(kb_account_id, kb_payment_id, tenant_context, options = {})
      Killbill::Plugin::Model::RefundInfoPlugin.new(amount_in_cents, DateTime.now, DateTime.now, illbill::Plugin::Model::RefundPluginStatus.new(:PROCESSED), "gateway_error", "gateway_error_code", nil)
    end

    def add_payment_method(kb_account_id, kb_payment_method_id, payment_method_props, set_default, call_context, options = {})
      nil
    end

    def delete_payment_method(kb_account_id, kb_payment_method_id, call_context, options = {})
    end

    def get_payment_method_detail(kb_account_id, kb_payment_method_id, tenant_context, options = {})
      Killbill::Plugin::Model::PaymentMethodPlugin.new("external_payment_method_id", false, [], nil, "Test", "cc_name", "cc_type", "cc_expiration_month", "cc_expiration_year", "cc_last4", "address1", "address2", "city", "state", "zip", "country")
    end

    def set_default_payment_method(kb_account_id, kb_payment_method_id, call_context, options = {})
    end

    def get_payment_methods(kb_account_id, refresh_from_gateway, call_context, options = {})
      [Killbill::Plugin::Model::PaymentMethodInfoPlugin.new(kb_account_id, kb_account_id, false, "external_payment_method_id")]
    end

    def reset_payment_methods(kb_account_id, payment_methods)
    end

    def raise_exception_on_next_calls
      @raise_exception = true
    end

    def clear_exception_on_next_calls
      @raise_exception = false
    end

  end
end
