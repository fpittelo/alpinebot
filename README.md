# AlpineBot 🚡🇨🇭

AlpineBot is an AI-powered chatbot using Azure OpenAI and OpenData.swiss to provide real-time info on Swiss public services, transport, and more. It's your personal guide to Swiss data! 🏔️

## Features 🚀

- **Swiss Public Data**: Real-time transport, environment, and healthcare stats from OpenData.swiss.
- **AI-Powered**: Human-like responses via Azure OpenAI.
- **Real-Time**: Live updates for transport and weather.
- **Multilingual**: Support for English, German, and French (coming soon).

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

   ```bash
   terraform init && terraform apply -auto-approve
   ```

3. **Run Locally**:
   ```bash
   func start
   ```

## Project Structure 🗂️

- `/frontend`: React app
- `/backend`: Azure Functions
- `/terraform`: Infrastructure code
- `/data`: Sample datasets

## Contributing & License 📜

We welcome PRs! AlpineBot is MIT Licensed.

## Contact 📧

Open an issue if you need help. The Alps are waiting! 🏔️
