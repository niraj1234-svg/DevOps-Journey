const express = require("express");
const path = require("path");
const { DatabaseSync } = require("node:sqlite");

// Express application
const app = express();
const PORT = 5000;

// Middleware
app.use(express.json());

// Frontend configuration
const frontendPath = process.env.FRONTEND_PATH || path.join(__dirname, "../frontend");
app.use(express.static(frontendPath));

// SQLite database connection
const dbPath = process.env.DB_PATH || path.join(__dirname, "../data/tasks.db");
const db = new DatabaseSync(dbPath);

// Create tasks table if it does not exist
db.exec(`
    CREATE TABLE IF NOT EXISTS tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        completed INTEGER DEFAULT 0,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    )
`);

// Health check API
app.get("/api/health", (req, res) => {
    res.json({
        success: true,
        message: "Task Manager API is running"
    });
});

// Get all tasks
app.get("/api/tasks", (req, res) => {
    const tasks = db.prepare(
        "SELECT * FROM tasks ORDER BY id DESC"
    ).all();

    res.json(tasks);
});

// Create a new task
app.post("/api/tasks", (req, res) => {
    const { title } = req.body;

    if (!title || !title.trim()) {
        return res.status(400).json({
            error: "Task title is required"
        });
    }

    const result = db.prepare(
        "INSERT INTO tasks (title) VALUES (?)"
    ).run(title.trim());

    res.status(201).json({
        success: true,
        message: "Task created successfully",
        id: Number(result.lastInsertRowid)
    });
});

// Update a task
app.put("/api/tasks/:id", (req, res) => {
    const { id } = req.params;
    const { title, completed } = req.body;

    const existingTask = db.prepare(
        "SELECT * FROM tasks WHERE id = ?"
    ).get(id);

    if (!existingTask) {
        return res.status(404).json({
            error: "Task not found"
        });
    }

    const newTitle = title === undefined
        ? existingTask.title
        : title.trim();

    const newCompleted = completed === undefined
        ? existingTask.completed
        : completed ? 1 : 0;

    if (!newTitle) {
        return res.status(400).json({
            error: "Task title cannot be empty"
        });
    }

    db.prepare(
        "UPDATE tasks SET title = ?, completed = ? WHERE id = ?"
    ).run(newTitle, newCompleted, id);

    res.json({
        success: true,
        message: "Task updated successfully"
    });
});

// Delete a task
app.delete("/api/tasks/:id", (req, res) => {
    const result = db.prepare(
        "DELETE FROM tasks WHERE id = ?"
    ).run(req.params.id);

    if (result.changes === 0) {
        return res.status(404).json({
            error: "Task not found"
        });
    }

    res.json({
        success: true,
        message: "Task deleted successfully"
    });
});

// Start server
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
