require('dotenv').config();
const express = require('express');
const cors = require('cors');
const mongoose = require('mongoose');

const app = express();
const PORT = process.env.PORT || 5001;

// Connect to MongoDB
if (process.env.MONGODB_URI) {
  mongoose.connect(process.env.MONGODB_URI)
    .then(() => console.log('✅ Connected to MongoDB Sanctuary Database'))
    .catch((err) => console.error('❌ MongoDB Connection Error:', err));
} else {
  console.warn('⚠️ WARNING: MONGODB_URI is undefined in environment variables. Database features will be disabled until configured.');
}

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use('/api/auth', require('./routes/authRoutes'));
app.use('/api/logs', require('./routes/logRoutes'));

// Basic Route for Sanctuary
app.get('/', (req, res) => {
  res.json({
    status: "online",
    message: "Welcome to Serene Sanctuary Backend",
    version: "1.0.0"
  });
});

// Health Check Endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ status: "healthy", timestamp: new Date().toISOString() });
});

// Start Server
app.listen(PORT, () => {
  console.log(`🚀 Sanctuary Server running on port ${PORT}`);
});
