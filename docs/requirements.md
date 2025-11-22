# AlpineBot Requirements

This document lists the functional and non-functional requirements for the AlpineBot project.

## 1. Functional Requirements

*   **FR1: User Authentication**
    *   **FR1.1:** The system shall allow users to authenticate using their Google account.
    *   **FR1.2:** The system shall create a user profile in the PostgreSQL database upon the user's first successful login.
*   **FR2: Chatbot**
    *   **FR2.1:** The system shall provide a web-based chatbot interface with a minimalist and elegant design.
    *   **FR2.2:** The chatbot shall answer questions about Switzerland.
    *   **FR2.3:** The chatbot shall use the Azure OpenAI service to generate responses.
    *   **FR2.4:** The chatbot shall use the data ingested from public data sources as its knowledge base.
    *   **FR2.5:** The chatbot shall support English, German, and French.
    *   **FR2.6:** The system shall provide a thumb up/thumb down voting mechanism for each chatbot response.
    *   **FR2.7:** The system shall store the user's feedback in the PostgreSQL database.
*   **FR3: Admin Portal**
    *   **FR3.1:** The system shall provide a web-based admin portal for managing the application, with a design consistent with the main application.
    *   **FR3.2:** The admin portal shall require administrators to authenticate.
    *   **FR3.3:** The admin portal shall allow administrators to view a list of all users.
    *   **FR3.4:** The admin portal shall allow administrators to manage data sources.
    *   **FR3.5:** The admin portal shall allow administrators to trigger the data ingestion pipeline manually.
    *   **FR3.6:** The admin portal shall display the status of the data ingestion pipeline.
    *   **FR3.7:** The admin portal shall display real-time performance metrics for the application.
    *   **FR3.8:** The admin portal shall allow administrators to manage the LLM's instructions and behavior.
    *   **FR3.9:** The admin portal shall display user feedback data, including the total number of votes and the percentage of good vs. bad responses.
*   **FR4: Data Ingestion**
    *   **FR4.1:** The system shall be able to ingest data from public data sources via API.
    *   **FR4.2:** The data ingestion process shall be automated and run on a schedule.
    *   **FR4.3:** The ingested data shall be stored in a PostgreSQL database.

## 2. Non-Functional Requirements

*   **NFR1: Performance**
    *   **NFR1.1:** The chatbot shall respond to user queries within 3 seconds.
    *   **NFR1.2:** The admin portal shall load within 5 seconds.
*   **NFR2: Scalability**
    *   **NFR2.1:** The system shall be able to handle up to 1,000 concurrent users.
*   **NFR3: Availability**
    *   **NFR3.1:** The system shall have an uptime of 99.9%.
*   **NFR4: Security**
    *   **NFR4.1:** All user data shall be encrypted at rest and in transit.
    *   **NFR4.2:** The system shall be protected against common web vulnerabilities, such as SQL injection and cross-site scripting (XSS).
*   **NFR5: Usability & Design**
    *   **NFR5.1:** The chatbot interface shall be simple, intuitive, and have a minimalist and elegant design. This includes a light color palette and a clean, simple layout.
    *   **NFR5.2:** The admin portal shall be easy to navigate and understand, and its design shall be consistent with the main application.
