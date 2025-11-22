# Workflow Documentation

This document explains the modular deployment and destroy workflows for the AlpineBot infrastructure.

## Overview

The deployment and destroy processes have been modularized into distinct, triggerable workflows. This allows for:
- **Efficiency**: Only deploy what you need (backend, infrastructure, or application)
- **Flexibility**: Run workflows independently or orchestrated together
- **Cost Optimization**: Avoid unnecessary operations (e.g., running Terraform when only frontend changes)

## Workflow Architecture

### Deployment Workflows

#### 1. `deploy-backend.yaml` - Backend Storage Deployment
**Purpose**: Creates the remote Terraform state storage in Azure (Blob Storage)

**When to use**:
- First-time setup for a new environment
- Rarely needed after initial setup
- Only if backend storage was accidentally deleted

**What it creates**:
- Azure Resource Group: `{env}-bkd-alpinebot`
- Azure Storage Account: `{env}bkdalpinebotsa`
- Azure Storage Container: `{env}-bkd-alpinebot-co`

**Trigger**: Manual (workflow_dispatch)

#### 2. `deploy-infra.yaml` - Infrastructure Deployment
**Purpose**: Deploys all infrastructure using Terraform

**When to use**:
- When infrastructure code changes (modules, main.tf, variables, etc.)
- When scaling resources
- When adding/removing Azure services

**What it deploys**:
- Azure Resource Group
- Key Vault
- OpenAI Cognitive Account
- App Service Plan
- Linux Web App (App Service)
- Redis Cache
- PostgreSQL Database
- Log Analytics Workspace
- Application Insights

**Prerequisites**: Backend storage must exist (run `deploy-backend.yaml` first)

**Trigger**: Manual (workflow_dispatch)

#### 3. `deploy-app.yaml` - Application Deployment
**Purpose**: Builds and deploys only the frontend React application

**When to use**:
- On every frontend code change
- When updating UI/UX
- Most frequent deployment workflow

**What it does**:
- Installs npm dependencies
- Builds React application
- Deploys build artifacts to Azure Web App

**Prerequisites**: Infrastructure must exist (run `deploy-infra.yaml` first)

**Trigger**: Manual (workflow_dispatch)

#### 4. `deploy.yaml` - Full Environment Orchestrator
**Purpose**: Orchestrates backend, infrastructure, and application deployment in sequence

**When to use**:
- Complete environment setup
- When you want to control which components to deploy
- Backward compatibility with old workflow

**Features**:
- Optional backend deployment (default: false)
- Optional infrastructure deployment (default: true)
- Optional application deployment (default: true)
- Jobs run in sequence with proper dependencies

**Trigger**: Manual (workflow_dispatch)

### Destroy Workflows

#### 1. `destroy-app.yaml` - Application Destroy
**Purpose**: Stops the Web App deployment

**When to use**:
- To stop the running application without destroying infrastructure
- Temporary shutdown to save costs
- Before redeploying a fresh build

**What it does**:
- Stops the Azure Web App

**Note**: Does not delete the App Service resource, only stops it

**Trigger**: Manual (workflow_dispatch)

#### 2. `destroy-infra.yaml` - Infrastructure Destroy
**Purpose**: Destroys all Terraform-managed infrastructure

**When to use**:
- Tearing down an environment
- Before major infrastructure changes
- Cleanup after testing

**What it destroys**:
- All resources created by Terraform
- Does NOT destroy backend storage (state remains safe)

**Prerequisites**: Should stop the app first (run `destroy-app.yaml`)

**Trigger**: Manual (workflow_dispatch)

#### 3. `destroy-backend.yaml` - Backend Storage Destroy
**Purpose**: Destroys the backend Terraform state storage

**When to use**:
- Complete environment teardown
- WARNING: This deletes your Terraform state!

**What it destroys**:
- Storage Container
- Storage Account
- Resource Group

**Prerequisites**: Should destroy infrastructure first (run `destroy-infra.yaml`)

**⚠️ WARNING**: After running this, you will lose Terraform state. Only run this for complete cleanup!

**Trigger**: Manual (workflow_dispatch)

#### 4. `destroy.yaml` - Full Environment Orchestrator
**Purpose**: Orchestrates destruction of app, infrastructure, and backend in sequence

