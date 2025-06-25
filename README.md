# Terraform VPC Setup

This project demonstrates how to use Terraform to provision a basic AWS Virtual Private Cloud (VPC) setup.

## 🛠️ What It Includes

- A new VPC with a customizable CIDR block
- Public and private subnets across availability zones
- Route tables and internet gateways
- Security groups
- AWS provider configured

## 🔧 Files

- `main.tf`: Core infrastructure configuration
- `variables.tf`: Input variables used throughout the setup
- `outputs.tf`: Key outputs such as VPC ID and subnet IDs

## 🚫 Secrets

All credentials and secrets have been excluded for security.

## 📌 Tools Used

- Terraform
- AWS Cloud (VPC, Subnets, IGW, Security Groups)
- Git/GitHub

## 📁 .gitignore

Sensitive files and folders (e.g., `.terraform`, `.tfstate`, `.tfvars`) have been excluded from version control following best practices.

---

✅ Created by [Leola Barrolle](https://github.com/LeolaBarrolleAWS)
