# Azure DevOps Cloud Resume Challenge

This repo provides the backend and frontend code that adapts the traditional  [Cloud Resume Challenge](https://cloudresumechallenge.dev/) for **Azure DevOps**. 

It replaces GitHub Actions with Azure Pipelines and runs CI/CD using a local Windows agent with PowerShell scripting.

## Overview

The backend service runs a **visitor counter API** via Azure Functions, which tracks visits to the frontend résumé site. Frontend files are deployed to a static website hosted in Azure Storage and delivered securely via Azure CDN. 

***

##  Challenge Steps & Enhancements

### ☁️ Infrastructure & Deployment

-  Automated **Infrastructure as Code** using **Terraform**
-  Deployed using **Azure DevOps Pipelines**
-  Remote state stored securely in the separate Azure Storage
-  CDN-enabled static website (HTTPS enforced via Azure CDN)

### 🛠 Backend (API)

-  Built using **Python Azure Functions**
-  Visitor data stored in **Azure Cosmos DB** (Table API)
-  Azure Function triggered via HTTP with CORS & security headers

### 🔄 CI/CD Process

-  Azure Function deployed only after frontend and backend infrastructure is provisioned successfully
-  End-to-end tests with **Cypress** 
-  All Bash commands adapted and troubleshooted in **PowerShell** for Windows compatibility

###  Security & Compliance

-  **SBOM (Software Bill of Materials)** generated with Syft
-  Vulnerability scanning (Grype, Bandit, Semgrep, Safety, other)
-  Azure Service Principal configured with minimal RBAC permissions
-  Secrets stored securely in Azure DevOps Pipelines Library

***

##  Notes

- Commits are signed and saved using `GPG secure commit`.

***
