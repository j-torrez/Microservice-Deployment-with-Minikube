from fastapi import FastAPI, HTTPException

app = FastAPI()

@app.get("/student") 
def get_student():
    return {"student_status:": "hired"}

@app.get("/")
async def handle_root():
    raise HTTPException(status_code=400, detail="Only GET requests to the path '/student' are allowed.")

@app.get("/{path_name}")
def	handle_invalid_path(path_name: str):
    raise HTTPException(status_code=404, detail=f"The path '{path_name}' is not valid.")    