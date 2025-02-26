# Debian XFCE with VNC and NoVNC

This Docker image provides a Debian environment with XFCE desktop, accessible via VNC through a browser using NoVNC.

## Overview

This Docker image sets up:
- Debian 12 based environment
- XFCE desktop environment
- TightVNC server for remote desktop access
- NoVNC for browser-based VNC access
- Commonly used utilities (Firefox, Git, etc.)

This base image is designed to support applications requiring a UI, particularly those running through Wine (though Wine is not included in this base image).

## Quick Start

### Prerequisites
- Docker and Docker Compose installed on your system

### Setup and Run

1. Clone this repository:
   ```sh
   git clone https://github.com/MrDKGE/Debian-XFCE-VNC.git
   cd Debian-XFCE-VNC
   ```

2. Build and start the container:
   ```sh
   docker compose up -d
   ```

3. Access the desktop environment:
   - Open your web browser and navigate to: `http://localhost:6080`
   - Enter the VNC password (default: "yourpassword")

## Configuration

You can customize the environment through the following variables in docker-compose.yml:

- `VNC_PASSWORD`: Set your preferred VNC password
- `VNC_RESOLUTION`: Change the screen resolution (default: 1600x900)
- `VNC_DEPTH`: Color depth (default: 24)

## Data Persistence

The container mounts a data directory to `/opt/data` inside the container for persistent storage.

## Extending This Image

This image provides a minimal desktop environment. To extend it:

1. Create a new Dockerfile that uses this image as base:
   ```dockerfile
   FROM dkge/debian-xfce-vnc:latest
   
   # Install additional software
   RUN apt-get update && apt-get install -y \
       your-additional-packages \
       && apt-get clean
   ```

## Security Considerations

- This image is primarily intended for development or internal use
- Change the default VNC password before deploying to production
- Consider using additional security measures when exposing publicly

## Versioning and Publishing
When you want to release a new version:

1. Run one of these commands depending on the type of version change:
   ```sh
   # For a patch version (1.0.0 -> 1.0.1)
   ./bump-version.sh patch

   # For a minor version (1.0.0 -> 1.1.0)
   ./bump-version.sh minor
   
   # For a major version (1.0.0 -> 2.0.0)
   ./bump-version.sh major
   ```

2. Push the changes and tags:
   ```sh
   git push && git push --tags
   ```

3. The GitHub Action will automatically build and tag your Docker image with the proper version and push it to Docker Hub.

Don't forget to set up your Docker Hub credentials in your GitHub repository:
- Go to your repository Settings → Secrets and variables → Actions
- Add two repository secrets:
  - `DOCKERHUB_USERNAME`: Your Docker Hub username
  - `DOCKERHUB_TOKEN`: Your Docker Hub access token