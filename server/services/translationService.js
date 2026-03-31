const translateSymptoms = (feelings) => {
  const tasks = [];
  const contexts = [];
  let summary = "";

  if (!feelings || feelings.length === 0) {
    return {
      summary: "She is resting currently.",
      context: "No symptoms logged yet today. Check in gently.",
      tasks: []
    };
  }

  // 1. Build summary
  if (feelings.length === 1) {
    summary = `She is feeling ${feelings[0]}.`;
  } else if (feelings.length === 2) {
    summary = `She is feeling ${feelings[0]} & ${feelings[1]}.`;
  } else {
    const list = [...feelings];
    const last = list.pop();
    summary = `She is feeling ${list.join(', ')}, & ${last}.`;
  }

  // 2. Map Symptoms to Contexts and Tasks
  if (feelings.includes('Exhausted')) {
    contexts.push("Her body is recovering from extreme physical trauma and sleep deprivation is peaking. She needs physical rest, not solutions.");
    tasks.push({ title: 'Take over all non-feeding baby duties tonight', priority: 'CRITICAL' });
    tasks.push({ title: 'Let her sleep uninterrupted for 4 hours', priority: 'HIGH' });
  }

  if (feelings.includes('Weepy')) {
    contexts.push("Hormone crash is active. Do not try to fix her sadness, just listen and validate.");
    tasks.push({ title: 'Bring her water and just hold her', priority: 'HIGH' });
    tasks.push({ title: 'Tell her she is doing an amazing job', priority: 'STABILITY' });
  }

  if (feelings.includes('Breast Pain')) {
    tasks.push({ title: 'Wash and sterilize the pump parts', priority: 'HIGH' });
    tasks.push({ title: 'Prepare ice packs or warm compresses', priority: 'STABILITY' });
  }

  // Fallback context
  const finalContext = contexts.length > 0 
    ? contexts.join(" ") 
    : "She has logged new feelings. Check in with her gently.";

  return {
    summary,
    context: finalContext,
    tasks
  };
};

module.exports = { translateSymptoms };
