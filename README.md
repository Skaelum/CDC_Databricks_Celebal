<p align="center">
  <a href="https://github.com/Skaelum/CDC_Databricks_Celebal">
    <img src="https://img.shields.io/badge/Repo-CDC__Databricks__Celebal-blue.svg" alt="Repo: CDC_Databricks_Celebal" />
  </a>
  <a href="https://azure.microsoft.com/">
    <img src="https://img.shields.io/badge/Made%20with-Azure-blue.svg" alt="Azure" />
  </a>
  <a href="https://databricks.com/">
    <img src="https://img.shields.io/badge/Powered%20by-Databricks-orange.svg" alt="Databricks" />
  </a>
  <a href="https://github.com/Skaelum/CDC_Databricks_Celebal/actions/workflows/ci.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/Skaelum/CDC_Databricks_Celebal/ci.yml?branch=main" alt="CI Status" />
  </a>
  <a href="https://github.com/Skaelum/CDC_Databricks_Celebal/blob/main/LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License: MIT" />
  </a>
</p>

# CDC with Azure Data Factory, Databricks & Automated Email Alerts

> End-to-end Change Data Capture (CDC) framework leveraging Azure Data Factory, Databricks, and Logic Apps, with automated email reporting.

---

## 🚀 Table of Contents

1. [Overview](#overview)
2. [Features](#features)
3. [Architecture](#architecture)
4. [Setup & Deployment](#setup--deployment)

   * [Prerequisites](#prerequisites)
   * [Deploy Infrastructure](#deploy-infrastructure)
   * [Configure Resources](#configure-resources)
5. [Usage](#usage)
6. [Repository Structure](#repository-structure)
7. [Project Documentation](#project-documentation)


---

## 🔍 Overview

This repository hosts a robust CDC solution designed to detect and propagate row-level changes (INSERT, UPDATE, DELETE) from a CDC-enabled Azure SQL Database into downstream targets (Azure SQL or Data Lake). Azure Data Factory orchestrates pipelines with Tumbling Window triggers, Databricks handles streaming and Delta Lake merges, and Logic Apps send automated summary emails after each execution.

---

## ✨ Features

* **Native CDC Integration**: Utilizes SQL Server CDC to capture DML changes at the source.
* **Delta Lake Merge**: Idempotent upserts and deletes with `MERGE INTO` on Delta tables.
* **Streaming Ingestion**: Spark Structured Streaming for near real‑time data processing.
* **Tumbling Window Scheduling**: ADF triggers ensure fault-tolerant, non-overlapping runs.
* **Managed Identity Security**: Eliminates hard-coded credentials with Managed Identity authentication.
* **Automated Notifications**: Logic App-driven email summaries with dynamic metrics.

---

## 🏗️ Architecture

1. **Source**: CDC-enabled Azure SQL Database
2. **Orchestration**: Azure Data Factory Tumbling Window trigger
3. **Processing**: Azure Databricks Notebook (Spark Structured Streaming + Delta Lake)
4. **Notification**: Azure Logic App (Outlook connector)

---

## 🛠️ Setup & Deployment

### Prerequisites

* Azure Subscription with permissions to create SQL Database, Data Factory, Databricks, and Logic Apps
* [Azure CLI](https://docs.microsoft.com/cli/azure/overview) & [Databricks CLI](https://docs.databricks.com/dev-tools/cli/index.html)
* Git (version control)

### Deploy Infrastructure

```bash
# Clone the repository
git clone https://github.com/Skaelum/CDC_Databricks_Celebal.git
cd CDC_Databricks_Celebal

# Deploy resources with ARM templates
az deployment group create \
  --resource-group <RESOURCE_GROUP> \
  --template-file infrastructure/azuredeploy.json \
  --parameters environment=prod
```

### Configure Resources

1. **Enable CDC** on your Azure SQL tables:

   ```sql
   EXEC sys.sp_cdc_enable_table 
     @source_schema = 'dbo', 
     @source_name   = '<table_name>', 
     @role_name     = NULL;
   ```
2. Update **parameters** in `/infrastructure/parameters/*.json` for your environment settings.
3. Deploy Databricks notebooks from `/databricks/notebooks` and attach to the designated cluster.
4. Update ADF linked services and pipelines under `/adf/pipelines` as needed.

---

## 📈 Usage

1. Open **Azure Data Factory** → **Author** → select pipeline `cdc_databricks_pipeline`.
2. **Publish** and run manually or wait for the configured Tumbling Window.
3. Monitor pipeline runs under **Monitor** and review email notifications in the designated inbox.

---

## 📂 Repository Structure

```text
CDC_Databricks_Celebal/
├── infrastructure/        # ARM templates & parameter files
├── adf/                   # Azure Data Factory JSON definitions
├── databricks/            # Databricks notebooks
│   └── cdc_notebook.ipynb
├── logicapp/              # Logic App JSON workflows
├── docs/                  # Diagrams, screenshots, and supporting docs
│   └── architecture.png
├── .github/               # CI workflows and issue templates
├── README.md              # Project overview & instructions
└── LICENSE                # MIT License
```

---

## Project Documentation
1. For Detailed Project data go to **Project_Documentation**
2. For Detailed visual interface verification go to **Interface Screenshots**

