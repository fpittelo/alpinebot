import React, { useState, useRef, useEffect } from "react";
import "./HomePage.css";

// Helper function to extract user display name from auth claims
const getUserDisplayName = (user) => {
  if (!user?.user_claims) return "Explorer";
  const nameClaim = user.user_claims.find((c) => c.typ === "name");
  return nameClaim?.val || "Explorer";
};

const HomePage = ({ user, onLogout }) => {
  const displayName = getUserDisplayName(user);
  const [messages, setMessages] = useState([
    {
      id: 1,
      type: "bot",
      text: "Hello! I'm AlpineBot, your guide to Swiss open data. Ask me anything about Switzerland's public records, statistics, geographic data, or social information.",
      timestamp: new Date(),
    },
  ]);
  const [inputValue, setInputValue] = useState("");
  const [isTyping, setIsTyping] = useState(false);
  const messagesEndRef = useRef(null);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  const handleSend = (e) => {
    e.preventDefault();
    if (!inputValue.trim()) return;

    // Add user message
    const userMessage = {
      id: Date.now(),
      type: "user",
      text: inputValue,
      timestamp: new Date(),
    };

    setMessages((prev) => [...prev, userMessage]);
    setInputValue("");
    setIsTyping(true);

    // Simulate bot response (placeholder for future API integration)
    setTimeout(() => {
      const botMessage = {
        id: Date.now() + 1,
        type: "bot",
        text: "I'm a placeholder response. Integration with Azure OpenAI will be implemented in future tasks.",
        timestamp: new Date(),
      };
      setMessages((prev) => [...prev, botMessage]);
      setIsTyping(false);
    }, 1500);
  };

  const handleVote = (messageId, vote) => {
    console.log(`Vote ${vote} for message ${messageId}`);
    // TODO: Implement vote persistence in future tasks
  };

  const handleCopy = (text) => {
    navigator.clipboard.writeText(text);
    // TODO: Add visual feedback for copy action
  };

  const handleRefresh = (messageId) => {
    console.log(`Refresh message ${messageId}`);
    // TODO: Implement message refresh in future tasks
  };

  return (
    <div className="home-page">
      <header className="home-header">
        <div className="brand-mark">
          <div className="brand-icon">+</div>
          <div className="brand-text">
            <span>AlpineBot</span>
            <small>Switzerland</small>
          </div>
        </div>
        <nav className="primary-nav">
          <a
            href="/privacy"
            onClick={(e) => {
              e.preventDefault();
              window.history.pushState({}, "", "/privacy");
              window.dispatchEvent(new PopStateEvent("popstate"));
            }}
          >
            Privacy
          </a>
          <a
            href="/about"
            onClick={(e) => {
              e.preventDefault();
              window.history.pushState({}, "", "/about");
              window.dispatchEvent(new PopStateEvent("popstate"));
            }}
          >
            About
          </a>
          <a
            href="https://www.swiss-ai.org/OpenAI"
            target="_blank"
            rel="noopener noreferrer"
          >
            OpenAI
          </a>
        </nav>
        <div className="session-controls">
          <span className="session-user">{displayName}</span>
          <button onClick={onLogout} className="logout-button">
            Logout
          </button>
        </div>
      </header>

      <main className="chat-container">
        <div className="chat-messages">
          {messages.map((message) => (
            <div key={message.id} className={`message ${message.type}`}>
              <div className="message-content">
                <div className="message-avatar">
                  {message.type === "bot"
                    ? "+"
                    : displayName.charAt(0).toUpperCase()}
                </div>
                <div className="message-body">
                  <div className="message-header">
                    <span className="message-sender">
                      {message.type === "bot" ? "AlpineBot" : displayName}
                    </span>
                    <span className="message-time">
                      {message.timestamp.toLocaleTimeString([], {
                        hour: "2-digit",
                        minute: "2-digit",
                      })}
                    </span>
                  </div>
                  <p className="message-text">{message.text}</p>
                  {message.type === "bot" && (
                    <div className="message-actions">
                      <button
                        className="action-button"
                        onClick={() => handleVote(message.id, "up")}
                        title="Thumbs up"
                        aria-label="Thumbs up"
                      >
                        👍
                      </button>
                      <button
                        className="action-button"
                        onClick={() => handleVote(message.id, "down")}
                        title="Thumbs down"
                        aria-label="Thumbs down"
                      >
                        👎
                      </button>
                      <button
                        className="action-button"
                        onClick={() => handleCopy(message.text)}
                        title="Copy message"
                        aria-label="Copy message"
                      >
                        📋
                      </button>
                      <button
                        className="action-button"
                        onClick={() => handleRefresh(message.id)}
                        title="Refresh response"
                        aria-label="Refresh response"
                      >
                        🔄
                      </button>
                    </div>
                  )}
                </div>
              </div>
            </div>
          ))}
          {isTyping && (
            <div className="message bot">
              <div className="message-content">
                <div className="message-avatar">+</div>
                <div className="message-body">
                  <div className="message-header">
                    <span className="message-sender">AlpineBot</span>
                  </div>
                  <div className="typing-indicator">
                    <span></span>
                    <span></span>
                    <span></span>
                  </div>
                </div>
              </div>
            </div>
          )}
          <div ref={messagesEndRef} />
        </div>

        <form className="chat-input-form" onSubmit={handleSend}>
          <input
            type="text"
            className="chat-input"
            placeholder="Ask about Swiss open data..."
            value={inputValue}
            onChange={(e) => setInputValue(e.target.value)}
            disabled={isTyping}
          />
          <button
            type="submit"
            className="send-button"
            disabled={!inputValue.trim() || isTyping}
          >
            Send
          </button>
        </form>
      </main>
    </div>
  );
};

export default HomePage;
