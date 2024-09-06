# Set base image
ARG BASE_IMAGE=neuml/txtai-cpu
FROM $BASE_IMAGE

# Copy RAG application
COPY rag.py requirements.txt .

RUN \
    # Install Java (for Apache Tika)
    apt-get update && \
    apt-get -y --no-install-recommends install default-jre-headless && \
    rm -rf /var/lib/apt/lists && \
    apt-get -y autoremove && \
    \
    # Install base requirements
    python -m pip install --no-cache-dir -r requirements.txt

# Start streamlit application
ENTRYPOINT ["streamlit", "run", "rag.py"]
