FROM python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    wget sudo dos2unix tshark jq \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN mkdir -p /app/chromadb
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY packet_buddy /app/packet_buddy/
COPY config/config.toml /root/.streamlit/config.toml

CMD ["streamlit", "run", "/app/packet_buddy/packet_buddy.py", "--server.port", "8505"]
