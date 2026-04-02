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
    type: String,
    enum: ['MOTHER', 'PARTNER'],
    default: 'MOTHER',
  },
  // Bcrypt-hashed 4-digit pairing code — never returned by default
  partnerCode: {
    type: String,
    select: false,
  },
  // Plaintext code returned exactly once at registration for display on client
  partnerCodeDisplay: {
    type: String,
    select: false,
  },
  linkedUser: {
    type: mongoose.Schema.ObjectId,
    ref: 'User',
  },
  // Profile Fields
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

// Pre-save: hash password + generate & hash 4-digit numeric pairing code
UserSchema.pre('save', async function (next) {
  if (this.isModified('password')) {
    const salt = await bcrypt.genSalt(10);
    this.password = await bcrypt.hash(this.password, salt);
  }

  // Only MOTHER accounts get a pairing code, only on first save
  if (!this.partnerCode && this.role === 'MOTHER') {
    const plainCode = String(Math.floor(1000 + Math.random() * 9000)); // 4 digits: 1000–9999
    this.partnerCodeDisplay = plainCode;          // Keep plaintext for one-time display

    const salt = await bcrypt.genSalt(10);
    this.partnerCode = await bcrypt.hash(plainCode, salt); // Store hashed version
  }

  next();
});

// Compare entered password to stored hash
UserSchema.methods.matchPassword = async function (enteredPassword) {
  return await bcrypt.compare(enteredPassword, this.password);
};

// Compare entered partner code to stored hash
UserSchema.methods.matchPartnerCode = async function (enteredCode) {
  return await bcrypt.compare(String(enteredCode), this.partnerCode);
};

module.exports = mongoose.model('User', UserSchema);
