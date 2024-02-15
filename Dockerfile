# Use the official Python base image
FROM python:3.9

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN mkdir /weather-application
# Set the working directory in the container
WORKDIR /weather-application

ADD ./weatherapplication/ /weather-application/
# Copy the requirements file
COPY ./requirements.txt /weather-application/

# Install the required dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port the Django app will run on
EXPOSE 8000

# Run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
