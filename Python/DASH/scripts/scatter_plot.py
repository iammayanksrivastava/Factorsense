import numpy as np
import plotly.offline as pyo
from plotly import graph_objs as go

np.random.seed(42)

random_x = np.random.randint(1,101, 100)
random_y = np.random.randint(1,101, 100)

data = [go.Scatter(x= random_x, y=random_y, mode='markers',
                    marker=dict(
                       size=8,
                       color='rgb(51,204,153)',
                       symbol='circle',
                       line = {'width':.5}
                   ) )]

layout = go.Layout(title='Random Number Scatter Plot', xaxis= dict(title ='X Axis'), yaxis=dict(title = 'Y Axis'), hovermode='closest')

fig = go.Figure(data=data, layout=layout)

pyo.plot(fig, filename='scatter.html')