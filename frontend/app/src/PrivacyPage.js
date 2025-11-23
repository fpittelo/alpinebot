import React from "react";
import "./StaticPage.css";

const PrivacyPage = () => {
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
          <p className="eyebrow">Privacy</p>
          <h1>Privacy Statement</h1>
          <p>
            At AlpineBot, we take your privacy seriously. This statement
            outlines how we collect, use, and protect your personal information
            when you use our service.
          </p>
          <h2>Data Collection</h2>
          <p>
            When you sign in with your Google account, we collect your name,
            email address, and a unique identifier. This information is used to
            create and maintain your user profile.
          </p>
          <h2>Data Usage</h2>
          <p>
            Your profile information is used to personalize your experience and
            maintain your chat history. We store up to 100 recent interactions
            per user to help you track your conversations with AlpineBot.
          </p>
          <h2>Data Storage</h2>
          <p>
            All data is stored securely in Swiss data centers and encrypted
            both at rest and in transit. We comply with Swiss data protection
            laws and regulations.
          </p>
          <h2>Third-Party Services</h2>
          <p>
            We use Google for authentication and Swiss-hosted OpenAI for
            generating chatbot responses. These services have their own privacy
            policies that govern the data they process.
          </p>
          <h2>Your Rights</h2>
          <p>
            You have the right to access, modify, or delete your personal data
            at any time through your user profile. You can also delete
            individual chat interactions or your entire chat history.
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

export default PrivacyPage;
