# Start from a small, official Python image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements and install dependencies
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app into the container
COPY app/ .

# Expose Flask's port
EXPOSE 3007

# Command to run the app
CMD ["python", "app.py"]