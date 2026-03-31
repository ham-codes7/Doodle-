const mongoose = require('mongoose');

const ActionTaskSchema = new mongoose.Schema({
  recipient: {
    type: mongoose.Schema.ObjectId,
    ref: 'User',
    required: true,
  },
  sourceLog: {
    type: mongoose.Schema.ObjectId,
    ref: 'SymptomLog',
    required: true,
  },
  title: {
    type: String,
    required: [true, 'Task title is required'],
  },
  priority: {
    type: String,
    enum: ['CRITICAL', 'HIGH', 'MEDIUM', 'STABILITY'],
    default: 'MEDIUM',
  },
  isCompleted: {
    type: Boolean,
    default: false,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

module.exports = mongoose.model('ActionTask', ActionTaskSchema);
