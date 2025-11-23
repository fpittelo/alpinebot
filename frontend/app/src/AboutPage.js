import React from "react";
import "./AboutPage.css";

const AboutPage = () => {
  return (
    <div className="about-page">
      <header className="page-header">
        <div className="brand-mark">
          <a href="/" className="brand-link">
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
            AlpineBot is powered by OpenAI, Switzerland's large language model,
            and hosted entirely within Swiss data centers. We support German,
            French, Italian, and Romansh to serve all Swiss language
            communities.
          </p>
          <div className="page-actions">
            <a href="/" className="primary-button">
              Back to Home
            </a>
          </div>
        </section>
      </main>
    </div>
  );
};

export default AboutPage;
