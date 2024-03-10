locals {
  sns = {
    min_delay_target               = 20
    max_delay_target               = 20
    num_retries                    = 3
    num_max_delay_retries          = 0
    num_no_delay_retries           = 0
    num_min_delay_retries          = 0
    disable_subscription_overrides = false
    max_receives_per_second        = 10
    kms_master_key_id              = "alias/aws/sns"
    paid = {
      name = "prd-purchase-paid-topic"
    }
    created = {
      name = "prd-purchase-created-topic"
    }
    status = {
      name = "prd-notification-purchase-status-queue"
    }
    payment_created = {
      name = "prd-payment-created-topic"
    }
    remove_customer_data = {
      name     = "prd-customer-remove-data-topic"
      protocol = "sqs"
    }
  }

  subscription = {
    payment_done_topic = {
      name                 = "prd-payment-done-topic"
      protocol             = "sqs"
      raw_message_delivery = true
    }
    payment_created_topic = {
      name                 = "prd-payment-created-topic"
      protocol             = "sqs"
      raw_message_delivery = true
    }
    remove_customer_data_topic = {
      name                 = "prd-customer-remove-data-topic"
      protocol             = "sqs"
      raw_message_delivery = true
    }
    cart_closed_topic = {
      name                 = "prd-cart-closed-topic"
      protocol             = "sqs"
      raw_message_delivery = true
    }

  }

  sqs = {
    delay_seconds              = 0
    max_message_size           = 262144
    message_retention_seconds  = 86400
    receive_wait_time_seconds  = 0
    visibility_timeout_seconds = 60
    sqs_managed_sse_enabled    = true
    cart_closed = {
      name = "prd-purchase-cart-closed-queue"
    }
    payment_done = {
      name = "prd-purchase-payment-done-queue"
    }
    payment_created = {
      name = "prd-purchase-payment-created-queue"
    }
    remove_customer_data = {
      name = "prd-purchase-remove-customer-data-queue"
    }
    removed_customer_data = {
      name = "prd-customer-remove-data-response-queue"
    }
  }
}