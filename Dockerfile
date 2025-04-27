FROM python:3.13-alpine

LABEL maintainer="volodymyr.vinohradov@gmail.com"

WORKDIR /app
COPY pyproject.toml uv.lock ./

RUN pip install --no-cache-dir uv \
    && uv sync --no-cache-dir \
    && pip uninstall -y pip setuptools wheel uv \
    && rm -rf /root/.cache /root/.pip

COPY app/ .

ENV VIRTUAL_ENV=/app/.venv
ENV PATH="/app/.venv/bin:$PATH"

CMD ["python", "main.py"]
