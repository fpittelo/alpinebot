import React, { useEffect, useState } from 'react';
import './App.css';
import LoginPage from './LoginPage';
import HomePage from './HomePage';

function App() {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Check authentication status by calling Azure App Service's .auth/me endpoint
    fetch('/.auth/me')
      .then(response => response.json())
      .then(data => {
        if (data && data.length > 0 && data[0].user_id) {
          setUser(data[0]);
        }
        setLoading(false);
      })
      .catch(error => {
        console.error('Error checking authentication:', error);
        setLoading(false);
      });
  }, []);

  const handleLogout = () => {
    // Redirect to Azure App Service's logout endpoint
    window.location.href = '/.auth/logout?post_logout_redirect_uri=/';
  };

  if (loading) {
    return (
      <div className="App">
        <div className="loading">Loading...</div>
      </div>
    );
  }

  return (
    <div className="App">
      {user ? (
        <HomePage user={user} onLogout={handleLogout} />
      ) : (
        <LoginPage />
      )}
    </div>
  );
}

export default App;
