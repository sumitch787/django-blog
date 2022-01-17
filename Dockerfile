FROM python:3.10-alpine3.15
COPY . /app
WORKDIR /app
RUN rm Dockerfile Jenkinsfile
ENV DJANGO_SUPERUSER_PASSWORD=admin \
    DJANGO_SUPERUSER_USERNAME=admin \
    DJANGO_SUPERUSER_EMAIL=admin@localhost.com
RUN pip install django
RUN python manage.py createsuperuser --noinput
RUN python manage.py migrate

CMD ["python","manage.py","runserver","0.0.0.0:8080"]
