import React from 'react';
import './LoginPage.css';

const LoginPage = () => {
  const handleGoogleLogin = () => {
    // Redirect to Azure App Service's Google authentication endpoint
    window.location.href = '/.auth/login/google?post_login_redirect_uri=/';
  };

  const handleMicrosoftLogin = () => {
    // Redirect to Azure App Service's Microsoft authentication endpoint
    window.location.href = '/.auth/login/aad?post_login_redirect_uri=/';
  };

  return (
    <div className="login-page">
      <div className="login-container">
        <h1>AlpineBot</h1>
        <p>Your AI assistant for everything Switzerland</p>
        <div className="login-buttons">
          <button className="google-login" onClick={handleGoogleLogin}>
            Login with Google
          </button>
          <button className="microsoft-login" onClick={handleMicrosoftLogin}>
            Login with Microsoft
          </button>
        </div>
      </div>
    </div>
  );
};

export default LoginPage;
