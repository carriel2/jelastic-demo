# 🚀 Full Stack Observability & Automation Lab

## 🌐 Select Language / Selecione o Idioma
[🇺🇸 English Version](#-english-version) | [🇧🇷 Versão em Português](#-versão-em-português)

---

## 🇺🇸 English Version
This project demonstrates a reference architecture for Modern DevOps, utilizing **SaveinCloud (Jelastic PaaS)**, **Docker**, **PostgreSQL**, and **GitHub Actions**.

### 🏗️ Architecture & Topology
The project implements an automated **Hybrid Topology** designed for stability and flexibility:

* **Application Layer:** Python/FastAPI running on **Docker Engine** nodes (Flexible & Containerized).
* **Data Layer:** Native **PostgreSQL** (Managed by the PaaS for better performance, backups, and security).
* **Observability:** Prometheus + Grafana stack pre-configured for real-time metrics.
* **CI/CD:** Full pipeline via GitHub Actions (**Zero Touch Deploy**).

### ⚙️ How the Pipeline Works
1.  **Push to Main:** The developer commits code to the GitHub repository.
2.  **Infrastructure Check:** GitHub Actions connects to the Cloud Provider via CLI and checks if the environment exists.
3.  **Provisioning (IaC):** If the environment is missing, the script installs the `manifest.jps` (Infrastructure as Code), creating the Database and Docker Engine from scratch.
4.  **Continuous Deployment:** If the environment exists, the script executes a remote command (`execcmdbygroup`) to pull the latest code and restart containers using Docker Compose.

### 📊 Observability
The environment automatically provisions:
* **Grafana (Port 3000):** For visualizing infrastructure and app metrics.
* **Prometheus:** Scrapes metrics from the containerized application.

---

### 🛠️ Technical Documentation & Setup

To replicate this deployment, you must configure **GitHub Secrets** in your repository settings (`Settings > Secrets and variables > Actions`). The pipeline relies on these environment variables to authenticate and interact with the Jelastic API.

#### 🔑 Required Environment Variables (Secrets)

| Variable Name | Description | Note |
| :--- | :--- | :--- |
| `JELASTIC_EMAIL` | Your Jelastic/SaveinCloud account email. | The email used for login. |
| `JELASTIC_PASSWORD` | **Access Token** (Recommended) or Password. | **Critical:** If 2FA is enabled, you MUST generate an **Access Token** in the dashboard (Settings > Access Tokens) and use it here. The CLI treats this as the password. |
| `JELASTIC_API_URL` | The Platform Entry Point URL. | Find your provider's URL here: [Hosting Providers List](https://www.virtuozzo.com/application-platform-docs/hosting-providers/). For SaveinCloud, use `app.saveincloud.net.br`. |
| `JELASTIC_ENV_NAME` | The target environment name. | The unique name (subdomain) for your environment (e.g., `my-observability-lab`). |

#### 🚀 Deployment Commands
The pipeline executes the following logic automatically:

1.  **Authentication:** Uses `JELASTIC_EMAIL` and `JELASTIC_PASSWORD` (Token) to create a session.
2.  **Verification:** Checks if `JELASTIC_ENV_NAME` exists using `getenvinfo`.
3.  **Execution:**
    * *If exists:* Runs `git pull` & `docker compose up -d --build` inside the container.
    * *If missing:* Provisions the infrastructure using `manifest.jps`.

---

## 🇧🇷 Versão em Português
Este projeto demonstra uma arquitetura de referência para DevOps Moderno, utilizando **SaveinCloud (Jelastic PaaS)**, **Docker**, **PostgreSQL** e **GitHub Actions**.

### 🏗️ Arquitetura e Topologia
O projeto implementa uma **Topologia Híbrida** automatizada, desenhada para estabilidade e flexibilidade:

* **Camada de Aplicação:** Python/FastAPI rodando em nós **Docker Engine** (Flexível e Containerizado).
* **Camada de Dados:** **PostgreSQL Nativo** (Gerenciado pela PaaS para melhor performance, backups e segurança).
* **Observabilidade:** Stack Prometheus + Grafana pré-configurada para métricas em tempo real.
* **CI/CD:** Pipeline completo via GitHub Actions (**Zero Touch Deploy**).

### ⚙️ Como Funciona o Pipeline
1.  **Push na Main:** O desenvolvedor envia o código para o repositório GitHub.
2.  **Checagem de Infraestrutura:** O GitHub Actions conecta no provedor de nuvem via CLI e verifica se o ambiente já existe.
3.  **Provisionamento (IaC):** Se o ambiente não existir, o script instala o `manifest.jps` (Infraestrutura como Código), criando o Banco de Dados e o Docker Engine do zero.
4.  **Deploy Contínuo:** Se o ambiente já existir, o script executa um comando remoto (`execcmdbygroup`) para baixar o código mais recente (`git pull`) e reiniciar os containers via Docker Compose.

### 📊 Observabilidade
O ambiente provisiona automaticamente:
* **Grafana (Porta 3000):** Para visualização de métricas da infraestrutura e da aplicação.
* **Prometheus:** Coleta métricas da aplicação containerizada.

---

### 🛠️ Documentação Técnica e Configuração

Para replicar este deploy, você deve configurar as **GitHub Secrets** nas configurações do repositório (`Settings > Secrets and variables > Actions`). O pipeline depende dessas variáveis de ambiente para autenticar e interagir com a API do Jelastic.

#### 🔑 Variáveis de Ambiente Necessárias (Secrets)

| Nome da Variável | Descrição | Nota Importante |
| :--- | :--- | :--- |
| `JELASTIC_EMAIL` | E-mail da sua conta Jelastic/SaveinCloud. | O e-mail utilizado para login na plataforma. |
| `JELASTIC_PASSWORD` | **Token de Acesso** (Recomendado) ou Senha. | **Crítico:** Se o 2FA estiver ativo, você DEVE gerar um **Token de Acesso** no painel (Configurações > Tokens de Acesso) e usá-lo aqui. A CLI interpreta o token como senha (`--password`). |
| `JELASTIC_API_URL` | URL de Entrada da Plataforma (API). | Consulte a URL do seu provedor aqui: [Lista de Provedores](https://www.virtuozzo.com/application-platform-docs/hosting-providers/). Para SaveinCloud, utilize `app.saveincloud.net.br`. |
| `JELASTIC_ENV_NAME` | O nome do ambiente alvo. | O nome único (subdomínio) que será criado ou atualizado (ex: `meu-lab-observabilidade`). |

#### 🚀 Comandos de Deploy
O pipeline executa a seguinte lógica automaticamente:

1.  **Autenticação:** Utiliza `JELASTIC_EMAIL` e `JELASTIC_PASSWORD` (Token) para criar uma sessão.
2.  **Verificação:** Checa se o ambiente definido em `JELASTIC_ENV_NAME` existe usando o comando `getenvinfo`.
3.  **Execução:**
    * *Se existir:* Roda `git pull` e `docker compose up -d --build` dentro do container.
    * *Se não existir:* Provisiona toda a infraestrutura utilizando o `manifest.jps`.
