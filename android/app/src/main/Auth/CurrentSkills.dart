import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';

const skills = [
  'Python', 'Java', 'JavaScript', 'React', 'Flutter',
  'SQL', 'Firebase', 'UI/UX Design', 'Git', 'Docker'
];

function CurrentSkills() {
  const [selectedSkills, setSelectedSkills] = useState([]);
  const navigate = useNavigate();

  const toggleSkill = (skill) => {
    setSelectedSkills(prev =>
      prev.includes(skill)
        ? prev.filter(s => s !== skill)
        : [...prev, skill]
    );
  };

  return (
    <div className="skills-container">
      <div className="skills-header">
        <h1>Your Current Skills</h1>
        <p>Select the skills you currently have</p>
      </div>

      <div className="skills-grid">
        {skills.map((skill) => (
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
        <button
          onClick={() => navigate('/new-skills')}
          disabled={selectedSkills.length === 0}
          className="btn-primary"
        >
          Next: Skills to Learn
        </button>
      </div>
    </div>
  );
}

export default CurrentSkills;