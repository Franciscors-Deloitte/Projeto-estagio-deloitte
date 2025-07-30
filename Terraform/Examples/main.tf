##################################
# VPC
##################################

module "vpc" {
  source = "../Modules/vpc/vpc"

  name               = "example"
  cidr               = "10.0.0.0/16"
  availability_zones = ["eu-west-2a", "eu-west-2b"]

  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  use_name_prefix      = true
  create               = true

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# VPC Endpoints
##################################

module "vpc_endpoints" {
  source = "../Modules/vpc/vpc_endpoints"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids

  endpoints = {
    s3 = {
      create  = true
      service = "com.amazonaws.eu-west-2.s3"
      type    = "Gateway"
    }

    logs = {
      create              = true
      service             = "com.amazonaws.eu-west-2.logs"
      type                = "Interface"
      private_dns_enabled = true
    }
  }

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# Security Group
##################################

module "security_group" {
  source = "../Modules/security_group/sg"

  vpc_id          = module.vpc.vpc_id
  name            = "main-sg"
  use_name_prefix = true

  ingress_rules = [
    { rule = "ssh-tcp", cidr_blocks = ["0.0.0.0/0"] },
    { rule = "https-443-tcp", cidr_blocks = ["0.0.0.0/0"] },
    { rule = "postgresql-tcp", cidr_blocks = ["10.0.0.0/16"] }
  ]

  egress_rules = [
    { rule = "all-all", cidr_blocks = ["0.0.0.0/0"] }
  ]

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# IAM
##################################

##################################
# IAM Account
##################################

module "iam_account" {
  source = "../Modules/iam/iam_account"

  account_alias = "infra-faculdade"

  create_account_password_policy     = true
  max_password_age                   = 90
  minimum_password_length            = 12
  allow_users_to_change_password     = true
  hard_expiry                        = false
  password_reuse_prevention          = 5
  require_lowercase_characters       = true
  require_uppercase_characters       = true
  require_numbers                    = true
  require_symbols                    = true
}

##################################
# IAM Policy - Readonly S3 & RDS
##################################

module "iam_policy_s3_rds_readonly" {
  source = "../Modules/iam/iam_policy"

  name        = "S3AndRDSReadonlyPolicy"
  description = "Permite leitura em S3 e leitura de configuração de RDS"
  path        = "/"
  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "S3ReadOnly",
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = "*"
      },
      {
        Sid    = "RDSDescribe",
        Effect = "Allow",
        Action = [
          "rds:DescribeDBInstances",
          "rds:DescribeDBClusters"
        ],
        Resource = "*"
      }
    ]
  })

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# IAM Policy - Logs Write
##################################

module "iam_policy_logs_write" {
  source = "../Modules/iam/iam_policy"

  name        = "LogsWritePolicy"
  description = "Permite escrita em CloudWatch Logs"
  path        = "/"
  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "CloudWatchLogsWrite",
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# IAM Group with Policies
##################################

module "iam_group_with_policies" {
  source = "../Modules/iam/iam_group_with_policies"

  name          = "dev-team"
  create_group  = true

  group_users = [
    module.iam_user.iam_user_name
  ]

  policy_arns = [
    module.iam_policy_s3_rds_readonly.arn,
    module.iam_policy_logs_write.arn
  ]

}

##################################
# IAM User
##################################

module "iam_user" {
  source = "../Modules/iam/iam_user"

  name        = "presentation_user"
  create_user = true

  create_iam_user_login_profile = true
  password_length               = 12
  password_reset_required       = true

  create_iam_access_key = false

  tags = {
    Project = "infra-example"
  }
}

##################################
# IAM Role for Lambda EC2 RDS
##################################

module "iam_assumable_role_services" {
  source = "../Modules/iam/iam_assumable_role"

  create_role      = true
  role_name        = "lambda_ec2_execution_role"

  trusted_role_services = [
    "lambda.amazonaws.com",
    "ec2.amazonaws.com",
    "rds.amazonaws.com"
  ]

  allow_self_assume_role = false
  role_requires_mfa = false
  max_session_duration   = 3600
}


##################################
# KMS Key
##################################

module "kms" {
  source = "../Modules/kms/kms"

