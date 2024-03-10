resource "aws_sns_topic" "purchase_created_topic" {
  name                                  = local.sns.created.name
  firehose_success_feedback_sample_rate = 0
  http_success_feedback_sample_rate     = 0
  kms_master_key_id                     = local.sns.kms_master_key_id
  delivery_policy = jsonencode(
    {
      http : {
        defaultHealthyRetryPolicy : {
          minDelayTarget     = local.sns.min_delay_target,
          maxDelayTarget     = local.sns.max_delay_target,
          numRetries         = local.sns.num_retries,
          numMaxDelayRetries = local.sns.num_max_delay_retries,
          numNoDelayRetries  = local.sns.num_no_delay_retries,
          numMinDelayRetries = local.sns.num_min_delay_retries,
        },
        disableSubscriptionOverrides = local.sns.disable_subscription_overrides,
        defaultThrottlePolicy : {
          maxReceivesPerSecond = local.sns.max_receives_per_second
        }
      }
    }
  )
}

resource "aws_sns_topic" "purchase_paid_topic" {
  name                                  = local.sns.paid.name
  firehose_success_feedback_sample_rate = 0
  http_success_feedback_sample_rate     = 0
  kms_master_key_id                     = local.sns.kms_master_key_id
  delivery_policy = jsonencode(
    {
      http : {
        defaultHealthyRetryPolicy : {
          minDelayTarget     = local.sns.min_delay_target,
          maxDelayTarget     = local.sns.max_delay_target,
          numRetries         = local.sns.num_retries,
          numMaxDelayRetries = local.sns.num_max_delay_retries,
          numNoDelayRetries  = local.sns.num_no_delay_retries,
          numMinDelayRetries = local.sns.num_min_delay_retries,
        },
        disableSubscriptionOverrides = local.sns.disable_subscription_overrides,
        defaultThrottlePolicy : {
          maxReceivesPerSecond = local.sns.max_receives_per_second
        }
      }
    }
  )
}

resource "aws_sns_topic" "payment_done_topic" {
  name                                  = local.sns.payment_done.name
  firehose_success_feedback_sample_rate = 0
  http_success_feedback_sample_rate     = 0
  kms_master_key_id                     = local.sns.kms_master_key_id
  delivery_policy = jsonencode(
    {
      http : {
        defaultHealthyRetryPolicy : {
          minDelayTarget     = local.sns.min_delay_target,
          maxDelayTarget     = local.sns.max_delay_target,
          numRetries         = local.sns.num_retries,
          numMaxDelayRetries = local.sns.num_max_delay_retries,
          numNoDelayRetries  = local.sns.num_no_delay_retries,
          numMinDelayRetries = local.sns.num_min_delay_retries,
        },
        disableSubscriptionOverrides = local.sns.disable_subscription_overrides,
        defaultThrottlePolicy : {
          maxReceivesPerSecond = local.sns.max_receives_per_second
        }
      }
    }
  )
}

resource "aws_sns_topic" "payment_created_topic" {
  name                                  = local.sns.payment_created.name
  firehose_success_feedback_sample_rate = 0
  http_success_feedback_sample_rate     = 0
  kms_master_key_id                     = local.sns.kms_master_key_id
  delivery_policy = jsonencode(
    {
      http : {
        defaultHealthyRetryPolicy : {
          minDelayTarget     = local.sns.min_delay_target,
          maxDelayTarget     = local.sns.max_delay_target,
          numRetries         = local.sns.num_retries,
          numMaxDelayRetries = local.sns.num_max_delay_retries,
          numNoDelayRetries  = local.sns.num_no_delay_retries,
          numMinDelayRetries = local.sns.num_min_delay_retries,
        },
        disableSubscriptionOverrides = local.sns.disable_subscription_overrides,
        defaultThrottlePolicy : {
          maxReceivesPerSecond = local.sns.max_receives_per_second
        }
      }
    }
  )
}