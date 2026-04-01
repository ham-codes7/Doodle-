const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

const UserSchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true, 'Please add a name'],
  },
  email: {
    type: String,
    required: [true, 'Please add an email'],
    unique: true,
    match: [
      /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/,
      'Please add a valid email',
    ],
  },
  password: {
    type: String,
    required: [true, 'Please add a password'],
    minlength: 6,
    select: false,
  },
  role: {
// ... (rest of the fields)
    type: String,
    enum: ['MOTHER', 'PARTNER'],
    default: 'MOTHER',
  },
  // Unique code for linking Mother and Partner
  partnerCode: {
    type: String,
    unique: true,
  },
  // Reference to the linked user
  linkedUser: {
    type: mongoose.Schema.ObjectId,
    ref: 'User',
  },
  // Profile Fields (Onboarding)
  age: String,
  height: String,
  weight: String,
  deliveryDate: Date,
  deliveryType: {
    type: String,
    enum: ['Vaginal', 'C-Section'],
  },
  isFirstPregnancy: Boolean,
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

// Encrypt password using bcrypt
UserSchema.pre('save', async function (next) {
  if (!this.isModified('password')) {
    next();
  }

  const salt = await bcrypt.genSalt(10);
  this.password = await bcrypt.hash(this.password, salt);

  // Generate a unique 6-character partner code if not exists
  if (!this.partnerCode) {
    this.partnerCode = Math.random().toString(36).substring(2, 8).toUpperCase();
  }
});

// Match user entered password to hashed password in database
UserSchema.methods.matchPassword = async function (enteredPassword) {
  return await bcrypt.compare(enteredPassword, this.password);
};

module.exports = mongoose.model('User', UserSchema);
