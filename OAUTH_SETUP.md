# OAuth Application Setup Guide

This guide provides step-by-step instructions for configuring OAuth applications for Google and Microsoft authentication with AlpineBot.

## Overview

AlpineBot uses Azure App Service's built-in authentication (Easy Auth) feature, which requires OAuth 2.0 applications to be configured with both Google and Microsoft. The authentication is handled at the infrastructure level, and the React frontend redirects users to Azure's authentication endpoints.

## Prerequisites

- Access to Google Cloud Console
- Access to Azure Portal with appropriate permissions
- GitHub repository access to set secrets

## Google OAuth Application Setup

### Step 1: Access Google Cloud Console

1. Navigate to [Google Cloud Console](https://console.cloud.google.com/)
2. Sign in with your Google account

### Step 2: Create or Select a Project

1. Click on the project dropdown at the top of the page
2. Either select an existing project or click "NEW PROJECT"
3. If creating a new project:
   - Enter project name: `AlpineBot` (or your preferred name)
   - Click "CREATE"

### Step 3: Enable Required APIs

1. Navigate to "APIs & Services" > "Library"
2. Search for "Google+ API" and enable it (if not already enabled)

### Step 4: Create OAuth 2.0 Credentials

1. Navigate to "APIs & Services" > "Credentials"
2. Click "CREATE CREDENTIALS" > "OAuth client ID"
3. If prompted to configure the OAuth consent screen:
   - Click "CONFIGURE CONSENT SCREEN"
   - Select "External" user type
   - Click "CREATE"
   - Fill in the required information:
     - App name: AlpineBot
     - User support email: Your email
     - Developer contact information: Your email
   - Click "SAVE AND CONTINUE"
   - Skip adding scopes (or add openid, profile, email)
   - Click "SAVE AND CONTINUE"
   - Add test users if needed
   - Click "SAVE AND CONTINUE"

4. Back at the credentials page, click "CREATE CREDENTIALS" > "OAuth client ID"
5. Select "Web application" as the application type
6. Enter a name: "AlpineBot Web App"

### Step 5: Configure Authorized Redirect URIs

Add the following redirect URIs based on your environments:

**For Development Environment:**
```
https://dev-alpinebot-as.azurewebsites.net/.auth/login/google/callback
```

**For QA Environment:**
```
https://qa-alpinebot-as.azurewebsites.net/.auth/login/google/callback
```

**For Production Environment:**
```
https://main-alpinebot-as.azurewebsites.net/.auth/login/google/callback
```

**Important**: The redirect URI must match exactly, including the protocol (https), subdomain, and path.

### Step 6: Save Client ID and Secret

1. Click "CREATE"
2. A dialog will appear with your client ID and client secret
3. **Save these values securely** - you'll need them for the GitHub secrets

## Microsoft OAuth Application Setup

### Step 1: Access Azure Portal

1. Navigate to [Azure Portal](https://portal.azure.com/)
2. Sign in with your Microsoft account

### Step 2: Register a New Application

1. In the search bar, type "Azure Active Directory" and select it
2. In the left sidebar, click "App registrations"
3. Click "+ New registration"

### Step 3: Configure Application Registration

1. Enter the application details:
   - **Name**: AlpineBot
   - **Supported account types**: Select "Accounts in any organizational directory (Any Azure AD directory - Multitenant) and personal Microsoft accounts (e.g. Skype, Xbox)"
   - **Redirect URI**: 
     - Select platform: "Web"
     - Enter URI: `https://dev-alpinebot-as.azurewebsites.net/.auth/login/aad/callback`

2. Click "Register"

### Step 4: Add Additional Redirect URIs

After registration:

1. Go to "Authentication" in the left sidebar
2. Under "Platform configurations" > "Web", click "Add URI"
3. Add the following redirect URIs:

**For QA Environment:**
```
https://qa-alpinebot-as.azurewebsites.net/.auth/login/aad/callback
```

**For Production Environment:**
```
https://main-alpinebot-as.azurewebsites.net/.auth/login/aad/callback
```

4. Make sure "ID tokens (used for implicit and hybrid flows)" is checked
5. Click "Save"

### Step 5: Create a Client Secret

1. In the left sidebar, click "Certificates & secrets"
2. Under "Client secrets", click "+ New client secret"
3. Enter a description: "AlpineBot Client Secret"
4. Select an expiration period (recommended: 24 months)
5. Click "Add"
6. **Immediately copy the secret value** - it will only be shown once
7. Also note the "Application (client) ID" from the Overview page

### Step 6: Configure API Permissions (Optional)

1. In the left sidebar, click "API permissions"
2. The default "User.Read" permission should be sufficient
3. If you need additional permissions, click "+ Add a permission"

## Configure GitHub Secrets

Once you have both OAuth applications configured, add the following secrets to your GitHub repository:

### Adding Secrets to GitHub

1. Go to your GitHub repository
2. Click "Settings" > "Secrets and variables" > "Actions"
3. Click "New repository secret"

### Required Secrets

Add the following secrets:

1. **GOOGLE_CLIENT_ID**
   - Value: The Client ID from Google Cloud Console

2. **GOOGLE_CLIENT_SECRET**
   - Value: The Client Secret from Google Cloud Console

3. **MICROSOFT_CLIENT_ID**
   - Value: The Application (client) ID from Azure Portal

4. **MICROSOFT_CLIENT_SECRET**
   - Value: The Client Secret value from Azure Portal

## Testing the Configuration

After configuring the OAuth applications and GitHub secrets:

1. Trigger a deployment to the dev environment via GitHub Actions
2. Wait for the deployment to complete
3. Navigate to `https://dev-alpinebot-as.azurewebsites.net`
4. You should see the login page
5. Click "Login with Google" or "Login with Microsoft"
6. You should be redirected to the respective login page
7. After successful authentication, you should be redirected back to AlpineBot

## Troubleshooting

### "Unauthorized client" Error

**Problem**: Getting "unauthorized_client" error when trying to authenticate.

**Solutions**:
- Verify that the OAuth application is created and enabled
- Ensure redirect URIs match exactly (check for typos, protocol, trailing slashes)
- Confirm that GitHub secrets are set correctly
- Check that the Terraform deployment completed successfully
- Verify that the client IDs in the deployed Azure App Service match the OAuth applications

### "Redirect URI mismatch" Error

**Problem**: Error stating that the redirect URI doesn't match.

**Solutions**:
- Double-check the redirect URI in the OAuth application configuration
- Ensure it matches the format: `https://{app-name}.azurewebsites.net/.auth/login/{provider}/callback`
- For Google, the provider is "google"
- For Microsoft, the provider is "aad"

### Client Secret Expired

**Problem**: Authentication suddenly stops working after some time.

**Solutions**:
- Check if the Microsoft client secret has expired
- Generate a new client secret in Azure Portal
- Update the GitHub secret `MICROSOFT_CLIENT_SECRET`
- Redeploy the application

### Application Not Found

**Problem**: Error stating the application doesn't exist.

**Solutions**:
- Verify the OAuth application exists in the respective console
- Check that the correct Client ID is used
- Ensure the application is enabled (not disabled)

## Security Best Practices

1. **Never commit secrets**: OAuth client secrets should never be committed to the repository
2. **Rotate secrets regularly**: Update client secrets periodically
3. **Use separate OAuth apps**: Consider using separate OAuth applications for dev, qa, and production environments
4. **Limit scopes**: Only request the minimum required OAuth scopes
5. **Monitor access**: Regularly review OAuth consent logs and access patterns

## Additional Resources

- [Google OAuth 2.0 Documentation](https://developers.google.com/identity/protocols/oauth2)
- [Microsoft Identity Platform Documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/)
- [Azure App Service Authentication Documentation](https://docs.microsoft.com/en-us/azure/app-service/overview-authentication-authorization)
