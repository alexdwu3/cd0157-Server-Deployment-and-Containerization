FROM python:3.9-slim

WORKDIR /app
COPY . /app

# Install pip and dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Define entrypoint with full bind address
ENTRYPOINT ["gunicorn", "-b", "0.0.0.0:8080", "main:APP"]
