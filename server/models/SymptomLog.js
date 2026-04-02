const mongoose = require('mongoose');

const SymptomLogSchema = new mongoose.Schema({
  user: {
    type: mongoose.Schema.ObjectId,
    ref: 'User',
    required: true,
  },
  feelings: {
    type: [String],
    default: [],
  },
  physicalRecovery: {
    type: [String],
    default: [],
  },
  vitalsAndCare: {
    type: [String],
    default: [],
  },
  emotional: {
    type: [String],
    default: [],
  },
  emotionalPulse: {
    type: String,
    enum: ['Calm', 'Heavy', 'Tired', 'Joyful', 'Tense', 'Not Specified'],
    default: 'Not Specified',
  },
  hydrationLiters: {
    type: Number,
    default: 0,
  },
  sleepQuality: {
    type: String,
    default: 'Not Specified',
  },
  notes: {
    type: String,
    maxLength: [500, 'Notes cannot be more than 500 characters'],
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

module.exports = mongoose.model('SymptomLog', SymptomLogSchema);
