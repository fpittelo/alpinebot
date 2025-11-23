# AlpineBot Frontend Application

This is the React frontend application for AlpineBot, featuring authentication via Google accounts through Azure App Service.

## Product Context & Hosting

- AlpineBot is an AI-powered chatbot that surfaces Swiss open data insights for end users in a friendly tone.
- The landing page and chat UI run on Azure App Service in the Switzerland region, reflecting the minimalist Swiss design language outlined in `docs/specifications.md`.
- Azure OpenAI (Swiss hosted) generates responses, while PostgreSQL and related Azure services in Switzerland store profiles, chat history, feedback, and data-ingestion artifacts securely.
- End-user authentication uses Google accounts through Azure App Service Easy Auth; the forthcoming admin portal will enforce Azure Entra ID for administrators.
- Security and privacy (encryption, hard tenancy, continuous monitoring) are baseline requirements across all environments.

## Key Features (per specifications)

- **Landing experience:** A sleek landing page introduces the Swiss open data mission and links to Privacy, About, and the external OpenAI resource in new tabs.
- **Authentication:** The “Continue with Google” CTA (/.auth/login/google) provisions a PostgreSQL profile with the user’s name, email, and IdP identifier on first login.
- **Chatbot experience:** A minimalist React interface backed by Azure OpenAI and curated Swiss open data knowledge, supporting English, German, and French.
- **User profiles:** Phase 2 introduces a secure portal for managing avatars, viewing up to 100 recent interactions, and deleting entries individually or in bulk.
- **Feedback loop:** Every chatbot response exposes thumbs up/down, copy, and refresh controls, persisting votes plus context for analytics.
- **Admin portal:** A separate Entra ID–secured React app will list users, manage data sources and security settings, display ingestion status/performance metrics, and tune LLM instructions.
- **Data ingestion:** Scheduled Azure Functions fetch, transform, and store public data into PostgreSQL to keep the knowledge base current.
- **LLM management & analytics:** Administrators adjust prompts/parameters and review aggregated feedback (totals and good/bad ratios) inside the portal.

## Authentication Setup

The application uses Azure App Service's built-in authentication and authorization (Easy Auth) feature. The authentication is handled at the infrastructure level, requiring proper OAuth application configuration.

### Required OAuth Configuration

#### Google OAuth Application

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Navigate to "APIs & Services" > "Credentials"
4. Create an OAuth 2.0 Client ID
5. Configure the following:
   - Application type: Web application
   - Authorized redirect URIs:
     - For dev: `https://dev-alpinebot-as.azurewebsites.net/.auth/login/google/callback`
     - For qa: `https://qa-alpinebot-as.azurewebsites.net/.auth/login/google/callback`
     - For main: `https://main-alpinebot-as.azurewebsites.net/.auth/login/google/callback`
6. Note the Client ID and Client Secret
7. Add these as GitHub secrets:
   - `GOOGLE_CLIENT_ID`
   - `GOOGLE_CLIENT_SECRET`

### Authentication Flow

1. **Unauthenticated Access**: When a user visits the application without being authenticated, they see the login page with the option to sign in with Google.

2. **Login Process**:

   - User clicks on "Continue with Google"
   - The app redirects to Azure App Service's authentication endpoint (`/.auth/login/google`)
   - Azure App Service handles the OAuth flow with the identity provider
   - After successful authentication, user is redirected back to the app

3. **Authenticated Access**:
   - The app checks authentication status using the `/.auth/me` endpoint
   - If authenticated, the HomePage component is displayed with user information
   - User can logout using the `/.auth/logout` endpoint

## Development

### Prerequisites

- Node.js 14.x or higher
- npm 6.x or higher

### Installation

```bash
cd frontend/app
npm install
```

### Running Locally

```bash
npm start
```

**Note**: When running locally, the Azure App Service authentication endpoints (`/.auth/me`, `/.auth/login/*`, `/.auth/logout`) will not work unless you configure a local development proxy or mock these endpoints.

### Environment Variables

The application requires the following environment variable to connect to the backend API:

- `REACT_APP_FUNCTION_APP_URL`: The URL of the Azure Function App (e.g., `https://dev-alpinebot-func.azurewebsites.net`)

For local development, create a `.env.local` file (see `.env.example` for reference):

```bash
REACT_APP_FUNCTION_APP_URL=https://dev-alpinebot-func.azurewebsites.net
```

This variable is automatically set during CI/CD deployment based on the environment.

### Building for Production

```bash
npm run build
```

The build artifacts will be stored in the `build/` directory.

## Deployment

The application is automatically deployed via GitHub Actions when changes are pushed to the repository. See `.github/workflows/deploy.yaml` for details.

## Project Structure

```
frontend/app/
├── public/           # Static files
├── src/
│   ├── App.js       # Main application component with auth logic
│   ├── LoginPage.js # Login page component
│   ├── HomePage.js  # Home page for authenticated users
│   └── ...          # Other components and styles
└── package.json
```

## Troubleshooting

### "Unauthorized client" Error

This error occurs when:

1. The OAuth application is not properly configured
2. The redirect URIs don't match the App Service URL
3. The client ID or secret is incorrect

**Solution**: Verify that:

- OAuth applications are created and configured correctly
- Redirect URIs match exactly (including protocol and path)
- GitHub secrets contain the correct client IDs and secrets
- The Terraform deployment has completed successfully

### Authentication Not Working Locally

The Azure App Service authentication only works when the app is deployed to Azure. For local development, you would need to either:

1. Mock the authentication endpoints
2. Use Azure Static Web Apps CLI for local emulation
3. Disable authentication checks during local development

## Roadmap Alignment

- **Phase 1:** Landing page, authentication UI, baseline chatbot, and feedback widgets (current React app scope).
- **Phase 2:** Admin portal scaffolding plus data ingestion, source management, LLM controls, and feedback analytics.
- **Phase 3:** Advanced RAG workflows, multilingual hardening, performance/security improvements, and production go-live readiness.

Refer to `docs/specifications.md` for the authoritative milestone and task breakdown.
