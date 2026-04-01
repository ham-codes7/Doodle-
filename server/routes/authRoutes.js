const express = require('express');
const jwt = require('jsonwebtoken');
const User = require('../models/User');
const { protect } = require('../middleware/authMiddleware');
const router = express.Router();

// @desc    Register a user
// @route   POST /api/auth/register
router.post('/register', async (req, res) => {
  try {
    const { name, email, password, role } = req.body;

    if (!name || !email || !password || !role) {
      return res.status(400).json({ success: false, message: 'Please provide all required fields' });
    }

    const user = await User.create({
      name,
      email,
      password,
      role
    });

    sendTokenResponse(user, 201, res);
  } catch (err) {
    res.status(400).json({ success: false, message: err.message });
  }
});

// @desc    Login user
// @route   POST /api/auth/login
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ success: false, message: 'Please provide an email and password' });
    }

    const user = await User.findOne({ email }).select('+password');

    if (!user) {
      return res.status(401).json({ success: false, message: 'Invalid credentials' });
    }

    const isMatch = await user.matchPassword(password);

    if (!isMatch) {
      return res.status(401).json({ success: false, message: 'Invalid credentials' });
    }

    sendTokenResponse(user, 200, res);
  } catch (err) {
    res.status(400).json({ success: false, message: err.message });
  }
});

// @desc    Link Partner to Mother via partnerCode
// @route   PUT /api/auth/link
router.put('/link', protect, async (req, res) => {
  try {
    const { partnerCode } = req.body;
    const partnerId = req.user.id; // Use ID from authenticated token

    if (!partnerCode) {
      return res.status(400).json({ success: false, message: 'Please provide a partner code' });
    }

    // 1. Find the Mother by her unique code
    const mother = await User.findOne({ partnerCode, role: 'MOTHER' });

    if (!mother) {
      return res.status(404).json({ success: false, message: 'Invalid partner code or no Mother found with this code' });
    }

    // 2. Link them bidirectionally
    await User.findByIdAndUpdate(partnerId, { linkedUser: mother._id });
    await User.findByIdAndUpdate(mother._id, { linkedUser: partnerId });

    res.status(200).json({ success: true, message: 'Sanctuary Link Successful! You are now connected.' });
  } catch (err) {
    res.status(400).json({ success: false, message: err.message });
  }
});

// Get token from model, create cookie and send response
const sendTokenResponse = (user, statusCode, res) => {
  // Create token
  const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, {
    expiresIn: '30d',
  });

  res.status(statusCode).json({
    success: true,
    token,
    user: {
      id: user._id,
      name: user.name,
      email: user.email,
      role: user.role,
      partnerCode: user.partnerCode,
      linkedUser: user.linkedUser
    }
  });
};

// @desc    Update User Profile (Mother/Partner)
// @route   PUT /api/auth/profile
router.put('/profile', protect, async (req, res) => {
  try {
    const fieldsToUpdate = {
      age: req.body.age,
      height: req.body.height,
      weight: req.body.weight,
      deliveryDate: req.body.deliveryDate,
      deliveryType: req.body.deliveryType,
      isFirstPregnancy: req.body.isFirstPregnancy
    };

    const user = await User.findByIdAndUpdate(req.user.id, fieldsToUpdate, {
      new: true,
      runValidators: true
    });

    res.status(200).json({
      success: true,
      data: user
    });
  } catch (err) {
    res.status(400).json({ success: false, message: err.message });
  }
});

module.exports = router;
