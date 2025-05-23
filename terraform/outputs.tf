output "instance_public_ip" {
  value = aws_instance.task_tracker.public_ip
}