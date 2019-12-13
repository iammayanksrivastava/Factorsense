import numpy as np
import plotly.offline as pyo
from plotly import graph_objs as go
import pandas as pd


df = pd.read_csv('/Users/mayanksrivastava/Documents/git/Programming/Python/DASH/Plotly-Dashboards-with-Dash/Data/2010YumaAZ.csv')

days = ['TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY', 'SUNDAY', 'MONDAY']

 
data = []

for day in days: 
    trace = go.Scatter(x=df['LST_TIME'],
                       y=df[df['DAY']==day]['T_HR_AVG'], 
                       mode='lines', name=day)
    
    data.append(trace)


layout = go.Layout(title = 'Daily Temp Averages', xaxis={'title':'Last Time'}, yaxis={'title':'Temperature'}, hovermode='closest')

fig = go.Figure(data= data, layout=layout)
pyo.plot(fig, filename='DailyTempAverages.html')