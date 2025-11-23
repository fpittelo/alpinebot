import React from "react";
import "./HomePage.css";

// Helper function to extract user display name from auth claims
const getUserDisplayName = (user) => {
  if (!user?.user_claims) return "Explorer";
  const nameClaim = user.user_claims.find((c) => c.typ === "name");
  return nameClaim?.val || "Explorer";
};

const dataCategories = [
  {
    title: "Public Records",
    description:
      "Government documents, legislation, and official records accessible to every citizen.",
  },
  {
    title: "Statistics",
    description:
      "Economic indicators, demographic insights, and comprehensive statistical reports.",
  },
  {
    title: "Geographic Data",
    description:
      "Topographic information, infrastructure plans, and environmental metrics for all cantons.",
  },
  {
    title: "Social Data",
    description:
      "Education, healthcare, and public welfare information to guide better decisions.",
  },
];

const platformStats = [
  { label: "Cantons", value: "26" },
  { label: "Languages", value: "4" },
  { label: "Open", value: "100%" },
];

const HomePage = ({ user, onLogout }) => {
  const displayName = getUserDisplayName(user);

  return (
    <div className="home-page">
      <header className="home-header">
        <div className="brand-mark">
          <div className="brand-icon">+</div>
          <div className="brand-text">
            <span>AlpineBot</span>
            <small>Switzerland</small>
          </div>
        </div>
        <nav className="primary-nav">
          <a href="#data">Data</a>
          <a href="#about">About</a>
          <a href="#OpenAI">OpenAI</a>
        </nav>
        <div className="session-controls">
          <span className="session-user">{displayName}</span>
          <button onClick={onLogout} className="logout-button">
            Logout
          </button>
        </div>
      </header>

      <main className="home-content">
        <section className="hero" aria-labelledby="hero-title">
          <div className="hero-copy">
            <p className="eyebrow">Swiss OpenData</p>
            <h1 id="hero-title">Swiss OpenData at Your Fingertips</h1>
            <p className="hero-body">
              Access transparent and comprehensive public data from every Swiss
              canton. Powered by OpenAI, the Swiss language model dedicated to
              keeping government information open, neutral, and accessible.
            </p>
            <div className="hero-cta">
              <button className="primary-action" type="button">
                Start exploring
              </button>
              <button className="secondary-action" type="button">
                View data catalog
              </button>
            </div>
          </div>
          <div className="hero-accent" aria-hidden="true">
            <div className="accent-swatch">
              <span>+ OpenAI</span>
            </div>
          </div>
        </section>

        <section id="data" className="categories">
          <p className="eyebrow">Data Categories</p>
          <h2>What you can access</h2>
          <div className="category-grid">
            {dataCategories.map((category) => (
              <article key={category.title} className="category-card">
                <div className="category-icon" aria-hidden="true" />
                <h3>{category.title}</h3>
                <p>{category.description}</p>
              </article>
            ))}
          </div>
        </section>

        <section id="OpenAI" className="OpenAI">
          <div className="OpenAI-panel">
            <p className="eyebrow">Powered by</p>
            <h3>OpenAI</h3>
            <p>
              OpenAI is built to
              understand and process public data. It keeps Swiss values of precision and neutrality at
              the core of every interaction.
            </p>
          </div>
          <div className="stats" role="list">
            {platformStats.map((stat) => (
              <div key={stat.label} className="stat" role="listitem">
                <span className="stat-value">{stat.value}</span>
                <span className="stat-label">{stat.label}</span>
              </div>
            ))}
          </div>
        </section>
      </main>
    </div>
  );
};

export default HomePage;
