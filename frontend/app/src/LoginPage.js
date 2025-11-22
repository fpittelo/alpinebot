import React from 'react';
import './LoginPage.css';

const LoginPage = () => {
  return (
    <div className="login-page">
      <div className="login-container">
        <h1>AlpineBot</h1>
        <p>Your AI assistant for everything Switzerland</p>
        <div className="login-buttons">
          <button className="google-login">Login with Google</button>
          <button className="microsoft-login">Login with Microsoft</button>
        </div>
      </div>
    </div>
  );
};

export default LoginPage;
