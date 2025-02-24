// current-task.widget.js
import { css } from 'uebersicht'
import { run } from 'uebersicht'

// Command to read the todo.org file
const inboxFile = "~/Dropbox/org/inbox.org"
export const command = "cat ~/Dropbox/org/inbox.org"

// How often to refresh in milliseconds (every 1 second)
export const refreshFrequency = 1000

// Styling for the widget
export const className = css`
  bottom: 0px;
  left: 10px;
  width: 18%;
  color: #fff;
  font-family: VictorMono Nerd Font Mono, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  font-weight: semi-bold;
  cursor: pointer;
  
  .task-container {
    background: linear-gradient(to bottom, 
      rgba(0, 0, 0, 0) 0%,
      rgba(0, 0, 0, 0.7) 100%);
    padding: 2px;
    padding-left: 10px;
    border-radius: 16px;
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px)
  }

  .task-container::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    border-radius: 16px;
    background: linear-gradient(to bottom,
      rgba(255, 255, 255, 0.1) 0%,
      rgba(255, 255, 255, 0.05) 100%);
    pointer-events: none;
  }
  
  .header {
    font-size: 15px;
    font-weight: bold;
    color: #4285f4;
    margin-bottom: 4px;
  }
  
  .task-list {
    display: flex;
    flex-direction: column;
    gap: 4px;
  }
  
  .task-row {
    display: flex;
    align-items: center;
    gap: 2px;
    font-size: 12px;
  }
  
  .checkbox {
    width: 10px;
    height: 10px;
    border: 2px solid #f19a38;
    border-radius: 13px;
    margin-right: 4px;
  }
  
  .star {
    color: #ffd700;
    font-size: 12px;
  }
  
  .date {
    background: rgba(255, 255, 255, 0.1);
    padding: 2px 6px;
    border-radius: 4px;
    font-size: 12px;
    margin-right: 4px;
  }
`

// Parse the org file content and find current tasks
const getCurrentTasks = (output) => {
  const lines = output.split('\n')
  const taskRegex = /^\*\* (TODO|\[\-\]) (.+)$/
  const dateRegex = /(\d{1,2})\s+(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s+'?(\d{2})\s+\d{2}:\d{2}/
  const tasks = []
  
  for (let i = 0; i < lines.length; i++) {
    const match = lines[i].match(taskRegex)
    if (match) {
      // Check next line for date
      const nextLine = lines[i + 1] ? lines[i + 1].trim() : ''
      const dateMatch = nextLine.match(dateRegex)
      
      let formattedDate = null
      if (dateMatch) {
        const [_, day, month, year] = dateMatch
        formattedDate = `${month} ${day}`  // Just use month and day for display
      }

      const task = {
        text: match[2].trim(),
        hasDate: !!dateMatch,
        date: formattedDate,
        isStarred: match[2].includes('[#A]') || match[2].includes('[#B]')
      }
      tasks.push(task)
      if (tasks.length >= 2) break
    }
  }
  
  return tasks.length > 0 ? tasks : [{text: 'No current tasks'}]
}

// Render the widget
export const render = ({ output, error }) => {
  if (error) {
    return (
      <div className="task-container">
        <div className="header">Error</div>
        <div className="task-row">{String(error)}</div>
      </div>
    )
  }

  const currentTasks = getCurrentTasks(output)
  
  return (
    <div className="task-container">
    <div className="header" onClick={() => {
      run(`open -a Emacs.app ${inboxFile}`);
    }}>
      Current Tasks
    </div>
      <div className="task-list">
        {currentTasks.map((task, index) => (
          <div key={index} className="task-row">
            <div className="checkbox" onClick={() => {
                     run(`sed -i '' '/${task.text}/s/TODO/DONE/' ${inboxFile}`);
            }} />
            {task.isStarred && <span className="star">★</span>}
            {task.hasDate && <span className="date">{task.date}</span>}
            <span className="task-text">{task.text}</span>
          </div>
        ))}
      </div>
    </div>
  )
}
