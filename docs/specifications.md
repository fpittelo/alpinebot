# AlpineBot Specifications

This document provides detailed specifications for the AlpineBot application.

Purpose: This file defines the desired state of the product, service. It serves as the single source of truth for the entire development lifecycle—from design to testing and deployment.

# Content Focus

- Context: General informations for the development
- Functional Requirements: What the system must do.
- Technical Design/Interface: Details of the interface.
- Acceptance Criteria: How successful implementation is defined.

## Context

- The AlpineBot web site is a IA powered website chatbot providing accurate information about Swiss publicly available open data in a friendly manner.

- The design of the website is modern, sleek, minimalist in the Swiss spirit.

- The hosting is MS Azure Switzerland datacenter, powered by the Swiss LLM Apertus, secured by Google authentication for users and Azure MS Entra ID for Admins.

- Security and data privacy is paramount for this project.

## Functional Requirements

## 1. User Authentication

- **1.2. Authentication Flow:**
  1.  At firts access, the user must land on the AlpineBot landing login web page which has a sleek minimalist look.
  2.  The user selects "Continue with Google".
  3.  The user is redirected to the selected identity provider's login page.
  4.  After successful authentication, the user is redirected back to the AlpineBot chat application.
- **1.3. User Profile:** A user profile will be created in the application's database after the first successful login. The profile will store the user's name, email address, and a unique identifier from the identity provider.

# AlpineBot Requirements

This document lists the functional and non-functional requirements for the AlpineBot project.

## 1. Functional Requirements

