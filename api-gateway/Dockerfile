# 1. Schlanker Python Base Image
FROM python:3.11-slim

# 2. Arbeitsverzeichnis setzen
WORKDIR /app

# 3. Abhängigkeiten kopieren und installieren
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Applikation kopieren
COPY main.py .

# 5. Startbefehl mit uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
