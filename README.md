Best Practices Applied
Practice
Description
✅ Small base image
Uses python:3.12-slim, minimal size.
✅ Multi-stage build
Build dependencies are not in final image.
✅ --no-cache-dir & --no-install-recommends
Reduce layer bloat and image size.
✅ Non-root user
Runs as appuser to follow least-privilege principle.
✅ Layer caching
Separates dependency installation for better caching.
========================================================================================================

Completing this exam was a valuable and rewarding experience. It allowed me to apply Docker, Python, Flask, and GitHub Actions in a real-world scenario. I structured a Flask API, containerized it using a multi-stage Dockerfile, orchestrated services with docker-compose, and implemented CI/CD pipelines. One of the main challenges was managing service dependencies—specifically ensuring the Flask app only starts after the PostgreSQL database is fully ready. I solved this using the wait-for-it script. Another hurdle was configuring proper test discovery with unittest and importing the application correctly in a modular structure. Troubleshooting import paths and structuring the project in a clean, Pythonic way taught me a lot.

🛠️ Next Steps for Production Readiness
To make this stack production-ready:

Add environment-based configuration (dev/staging/prod).

Use Gunicorn as the WSGI server for Flask.

Add HTTPS support via reverse proxy (e.g. Nginx).

Implement logging & monitoring (e.g. Grafana, Prometheus).

Secure database access and secrets using Docker secrets or a vault.

Optimize Docker image further with Alpine or slim Python base.

Add rate limiting, error handling, and production-grade testing.