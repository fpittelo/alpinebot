"""
Unit tests for the chatbot Azure Function.
"""

import json
import os
import sys
import unittest
from unittest.mock import Mock, patch, MagicMock

# Add parent directory to path to import function_app
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import function_app


class TestChatFunction(unittest.TestCase):
    """Test cases for the chat function."""
    
    def setUp(self):
        """Set up test fixtures."""
        # Mock environment variables
        self.env_vars = {
            'AZURE_OPENAI_API_KEY': 'test-key',
            'AZURE_OPENAI_ENDPOINT': 'https://test.openai.azure.com/',
            'AZURE_OPENAI_DEPLOYMENT_NAME': 'test-gpt-4',
            'AZURE_OPENAI_API_VERSION': '2024-02-15-preview'
        }
    
    @patch.dict(os.environ, {
        'AZURE_OPENAI_API_KEY': 'test-key',
        'AZURE_OPENAI_ENDPOINT': 'https://test.openai.azure.com/',
        'AZURE_OPENAI_DEPLOYMENT_NAME': 'test-gpt-4',
        'AZURE_OPENAI_API_VERSION': '2024-02-15-preview'
    })
    def test_missing_message_in_request(self):
        """Test that missing message returns 400 error."""
        # Create mock request with empty message
        mock_req = Mock()
        mock_req.get_json.return_value = {}
        
        # Call function
        response = function_app.chat(mock_req)
        
        # Verify response
        self.assertEqual(response.status_code, 400)
        response_body = json.loads(response.get_body().decode())
        self.assertIn('error', response_body)
        self.assertIn('Missing', response_body['error'])
    
    @patch.dict(os.environ, {
        'AZURE_OPENAI_API_KEY': 'test-key',
        'AZURE_OPENAI_ENDPOINT': 'https://test.openai.azure.com/'
    })
    def test_invalid_json_request(self):
        """Test that invalid JSON returns 400 error."""
        # Create mock request that raises ValueError on get_json
        mock_req = Mock()
        mock_req.get_json.side_effect = ValueError("Invalid JSON")
        
        # Call function
        response = function_app.chat(mock_req)
        
        # Verify response
        self.assertEqual(response.status_code, 400)
        response_body = json.loads(response.get_body().decode())
        self.assertIn('error', response_body)
        self.assertIn('Invalid JSON', response_body['error'])
    
    @patch.dict(os.environ, {
        'AZURE_OPENAI_API_KEY': 'test-key',
        'AZURE_OPENAI_ENDPOINT': 'https://test.openai.azure.com/'
    })
    def test_invalid_conversation_history_type(self):
        """Test that non-list conversation_history returns 400 error."""
        # Create mock request with invalid conversation_history
        mock_req = Mock()
        mock_req.get_json.return_value = {
            'message': 'Test message',
            'conversation_history': 'not a list'
        }
        
        # Call function
        response = function_app.chat(mock_req)
        
        # Verify response
        self.assertEqual(response.status_code, 400)
        response_body = json.loads(response.get_body().decode())
        self.assertIn('error', response_body)
        self.assertIn('must be an array', response_body['error'])
    
    @patch.dict(os.environ, {
        'AZURE_OPENAI_API_KEY': 'test-key',
        'AZURE_OPENAI_ENDPOINT': 'https://test.openai.azure.com/'
    })
    def test_invalid_conversation_history_structure(self):
        """Test that malformed conversation_history messages return 400 error."""
        # Create mock request with invalid message structure
        mock_req = Mock()
        mock_req.get_json.return_value = {
            'message': 'Test message',
            'conversation_history': [
                {'role': 'user'}  # Missing 'content' field
            ]
        }
        
        # Call function
        response = function_app.chat(mock_req)
        
        # Verify response
        self.assertEqual(response.status_code, 400)
        response_body = json.loads(response.get_body().decode())
        self.assertIn('error', response_body)
        self.assertIn('Invalid conversation_history format', response_body['error'])
    
    def test_get_openai_client_missing_api_key(self):
        """Test that missing API key raises ValueError."""
        with patch.dict(os.environ, {'AZURE_OPENAI_ENDPOINT': 'https://test.com/'}, clear=True):
            with self.assertRaises(ValueError) as context:
                function_app.get_openai_client()
            self.assertIn('credentials not configured', str(context.exception))
    
    def test_get_openai_client_missing_endpoint(self):
        """Test that missing endpoint raises ValueError."""
        with patch.dict(os.environ, {'AZURE_OPENAI_API_KEY': 'test-key'}, clear=True):
            with self.assertRaises(ValueError) as context:
                function_app.get_openai_client()
            self.assertIn('credentials not configured', str(context.exception))
    
    @patch.dict(os.environ, {
        'AZURE_OPENAI_API_KEY': 'test-key',
        'AZURE_OPENAI_ENDPOINT': 'https://test.openai.azure.com/',
        'AZURE_OPENAI_DEPLOYMENT_NAME': 'test-gpt-4'
    })
    @patch('function_app.get_openai_client')
    def test_successful_chat_request(self, mock_get_client):
        """Test successful chat request with mocked OpenAI response."""
        # Mock OpenAI client and response
        mock_client = MagicMock()
        mock_response = MagicMock()
        mock_response.choices = [MagicMock()]
        mock_response.choices[0].message.content = "This is a test response about Switzerland."
        mock_client.chat.completions.create.return_value = mock_response
        mock_get_client.return_value = mock_client
        
        # Create mock request
        mock_req = Mock()
        mock_req.get_json.return_value = {
            'message': 'Tell me about Switzerland',
            'conversation_history': []
        }
        
        # Call function
        response = function_app.chat(mock_req)
        
        # Verify response
        self.assertEqual(response.status_code, 200)
        response_body = json.loads(response.get_body().decode())
        self.assertEqual(response_body['status'], 'success')
        self.assertIn('response', response_body)
        self.assertEqual(response_body['response'], "This is a test response about Switzerland.")
        
        # Verify OpenAI was called with correct parameters
        mock_client.chat.completions.create.assert_called_once()
        call_args = mock_client.chat.completions.create.call_args
        self.assertEqual(call_args.kwargs['model'], 'test-gpt-4')
        self.assertIn('messages', call_args.kwargs)
        messages = call_args.kwargs['messages']
        # Should have system message + user message
        self.assertEqual(len(messages), 2)
        self.assertEqual(messages[0]['role'], 'system')
        self.assertEqual(messages[1]['role'], 'user')
        self.assertEqual(messages[1]['content'], 'Tell me about Switzerland')
    
    @patch.dict(os.environ, {
        'AZURE_OPENAI_API_KEY': 'test-key',
        'AZURE_OPENAI_ENDPOINT': 'https://test.openai.azure.com/',
        'AZURE_OPENAI_DEPLOYMENT_NAME': 'test-gpt-4'
    })
    @patch('function_app.get_openai_client')
    def test_chat_with_conversation_history(self, mock_get_client):
        """Test chat request with conversation history."""
        # Mock OpenAI client and response
        mock_client = MagicMock()
        mock_response = MagicMock()
        mock_response.choices = [MagicMock()]
        mock_response.choices[0].message.content = "Here are more details."
        mock_client.chat.completions.create.return_value = mock_response
        mock_get_client.return_value = mock_client
        
        # Create mock request with history
        mock_req = Mock()
        mock_req.get_json.return_value = {
            'message': 'Tell me more',
            'conversation_history': [
                {'role': 'user', 'content': 'What is Switzerland?'},
                {'role': 'assistant', 'content': 'Switzerland is a country.'}
            ]
        }
        
        # Call function
        response = function_app.chat(mock_req)
        
        # Verify response
        self.assertEqual(response.status_code, 200)
        
        # Verify conversation history was included
        call_args = mock_client.chat.completions.create.call_args
        messages = call_args.kwargs['messages']
        # Should have system message + 2 history messages + current message
        self.assertEqual(len(messages), 4)
        self.assertEqual(messages[0]['role'], 'system')
        self.assertEqual(messages[1]['role'], 'user')
        self.assertEqual(messages[1]['content'], 'What is Switzerland?')
        self.assertEqual(messages[2]['role'], 'assistant')
        self.assertEqual(messages[3]['role'], 'user')
        self.assertEqual(messages[3]['content'], 'Tell me more')
    
    @patch.dict(os.environ, {
        'AZURE_OPENAI_API_KEY': 'test-key',
        'AZURE_OPENAI_ENDPOINT': 'https://test.openai.azure.com/'
    })
    @patch('function_app.get_openai_client')
    def test_openai_error_handling(self, mock_get_client):
        """Test that OpenAI errors are handled gracefully."""
        # Mock OpenAI client to raise an exception
        mock_client = MagicMock()
        mock_client.chat.completions.create.side_effect = Exception("OpenAI API error")
        mock_get_client.return_value = mock_client
        
        # Create mock request
        mock_req = Mock()
        mock_req.get_json.return_value = {
            'message': 'Test message'
        }
        
        # Call function
        response = function_app.chat(mock_req)
        
        # Verify error response
        self.assertEqual(response.status_code, 500)
        response_body = json.loads(response.get_body().decode())
        self.assertIn('error', response_body)
        self.assertIn('OpenAI API error', response_body['error'])
    
    @patch.dict(os.environ, {
        'AZURE_OPENAI_API_KEY': 'test-key',
        'AZURE_OPENAI_ENDPOINT': 'https://test.openai.azure.com/'
    })
    @patch('function_app.get_openai_client')
    def test_openai_empty_choices(self, mock_get_client):
        """Test that empty OpenAI response is handled gracefully."""
        # Mock OpenAI client to return empty choices
        mock_client = MagicMock()
        mock_response = MagicMock()
        mock_response.choices = []
        mock_client.chat.completions.create.return_value = mock_response
        mock_get_client.return_value = mock_client
        
        # Create mock request
        mock_req = Mock()
        mock_req.get_json.return_value = {
            'message': 'Test message'
        }
        
        # Call function
        response = function_app.chat(mock_req)
        
        # Verify error response
        self.assertEqual(response.status_code, 500)
        response_body = json.loads(response.get_body().decode())
        self.assertIn('error', response_body)
        self.assertIn('No response generated', response_body['error'])


if __name__ == '__main__':
    unittest.main()
