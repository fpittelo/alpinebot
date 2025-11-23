import React from "react";
import "./LoginPage.css";

const LoginPage = () => {
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
            <p className="eyebrow">OpenAI</p>
            <h1 id="login-hero-title">Swiss OpenData at your fingertips</h1>
          </div>
        </div>
        <p>
          Interact with OpenAI, the Swiss hosted, to explore public data from
          across Switzerland. Ask questions in German, French, Italian, or
          Romansh and get answers built on transparency and precision.
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
          <h2 id="login-panel-title">Welcome back</h2>
          <p>Sign in to continue your conversations with OpenAI.</p>
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
        <p className="login-note">
          By continuing you agree to the AlpineBot acceptable use guidelines.
        </p>
      </section>
    </div>
  );
};

export default LoginPage;
