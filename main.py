# main.py
from fastapi import FastAPI, Response
from prometheus_fastapi_instrumentator import Instrumentator
import os
import random
import time

app = FastAPI(title="Jelastic Observability Demo")

# -- OBSERVABILITY SETUP --
instrumentator = Instrumentator().instrument(app)

@app.on_event("startup")
async def _startup():
    # Start the instrumentation
    instrumentator.expose(app)
    
# -- END OF OBSERVABILITY SETUP --

# -- ROUTES --

@app.get("/")
def read_root():
    """Root endpoint returning a welcome message."""
    return {"message": "Testing CI/CD!", "node": os.getenv("HOSTNAME", "unknown")}

@app.get("/health")
def health_chgeck():
    """Health check Jelastic LoadBalancer endpoint."""
    return {"status": "ok"}

@app.get("/heavy")
def heavy_task():
    """Simulates a heavy task by sleeping for a random duration."""
    time.sleep(random.uniform(0.1, 0.8))
    return {"task": "completed_heavy_calculation"}

@app.get("/error")
def simulate_error():
    """Simulates an error by raising an exception."""
    if random.choice([True, False]):
        return Response(status_code=500, content="Simulated error occurred!")
    return {"status": "no error this time!"}

