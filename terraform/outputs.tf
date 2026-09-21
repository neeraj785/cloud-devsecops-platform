output "backend_repository_url" {
    description = "backend ecr repository url"
    value       = aws_ecr_repository.backend.repository_url
}

output "frontend_repository_url" {
    description = "frontend ecr repository url"
    value       = aws_ecr_repository.frontend.repository_url
}