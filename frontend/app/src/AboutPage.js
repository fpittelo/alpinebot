import React from "react";
import "./StaticPage.css";

const AboutPage = () => {
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
          <p className="eyebrow">About</p>
          <h1>About AlpineBot</h1>
          <p>
            AlpineBot is an AI-powered chatbot dedicated to making Swiss open
            data accessible to everyone. Built on Swiss values of transparency,
            precision, and neutrality, AlpineBot connects you to publicly
            available information from across Switzerland.
          </p>
          <h2>Our Mission</h2>
          <p>
            We believe that open data should be easy to access and understand.
            AlpineBot uses Swiss-hosted OpenAI technology to help you explore
            government documents, statistics, geographic data, and more—all in
            a friendly, conversational interface.
          </p>
          <h2>Technology</h2>
          <p>
            AlpineBot is powered by Swiss-hosted OpenAI technology, leveraging
            advanced language models within Swiss data centers. We support
            German, French, Italian, and Romansh to serve all Swiss language
            communities.
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

export default AboutPage;
