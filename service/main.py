from typing import List, Dict

import joblib

from fastapi import FastAPI
from fastapi.responses import JSONResponse
from pydantic import BaseModel 
from sklearn.ensemble import IsolationForest

app = FastAPI()

model: IsolationForest = joblib.load("model/model.joblib")

class PredictionRequest(BaseModel):
    feature_vector: List[float]
    score: bool = False


@app.post("/prediction")
def predict(request: PredictionRequest):
    """Predict if an object is inlier or outlier."""
    print(request)
    feature_vector = [request.feature_vector, ]
    try:
        prediction = int(model.predict(feature_vector)[0])
    except Exception as e:
        return {"error": e}
    if request.score:
        anomaly_score = model.score_samples(feature_vector)[0]
        return JSONResponse(content={"is_inlier": prediction, "anomaly_score": anomaly_score})
    else:
        return JSONResponse(content={"is_inlier": prediction})


@app.get("/model_information")
def model_information():
    """Return the information about the IsolateForest model."""
    return JSONResponse(content=model.get_params())
