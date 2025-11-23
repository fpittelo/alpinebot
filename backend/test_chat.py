#!/usr/bin/env python3
"""
Simple test script for the AlpineBot chat API endpoint.
This script demonstrates how to call the chat function locally or remotely.
"""

import json
import sys
import requests

def test_chat_endpoint(base_url="http://localhost:7071", message="Tell me about Switzerland"):
    """
    Test the chat endpoint with a sample message.
    
    Args:
        base_url: Base URL of the function app (default: http://localhost:7071)
        message: User message to send (default: "Tell me about Switzerland")
    """
    endpoint = f"{base_url}/api/chat"
    
    payload = {
        "message": message,
        "conversation_history": []
    }
    
    print(f"Testing endpoint: {endpoint}")
    print(f"Sending message: {message}")
    print("-" * 50)
    
    try:
        response = requests.post(
            endpoint,
            json=payload,
            headers={"Content-Type": "application/json"},
            timeout=30
        )
        
        print(f"Status Code: {response.status_code}")
        print("-" * 50)
        
        if response.status_code == 200:
            data = response.json()
            print("Response:")
            print(json.dumps(data, indent=2))
            print("-" * 50)
            print("✅ Test passed! Chat endpoint is working.")
            return True
        else:
            print("Error Response:")
            print(response.text)
            print("-" * 50)
            print("❌ Test failed! Check the error message above.")
            return False
            
    except requests.exceptions.ConnectionError:
        print("❌ Connection error! Make sure the function is running.")
        print("Start it with: func start")
        return False
    except Exception as e:
        print(f"❌ Error: {str(e)}")
        return False

if __name__ == "__main__":
    # Parse command line arguments
    base_url = "http://localhost:7071"
    message = "Tell me about Switzerland"
    
    if len(sys.argv) > 1:
        base_url = sys.argv[1]
    if len(sys.argv) > 2:
        message = " ".join(sys.argv[2:])
    
    success = test_chat_endpoint(base_url, message)
    sys.exit(0 if success else 1)
