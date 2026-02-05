# Step 1: Builder (Compiles and installs dependencies) 
FROM python:3.9-slim AS builder

WORKDIR /app

# Install System Dependencies
RUN apt-get update && apt-get install -y gcc && rm -rf /var/lib/apt/lists/*

# Creates a virtual environment (venv) in the /opt/venv folder.
RUN python -m venv /opt/venv

# Activate venv in PATH so that pip installs within it
ENV PATH="/opt/venv/bin:$PATH"

#  Copy requirements file and install Python dependencies
COPY requirements.txt . 

# Install dependencies within the virtual environment
RUN pip install --no-cache-dir -r requirements.txt

#  Step 2: Runner (Final lightweight image)
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Create a non-root user and group
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Copy the installed dependencies from the builder stage
COPY --from=builder /opt/venv /opt/venv

# Copy application code
COPY . .

# Ensure that PATH includes the binaries installed by pip in the venv
ENV PATH="/opt/venv/bin:$PATH"

# Changes the user to a non-root user for security
USER appuser

# Exposes application port (Uvicorn default is 8000)
EXPOSE 8000

# Initializes the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]