# AlpineBot Backend - Azure Functions

This directory contains the Azure Functions backend for AlpineBot, providing secure API endpoints for the chatbot functionality.

## Overview

The backend is implemented using Azure Functions with Python and integrates with Azure OpenAI to process user queries and generate responses about Switzerland.

## Architecture

- **Function Runtime**: Python 3.12
- **Trigger Type**: HTTP POST
- **Authentication**: Function-level auth
- **AI Service**: Azure OpenAI (Swiss hosted)

## API Endpoints

### POST /api/chat

Processes user chat messages and returns AI-generated responses.

**Request Body:**
```json
{
  "message": "What are the main cities in Switzerland?",
  "conversation_history": [
    {
      "role": "user",
      "content": "Tell me about Switzerland"
    },
    {
      "role": "assistant",
      "content": "Switzerland is a beautiful country..."
    }
  ]
}
```

**Response:**
```json
{
  "response": "The main cities in Switzerland include Zurich, Geneva, Basel...",
  "status": "success"
}
```

**Error Response:**
```json
{
  "error": "Error message describing what went wrong"
}
```

## Environment Variables

The following environment variables must be configured:

| Variable | Description | Required |
|----------|-------------|----------|
| `AZURE_OPENAI_API_KEY` | API key for Azure OpenAI service | Yes |
| `AZURE_OPENAI_ENDPOINT` | Azure OpenAI endpoint URL | Yes |
| `AZURE_OPENAI_DEPLOYMENT_NAME` | Name of the deployed model | Yes (default: gpt-4) |
| `AZURE_OPENAI_API_VERSION` | API version to use | No (default: 2024-02-15-preview) |

## Local Development

### Prerequisites

- Python 3.12 or higher
- Azure Functions Core Tools 4.x
- Azure OpenAI credentials

### Setup

1. Install dependencies:
   ```bash
   cd backend
   pip install -r requirements.txt
   ```

2. Configure local settings:
   - Copy `local.settings.json.example` to `local.settings.json` (if provided)
   - Or update `local.settings.json` with your Azure OpenAI credentials:
     ```json
     {
       "Values": {
         "AZURE_OPENAI_API_KEY": "your-api-key",
         "AZURE_OPENAI_ENDPOINT": "https://your-resource.openai.azure.com/",
         "AZURE_OPENAI_DEPLOYMENT_NAME": "gpt-4"
       }
     }
     ```

3. Start the function locally:
   ```bash
   func start
   ```

   The function will be available at `http://localhost:7071/api/chat`

### Testing

Test the endpoint using curl:

```bash
curl -X POST http://localhost:7071/api/chat \
  -H "Content-Type: application/json" \
  -d '{
    "message": "Tell me about the Swiss Alps"
  }'
```

## Deployment

The backend is deployed to Azure via GitHub Actions. The deployment workflow:

1. Installs dependencies from `requirements.txt`
2. Packages the function app
3. Deploys to Azure Function App in Switzerland North region
4. Configures environment variables from GitHub Secrets

### Required GitHub Secrets

- `AZURE_OPENAI_API_KEY`: Azure OpenAI API key
- `AZURE_OPENAI_ENDPOINT`: Azure OpenAI endpoint URL
- `AZURE_OPENAI_DEPLOYMENT_NAME`: Model deployment name

## Security

- **API Keys**: Never commit API keys or secrets to the repository
- **Authentication**: Functions use function-level authentication
- **CORS**: Configured to allow requests only from the AlpineBot frontend domain
- **Logging**: Sensitive data is not logged; only error messages and request metadata
- **Encryption**: All data in transit is encrypted via HTTPS

## Features

### Current Implementation (Task 1.4.1)

- ✅ HTTP trigger endpoint for chat queries
- ✅ Azure OpenAI integration
- ✅ Secure credential handling via environment variables
- ✅ Error handling and logging
- ✅ Conversation history support

### Future Enhancements (Upcoming Tasks)

- [ ] Integration with PostgreSQL for chat history persistence (Task 1.5.3)
- [ ] RAG (Retrieval-Augmented Generation) with vector database
- [ ] Multilingual support (English, German, French)
- [ ] User feedback storage
- [ ] Rate limiting and usage monitoring

## Project Structure

```
backend/
├── function_app.py          # Main function implementation
├── requirements.txt         # Python dependencies
├── host.json               # Function host configuration
├── local.settings.json     # Local environment variables (git-ignored)
├── .gitignore             # Git ignore patterns
└── README.md              # This file
```

## Troubleshooting

### "Configuration error: Azure OpenAI credentials not configured"

Make sure you have set the required environment variables:
- `AZURE_OPENAI_API_KEY`
- `AZURE_OPENAI_ENDPOINT`

### "An error occurred: ..."

Check the function logs for detailed error information:
```bash
func start --verbose
```

### Local Development with Azurite

For local testing without Azure Storage, the function uses `UseDevelopmentStorage=true`. If you encounter storage-related errors, install Azurite:

```bash
npm install -g azurite
azurite
```

## Contributing

When contributing to the backend:

1. Follow Python coding standards (PEP 8)
2. Add appropriate error handling
3. Update this README if adding new endpoints or features
4. Test locally before committing
5. Ensure no secrets are committed

## Related Documentation

- [Azure Functions Python Developer Guide](https://learn.microsoft.com/en-us/azure/azure-functions/functions-reference-python)
- [Azure OpenAI Service Documentation](https://learn.microsoft.com/en-us/azure/ai-services/openai/)
- [AlpineBot Specifications](../docs/specifications.md)
