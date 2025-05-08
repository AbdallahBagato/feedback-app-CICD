# 🚀 FeedbackApp Infrastructure

This repository contains Terraform and Ansible configurations to fully provision and configure infrastructure on AWS.

---

## 📦 Project Structure

- **/eks-cluster/**
  - Terraform scripts to create:
    - VPC
    - Security Groups
    - IAM Roles and Policies
    - EKS Cluster
    - EKS Node Group

- **/ec2-instance/**
  - Terraform scripts to create:
    - VPC
    - Security Groups
    - EC2 Instances
    - Key Pairs for SSH Access

- **/ansible/**
  - Ansible playbooks to:
    - Prepare EC2 instances as agents
    - Install required packages (Python, Docker, kubectl)
    - Configure the system

---

## ⚙️ Technologies Used

- **Terraform** — Infrastructure as Code (IaC)
- **AWS** — Cloud Provider
- **Ansible** — Server Configuration Management

---
