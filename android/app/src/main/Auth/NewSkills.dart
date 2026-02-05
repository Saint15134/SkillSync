import React, { useState } from 'react';

const newSkills = [
  'Python', 'Java', 'JavaScript', 'React', 'Flutter',
  'SQL', 'Firebase', 'UI/UX Design', 'Git', 'Docker',
  'Machine Learning', 'Blockchain'
];

function NewSkills() {
  const [selectedSkills, setSelectedSkills] = useState([]);

  const toggleSkill = (skill) => {
    setSelectedSkills(prev =>
      prev.includes(skill)
        ? prev.filter(s => s !== skill)
        : [...prev, skill]
    );
  };

  const handleSave = () => {
    // Save to Firebase here
    alert('Skills saved successfully!');
  };

  return (
    <div className="skills-container">
      <div className="skills-header">
        <h1>Skills to Learn</h1>
        <p>Select skills you want to learn</p>
      </div>

      <div className="skills-grid">
        {newSkills.map((skill) => (
          <button
            key={skill}
            className={`skill-card ${selectedSkills.includes(skill) ? 'selected' : ''}`}
            onClick={() => toggleSkill(skill)}
          >
            {skill}
          </button>
        ))}
      </div>

      <div className="skills-footer">
        {selectedSkills.length > 0 && (
          <div className="selection-count">
            {selectedSkills.length} skill(s) selected
          </div>
        )}
        <button
          onClick={handleSave}
          disabled={selectedSkills.length === 0}
          className="btn-primary"
        >
          Save & Finish
        </button>
      </div>
    </div>
  );
}

export default NewSkills;