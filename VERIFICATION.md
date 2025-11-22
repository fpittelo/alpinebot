# Verification Instructions

This document provides instructions on how to verify the Terraform configuration changes through the CI/CD pipeline.

## 1. Create a New Branch

Create a new branch from the `dev` branch to hold the changes you've made to the Terraform configuration and documentation.

```bash
git checkout -b feature/authentication-backend
```

## 2. Commit the Changes

Commit all the changes you've made to the following files:

- `README.md`
- `GEMINI.md`
- `plan.md`
- `specs.md`
- `requirements.md`
- `modules/linux_web_app/main.tf`
- `modules/linux_web_app/variables.tf`
- `infra/main.tf`
- `infra/variables.tf`
- `infra/dev.tfvars`
- `.github/workflows/deploy.yaml`

```bash
git add .
git commit -m "feat: configure authentication and update documentation"
```

## 3. Push the Branch to GitHub

Push the new branch to your GitHub repository.

```bash
git push origin feature/authentication-backend
```

## 4. Create a Pull Request

In GitHub, create a new pull request from the `feature/authentication-backend` branch to the `dev` branch.

## 5. Verify the CI/CD Pipeline

The pull request will trigger the GitHub Actions workflow defined in `.github/workflows/deploy.yaml`.

## 6. Merge the Pull Request

Once the pull request is approved and the CI/CD pipeline has passed, merge the pull request into the `dev` branch. This will trigger the `deploy` job in the GitHub Actions workflow, which will apply the Terraform changes to your Azure environment.

After the `deploy` job has completed successfully, the Azure App Service will be configured with the new authentication settings.
