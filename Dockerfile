# Set base image
ARG BASE_IMAGE=neuml/txtai-cpu
FROM $BASE_IMAGE

# Copy RAG application
COPY rag.py .

RUN \
    # Install Java (for Apache Tika)
    apt-get update && \
    apt-get -y --no-install-recommends install default-jre-headless && \
    rm -rf /var/lib/apt/lists && \
    apt-get -y autoremove && \
    \
    # Install Streamlit (UI), AutoAWQ (for quantization), latest Transformers (Llama 3.1)
    python -m pip install --no-cache-dir streamlit matplotlib autoawq transformers --upgrade

# Start streamlit application
ENTRYPOINT ["streamlit", "run", "rag.py"]
