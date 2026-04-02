const express = require('express');
const router = express.Router();
const SymptomLog = require('../models/SymptomLog');
const ActionTask = require('../models/ActionTask');
const User = require('../models/User');
const { translateSymptoms } = require('../services/translationService');
const { protect } = require('../middleware/authMiddleware');

// @desc    Submit a new symptom log (Mother)
// @route   POST /api/logs
router.post('/', protect, async (req, res) => {
  try {
    const userId = req.user.id;
    const { 
      feelings, 
      physicalRecovery, 
      vitalsAndCare, 
      emotional, 
      emotionalPulse, 
      hydrationLiters, 
      sleepQuality, 
      notes 
    } = req.body;

    // 1. Save the Log
    const log = await SymptomLog.create({
      user: userId,
      feelings: feelings || [],
      physicalRecovery: physicalRecovery || [],
      vitalsAndCare: vitalsAndCare || [],
      emotional: emotional || [],
      emotionalPulse,
      hydrationLiters,
      sleepQuality,
      notes
    });

    console.log('✅ Saved Log:', log);

    // 2. Find Linked Partner
    const mother = await User.findById(userId);
    if (mother && mother.linkedUser) {
      try {
        // 3. Run Translation Engine
        const translation = translateSymptoms(feelings);

        // 4. Generate and Save New Tasks for the Partner
        if (translation && translation.tasks) {
          const taskPromises = translation.tasks.map(task => {
            return ActionTask.create({
              recipient: mother.linkedUser,
              sourceLog: log._id,
              title: task.title,
              priority: task.priority
            });
          });
          await Promise.all(taskPromises);
        }
      } catch (transErr) {
        console.error('Translation Error:', transErr);
        // We still return 201 because the log itself was saved
      }
    }

    res.status(201).json({ success: true, data: log });
  } catch (err) {
    res.status(400).json({ success: false, message: err.message });
  }
});

// @desc    Get dashboard data for Partner
// @route   GET /api/logs/partner/dashboard
router.get('/partner/dashboard', protect, async (req, res) => {
  try {
    const partnerId = req.user.id; // Use authenticated user ID

    // 1. Find the Mother linked to this Partner
    const mother = await User.findOne({ linkedUser: partnerId, role: 'MOTHER' });
    if (!mother) {
      return res.status(404).json({ success: false, message: "No linked mother found" });
    }

    // 2. Get latest log from Mother
    const latestLog = await SymptomLog.findOne({ user: mother._id }).sort({ createdAt: -1 });
    
    // 3. Get pending tasks for Partner
    const tasks = await ActionTask.find({ recipient: partnerId, isCompleted: false });

    // 4. Run translation for context (in case it's not stored on log)
    const translation = translateSymptoms(latestLog ? latestLog.feelings : []);

    res.status(200).json({
      success: true,
      summary: translation.summary,
      context: translation.context,
      activeTasks: tasks
    });
  } catch (err) {
    res.status(400).json({ success: false, message: err.message });
  }
});

// @desc    Mark Task as Completed (Partner)
// @route   PUT /api/logs/task/:id
router.put('/task/:id', protect, async (req, res) => {
  try {
    const { isCompleted } = req.body;
    const task = await ActionTask.findByIdAndUpdate(
      req.params.id, 
      { isCompleted }, 
      { new: true }
    );

    if (!task) {
      return res.status(404).json({ success: false, message: "Task not found" });
    }

    res.status(200).json({ success: true, data: task });
  } catch (err) {
    res.status(400).json({ success: false, message: err.message });
  }
});

module.exports = router;