- **FR1: Website landing page**

  - **FR1.1:** The AlpineBot website has a landing web page which has a sleek minimalist look.
  - **FR1.2:** The design of the landing page (and website overall) must reflect Swiss minimalist modern design.
  - **FR1.3:** The landing page briefly describe the site purpose to interact in a friendly manner via a chatbot with Swiss publicly availailable open data.
  - **FR1.4:** The landing page will provide links to the following AlpineBot website pages: a privacy statement, an about page.
  - **FR1.5:** The landing page will provide links, open to a new tab or browser window, to the following external sources: Apertus (https://www.swiss-ai.org/apertus)

The landing login pag will be minimalist and modern. A button will allow to login with a Google account
  
 
- **FR2: Authentication flow**

  - **FR2.1:** From the AlpineBot landing page, the system shall allow users to authenticate using their Google account via a login button.
  - **FR1.3:** The user selects "Continue with Google". The user is redirected to the selected identity provider's login page.
  - **FR2.3:** After a successful authentication, The system shall create a user profile in the PostgreSQL database upon the user's first successful login.

- **FR3: Chatbot**

  - **FR3.1:** The system shall provide a web-based chatbot interface with a minimalist and elegant design.
  - **FR3.2:** The chatbot shall answer questions about Switzerland.
  - **FR3.3:** The chatbot shall use the Azure OpenAI service to generate responses.
  - **FR3.4:** The chatbot interface will be a simple, easy-to-use web application built with React. The design will be a light color palette nd a clean, simple layout.
  - **FR3.5:** The chatbot will use the Azure OpenAI service to generate responses.
  - **FR3.6:** The chatbot will use the data ingested from the public data sources as its knowledge base.
  - **FR3.7:** The chatbot will be able to understand and respond to users in English, German, and French.
  - **FR3.8:** Each chatbot response will have a thumb up and a thumb down button.
  - **FR3.9:** When a user clicks one of these buttons, the vote will be recorded in the database.
  - **FR3.10:** The recorded data will include the chat history, the response, and the user's vote.
  - **FR3.4:** The chatbot shall use the data ingested from public data sources as its knowledge base.
  - **FR3.5:** The chatbot shall support English, German, and French.
  - **FR3.6:** The chatbot shall support voting button to rate, copy and refresh each chatbot respons.
  - **FR3.7:** The system shall support to store a minimal history of users' interactions (100 maximum) in their respective profile page.
  - **FR3.8:** The system shall store the user's feedback in the PostgreSQL database.

- **FR4: User's Profile Portal**

  - **FR4.1:** The user profile shall allow each users to manage their profile securely.
  - **FR4.2:** The user profile portal shall support to manage a profile picture similar to github profile picture.
  - **FR4.3:** The user profile portal shall support to manage th
  - **FR4.4:** The user profile shall display a minimalist history of their chat of 100 interaction maximum.
  - **FR4.5:** The user shall have the capacity to delete individual history chat or delete his chat history in bulk.

- **FR5: Admin Portal**

  - **FR5.1:** The system shall provide a web-based admin portal for managing the application, with a design consistent with the main application.
  - **FR5.2:** The admin portal shall require administrators to authenticate.
  - **FR5.3:** The admin portal shall allow administrators to view a list of all users.
  - **FR5.4:** The admin portal shall allow administrators to manage data sources.
  - **FR5.5:** The admin portal shall allow administrators to trigger the data ingestion pipeline manually.
  - **FR5.6:** The admin portal shall display the status of the data ingestion pipeline.
  - **FR5.7:** The admin portal shall display real-time performance metrics for the application.
  - **FR5.8:** The admin portal shall allow administrators to manage the LLM's instructions and behavior.
  - **FR5.9:** The admin portal shall display user feedback data, including the total number of votes and the percentage of good vs. bad responses.
  - **FR5.10:** The admin portal will be a separate web application with its own authentication system. Only authorized administrators will be able to access the admin portal. The design will be consistent with the main application's minimalist aesthetic.
  - **FR5.11:** Administrators will be able to view a list of all users who have authenticated with the chatbot application.
  - **FR5.12:** Administrators will be able to manage security settings for the application, such as configuring allowed IP addresses and setting up alerts for suspicious activity.
  - **FR5.13:** The admin portal will display real-time performance metrics for the application, including: Number of active users; Chatbot response times; API usage; error rates.
  - **FR5.14:** Administrators will be able to add, edit, and delete data sources.
  - **FR5.15.1:** A data source is defined by a name, a description, and an API endpoint.
  - **FR5.15.2:** Administrators will be able to trigger the data ingestion pipeline for a specific data source manually.
  - **FR5.15.3:** The admin portal will display the status of the data ingestion pipeline for each data source.

- **FR6: Data Ingestion**

  - **FR6.1:** The system shall be able to ingest data from public data sources via API.
  - **FR6.2:** The data ingestion process shall be automated and run on a schedule.
  - **FR6.3:** The ingested data shall be stored in a PostgreSQL database.
  - **FR6.4:** The data ingestion pipeline will be implemented as an Azure Function that is triggered on a schedule (e.g., once a day).
  - **FR6.4.1:** The Azure Function will fetch data from the API endpoint of a data source.
  - **FR6.4.2:** The data may need to be transformed before it is stored. The transformation logic will be implemented in the Azure Function.
  - **FR6.5:** The ingested data will be stored in a dedicated PostgreSQL database. Each document in the collection will represent a single data record and will include a timestamp indicating when the data was ingested.

- **FR7: LLM Management:**
  - The admin portal will provide a page to manage the LLM's instructions and behavior.
  - Administrators will be able to update the LLM's system prompt, temperature, and other parameters.
- **FR8: User Feedback Analysis:**
  - The admin portal will display a page with user feedback data.
  - The page will show the total number of thumb up and thumb down votes.
  - The page will show the percentage of good vs. bad responses.

## 2. Non-Functional Requirements

- **NFR1: Performance**
  - **NFR1.1:** The chatbot shall respond to user queries within 3 seconds.
  - **NFR1.2:** The admin portal shall load within 5 seconds.
- **NFR2: Scalability**
  - **NFR2.1:** The system shall be able to handle up to 1,000 concurrent users.
- **NFR3: Availability**
  - **NFR3.1:** The system shall have an uptime of 99.9%.
- **NFR4: Security**
  - **NFR4.1:** All user data shall be encrypted at rest and in transit.
  - **NFR4.2:** The system shall be protected against common web vulnerabilities, such as SQL injection and cross-site scripting (XSS).
- **NFR5: Usability & Design**
  - **NFR5.1:** The chatbot interface shall be simple, intuitive, and have a minimalist and elegant design. This includes a light color palette and a clean, simple layout.
  - **NFR5.2:** The admin portal shall be easy to navigate and understand, and its design shall be consistent with the main application.

# AlpineBot Development Plan

This document outlines the development plan for the AlpineBot project. The project will follow a Test-Driven Development (TDD) approach.

## Phase 1: Core Infrastructure and Authentication

- **Milestone 1.1: Authentication Backend**
  - [x] **Task 1.1.1:** Define Terraform configuration for Azure App Service Authentication.
  - [x] **Task 1.1.2:** Implement automated tests for the Terraform configuration (e.g., `terraform validate`, `terraform plan` checks within CI/CD). _(Completed by updating deploy.yaml)_
  - [x] **Task 1.1.3:** Configure Google as an identity provider within the Terraform configuration. (Completed as part of 1.1.1)
  - [x] **Task 1.1.4:** _(Deprecated)_ Microsoft identity provider support removed in favor of a Google-only experience.
  - [x] **Task 1.1.5:** Verify authentication configuration deployment through CI/CD pipeline. _(Verification instructions provided in VERIFICATION.md, pending user action)_
- **Milestone 1.2: Frontend Authentication UI**
  - [ ] **Task 1.2.1:** Create a basic React application with a login page, inspired by a minimalist design.
  - [ ] **Task 1.2.2:** Write unit tests for the login page components.
  - [ ] **Task 1.2.3:** Implement the UI for the Google login button and CTA.
  - [ ] **Task 1.2.4:** Write end-to-end tests for the login flow.
- **Milestone 1.3: Basic Chatbot Interface**
  - [ ] **Task 1.3.1:** Create a basic chatbot interface using React, following the established design principles.
  - [ ] **Task 1.3.2:** Write unit tests for the chatbot interface components.
  - [ ] **Task 1.3.3:** Implement a mock chatbot service for testing.
  - [ ] **Task 1.3.4:** Write integration tests for the chatbot interface and the mock service.
- **Milestone 1.4: Chatbot Backend**
  - [ ] **Task 1.4.1:** Create an Azure Function for the chatbot backend.
  - [ ] **Task 1.4.2:** Write unit tests for the Azure Function.
  - [ ] **Task 1.4.3:** Integrate the Azure Function with the Azure OpenAI service.
  - [ ] **Task 1.4.4:** Implement a simple "echo" chatbot to test the connection.
  - [ ] **Task 1.4.5:** Write integration tests for the Azure Function and the OpenAI service.
- **Milestone 1.5: User Feedback**
  - [ ] **Task 1.5.1:** Implement the thumb up/thumb down user feedback mechanism on the chatbot responses.
  - [ ] **Task 1.5.2:** Write unit tests for the feedback components.
  - [ ] **Task 1.5.3:** Implement the backend logic to store feedback in PostgreSQL.
  - [ ] **Task 1.5.4:** Write integration tests for the feedback mechanism.

## Phase 2: Admin Portal and Data Ingestion

- **Milestone 2.1: Admin Portal Scaffolding**
  - [ ] Create a separate React application for the admin portal.
  - [ ] Implement authentication for the admin portal (e.g., using Azure AD B2C).
  - [ ] Create a basic layout for the admin portal with navigation, following the same minimalist design principles.
- **Milestone 2.2: Data Ingestion Pipeline**
  - [ ] Design a data ingestion pipeline using Azure Functions.
  - [ ] Implement a function to fetch data from a sample public API.
  - [ ] Store the ingested data in PostgreSQL.
- **Milestone 2.3: Data Source Management**
  - [ ] Create a UI in the admin portal for managing data sources.
  - [ ] Implement functionality to add, edit, and delete data sources.
  - [ ] Implement functionality to trigger the data ingestion pipeline manually.
- **Milestone 2.4: LLM Management**
  - [ ] Create a UI in the admin portal for managing the LLM's instructions and behavior.
  - [ ] Implement functionality to update the LLM's system prompt and other parameters.
- **Milestone 2.5: User Feedback Analysis**
  - [ ] Create a UI in the admin portal to display user feedback data.
  - [ ] Display the total number of votes (thumb up/thumb down).
  - [ ] Display the percentage of good vs. bad responses.

## Phase 3: Advanced Features and Deployment

- **Milestone 3.1: Advanced Chatbot Features**
  - [ ] Implement the RAG workflow with a vector database.
  - [ ] Implement multilingual support (English, German, French).
- **Milestone 3.2: Performance and Security**
  - [ ] Implement performance monitoring in the admin portal.
  - [ ] Implement security best practices for the entire application.
  - [ ] Conduct a security review of the application.
- **Milestone 3.3: Deployment and Go-Live**
  - [ ] Deploy the application to the production environment.
  - [ ] Conduct user acceptance testing (UAT).
  - [ ] Go live!
