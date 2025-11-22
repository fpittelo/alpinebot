import React from 'react';
import './HomePage.css';

const HomePage = ({ user, onLogout }) => {
  return (
    <div className="home-page">
      <header className="home-header">
        <h1>AlpineBot</h1>
        <div className="user-info">
          <span>Welcome, {user?.user_claims?.find(c => c.typ === 'name')?.val || 'User'}!</span>
          <button onClick={onLogout} className="logout-button">Logout</button>
        </div>
      </header>
      <div className="chat-container">
        <div className="chat-placeholder">
          <p>Your AI assistant for everything Switzerland</p>
          <p className="placeholder-text">Chat interface coming soon...</p>
        </div>
      </div>
    </div>
  );
};

export default HomePage;
