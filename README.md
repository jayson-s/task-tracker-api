# Task Tracker API 📝

A cloud-deployed Flask-based task tracking API built from scratch, containerized with Docker, and provisioned using Terraform on AWS EC2.

---

## 🚀 Live Demo

**API Base URL:** `http://3.83.160.162:3007`

**Example Endpoint:**  
`GET /tasks` → Returns a list of tasks  
`POST /tasks` → Adds a new task  
`PUT /tasks/<id>` → Updates a task  
`DELETE /tasks/<id>` → Deletes a task

---

## 🛠️ Tech Stack

- **Flask** – lightweight Python web framework
- **Docker** – containerized the app for portability
- **Terraform** – infrastructure as code (IAC) for EC2 provisioning
- **AWS EC2** – cloud hosting (Ubuntu 22.04 / Amazon Linux 2)
- **GitHub** – version control & deployment source

---

## 📁 Project Structure

```
task-tracker-api/
├── app/
│   ├── app.py              # Flask API
│   └── requirements.txt    # Python dependencies
├── terraform/
│   ├── main.tf             # EC2 + security group setup
│   ├── variables.tf        # Terraform input variables
│   └── terraform.tfvars    # Actual values (not included)
├── Dockerfile              # Docker config
└── .gitignore              # Git hygiene
```

---

## 🧪 How to Use the API

### Example `curl` POST

```bash
curl -X POST http://3.83.160.162:3007/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "Build DevOps portfolio project"}'
```

### Example Response

```json
{
  "id": 1,
  "title": "Build DevOps portfolio project",
  "completed": false
}
```

---

## ⚙️ How to Deploy Your Own

### 1. Clone This Repo

```bash
git clone https://github.com/jayson-s/task-tracker-api.git
cd task-tracker-api
```

### 2. Create a `.pem` key and configure AWS IAM credentials

Make sure you:
- Create an IAM user with programmatic access
- Run `aws configure` with those keys
- Save your `.pem` file in `~/.ssh/` and set correct permissions

### 3. Use Terraform to Provision EC2

```bash
cd terraform
terraform init
terraform apply
```

### 4. SSH into EC2 & Deploy App

```bash
ssh -i ~/.ssh/your-key.pem ec2-user@<public-ip>
git clone https://github.com/jayson-s/task-tracker-api.git
cd task-tracker-api
docker build -t task-tracker-api .
docker run -d -p 3007:3007 task-tracker-api
```

---

## ✅ Why This Project Matters

This project demonstrates the ability to:

- Build and run production-ready APIs
- Automate infrastructure with Terraform
- Use Docker for portable, scalable deployment
- Deploy to AWS securely and efficiently
- Combine software engineering with DevOps skills

---

> Made with ❤️ + Python + Terraform + AWS
