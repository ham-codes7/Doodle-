const express = require('express');
const cors = require('cors');
const mongoose = require('mongoose');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 5000;

// Connect to MongoDB
mongoose.connect(process.env.MONGODB_URI)
  .then(() => console.log('✅ Connected to MongoDB Sanctuary Database'))
  .catch((err) => console.error('❌ MongoDB Connection Error:', err));

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
