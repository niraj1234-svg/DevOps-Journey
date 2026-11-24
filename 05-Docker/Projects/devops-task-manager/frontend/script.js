const API_URL = "/api/tasks";

const taskForm = document.getElementById("task-form");
const taskInput = document.getElementById("task-input");
const taskList = document.getElementById("task-list");

const totalCount = document.getElementById("total-count");
const completedCount = document.getElementById("completed-count");
const emptyMessage = document.getElementById("empty-message");

// Fetch and display all tasks
async function loadTasks() {
    try {
        const response = await fetch(API_URL);
        if (!response.ok) throw new Error("Unable to fetch tasks");

        const tasks = await response.json();

        taskList.innerHTML = "";

        totalCount.textContent = tasks.length;
        completedCount.textContent =
            tasks.filter(task => task.completed === 1).length;

        emptyMessage.style.display =
            tasks.length === 0 ? "block" : "none";

        tasks.forEach(task => {
            const li = document.createElement("li");
            li.className = "task-item";

            if (task.completed === 1) {
                li.classList.add("completed");
            }

            const checkbox = document.createElement("input");
            checkbox.type = "checkbox";
            checkbox.checked = task.completed === 1;

            checkbox.addEventListener("change", () => {
                updateTask(task.id, checkbox.checked);
            });

            const title = document.createElement("span");
            title.textContent = task.title;

            const deleteButton = document.createElement("button");
            deleteButton.textContent = "Delete";
            deleteButton.className = "delete-btn";

            deleteButton.addEventListener("click", () => {
                deleteTask(task.id);
            });

            li.append(checkbox, title, deleteButton);
            taskList.appendChild(li);
        });

    } catch (error) {
        console.error("Error:", error);
        emptyMessage.textContent = "Unable to connect to backend.";
        emptyMessage.style.display = "block";
    }
}

// Create a new task
taskForm.addEventListener("submit", async (event) => {
    event.preventDefault();

    const title = taskInput.value.trim();

    if (!title) return;

    try {
        const response = await fetch(API_URL, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ title })
        });

        if (!response.ok) throw new Error("Unable to create task");

        taskInput.value = "";
        await loadTasks();

    } catch (error) {
        alert(error.message);
    }
});

// Update task status
async function updateTask(id, completed) {
    try {
        const response = await fetch(`${API_URL}/${id}`, {
            method: "PUT",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ completed })
        });

        if (!response.ok) throw new Error("Unable to update task");

        await loadTasks();

    } catch (error) {
        alert(error.message);
    }
}

// Delete task
async function deleteTask(id) {
    try {
        const response = await fetch(`${API_URL}/${id}`, {
            method: "DELETE"
        });

        if (!response.ok) throw new Error("Unable to delete task");

        await loadTasks();

    } catch (error) {
        alert(error.message);
    }
}

// Load tasks when page opens
loadTasks();
