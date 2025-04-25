# RAG Demo

This repository demonstrates a **Retrieval-Augmented Generation (RAG)** pipeline that calls a **cloud-based LLM** (like Claude's API). It is containerized with Docker to simplify deployment and sharing. 

## Overview

- **Docker**: Encapsulates the Python environment and dependencies.  
- **Cloud LLM**: Currently configured to use Claude 3.7.

## Prerequisites

1. **Docker** and **Docker Compose** installed on your system.
2. An **Anthropic API Key**.  

## Getting Started

1. **Clone the Repository**

   ```bash
   git clone https://github.com/CedarvilleCS/maestro.git
   ```
2. **Navigate to Project Directory**
   ```bash
   cd maestro
   ```
3. **Build Container**
   ```bash
   docker-compose up --build
   ```
4. **Connect to GUI**
   ```bash
   localhost:8866
   ```

For an example walkthrough of how MAESTRO works: [Go to Docs](./tutorial/THM-Rootme-Walkthrough.md)
