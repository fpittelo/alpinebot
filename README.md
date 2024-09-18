Welcome to AlpineBot! 🚡🇨🇭
AlpineBot is your friendly, AI-powered Swiss data chat assistant, here to help you navigate the mountains of Swiss public datasets! Whether you’re looking for the next train from Zurich, the latest air quality index in Geneva, or the GDP of Switzerland, AlpineBot has got you covered. 🏔️✨

What is AlpineBot?
AlpineBot is an intelligent chatbot powered by Azure OpenAI and integrated with public data from OpenData.swiss. It's designed to provide real-time, interactive responses to questions about Swiss public services, transportation, healthcare, and much more!

It’s like having a Swiss guide who knows everything—from train schedules to environmental stats—right in your browser.

Features 🚀
Swiss Public Data Integration: Get real-time information on public transport, environmental conditions, healthcare stats, and more, directly from OpenData.swiss.
AI-Powered Conversations: Thanks to Azure’s GPT model, AlpineBot provides human-like, smart responses to user queries.
Real-Time Updates: AlpineBot keeps you updated with the latest info using live APIs for transport and weather.
Domain Specialization: AlpineBot is fine-tuned with domain-specific data to ensure accurate and contextual answers for Swiss-focused queries.
Multilingual: Alpines speak more than one language! Support for multiple languages including English, German, and French (coming soon).
How to Get Started ⛷️
Clone the repository:

bash
Copy code
git clone https://github.com/fpittelo/alpinebot/AlpineBot.git
cd AlpineBot
Set up your environment: Make sure you have the following dependencies installed:

Python 3.x
Azure Functions Core Tools
Terraform
Azure CLI
Configure your environment variables: You'll need to set the following environment variables in your .env file or Azure Key Vault:

AZURE_OPENAI_KEY: Your Azure OpenAI API key for AI-powered responses.
OPENDATA_API_KEY: (Optional) API key for accessing live datasets from OpenData.swiss, if available.
Deploy using Terraform: AlpineBot's infrastructure is fully managed via Terraform.

bash
Copy code
terraform init
terraform apply -auto-approve
Run AlpineBot locally:

bash
Copy code
func start
Chat with AlpineBot: Once deployed, you can start chatting with AlpineBot on the web interface or via API calls. Ask it questions like:

"What’s the next train from Zurich to Lausanne?"
"What’s the air quality index in Bern today?"
"What's Switzerland’s GDP for 2023?"
Project Structure 🗂️
bash
Copy code
/alpinebot
│
├── /frontend/       # Frontend React app for chatting with AlpineBot
├── /backend/        # Backend Azure Functions for AI model and dataset integration
├── /terraform/      # Terraform scripts for deploying the infrastructure on Azure
├── /data/           # Sample data or datasets from OpenData.swiss (for testing)
└── README.md        # You're reading it! 🧐
Contributing 🍫
We love contributions as much as Switzerland loves chocolate! 🍫 Feel free to submit issues or pull requests if you have ideas for improving AlpineBot’s functionality. Whether it’s enhancing the AI model, adding new datasets, or making AlpineBot multilingual, we welcome your ideas.

License 📜
AlpineBot is open-sourced under the MIT License. Feel free to fork, contribute, and make it even more amazing!

Fun Fact 🧐
Did you know that the Matterhorn was first climbed in 1865? 🏔️ While AlpineBot may not help you scale mountains, it will definitely help you scale the peaks of Swiss public data! ⛰️

Contact Us 📧
If you run into any trouble, feel free to open an issue.

Now go ahead and chat with AlpineBot! The Alps are waiting… 🏔️💬