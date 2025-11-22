# AlpineBot Frontend Application

This is the React frontend application for AlpineBot, featuring authentication via Google accounts through Azure App Service.

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
