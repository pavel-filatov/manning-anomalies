from typing import List
import joblib
from fastapi import FastAPI

app = FastAPI()

model = joblib.load("model/model.joblib")

@app.get("/prediction")
def predict(feature_vector: List[float], score: bool) -> bool:
    prediction = model.predict(feature_vector)
    if score:
        return {"is_inlier": prediction, "anomaly_score": 0.5}
    else:
        return {"is_inlier": prediction}
