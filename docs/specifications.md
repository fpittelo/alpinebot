# AlpineBot Specifications

This document provides detailed specifications for the AlpineBot application.

**Purpose:** This file defines the desired state of the product and serves as the single source of truth for the entire development lifecycle.

# Content Focus

1. Context
2. Functional Requirements
3. Non-Functional Requirements
4. Technical Design
5. Plan

## 1. Context

- **AlpineBot** is an AI-powered chatbot providing accurate information about Swiss publicly available open data.
- **Design:** Modern, sleek, minimalist, "Swiss style".
- **Hosting:** MS Azure Switzerland, powered by Swiss-hosted OpenAI.
- **Auth:** Google authentication for users (via Azure App Service Easy Auth), Azure Entra ID for Admins.
- **Frontend:** React SPA deployed to Azure App Service.
- **Security:** Paramount importance for data privacy.

## 2. Functional Requirements

### FR1: Website Landing & General UI

- **FR1.1:** Sleek, minimalist landing page reflecting Swiss design.
- **FR1.2:** Briefly describes the purpose: friendly interaction with Swiss open data.
- **FR1.3:** Links to **Privacy Statement**, **About**, and **Guidelines** pages.
- **FR1.4:** External link to OpenAI (https://www.swiss-ai.org/OpenAI) opening in a new tab.

### FR2: Authentication Flow

- **FR2.1:** Login via Google ("Continue with Google") using Azure App Service Easy Auth.
- **FR2.2:** Redirects to AlpineBot chat upon successful login.
- **FR2.3:** Creates a user profile in PostgreSQL on first login (storing name, email, provider ID).
- **FR2.4:** Admin portal requires Azure Entra ID authentication.

### FR3: Chatbot Interface & Logic

- **FR3.1:** Minimalist web-based chat interface.
- **FR3.2:** Answers questions about Switzerland using Azure OpenAI (Swiss hosted).
- **FR3.3:** Supports English, German, and French.
- **FR3.4:** **Controls:** Thumbs up/down, Copy, Refresh for each response.
- **FR3.5:** **Disclaimer:** "AlpineBot can make mistakes. Check important info." displayed below chat.
- **FR3.6:** **Persistence:** Votes, chat history, and user ID recorded in PostgreSQL.
- **FR3.7:** **History:** Maintains last 100 interactions per user.

### FR4: User Profile Portal

- **FR4.1:** Secure profile management.
- **FR4.2:** Displays profile picture (from identity provider).
- **FR4.3:** Displays chat history (max 100 interactions).
- **FR4.4:** Option to delete individual chat items or bulk delete history.

### FR5: Admin Portal (Separate App)

- **FR5.1:** Web-based portal for management, consistent design.
- **FR5.2:** **Auth:** Azure Entra ID (Admins only).
- **FR5.3:** **User Management:** View list of authenticated users.
- **FR5.4:** **Data Sources:** Manage (Add/Edit/Delete) API endpoints for ingestion.
- **FR5.5:** **Ingestion:** Manually trigger pipeline, view status.
- **FR5.6:** **LLM Ops:** Manage system prompts, temperature, behavior.
- **FR5.7:** **Analytics:** Real-time metrics (active users, response times, errors), feedback stats (votes, good/bad %).

### FR6: Data Ingestion

- **FR6.1:** Automated scheduled Azure Function (e.g., daily).
- **FR6.2:** Ingests data from public APIs into PostgreSQL.
- **FR6.3:** Handles data transformation during ingestion.

## 3. Non-Functional Requirements

- **NFR1: Performance:** Chat response < 3s, Admin load < 5s.
- **NFR2: Scalability:** Support 1,000 concurrent users.
- **NFR3: Availability:** 99.9% uptime.
- **NFR4: Security:** Encryption at rest/transit. Protection against OWASP Top 10 (SQLi, XSS).
- **NFR5: Usability:** Minimalist, intuitive, accessible.

## 4. Technical Design

- **Frontend:** React SPA (`frontend/app`), Azure App Service, Google Easy Auth.
- **Styling:** Vanilla CSS, **Space Grotesk** font.
- **Backend:** Azure Functions (Python) for Chat API (`/api/chat`) and Ingestion.
- **AI:** Azure OpenAI (GPT-4).
- **Database:** PostgreSQL (User profiles, Chat History, Feedback, Data Sources).
- **Infrastructure:** Terraform (IaC) managed via GitHub Actions.
- **Secrets Management:** Dynamic secrets creation and storage. The dynamic creation and storage of secrets are handled entirely by Terraform's resource dependency graph, running within the authorized context of GitHub Actions pipeline.
  - _Security Insight:_ At no point does the OpenAI key value get explicitly logged to the console or hardcoded. It is read from Azure's API into Terraform's memory and then written back to Azure Key Vault's API in the same execution run. The value is stored only in the encrypted Terraform state file and in the Key Vault.
  - _Pipeline Access Control:_
    - `azurerm_function_app.proxy_function` creates the Function App with System-Assigned Managed Identity.
    - `azurerm_role_assignment.kv_access_for_function` grants the Function's Managed Identity the "Key Vault Secrets User" role.
  - _Runtime Flow:_
    - **Code Call:** Function code calls Key Vault via Azure SDK.
    - **Authentication:** Managed Identity provides a token.
    - **Retrieval:** Key Vault validates role and releases the `openai-api-key` to memory.
    - **Usage:** Function uses the key to call Azure OpenAI.
- **CI/CD:** GitHub Actions for all deployments.

## 5. Plan

### Phase 1: Foundation (Landing, Chat, Auth)

- **Milestone 1.1: Authentication & Infra**
  - [x] Terraform for App Service Auth (Google).
  - [x] CI/CD Pipeline verification.
- **Milestone 1.2: Frontend UI**
  - [x] Minimalist React App (Login, Home, About, Privacy, Guidelines).
  - [x] Google Login UI.
  - [ ] Unit/E2E tests for Login.
- **Milestone 1.3: Chatbot Interface**
  - [x] Basic Chat Interface (React).
  - [x] Feedback UI (Thumbs up/down, Copy, Refresh) - _UI only_.
  - [ ] Unit/Integration tests.
- **Milestone 1.4: Chatbot Backend**
  - [x] Azure Function setup (`function_app.py`).
  - [x] Azure OpenAI integration.
  - [ ] **Task:** Implement DB persistence (User Profile, History, Feedback).
  - [ ] Unit/Integration tests.

### Phase 2: Admin & Data (Next Steps)

- **Milestone 2.1: Admin Portal**
  - [ ] Create separate React App.
  - [ ] Azure Entra ID Auth.
- **Milestone 2.2: Data Ingestion**
  - [ ] Azure Function for scheduled ingestion.
  - [ ] PostgreSQL schema & storage logic.
- **Milestone 2.3: Management Features**
  - [ ] Data Source management UI.
  - [ ] LLM Configuration UI.
  - [ ] Analytics Dashboard.

### Phase 3: Advanced (Future)

- **Milestone 3.1: RAG & Multilingual**
  - [ ] Vector Database implementation.
  - [ ] Full RAG workflow.
- **Milestone 3.2: Hardening**
  - [ ] Security Audit.
  - [ ] Performance Optimization.
  - [ ] Production Go-Live.
