const API_BASE = 'http://3.83.160.162:3007/tasks';

document.addEventListener("DOMContentLoaded", () => {
    fetchTasks();

    document.getElementById("task-form").addEventListener("submit", async (e) => {
        e.preventDefault();
        const input = document.getElementById("task-input");
        if (input.value.trim()) {
            await fetch(API_BASE, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ title: input.value.trim() }),
            });
            input.value = "";
            fetchTasks();
        }
    });
});

async function fetchTasks() {
    const res = await fetch(API_BASE);
    const tasks = await res.json();
    const list = document.getElementById("task-list");
    list.innerHTML = "";

    tasks.forEach(task => {
        const li = document.createElement("li");
        if (task.completed) li.classList.add("completed");

        const span = document.createElement("span");
        span.textContent = task.title;

        const btnContainer = document.createElement("div");
        btnContainer.className = "action-buttons";

        const completeBtn = document.createElement("button");
        completeBtn.textContent = task.completed ? "Undo" : "Complete";
        completeBtn.onclick = async () => {
            await fetch(`${API_BASE}/${task.id}`, {
                method: "PUT",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ completed: !task.completed }),
            });
            fetchTasks();
        };

        const deleteBtn = document.createElement("button");
        deleteBtn.textContent = "Delete";
        deleteBtn.onclick = async () => {
            await fetch(`${API_BASE}/${task.id}`, {
                method: "DELETE",
            });
            fetchTasks();
        };

        btnContainer.appendChild(completeBtn);
        btnContainer.appendChild(deleteBtn);

        li.appendChild(span);
        li.appendChild(btnContainer);
        list.appendChild(li);
    });
}