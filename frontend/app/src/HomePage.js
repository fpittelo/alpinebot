import React from 'react';
import './HomePage.css';

// Helper function to extract user display name from auth claims
const getUserDisplayName = (user) => {
  if (!user?.user_claims) return 'User';
  const nameClaim = user.user_claims.find(c => c.typ === 'name');
  return nameClaim?.val || 'User';
};

const HomePage = ({ user, onLogout }) => {
  const displayName = getUserDisplayName(user);

  return (
    <div className="home-page">
      <header className="home-header">
        <h1>AlpineBot</h1>
        <div className="user-info">
          <span>Welcome, {displayName}!</span>
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
