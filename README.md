# AlpineBot _🇨🇭

AlpineBot is an AI-powered chatbot for everything Switzerland, presented with a minimalist and elegant design inspired by the provided image in the `inspiration` folder. The interface will feature a clean, airy aesthetic with a focus on white and light gray, and will use a large, high-quality background image of the Swiss Alps. To access the chatbot, users must authenticate using their Google or Microsoft accounts. The application includes an admin portal for full management of the application, including security, performance, data ingestion from live public data sources, and management of the LLM's instructions and behavior.

## Features 🚀

- **Swiss Public Data**: Real-time information about Switzerland from various public data sources.
- **AI-Powered**: Human-like responses via Azure OpenAI, using a Retrieval-Augmented Generation (RAG) architecture for up-to-date and accurate answers.
- **Secure Authentication**: Users can log in using their Google or Microsoft accounts.
- **Admin Portal**: A comprehensive admin portal for managing the application, including:
    - User management
    - Security settings
    - Performance monitoring
    - Data source management and ingestion
    - LLM instruction and behavior management
    - User feedback analysis
- **User Feedback**: Users can provide feedback on the chatbot's responses using a thumb up/thumb down voting system.
- **Real-Time Data Ingestion**: The ability to connect to live public data sources via API and ingest data regularly for up-to-date knowledge.
- **Multilingual**: Support for English, German, and French (coming soon).
- **Minimalist Design**: A clean, elegant, and user-friendly interface inspired by the provided image, featuring a large background image of the Swiss Alps and a light color palette.

## Getting Started ⛷️

### Prerequisites

- Python 3.x, Azure Functions Core Tools, Terraform, Azure CLI

### Installation

1. **Clone & Setup**:

   ```bash
   git clone https://github.com/fpittelo/alpinebot/ && cd AlpineBot
   # Ensure env vars are set: AZURE_OPENAI_KEY, OPENDATA_API_KEY (optional)
   ```

2. **Deploy**:

   Infrastructure deployment is managed exclusively through GitHub Actions. Pushing changes to the `dev` branch or merging pull requests into `qa` or `main` will trigger the automated deployment workflows.

## Project Structure 🗂️

- `/frontend`: React app
- `/backend`: Azure Functions
- `/terraform`: Infrastructure code
- `/data`: Sample datasets
- `/inspiration`: Design inspiration for the user interface.

## Architecture 🏗️

```mermaid
graph TD
    subgraph "User & Admin Interfaces"
        User[User] --> Frontend[React Web App];
        Admin[Admin] --> AdminPortal[React Admin Portal];
    end

    subgraph "Authentication"
        Frontend --> Auth[Azure App Service Auth];
        Auth --> Google[Google Identity];
        Auth --> Microsoft[Microsoft Identity];
        AdminPortal --> AdminAuth[Azure AD B2C];
    end

    subgraph "Backend Logic (Azure Functions)"
        Frontend --> Backend_User_Query[User Query Function];
        AdminPortal --> Backend_Admin_Actions[Admin Actions Function];
    end

    subgraph "Data Ingestion & Processing"
        PublicData[Public Data Sources] --> Ingestion_Func[Data Ingestion Function];
        Ingestion_Func -- chunks of text --> Embedding_Model[Azure OpenAI Embedding Model];
        Embedding_Model -- vectors --> VectorDB[Azure AI Search - Vector DB];
    end

    subgraph "RAG Workflow"
        Backend_User_Query -- user query --> Embedding_Model;
        Embedding_Model -- query vector --> VectorDB;
        VectorDB -- relevant chunks --> Backend_User_Query;
        Backend_User_Query -- prompt + context --> OpenAI_Completion[Azure OpenAI Completion Model];
        OpenAI_Completion -- generated response --> Backend_User_Query;
        Backend_User_Query -- final answer --> Frontend;
    end

    subgraph "Data & Monitoring"
        Backend_User_Query -- session data --> Redis[Azure Cache for Redis];
        Backend_User_Query --> PostgreSQL[Azure DB for PostgreSQL for Chat History & Feedback];
        Backend_Admin_Actions --> PostgreSQL;
        Backend_User_Query --> AppInsights[Application Insights];
        Ingestion_Func --> AppInsights;
    end
```

## Development Process

This project follows an iterative development process and a Test-Driven Development (TDD) approach. All development will be done in small, manageable increments, with tests written before the code. All GitHub activities, such as issues, merges, and pull requests, will be documented. The documentation will be updated if any change occurs.

## Contributing & License 📜

We welcome PRs! AlpineBot is MIT Licensed.

## Contact 📧

Open an issue if you need help. The Alps are waiting! 🏔️
