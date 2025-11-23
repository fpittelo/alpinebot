import React from "react";
import "./StaticPage.css";

const GuidelinesPage = () => {
  const handleNavigation = (e) => {
    e.preventDefault();
    window.history.pushState({}, "", "/");
    window.dispatchEvent(new PopStateEvent("popstate"));
  };

  return (
    <div className="page-container">
      <header className="page-header">
        <div className="brand-mark">
          <a href="/" onClick={handleNavigation} className="brand-link">
            <div className="brand-icon">+</div>
            <div className="brand-text">
              <span>AlpineBot</span>
              <small>Switzerland</small>
            </div>
          </a>
        </div>
      </header>
      <main className="page-content">
        <section className="content-section">
          <p className="eyebrow">Guidelines</p>
          <h1>Responsible Use</h1>
          <p>
            AlpineBot helps you explore Swiss open data with a conversational
            interface. Use the assistant thoughtfully and treat every response
            as guidance that should be validated before making decisions.
          </p>
          <h2>Interact with Prudence</h2>
          <ul>
            <li>
              <strong>Verify critical facts:</strong> Cross-check answers
              against official Swiss sources when accuracy matters.
            </li>
            <li>
              <strong>Protect sensitive data:</strong> Avoid sharing personal,
              confidential, or regulated information in your prompts.
            </li>
            <li>
              <strong>Provide context wisely:</strong> Share only the details
              needed for the assistant to understand your question.
            </li>
            <li>
              <strong>Respect multilingual support:</strong> AlpineBot responds
              in English, German, and French—choose the language that fits your
              audience and stay consistent.
            </li>
            <li>
              <strong>Use feedback controls:</strong> Thumb up/down, copy, and
              refresh buttons help refine the experience and surface better
              answers for everyone.
            </li>
            <li>
              <strong>Keep records mindful:</strong> Remember that your latest
              interactions (up to 100) are stored in your profile for reference.
            </li>
          </ul>
          <h2>Need a Reminder?</h2>
          <p>
            If you are unsure about a response, revisit these guidelines,
            consult authoritative datasets, or reach out to project
            administrators. Safe, informed usage keeps AlpineBot reliable for
            the community.
          </p>
          <div className="page-actions">
            <a href="/" onClick={handleNavigation} className="primary-button">
              Back to Home
            </a>
          </div>
        </section>
      </main>
    </div>
  );
};

export default GuidelinesPage;
