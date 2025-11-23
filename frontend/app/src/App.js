import React, { useEffect, useState } from "react";
import "./App.css";
import LoginPage from "./LoginPage";
import HomePage from "./HomePage";
import AboutPage from "./AboutPage";
import PrivacyPage from "./PrivacyPage";
import GuidelinesPage from "./Guidelines";

function App() {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [currentPath, setCurrentPath] = useState(window.location.pathname);

  useEffect(() => {
    // Handle browser navigation
    const handlePopState = () => {
      setCurrentPath(window.location.pathname);
    };
    window.addEventListener("popstate", handlePopState);
    return () => window.removeEventListener("popstate", handlePopState);
  }, []);

  useEffect(() => {
    // Check authentication status by calling Azure App Service's .auth/me endpoint
    fetch("/.auth/me")
      .then((response) => response.json())
      .then((data) => {
        if (data && data.length > 0 && data[0].user_id) {
          setUser(data[0]);
        }
        setLoading(false);
      })
      .catch(() => {
        // Silently handle auth check failure - user is not authenticated
        setLoading(false);
      });
  }, []);

  const handleLogout = () => {
    // Redirect to Azure App Service's logout endpoint
    window.location.href = "/.auth/logout?post_logout_redirect_uri=/";
  };

  if (loading) {
    return (
      <div className="App">
        <div className="loading">Loading...</div>
      </div>
    );
  }

  const renderStaticPage = () => {
    switch (currentPath) {
      case "/about":
        return <AboutPage />;
      case "/privacy":
        return <PrivacyPage />;
      case "/guidelines":
        return <GuidelinesPage />;
      default:
        return null;
    }
  };

  const staticPage = renderStaticPage();
  if (staticPage) {
    return <div className="App">{staticPage}</div>;
  }

  return (
    <div className="App">
      {user ? <HomePage user={user} onLogout={handleLogout} /> : <LoginPage />}
    </div>
  );
}

export default App;
