import React from "react";
import "./LoginPage.css";

const LoginPage = () => {
  const handleNavigation = (e, path) => {
    e.preventDefault();
    window.history.pushState({}, "", path);
    window.dispatchEvent(new PopStateEvent("popstate"));
  };

  const loginOptions = [
    {
      label: "Continue with Google",
      action: () => {
        window.location.href = "/.auth/login/google?post_login_redirect_uri=/";
      },
      variant: "google",
      icon: "G",
    },
  ];

  return (
    <div className="login-page">
      <section className="login-hero" aria-labelledby="login-hero-title">
        <div className="hero-brand">
          <div className="hero-badge">+</div>
          <div>
            <p className="eyebrow">AlpineBot</p>
            <h1 id="login-hero-title">Swiss OpenData at your fingertips</h1>
          </div>
        </div>
        <p>
          A friendly chatbot powered by Swiss-hosted OpenAI, connecting you to
          publicly available Swiss open data. Explore government information,
          statistics, and more in a modern, minimalist interface.
        </p>
        <div className="hero-stats">
          <div>
            <span>26</span>
            <small>Cantons</small>
          </div>
          <div>
            <span>4</span>
            <small>Languages</small>
          </div>
          <div>
            <span>100%</span>
            <small>Open</small>
          </div>
        </div>
      </section>

      <section className="login-panel" aria-labelledby="login-panel-title">
        <div className="panel-header">
          <div className="panel-logo">
            <span>+</span>
            <div>
              <strong>AlpineBot</strong>
              <small>Switzerland</small>
            </div>
          </div>
          <p>
            Sign in with your Google account to start exploring Swiss open data.
          </p>
        </div>
        <div className="login-buttons">
          {loginOptions.map((option) => (
            <button
              key={option.label}
              className={`login-button ${option.variant}`}
              onClick={option.action}
              type="button"
            >
              <span className="login-icon" aria-hidden="true">
                {option.icon}
              </span>
              {option.label}
            </button>
          ))}
        </div>
        <footer className="login-footer">
          <a
            href="/privacy"
            onClick={(e) => handleNavigation(e, "/privacy")}
            className="footer-link"
          >
            Privacy
          </a>
          <span className="footer-separator">•</span>
          <a
            href="/about"
            onClick={(e) => handleNavigation(e, "/about")}
            className="footer-link"
          >
            About
          </a>
          <span className="footer-separator">•</span>
          <a
            href="/guidelines"
            onClick={(e) => handleNavigation(e, "/guidelines")}
            className="footer-link"
          >
            Guidelines ↗
          </a>
        </footer>
      </section>
    </div>
  );
};

export default LoginPage;
