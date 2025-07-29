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
# IAM Role for Service Accounts (EKS)
##################################

# Ainda por corrigir

module "iam_role_for_service_accounts_eks" {
  source = "../Modules/iam/iam_role_for_service_accounts_eks"

  create_role      = true
  iam_role_name    = "eks_service_role"

  attach_load_balancer_controller_policy = true
  attach_vpc_cni_policy                  = true

  oidc_providers = {
    "default" = {
      provider_arn = "arn:aws:iam::<ACCOUNT_ID>:oidc-provider/oidc.eks.eu-west-2.amazonaws.com/id/<OIDC_ID>"
      namespace_service_accounts = [
        "kube-system:aws-node",
        "kube-system:aws-load-balancer-controller"
      ]
    }
  }
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
  source = "../Modules/rds"

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
