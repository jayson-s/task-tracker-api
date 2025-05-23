from flask import Flask, request, jsonify

app = Flask(__name__)

# In-memory "database" of tasks
tasks = {}
current_id = 1

# List all tasks
@app.route("/tasks", methods=["GET"])
def get_tasks():
    return jsonify(list(tasks.values())), 200

# Create a new task
@app.route("/tasks", methods=["POST"])
def create_task():
    global current_id
    data = request.get_json()
    task = {
        "id": current_id,
        "title": data.get("title"),
        "completed": False
    }
    tasks[current_id] = task
    current_id += 1
    return jsonify(task), 201

# Get a single task
@app.route("/tasks/<int:task_id>", methods=["GET"])
def get_task(task_id):
    task = tasks.get(task_id)
    if not task:
        return jsonify({"error": "Task not found"}), 404
    return jsonify(task), 200

# Update a task
@app.route("/tasks/<int:task_id>", methods=["PUT"])
def update_task(task_id):
    task = tasks.get(task_id)
    if not task:
        return jsonify({"error": "Task not found"}), 404
    data = request.get_json()
    task["title"] = data.get("title", task["title"])
    task["completed"] = data.get("completed", task["completed"])
    return jsonify(task), 200

# Delete a task
@app.route("/tasks/<int:task_id>", methods=["DELETE"])
def delete_task(task_id):
    if task_id not in tasks:
        return jsonify({"error": "Task not found"}), 404
    del tasks[task_id]
    return jsonify({"message": "Task deleted"}), 200

# Run the app
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=3007)