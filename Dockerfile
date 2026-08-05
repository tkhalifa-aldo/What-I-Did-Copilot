FROM python:3.12-slim

WORKDIR /app

# The project has no pip dependencies; all core scripts use Python stdlib.
COPY . /app

# Use an entrypoint so users can pass normal whatidid arguments.
ENTRYPOINT ["python", "whatidid.py"]
# Defaults to a 7-day lookback.
CMD ["--7D", "--out-dir", "/app/reports"]
