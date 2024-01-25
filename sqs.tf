resource "aws_sqs_queue" "payment_done_queue" {
  name                       = local.sqs.name
  delay_seconds              = local.sqs.delay_seconds
  max_message_size           = local.sqs.max_message_size
  message_retention_seconds  = local.sqs.message_retention_seconds
  receive_wait_time_seconds  = local.sqs.receive_wait_time_seconds
  visibility_timeout_seconds = local.sqs.visibility_timeout_seconds
  sqs_managed_sse_enabled    = local.sqs.sqs_managed_sse_enabled
}

resource "aws_sns_topic_subscription" "get_payment_done_events" {
  topic_arn = data.aws_sns_topic.payment_done_topic.arn
  protocol  = local.subscription.payment_done_topic.protocol
  endpoint  = aws_sqs_queue.payment_done_queue.arn

  depends_on = [
    aws_sqs_queue.payment_done_queue,
    data.aws_sns_topic.payment_done_topic
  ]
}