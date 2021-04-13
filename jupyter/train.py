import pandas as pd
import joblib

from sklearn.ensemble import IsolationForest

train = pd.read_csv("/src/data/train.csv")

model = IsolationForest(random_state=16, contamination=0.001)

model.fit(train)

joblib.dump(model, "/model/model.joblib")
