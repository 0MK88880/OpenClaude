const fs = require('fs');
const path = require('path');

const MEMORY_DIR = path.join(__dirname, '.openclaude');
const HISTORY_FILE = path.join(MEMORY_DIR, 'session-history.json');

class SessionMemory {
  constructor() {
    if (!fs.existsSync(MEMORY_DIR)) {
      fs.mkdirSync(MEMORY_DIR, { recursive: true });
    }
    this.history = this.loadHistory();
  }

  loadHistory() {
    if (fs.existsSync(HISTORY_FILE)) {
      try {
        return JSON.parse(fs.readFileSync(HISTORY_FILE, 'utf8'));
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  saveHistory() {
    fs.writeFileSync(HISTORY_FILE, JSON.stringify(this.history, null, 2));
  }

  addMessage(role, content) {
    this.history.push({
      timestamp: new Date().toISOString(),
      role,
      content
    });
    this.saveHistory();
  }

  getHistory(limit = 50) {
    return this.history.slice(-limit);
  }

  getHistoryText() {
    return this.history
      .map(msg => `[${msg.role.toUpperCase()}]: ${msg.content}`)
      .join('\n');
  }

  clearHistory() {
    this.history = [];
    this.saveHistory();
  }
}

module.exports = SessionMemory;