  create                     = true
  name                       = "project-kms-key"
  alias_name                 = "alias/project-kms"
  description                = "Chave KMS para encriptação de serviços AWS no projeto académico"
  deletion_window_in_days    = 10
  enable_key_rotation        = true
  is_enabled                 = true
  customer_master_key_spec   = "SYMMETRIC_DEFAULT"
  key_usage                  = "ENCRYPT_DECRYPT"
  multi_region               = false
  bypass_policy_lockout_safety_check = false

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# S3 Bucket
##################################

##################################
# Bucket
##################################

module "s3_bucket" {
  source = "../Modules/s3_bucket/s3"

  create              = true
  name                = "infra-example-bucket"
  use_name_prefix     = false
  force_destroy       = false

  enable_versioning          = true
  enable_ownership_controls  = true
  object_ownership           = "BucketOwnerEnforced"

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# Notifications
##################################

module "s3_notifications" {
  source = "../Modules/s3_bucket/notification"

  create = true
  bucket = module.s3_bucket.s3_bucket_id

  lambda_notifications = {
    "processar_eventos" = {
      function_arn  = module.lambda_function.lambda_function_arn
      events        = ["s3:ObjectCreated:*"]
      filter_prefix = "uploads/"
      filter_suffix = ".json"
    }
  }

  eventbridge = false
}

##################################
# Lambda Function
##################################

module "lambda_function" {
  source = "../Modules/lambda/lambda"

  function_name = "processar-eventos"
  description   = "Função Lambda de exemplo"
  handler       = "package.lambda_handler"
  runtime       = "python3.11"

  source_path = "${path.module}/package.py"

  lambda_execution_role_arn = module.iam_assumable_role_services.iam_role_arn

  vpc_subnet_ids         = module.vpc.private_subnet_ids
  vpc_security_group_ids = [module.security_group.security_group_id]

  timeout = 10

  allow_s3_invocation = true
  s3_bucket_arn       = module.s3_bucket.s3_bucket_arn

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# EC2 Instance
##################################

module "ec2_instance" {
  source = "../Modules/ec2_intance/ec2"

  ami           = "ami-0c55b159cbfafe1f0" # Ubuntu 22.04 em eu-west-2
  instance_type = "t3.micro"

  subnet_id              = module.vpc.private_subnet_ids[0]
  vpc_security_group_ids = [module.security_group.security_group_id]

  iam_instance_profile = module.iam_assumable_role_services.iam_instance_profile_name

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# RDS
##################################

module "rds" {
  source = "../Modules/data_base/rds/rds"

  identifier                    = "example-rds"
  allocated_storage             = 20
  storage_type                  = "gp2"
  engine                        = "postgres"
  engine_version                = "15.3"
  instance_class                = "db.t3.micro"
  db_name                       = "exampledb"
  username                      = "adminuser"
  password                      = "strongpassword123"
  port                          = 5432

  multi_az                      = false
  publicly_accessible           = false
  db_subnet_group_name          = module.vpc.db_subnet_group_name
  vpc_security_group_ids        = [module.security_group.security_group_id]
  parameter_group_name          = null
  option_group_name             = null
  backup_retention_period       = 7
  backup_window                 = "03:00-04:00"
  maintenance_window            = "Mon:04:00-Mon:05:00"
  skip_final_snapshot           = true
  final_snapshot_identifier     = null
  deletion_protection           = false
  apply_immediately             = true

  monitoring_role_arn           = module.iam_assumable_role_services.iam_role_arn
  monitoring_interval           = 60

  performance_insights_enabled  = true
  performance_insights_kms_key_id = module.kms.key_arn
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# Application Load Balancer (ALB)
##################################

module "alb" {
  source = "../Modules/alb/alb"

  name                        = "example-alb"
  internal                    = false
  load_balancer_type          = "application"
  enable_deletion_protection  = false

  subnets         = module.vpc.public_subnet_ids
  security_groups = [module.security_group.security_group_id]

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# API Gateway
##################################

module "api_gateway" {
  source = "../Modules/api_gateway/api_gateway"

  name          = "example-api"
  description   = "API Gateway de exemplo"
  protocol_type = "HTTP"

  stage_name  = "dev"
  auto_deploy = true

  create_routes_and_integrations = true

  routes = [
    {
      route_key              = "GET /hello"
      integration_type       = "AWS_PROXY"
      integration_uri        = module.lambda_function.lambda_function_invoke_arn
      integration_method     = "POST"
      payload_format_version = "2.0"
    }
  ]

