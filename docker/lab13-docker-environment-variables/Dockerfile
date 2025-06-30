# Use python image
FROM python:3.14.0b3-alpine3.21

# Set working directory
WORKDIR /app

# Copy application files
COPY . .

# Install flask
RUN pip install flask

# Expose port
EXPOSE 8080

# Set environment variables (for production, canada-west)
ENV APP_MODE=production
ENV APP_REGION=canada-west

# Run the app
CMD ["python", "app.py"]
