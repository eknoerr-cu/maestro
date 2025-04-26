# Maestro - Retrieval-Augmented Generation (RAG) System

## Overview

This repository demonstrates a **Retrieval-Augmented Generation (RAG)** pipeline that calls a **cloud-based LLM** (currently Claude's API). It is containerized with Docker to simplify deployment and sharing. 

## Key Features

- **Document Processing Pipeline**: Convert various document formats into processable text
- **Contextual Retrieval**: Find the most relevant documents for user queries
- **LLM Integration**: Seamlessly integrate with Claude 3.5 for intelligent responses
- **Web Interface**: User-friendly interface for interacting with the system

## Directory Structure

- `/src` - Core application code
- `/src/code_templates` - Example code structures given to the agents on how to output code
- `/tutorial` - Example walkthrough of how MAESTRO works

## Prerequisites

1. **Docker** and **Docker Compose** are installed on your system.
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

## API Key
   - MAESTRO will prompt the user for an Anthropic API key when first spinning up the Web GUI.
   - API key modifications can be done in user_config.json, which is created during startup.

## LLM Model
   - Currently the model being used is Claude 3.5
   - You can change the specific Anthropic model used in  src/linear gui.ipynb -> cell 4

## CyberRecon
   - This project was created to compete in the 2025 US Cyber Command CyberRecon competition.
   - The paper covering our research can be located here: [CyberRecon Paper](.MAESTRO_Reasearch.pdf)

## File Descriptions
   - src/capec.csv 
      - A CSV database containing detailed information about various computer security attack patterns, their descriptions, prerequisites, execution flows, impacts, and mitigations as part of the Common Attack Pattern Enumeration and Classification (CAPEC) framework.
   - src/exploit_dp.json
      - Defines exploitation techniques, known vulnerabilities, payloads, mitigation strategies, and associated threat actors.
   - src/linear gui.ipynb
      - Defines and renders an interactive Maestro chat GUI in Voilà and a LangChain/Anthropic backend to route cybersecurity CTF questions through reconnaissance, exploitation, and pivoting agent workflows.
   - src/nvdcve-1.1-modified.json
      - CVE Database that MAESTRO utilizes to pull modern CVE data that can be edited by the user.
   - src/pivot_db.json
      - A database of network pivoting tools, listing each tool’s title, type, tag, description, and optional standard usage commands.
   - src/tooling.json
      - Defines a collection of security and reconnaissance tools, each with metadata (title, type, tag, description) and example command templates for usage.
   - .gitignore
      - Tells Git to ignore all .DS_Store and any src/user_config.json file, created by MAESTRO when user first inputs API key, anywhere in the repository.
   - docker-compose.yml
      - Defines an ai-cyber-agent service that builds from the local Dockerfile, maps host port 8866 to container port 8866, enables an interactive terminal, and mounts the src directory into /app/src inside the container.
   - Dockerfile
      - Defines a Python 3.10-slim container that installs system and Python dependencies, copies application code and an entrypoint script (making it executable) to the container, and exposes port 8866.
   - entrypoint.sh
      - Prints the current directory contents, switches into the src folder, and then launches the linear gui.ipynb notebook via Voilà on port 8866.
   - requirements.txt
      - Ran by the Dockerfile to install the necessary dependencies needed to run MAESTRO

## Example Walkthrough
   - For an example walkthrough of how MAESTRO works: [Go to THM-Rootme-Walkthrough](./tutorial/THM-Rootme-Walkthrough.md)
