import numpy as np
import plotly.offline as plot
import plotly.graph_objs as go 

np.random.seed(42)

random_x = np.random.randint(1,101, 100)
random_y = np.random.randint(1,101, 100)

data = [go.Scatter(x= random_x, y=random_y, mode='markers')]

plot.plot(data, filename='scatter.html')