#!/bin/bash

# Create a temporary directory
mkdir /tmp/flask-api-example
cd /tmp/flask-api-example

# Create the app.py file
echo 'from flask import Flask, jsonify, request

app = Flask(__name__)

@app.route("/", defaults={"path": ""})
@app.route("/<path:path>")
def catch_all(path):
    return jsonify({"message": f"You requested: {request.url}"}), 200

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=8080)' > app.py

# Create the Dockerfile
echo 'FROM python

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8080

CMD ["python", "app.py"]' > Dockerfile

# Create the requirements.txt file
echo 'Flask' > requirements.txt

# Build the Docker image
docker build -t flask-api-example .

# Run the Docker container on port 8080
docker run -d -p 8080:8080 --name flask-api-example flask-api-example
