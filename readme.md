# 🚀 Full Stack Observability & Automation Lab

![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Grafana](https://img.shields.io/badge/Grafana-F46800?style=for-the-badge&logo=grafana&logoColor=white)
![Jelastic](https://img.shields.io/badge/Jelastic_PaaS-blue?style=for-the-badge)

---

### 🌐 Select Language / Selecione o Idioma

[🇺🇸 English Version](#-english-version) | [🇧🇷 Versão em Português](#-versão-em-português)

---

## 🇺🇸 English Version

This project demonstrates a reference architecture for **Modern DevOps**, utilizing **SaveinCloud (Jelastic PaaS)**, **Docker**, **PostgreSQL**, and **GitHub Actions**.

### 🏗️ Architecture & Topology
The project implements an automated **Hybrid Topology** designed for stability and flexibility:
* **Application Layer:** Python/FastAPI running on **Docker Engine** nodes (Flexible & Containerized).
* **Data Layer:** **Native PostgreSQL** (Managed by the PaaS for better performance, backups, and security).
* **Observability:** Prometheus + Grafana stack pre-configured for real-time metrics.
* **CI/CD:** Full pipeline via **GitHub Actions** (Zero Touch Deploy).

### ⚙️ How the Pipeline Works
1.  **Push to Main:** The developer commits code to the GitHub repository.
2.  **Infrastructure Check:** GitHub Actions connects to the Cloud Provider via CLI and checks if the environment exists.
3.  **Provisioning (IaC):** If the environment is **missing**, the script installs the `manifest.jps` (Infrastructure as Code), creating the Database and Docker Engine from scratch.
4.  **Continuous Deployment:** If the environment **exists**, the script executes a remote command (`execcmdbygroup`) to pull the latest code and restart containers using Docker Compose.

### 📊 Observability
The environment automatically provisions:
* **Grafana** (Port 3000): For visualizing infrastructure and app metrics.
* **Prometheus:** Scrapes metrics from the containerized application.

---

## 🇧🇷 Versão em Português

Este projeto demonstra uma arquitetura de referência para **DevOps Moderno**, utilizando **SaveinCloud (Jelastic PaaS)**, **Docker**, **PostgreSQL** e **GitHub Actions**.

### 🏗️ Arquitetura e Topologia
O projeto implementa uma **Topologia Híbrida** automatizada, desenhada para estabilidade e flexibilidade:
* **Camada de Aplicação:** Python/FastAPI rodando em nós **Docker Engine** (Flexível e Containerizado).
* **Camada de Dados:** **PostgreSQL Nativo** (Gerenciado pela PaaS para melhor performance, backups e segurança).
* **Observabilidade:** Stack Prometheus + Grafana pré-configurada para métricas em tempo real.
* **CI/CD:** Pipeline completo via **GitHub Actions** (Zero Touch Deploy).

### ⚙️ Como Funciona o Pipeline
1.  **Push na Main:** O desenvolvedor envia o código para o repositório GitHub.
2.  **Checagem de Infraestrutura:** O GitHub Actions conecta no provedor de nuvem via CLI e verifica se o ambiente já existe.
3.  **Provisionamento (IaC):** Se o ambiente **não existir**, o script instala o `manifest.jps` (Infraestrutura como Código), criando o Banco de Dados e o Docker Engine do zero.
4.  **Deploy Contínuo:** Se o ambiente **já existir**, o script executa um comando remoto (`execcmdbygroup`) para baixar o código mais recente (git pull) e reiniciar os containers via Docker Compose.

### 📊 Observabilidade
O ambiente provisiona automaticamente:
* **Grafana** (Porta 3000): Para visualização de métricas da infraestrutura e da aplicação.
* **Prometheus:** Coleta métricas da aplicação containerizada.
