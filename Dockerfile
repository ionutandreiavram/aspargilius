FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install required system packages
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    gcc \
    libasound2-dev \
    portaudio19-dev \
    pulseaudio \
    python3-pip \
    python3-distutils && \
    rm -rf /var/lib/apt/lists/*

# Copy your files
COPY requirements.txt .
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt


# Set environment variable to use PulseAudio inside the container
ENV PULSE_SERVER=unix:/run/user/1000/pulse/native

CMD ["python", "speech_test.py"]

# Add at the end if you want tests to run on build
COPY tests/ /app/tests/
RUN pytest /app/tests || true  # Remove "|| true" to make build fail on test error

