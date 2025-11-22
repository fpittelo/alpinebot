# Project Overview

This project contains the Terraform infrastructure for a chatbot called AlpineBot. The chatbot is deployed on Azure and uses various Azure services, including Azure OpenAI, Azure App Service, Cosmos DB, and Application Insights.

The chatbot provides information about Switzerland and requires users to authenticate with their Google or Microsoft account. The user interface will have a minimalist and elegant design. It also features an admin portal for managing the application, security, performance, data ingestion from live public data sources, and the LLM's instructions and behavior. Users can provide feedback on the chatbot's responses using a thumb up/thumb down voting system.

The infrastructure is defined using a modular approach, with separate modules for each Azure service. The project is structured to support multiple environments (dev, qa, main).

## Building and Running

### Prerequisites

> [!IMPORTANT]
> **NO LOCAL OPERATIONS**: This project is designed to be deployed and managed **exclusively** via the GitHub Actions pipeline. You do **NOT** need to run Terraform or Azure CLI commands locally on your machine. All infrastructure changes must be committed to the repository and deployed through the automated workflows.

*   Python 3.x, Azure Functions Core Tools (for local function development only)

### Configuration

1.  **Azure Credentials:** You will need to have an Azure Service Principal with the necessary permissions to create the resources defined in the Terraform configuration. The credentials for this service principal should be set as secrets in your GitHub repository (`AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID`, `AZURE_SP_OBJECT_ID`).
2.  **Terraform Variables:** The `infra` directory contains `dev.tfvars`, `qa.tfvars`, and `main.tfvars` files for environment-specific variables. You will need to populate these files with the appropriate values for your environment.
3.  **Authentication Providers:** You will need to configure OAuth 2.0 applications for Google and Microsoft to enable user authentication. The client IDs and secrets for these applications will need to be added to the Azure App Service configuration.

### Deployment

The infrastructure is deployed exclusively through GitHub Actions workflows defined in `.github/workflows/deploy.yaml`. Pushing changes to the `dev` branch or merging pull requests into `qa` or `main` will trigger the automated deployment workflows. All Terraform state management is also handled by GitHub Actions.

## Development Conventions

*   **Iterative Development:** All development will be done in small, manageable increments.
*   **Test-Driven Development (TDD):** All code will be developed using a TDD approach, with tests written before the code.
*   **Modular Terraform:** The Terraform code is organized into modules, with each module responsible for a single Azure service. This promotes reusability and maintainability.
*   **Multiple Environments:** The project is set up to support multiple environments (dev, qa, main). Environment-specific variables are stored in `.tfvars` files.
*   **CI/CD:** The infrastructure is deployed using a GitHub Actions workflow, which provides a consistent and automated deployment process. **Local Terraform execution is strictly prohibited.**
*   **Authentication:** User authentication is handled by Azure App Service's built-in authentication and authorization capabilities, integrated with Google and Microsoft as identity providers.
*   **User Feedback:** User feedback is collected through a voting system on the chatbot's responses and analyzed in the admin portal.
*   **LLM Management:** The LLM's instructions and behavior are managed through the admin portal to allow for continuous improvement.
*   **Design:** The user interface should follow the minimalist and elegant design principles. This includes a clean, simple layout.
*   **Documentation:** All GitHub activities, such as issues, merges, and pull requests, will be documented. The documentation will be updated if any change occurs.