  # CloudWatch Logging (opcional)
  # access_log_destination_arn = aws_cloudwatch_log_group.api_gw_logs.arn
  # access_log_format = jsonencode({
  #   requestId       = "$context.requestId",
  #   ip              = "$context.identity.sourceIp",
  #   requestTime     = "$context.requestTime",
  #   httpMethod      = "$context.httpMethod",
  #   routeKey        = "$context.routeKey",
  #   status          = "$context.status",
  #   integrationErrorMessage = "$context.integrationErrorMessage"
  # })

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# CloudTrail
##################################

##################################
# IAM Role for CloudTrail & CloudWatch Logs
##################################

module "iam_assumable_role_logs" {
  source = "../Modules/iam/iam_assumable_role"

  create_role = true
  role_name   = "cloudtrail_cloudwatch_logs_role"

  trusted_role_services = [
    "cloudtrail.amazonaws.com",
    "logs.amazonaws.com"
  ]

  allow_self_assume_role = false
  role_requires_mfa      = false
  max_session_duration   = 3600

  custom_role_policy_arns = [
    # Permite que o serviço de logs publique dados para o destino (ex: Lambda/Kinesis)
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# CloudTrail
##################################

module "cloudtrail" {
  source = "../Modules/monitoring/cloud_trail/ct"

  name                          = "example-cloudtrail"
  s3_bucket_name                = module.s3_bucket.s3_bucket_id
  s3_key_prefix                 = "cloudtrail/"
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  enable_logging                = true
  is_organization_trail         = false
  kms_key_id                    = module.kms.key_arn

  
  enable_cloudwatch_logs    = true
  cloudwatch_logs_role_arn  = module.iam_assumable_role_logs.iam_role_arn
  cloudwatch_logs_group_arn = module.log_group.cloudwatch_log_group_arn

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# CloudWatch
##################################

##################################
# Log Group
##################################

module "log_group" {
  source = "../Modules/monitoring/cloud_watch/log_group"

  name              = "/aws/cloudtrail/logs"
  retention_in_days = 30
  kms_key_id      = module.kms.key_arn
  log_group_class = "STANDARD"
  skip_destroy    = true

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# Log Stream
##################################

module "log_stream" {
  source = "../Modules/monitoring/cloud_watch/log_stream"

  name           = "app-log-stream"
  log_group_name = module.log_group.cloudwatch_log_group_name
}

##################################
# Log Subscription Filter
##################################

module "log_subscription_filter" {
  source = "../Modules/monitoring/cloud_watch/log_subscription_filter"

  name              = "cloudwatch-to-lambda"
  log_group_name    = module.log_group.cloudwatch_log_group_name
  destination_arn   = module.lambda_function.lambda_function_arn
  role_arn          = module.iam_assumable_role_logs.iam_role_arn
  filter_pattern    = "" # Aceita todos os logs

}

##################################
# Metric Alarm - Lambda Errors
##################################

module "lambda_error_alarm" {
  source = "../Modules/monitoring/cloud_watch/metric_alarm"

  alarm_name          = "lambda-error-alarm"
  alarm_description   = "Alarme para erros na função Lambda"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  threshold           = 1

  metric_name = "Errors"
  namespace   = "AWS/Lambda"
  period      = 60
  statistic   = "Sum"

  dimensions = {
    FunctionName = module.lambda_function.lambda_function_name
  }

  treat_missing_data = "notBreaching"

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# Metric Alarm - EC2 CPU Utilization
##################################

module "ec2_cpu_alarm" {
  source = "../Modules/monitoring/cloud_watch/metric_alarm"

  alarm_name          = "ec2-high-cpu"
  alarm_description   = "Dispara se a CPU da instância EC2 exceder 80%"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  threshold           = 80

  metric_name = "CPUUtilization"
  namespace   = "AWS/EC2"
  period      = 60
  statistic   = "Average"

  dimensions = {
    InstanceId = module.ec2_instance.id
  }

  treat_missing_data = "notBreaching"

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# Composite Alarm
##################################

module "composite_alarm" {
  source = "../Modules/monitoring/cloud_watch/composite_alarm"

  alarm_name        = "lambda-or-ec2-critical"
  alarm_description = "Dispara se a Lambda falhar ou a EC2 estiver com CPU elevada"
  actions_enabled   = true

  alarm_rule = join(" ", [
    "ALARM(\"${module.lambda_error_alarm.alarm_name}\")",
    "OR",
    "ALARM(\"${module.ec2_cpu_alarm.alarm_name}\")"
  ])

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# WAF Web ACL associado ao ALB
##################################

module "waf" {
  source = "../Modules/waf/waf"

  name        = "web-acl-example"
  description = "Web ACL simples com bloqueio básico"
  scope       = "REGIONAL"

  associate_with_resource = true
  resource_arn            = module.alb.arn

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# EKS
##################################

##################################
# IAM Policy para Acesso EKS
##################################

module "eks_admin_policy" {
  source       = "../Modules/iam/iam_policy"
  create_policy = true
  name          = "eks-admin-policy"
  description   = "Política para administração do EKS"
  policy        = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "eks:*",
        Resource = "*"
      }
    ]
  })
  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# IAM User para EKS
##################################

module "eks_user" {
  source                         = "../Modules/iam/iam_user"
  create_user                    = true
  name                           = "eks-admin-user"
  path                           = "/"
  force_destroy                  = true
  create_iam_user_login_profile = false
  create_iam_access_key         = false

  policy_arns = [module.eks_admin_policy.arn]

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# IAM Role for EKS Cluster
##################################

module "iam_assumable_role_eks" {
  source = "../Modules/iam/iam_assumable_role" 

  create_role           = true
  role_name             = "eks_cluster_role"
  role_requires_mfa     = false
  trusted_role_services = ["eks.amazonaws.com"] 

  max_session_duration = 3600

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# EKS Cluster
##################################

module "eks" {
  source = "../Modules/eks/eks"

  cluster_name                = "example-eks-cluster"
  cluster_version             = "1.29"
  cluster_ip_family           = "ipv4"
  cluster_service_ipv4_cidr   = "10.100.0.0/16"

  subnet_ids                  = module.vpc.private_subnet_ids
  cluster_security_group_id   = module.security_group.security_group_id
  cluster_additional_security_group_ids = []

  cluster_endpoint_private_access       = true
  cluster_endpoint_public_access        = true
  cluster_endpoint_public_access_cidrs  = ["0.0.0.0/0"]

  cluster_enabled_log_types             = ["api", "audit"]

  kms_key_arn                 = module.kms.key_arn
  cluster_encryption_config   = {}
  encryption_resources        = []

  iam_role_arn                = module.iam_assumable_role_eks.iam_role_arn

  create_cni_ipv6_iam_policy  = false
  dataplane_wait_duration     = "30s"

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##################################
# EKS Managed Node Group
##################################

module "eks_managed_node_group" {
  source = "../Modules/eks/eks_managed_node_group"

  name           = "example-node-group"
  cluster_name   = module.eks.cluster_name
  node_role_arn  = module.iam_assumable_role_eks.iam_role_arn
  subnet_ids     = module.vpc.private_subnet_ids

  instance_types = ["t3.medium"]
  desired_size   = 2
  min_size       = 1
  max_size       = 3
  disk_size      = 20
  capacity_type  = "ON_DEMAND"

  version         = null
  release_version = null
  ami_type        = null

  labels = {
    role = "worker"
  }

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }

  depends_on = [
    module.eks
  ]
}

##################################
# AWS Auth Mapping
##################################

module "aws_auth" {
  source = "../Modules/eks/aws_auth"

  create                      = true
  create_aws_auth_configmap  = true

  aws_auth_roles = [
    {
      rolearn = module.eks_managed_node_group.node_group_iam_role_arn
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = [
        "system:bootstrappers",
        "system:nodes"
      ]
    }
  ]

  aws_auth_users = [
    {
      userarn  = module.eks_user.iam_user_arn
      username = "eks-admin"
      groups   = ["system:masters"]
    }
  ]

  aws_auth_accounts = []

  labels = {
    Environment = "dev"
    Project     = "infra-example"
  }
}

##############################################
# IAM Role for Service Accounts (IRSA - EKS)
##############################################

module "irsa_for_external_dns" {
  source = "../Modules/iam/iam_role_for_service_accounts_eks"

  iam_role_name = module.iam_assumable_role_eks.iam_role_name

  oidc_providers = {
    eks = {
      provider_arn = module.eks.cluster_iam_role_arn
      namespace_service_accounts = [
        "kube-system:external-dns"
      ]
    }
  }

  attach_external_dns_policy = true

  tags = {
    Environment = "dev"
    Project     = "infra-example"
  }
}