**When to use**:
- Complete environment teardown
- When you want control over what to destroy

**Features**:
- Optional app destroy (default: true)
- Optional infrastructure destroy (default: true)
- Optional backend destroy (default: false) - protected by default
- Jobs run in sequence with proper dependencies

**Trigger**: Manual (workflow_dispatch)

## Usage Examples

### Scenario 1: First-Time Environment Setup
```
1. Run: deploy-backend.yaml (env: dev)
2. Run: deploy-infra.yaml (env: dev)
3. Run: deploy-app.yaml (env: dev)
```

Or use the orchestrator:
```
1. Run: deploy.yaml
   - environment: dev
   - deploy_backend: true
   - deploy_infra: true
   - deploy_app: true
```

### Scenario 2: Frontend Code Change
```
1. Run: deploy-app.yaml (env: dev)
```

### Scenario 3: Infrastructure Update
```
1. Run: deploy-infra.yaml (env: dev)
2. Run: deploy-app.yaml (env: dev)  # Re-deploy app if needed
```

### Scenario 4: Complete Environment Teardown
```
1. Run: destroy-app.yaml (env: dev)
2. Run: destroy-infra.yaml (env: dev)
3. Run: destroy-backend.yaml (env: dev)  # Only if you want to delete state
```

Or use the orchestrator:
```
1. Run: destroy.yaml
   - environment: dev
   - destroy_app: true
   - destroy_infra: true
   - destroy_backend: true  # Only if you want to delete state
```

### Scenario 5: Temporary Shutdown
```
1. Run: destroy-app.yaml (env: dev)
# Infrastructure remains, just the app is stopped
```

## Environment Support

All workflows support three environments:
- `dev` - Development environment
- `qa` - Quality Assurance/Testing environment
- `main` - Production environment

## Required Secrets

All workflows require these GitHub secrets to be configured:
- `AZURE_CLIENT_ID` - Azure Service Principal Client ID
- `AZURE_TENANT_ID` - Azure Tenant ID
- `AZURE_SUBSCRIPTION_ID` - Azure Subscription ID
- `AZURE_SP_OBJECT_ID` - Service Principal Object ID
- `AZURE_OPENAI_KEY` - Azure OpenAI API Key
- `POSTGRESQL_ADMIN_USERNAME` - PostgreSQL admin username
- `POSTGRESQL_ADMIN_PASSWORD` - PostgreSQL admin password
- `GOOGLE_CLIENT_ID` - Google OAuth Client ID
- `GOOGLE_CLIENT_SECRET` - Google OAuth Client Secret
- `MICROSOFT_CLIENT_ID` - Microsoft OAuth Client ID
- `MICROSOFT_CLIENT_SECRET` - Microsoft OAuth Client Secret

## Best Practices

1. **Always run backend deployment first** on new environments
2. **Run infrastructure before app deployment** on new environments
3. **Use app deployment workflow** for frequent frontend updates
4. **Test in dev environment first** before deploying to qa or main
5. **Be cautious with backend destroy** - it deletes Terraform state
6. **Use orchestrator workflows** for convenience with multiple components
7. **Check workflow logs** for any issues or errors

## Troubleshooting

### Backend already exists error
- This is normal if backend was already created
- Skip the backend deployment step or use orchestrator with `deploy_backend: false`

### Terraform state lock error
- Wait for other Terraform operations to complete
- Check if another workflow is running

### Web App not found during destroy
- The resource may already be deleted
- Check Azure Portal to verify
- This is generally safe to ignore

### Permission errors
- Verify all required secrets are configured
- Check Azure Service Principal permissions
- Ensure OIDC federation is properly configured

## Migration from Old Workflows

The old monolithic workflows have been replaced with:
- `deploy.yaml` - Now an orchestrator with options
- `destroy.yaml` - Now an orchestrator with options

**Key differences**:
- More granular control over what gets deployed/destroyed
- Optional components via boolean inputs
- Better efficiency by skipping unnecessary steps

**Backward compatibility**:
- The orchestrator workflows maintain similar behavior
- Can still deploy full environment in one run
- Choose which components to deploy/destroy
