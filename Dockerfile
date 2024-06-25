FROM python:3.9-slim

# Create working folder and install dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application contents
COPY service/ ./service/

# Switch to a non-root usere
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Expose to port 8080 - run the service
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]