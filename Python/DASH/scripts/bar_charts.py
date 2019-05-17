import pandas as pd
import plotly.graph_objs as go 
import plotly.offline as pyo 


df = pd.read_csv('/Users/mayanksrivastava/Documents/git/Programming/Python/DASH/Plotly-Dashboards-with-Dash/Data/2018WinterOlympics.csv')



trace1 = go.Bar(x=df['NOC'],y=df['Gold'], 
            name = 'Gold', 
            marker={'color': '#FFD700'})


trace2 = go.Bar(x=df['NOC'],y=df['Silver'], 
                    name = 'Silver', 
                    marker={'color': '#9EA0A1'})

trace3 = go.Bar(x=df['NOC'],y=df['Bronze'], 
                    name = 'Bronze', 
                    marker={'color': '#CD7F32'})


data = [trace1, trace2, trace3]

layout = go.Layout(title = 'Total Number of Medals', barmode = 'stack')

fig =go.Figure(data=data, layout=layout )

pyo.plot(fig, filename = 'bar_chart.html')