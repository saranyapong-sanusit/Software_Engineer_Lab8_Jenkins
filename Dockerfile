FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y \
    firefox-esr \
    wget \
    ca-certificates \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# ---- install geckodriver (pin version) ----
RUN wget -O /tmp/geckodriver.tar.gz \
    https://github.com/mozilla/geckodriver/releases/download/v0.36.0/geckodriver-v0.36.0-linux64.tar.gz \
    && tar -xzf /tmp/geckodriver.tar.gz -C /usr/local/bin \
    && chmod +x /usr/local/bin/geckodriver \
    && rm /tmp/geckodriver.tar.gz

# ---- Robot Framework venv ----
RUN python3 -m venv /opt/robotenv
RUN /opt/robotenv/bin/pip install --no-cache-dir \
    robotframework \
    robotframework-seleniumlibrary

ENV PATH="/opt/robotenv/bin:$PATH"

USER jenkins

