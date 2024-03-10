### PURCHASE-PAYMENT-DONE-QUEUE
resource "aws_sqs_queue" "payment_done_queue" {
  name                       = local.sqs.payment_done.name
  delay_seconds              = local.sqs.delay_seconds
  max_message_size           = local.sqs.max_message_size
  message_retention_seconds  = local.sqs.message_retention_seconds
  receive_wait_time_seconds  = local.sqs.receive_wait_time_seconds
  visibility_timeout_seconds = local.sqs.visibility_timeout_seconds
  sqs_managed_sse_enabled    = local.sqs.sqs_managed_sse_enabled

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.payment_done_queue_dlq.arn,
    maxReceiveCount     = 3
  })

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = ["${aws_sqs_queue.payment_done_queue_dlq.arn}"]
  })

  depends_on = [
    aws_sqs_queue.payment_done_queue_dlq
  ]
}

resource "aws_sqs_queue" "payment_done_queue_dlq" {
  name                       = "${local.sqs.payment_done.name}-dlq"
  delay_seconds              = local.sqs.delay_seconds
  max_message_size           = local.sqs.max_message_size
  message_retention_seconds  = local.sqs.message_retention_seconds
  receive_wait_time_seconds  = local.sqs.receive_wait_time_seconds
  visibility_timeout_seconds = local.sqs.visibility_timeout_seconds
  sqs_managed_sse_enabled    = local.sqs.sqs_managed_sse_enabled
}

resource "aws_sns_topic_subscription" "get_payment_done_events" {
  topic_arn            = data.aws_sns_topic.payment_done_topic.arn
  protocol             = local.subscription.payment_done_topic.protocol
  endpoint             = aws_sqs_queue.payment_done_queue.arn
  raw_message_delivery = local.subscription.payment_done_topic.raw_message_delivery

  depends_on = [
    aws_sqs_queue.payment_done_queue,
    data.aws_sns_topic.payment_done_topic
  ]
}

resource "aws_sqs_queue_policy" "payment_done_to_process_subscription" {
  queue_url = aws_sqs_queue.payment_done_queue.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "sns.amazonaws.com"
        },
        Action : [
          "sqs:SendMessage"
        ],
        Resource = [
          aws_sqs_queue.payment_done_queue.arn
        ],
        Condition = {
          ArnEquals = {
            "aws:SourceArn" : data.aws_sns_topic.payment_done_topic.arn
          }
        }
      }
    ]
  })
}

### PURCHASE-CART-DONE-QUEUE
resource "aws_sqs_queue" "cart_closed_queue" {
  name                       = local.sqs.cart_closed.name
  delay_seconds              = local.sqs.delay_seconds
  max_message_size           = local.sqs.max_message_size
  message_retention_seconds  = local.sqs.message_retention_seconds
  receive_wait_time_seconds  = local.sqs.receive_wait_time_seconds
  visibility_timeout_seconds = local.sqs.visibility_timeout_seconds
  sqs_managed_sse_enabled    = local.sqs.sqs_managed_sse_enabled

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.cart_closed_queue_dlq.arn,
    maxReceiveCount     = 3
  })

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = ["${aws_sqs_queue.cart_closed_queue_dlq.arn}"]
  })

  depends_on = [
    aws_sqs_queue.cart_closed_queue_dlq
  ]
}

resource "aws_sqs_queue" "cart_closed_queue_dlq" {
  name                       = "${local.sqs.cart_closed.name}-dlq"
  delay_seconds              = local.sqs.delay_seconds
  max_message_size           = local.sqs.max_message_size
  message_retention_seconds  = local.sqs.message_retention_seconds
  receive_wait_time_seconds  = local.sqs.receive_wait_time_seconds
  visibility_timeout_seconds = local.sqs.visibility_timeout_seconds
  sqs_managed_sse_enabled    = local.sqs.sqs_managed_sse_enabled
}

resource "aws_sns_topic_subscription" "get_cart_closed_events" {
  topic_arn            = data.aws_sns_topic.cart_closed_topic.arn
  protocol             = local.subscription.cart_closed_topic.protocol
  endpoint             = aws_sqs_queue.cart_closed_queue.arn
  raw_message_delivery = local.subscription.cart_closed_topic.raw_message_delivery

  depends_on = [
    aws_sqs_queue.cart_closed_queue,
    data.aws_sns_topic.cart_closed_topic
  ]
}

resource "aws_sqs_queue_policy" "cart_closed_to_process_subscription" {
  queue_url = aws_sqs_queue.cart_closed_queue.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "sns.amazonaws.com"
        },
        Action : [
          "sqs:SendMessage"
        ],
        Resource = [
          aws_sqs_queue.cart_closed_queue.arn
        ],
        Condition = {
          ArnEquals = {
            "aws:SourceArn" : data.aws_sns_topic.cart_closed_topic.arn
          }
        }
      }
    ]
  })
}

