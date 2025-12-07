import azure.functions as func
import json
import logging
import os
@app.route(route="health", methods=["GET"], auth_level=func.AuthLevel.ANONYMOUS)
def health(req: func.HttpRequest) -> func.HttpResponse:
    """
    Simple health check endpoint.
    """
    logging.info('Health check triggered.')
    return func.HttpResponse(
        json.dumps({"status": "healthy"}),
        mimetype="application/json",
        status_code=200
    )

@app.route(route="chat", methods=["POST"], auth_level=func.AuthLevel.ANONYMOUS)
def chat(req: func.HttpRequest) -> func.HttpResponse:
    """
    HTTP trigger function for chatbot queries.
    
    Accepts POST requests with JSON body containing:
    - message: User's query message (required)
    - conversation_history: Optional array of previous messages
    
    Returns:
    - JSON response with the chatbot's reply
    """
    logging.info('Chatbot function processing a request.')
    
    try:
        from openai import AzureOpenAI  # Import inside function to avoid top-level failures
        
        # Parse request body
        try:
            req_body = req.get_json()
        except ValueError:
            return func.HttpResponse(
                json.dumps({"error": "Invalid JSON in request body"}),
                mimetype="application/json",
                status_code=400
            )
        
        user_message = req_body.get('message')
        conversation_history = req_body.get('conversation_history', [])
        
        if not user_message:
            return func.HttpResponse(
                json.dumps({"error": "Missing 'message' in request body"}),
                mimetype="application/json",
                status_code=400
            )
        
        # Validate conversation_history structure
        if not isinstance(conversation_history, list):
            return func.HttpResponse(
                json.dumps({"error": "'conversation_history' must be an array"}),
                mimetype="application/json",
                status_code=400
            )
        
        for msg in conversation_history:
            if not isinstance(msg, dict) or 'role' not in msg or 'content' not in msg:
                return func.HttpResponse(
                    json.dumps({"error": "Invalid conversation_history format. Each message must have 'role' and 'content' fields"}),
                    mimetype="application/json",
                    status_code=400
                )

        # Initialize Azure OpenAI Client inside the request
        api_key = os.environ.get("AZURE_OPENAI_API_KEY")
        api_base = os.environ.get("AZURE_OPENAI_ENDPOINT")
        api_version = os.environ.get("AZURE_OPENAI_API_VERSION", "2024-02-15-preview")
        
        if not api_key or not api_base:
             # Log error but return 500
             logging.error("Azure OpenAI credentials not configured.")
             return func.HttpResponse(
                json.dumps({"error": "Configuration error: Missing Azure OpenAI credentials."}),
                mimetype="application/json",
                status_code=500
            )

        client = AzureOpenAI(
            api_key=api_key,
            api_version=api_version,
            azure_endpoint=api_base
        )
        
        deployment_name = os.environ.get("AZURE_OPENAI_DEPLOYMENT_NAME", "gpt-4")
        
        # Build messages for OpenAI
        messages = [
            {
                "role": "system",
                "content": (
                    "You are AlpineBot, a friendly AI assistant specialized in providing "
                    "information about Switzerland. You help users with questions about Swiss "
                    "culture, geography, history, public services, and general information. "
                    "Respond in a helpful, accurate, and engaging manner."
                )
            }
        ]
        
        # Add conversation history
        if conversation_history:
            messages.extend(conversation_history)
        
        # Add current user message
        messages.append({"role": "user", "content": user_message})
        
        # Call Azure OpenAI
        logging.info(f"Sending request to Azure OpenAI deployment: {deployment_name}")
        response = client.chat.completions.create(
            model=deployment_name,
            messages=messages,
            temperature=0.7,
            max_tokens=800,
            top_p=0.95
        )
        
        # Extract response
        if not response.choices or len(response.choices) == 0:
            logging.error("OpenAI response contained no choices")
            return func.HttpResponse(
                json.dumps({"error": "No response generated from AI service"}),
                mimetype="application/json",
                status_code=500
            )
        
        assistant_message = response.choices[0].message.content
        
        # Return response
        return func.HttpResponse(
            json.dumps({
                "response": assistant_message,
                "status": "success"
            }),
            mimetype="application/json",
            status_code=200
        )
        
    except ImportError as ie:
        logging.error(f"Import Error: {str(ie)}")
        return func.HttpResponse(
             json.dumps({"error": "Server Configuration Error: Missing dependencies."}),
             mimetype="application/json",
             status_code=500
        )
    except ValueError as ve:
        logging.error(f"Configuration error: {str(ve)}")
        return func.HttpResponse(
            json.dumps({"error": f"Configuration error: {str(ve)}"}),
            mimetype="application/json",
            status_code=500
        )
    except Exception as e:
        logging.error(f"Error processing chat request: {str(e)}")
        return func.HttpResponse(
            json.dumps({"error": f"An error occurred: {str(e)}"}),
            mimetype="application/json",
            status_code=500
        )