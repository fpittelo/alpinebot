# Contributing to AlpineBot

First off, thank you for considering contributing to AlpineBot! 🇨🇭

Following these guidelines helps to communicate that you respect the time of the developers managing and developing this open source project. In return, they should reciprocate that respect in addressing your issue, assessing changes, and helping you finalize your pull requests.

## Code of Conduct

By participating in this project, you are expected to uphold our Code of Conduct: be respectful, inclusive, and constructive in all interactions.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When you create a bug report, include as many details as possible:

- **Use a clear and descriptive title**
- **Describe the exact steps to reproduce the problem**
- **Provide specific examples** (code snippets, screenshots, etc.)
- **Describe the behavior you observed and what you expected**
- **Include your environment details** (OS, browser, Node version, etc.)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion:

- **Use a clear and descriptive title**
- **Provide a detailed description** of the suggested enhancement
- **Explain why this enhancement would be useful**
- **List any alternative solutions** you've considered

### Pull Requests

1. **Fork the repository** and create your branch from `dev`
2. **Follow the Test-Driven Development (TDD) approach**:
   - Write tests before implementing features
   - Ensure all tests pass before submitting
3. **Follow the coding style** of the project
4. **Update documentation** if you change functionality
5. **Write clear commit messages** following conventional commits format
6. **Ensure your PR description clearly describes the problem and solution**

## Development Process

### Branching Strategy

- `main` - production-ready code
- `qa` - quality assurance/staging environment
- `dev` - active development branch
- `feature/*` - feature branches (branch from `dev`)
- `bugfix/*` - bug fix branches (branch from `dev`)

### Setting Up Your Development Environment

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/alpinebot.git
cd alpinebot

# Add upstream remote
git remote add upstream https://github.com/fpittelo/alpinebot.git

# Create a feature branch
git checkout -b feature/your-feature-name dev
```

### Test-Driven Development (TDD)

This project strictly follows TDD:

1. **Write a failing test** that defines the desired functionality
2. **Write the minimum code** needed to make the test pass
3. **Refactor** the code while keeping tests green
4. **Repeat** for each new feature or bug fix

### Running Tests

```bash
# Frontend tests
cd frontend
npm test

# Backend tests
cd backend
pytest
```

### Deployment

**Important**: All infrastructure deployment is handled via GitHub Actions. Do NOT run Terraform locally.

- Pushing to `dev` triggers dev environment deployment
- PRs to `qa` trigger QA environment deployment
- PRs to `main` trigger production deployment

### Commit Message Format

We follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>

<body>

<footer>
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

Example:

```
feat(auth): add Google OAuth integration

Implement Google OAuth provider configuration in Terraform
and add authentication flow to frontend.

Closes #123
```

## Project Structure

```
/frontend       - React web application
/backend        - Azure Functions
/terraform      - Infrastructure as Code
/data          - Sample datasets
/docs          - Project documentation
/.github       - GitHub Actions workflows
```

## Style Guidelines

### TypeScript/JavaScript

- Use TypeScript for frontend code
- Follow ESLint configuration
- Use functional components and hooks in React
- Maintain minimalist design principles

### Python

- Follow PEP 8 style guide
- Use type hints
- Write docstrings for functions and classes

### Documentation

- Use clear, concise language
- Include code examples where helpful
- Update README.md if you change features
- Keep CHANGELOG.md up to date

## Questions?

Feel free to open an issue with the `question` label, and we'll be happy to help!

## Recognition

Contributors will be recognized in our README.md. Thank you for making AlpineBot better! 🏔️
