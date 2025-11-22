# Contributing to AlpineBot 🏔️

Thank you for your interest in contributing to AlpineBot! We welcome contributions from the community to help make this chatbot better for everyone.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Process](#development-process)
- [How to Contribute](#how-to-contribute)
- [Pull Request Process](#pull-request-process)
- [Style Guidelines](#style-guidelines)
- [Testing Guidelines](#testing-guidelines)
- [Documentation Guidelines](#documentation-guidelines)

## Code of Conduct

By participating in this project, you agree to maintain a respectful, inclusive, and collaborative environment. We expect all contributors to:

- Be respectful and considerate in all interactions
- Provide constructive feedback
- Focus on what is best for the community and the project
- Show empathy towards other community members

## Getting Started

### Prerequisites

Before you begin, ensure you have:

- Git installed on your machine
- Python 3.x (for local function development)
- Azure Functions Core Tools (for local function development)
- Access to the repository (request access if needed)

> [!IMPORTANT]
> **NO LOCAL TERRAFORM OPERATIONS**: Infrastructure deployment and management are handled **exclusively** via GitHub Actions. Do NOT run Terraform commands locally.

### Setting Up Your Development Environment

1. **Fork and Clone the Repository**

   ```bash
   git clone https://github.com/fpittelo/alpinebot.git
   cd alpinebot
   ```

2. **Create a Branch**

   Always create a new branch for your work:

   ```bash
   git checkout -b feature/your-feature-name
   ```

   Use descriptive branch names:
   - `feature/` for new features
   - `fix/` for bug fixes
   - `docs/` for documentation updates
   - `refactor/` for code refactoring

## Development Process

AlpineBot follows a **Test-Driven Development (TDD)** approach:

1. **Write Tests First**: Before implementing a feature, write tests that define the expected behavior
2. **Implement Code**: Write the minimum code necessary to make the tests pass
3. **Refactor**: Clean up the code while ensuring all tests still pass
4. **Iterate**: Repeat the process for small, manageable increments

### Iterative Development

- Work in small, manageable increments
- Commit frequently with meaningful messages
- Test your changes thoroughly before submitting
- Document your changes as you go

## How to Contribute

### Reporting Bugs

If you find a bug, please create an issue with:

- A clear and descriptive title
- Steps to reproduce the issue
- Expected behavior vs. actual behavior
- Screenshots (if applicable)
- Environment details (browser, OS, etc.)

### Suggesting Enhancements

For feature requests or enhancements:

- Check existing issues to avoid duplicates
- Provide a clear description of the feature
- Explain the use case and benefits
- Include mockups or examples if applicable

### Code Contributions

1. **Check Existing Issues**: Look for open issues or create a new one
2. **Discuss First**: For major changes, discuss your approach in the issue
3. **Follow the Development Process**: Use TDD and iterative development
4. **Write Tests**: Include tests for all new functionality
5. **Update Documentation**: Keep docs in sync with code changes

## Pull Request Process

1. **Ensure Your Branch is Up to Date**

   ```bash
   git fetch origin
   git rebase origin/dev
   ```

2. **Run Tests Locally** (when applicable)

   Ensure all tests pass before submitting your PR.

3. **Update Documentation**

   Update relevant documentation files:
   - README.md (if architecture changes)
   - plan.md (if affecting project milestones)
   - specs.md (if changing specifications)
   - requirements.md (if adding/modifying requirements)
   - CHANGELOG.md (document your changes)

4. **Commit Your Changes**

   Use clear, descriptive commit messages following [Conventional Commits](https://www.conventionalcommits.org/):

   ```
   feat: add user feedback voting system
   fix: resolve authentication redirect issue
   docs: update README with new architecture diagram
   refactor: simplify data ingestion pipeline
   test: add unit tests for chatbot service
   ```

5. **Push Your Branch**

   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request**

   - Use a clear, descriptive title
   - Reference related issues (e.g., "Closes #123")
   - Provide a detailed description of changes
   - Include screenshots for UI changes
   - List any breaking changes

7. **Code Review**

   - Address reviewer feedback promptly
   - Make requested changes in new commits
   - Push updates to the same branch
   - Re-request review when ready

8. **CI/CD Pipeline**

   - All PRs must pass the CI/CD pipeline
   - The pipeline runs Terraform validation and planning
   - Deployments happen automatically after merge

## Style Guidelines

### Code Style

- Follow existing code patterns in the repository
- Use meaningful variable and function names
- Keep functions small and focused on a single responsibility
- Add comments for complex logic, but prefer self-documenting code

### Terraform

- Use consistent naming conventions for resources
- Follow the modular structure (one module per service)
- Use variables for environment-specific values
- Include meaningful descriptions for all variables
- Tag all resources appropriately

### Python (for future backend development)

- Follow PEP 8 style guidelines
- Use type hints where applicable
- Write docstrings for all functions and classes

### React (for future frontend development)

- Use functional components with hooks
- Follow the minimalist design principles (light colors, clean layout)
- Ensure accessibility (ARIA labels, keyboard navigation)
- Keep components small and reusable

## Testing Guidelines

### Test Requirements

- All new features must include tests
- Tests should be clear and maintainable
- Use descriptive test names that explain the scenario
- Cover both success and failure cases

### Test Types

- **Unit Tests**: Test individual functions/components in isolation
- **Integration Tests**: Test interaction between components
- **End-to-End Tests**: Test complete user workflows
- **Infrastructure Tests**: Terraform validation and planning in CI/CD

## Documentation Guidelines

### Documentation Standards

- Keep documentation up to date with code changes
- Use clear, concise language
- Include code examples where helpful
- Add diagrams for complex concepts
- Update the Mermaid diagram in README.md for architecture changes

### Documentation Files

- **README.md**: Project overview, getting started, architecture
- **plan.md**: Development plan and milestone tracking
- **specs.md**: Detailed technical specifications
- **requirements.md**: Functional and non-functional requirements
- **CHANGELOG.md**: Version history and notable changes
- **CONTRIBUTING.md**: This file - contribution guidelines

### Updating the Mermaid Diagram

When infrastructure or architecture changes:

1. Update the Mermaid diagram in README.md
2. Ensure all components are represented
3. Show data flow and relationships clearly
4. Keep the diagram readable and well-organized

## Questions?

If you have questions or need help:

- Check existing documentation first
- Search for similar issues
- Create a new issue with the "question" label
- Reach out to project maintainers

## License

By contributing to AlpineBot, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to AlpineBot! Your efforts help make this project better for everyone. 🇨🇭⛷️
