FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    chromium \
    chromium-driver \
    && rm -rf /var/lib/apt/lists/*

#ใช้ virtual environment เพราะ debian ล็อกไม่ให้ใช้ pip
RUN python3 -m venv /opt/robotenv

#pip ผ่าน virtual environment
RUN /opt/robotenv/bin/pip install --no-cache-dir \
    robotframework \
    robotframework-seleniumlibrary

ENV PATH="/opt/robotenv/bin:$PATH"

USER jenkins