### PURCHASE-REMOVE-CUSTOMER-DATA-QUEUE
resource "aws_sqs_queue" "remove_customer_data_queue" {
  name                       = local.sqs.remove_customer_data.name
  delay_seconds              = local.sqs.delay_seconds
  max_message_size           = local.sqs.max_message_size
  message_retention_seconds  = local.sqs.message_retention_seconds
  receive_wait_time_seconds  = local.sqs.receive_wait_time_seconds
  visibility_timeout_seconds = local.sqs.visibility_timeout_seconds
  sqs_managed_sse_enabled    = local.sqs.sqs_managed_sse_enabled

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.remove_customer_data_dlq.arn,
    maxReceiveCount     = 3
  })

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = ["${aws_sqs_queue.remove_customer_data_dlq.arn}"]
  })

  depends_on = [
    aws_sqs_queue.remove_customer_data_dlq
  ]
}

resource "aws_sqs_queue" "remove_customer_data_dlq" {
  name                       = "${local.sqs.remove_customer_data.name}-dlq"
  delay_seconds              = local.sqs.delay_seconds
  max_message_size           = local.sqs.max_message_size
  message_retention_seconds  = local.sqs.message_retention_seconds
  receive_wait_time_seconds  = local.sqs.receive_wait_time_seconds
  visibility_timeout_seconds = local.sqs.visibility_timeout_seconds
  sqs_managed_sse_enabled    = local.sqs.sqs_managed_sse_enabled
}

resource "aws_sns_topic_subscription" "get_remove_customer_data_events" {
  topic_arn            = data.aws_sns_topic.remove_customer_data_topic.arn
  protocol             = local.subscription.remove_customer_data_topic.protocol
  endpoint             = aws_sqs_queue.remove_customer_data_queue.arn
  raw_message_delivery = local.subscription.remove_customer_data_topic.raw_message_delivery

  depends_on = [
    aws_sqs_queue.remove_customer_data_queue,
    data.aws_sns_topic.remove_customer_data_topic
  ]
}

resource "aws_sqs_queue_policy" "remove_customer_data_to_process_subscription" {
  queue_url = aws_sqs_queue.remove_customer_data_queue.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "sns.amazonaws.com"
        },
        Action : [
          "sqs:SendMessage"
        ],
        Resource = [
          aws_sqs_queue.remove_customer_data_queue.arn
        ],
        Condition = {
          ArnEquals = {
            "aws:SourceArn" : data.aws_sns_topic.remove_customer_data_topic.arn
          }
        }
      }
    ]
  })
}

### PURCHASE-PAYMENT-CREATED-QUEUE
resource "aws_sqs_queue" "payment_created_queue" {
  name                       = local.sqs.payment_created.name
  delay_seconds              = local.sqs.delay_seconds
  max_message_size           = local.sqs.max_message_size
  message_retention_seconds  = local.sqs.message_retention_seconds
  receive_wait_time_seconds  = local.sqs.receive_wait_time_seconds
  visibility_timeout_seconds = local.sqs.visibility_timeout_seconds
  sqs_managed_sse_enabled    = local.sqs.sqs_managed_sse_enabled

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.payment_created_dlq.arn,
    maxReceiveCount     = 3
  })

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = ["${aws_sqs_queue.payment_created_dlq.arn}"]
  })

  depends_on = [
    aws_sqs_queue.payment_created_dlq
  ]
}

resource "aws_sqs_queue" "payment_created_dlq" {
  name                       = "${local.sqs.remove_customer_data.name}-dlq"
  delay_seconds              = local.sqs.delay_seconds
  max_message_size           = local.sqs.max_message_size
  message_retention_seconds  = local.sqs.message_retention_seconds
  receive_wait_time_seconds  = local.sqs.receive_wait_time_seconds
  visibility_timeout_seconds = local.sqs.visibility_timeout_seconds
  sqs_managed_sse_enabled    = local.sqs.sqs_managed_sse_enabled
}

resource "aws_sns_topic_subscription" "get_payment_created_events" {
  topic_arn            = data.aws_sns_topic.payment_created_topic.arn
  protocol             = local.subscription.payment_created_topic.protocol
  endpoint             = aws_sqs_queue.payment_created_queue.arn
  raw_message_delivery = local.subscription.payment_created_topic.raw_message_delivery

  depends_on = [
    aws_sqs_queue.payment_created_queue,
    data.aws_sns_topic.payment_done_topic
  ]
}

resource "aws_sqs_queue_policy" "payment_created_to_process_subscription" {
  queue_url = aws_sqs_queue.payment_created_queue.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "sns.amazonaws.com"
        },
        Action : [
          "sqs:SendMessage"
        ],
        Resource = [
          aws_sqs_queue.payment_created_queue.arn
        ],
        Condition = {
          ArnEquals = {
            "aws:SourceArn" : data.aws_sns_topic.payment_created_topic.arn
          }
        }
      }
    ]
  })
}