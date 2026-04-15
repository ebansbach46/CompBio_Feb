# Homework 12
# may 7 have everything done by may 7

# update conda: $ conda update -n base -c defaults conda

from math import exp
import json
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go

# Question 1
gap = px.data.gapminder().query("year==1972")

europe = gap.query("continent == 'Europe'") #new

fig = px.choropleth(
    europe,
    locations = "iso_alpha",
    color = "gdpPercap",
    hover_name = "country",
    hover_data = {
        "gdpPercap": ":,.0f",
        "pop": ":,",
        "iso_alpha": False
    },
    color_continuous_scale = "Viridis",
    title = "GDP By Country in Europe (1972)" 
)
# new:
fig.update_geos(
    scope = "Europe",
    showland = True,
    landcolor = "rgb(240,240,240)"
)   # isn't actually scoping in on europe
#
fig.show()

# Question 2
gap2 = px.data.gapminder().query("year==1972")

fig2 = px.scatter_geo(
    gap2,
    locations = "iso_alpha",
    size = "pop",
    color = "pop",
    hover_name = "country",
    hover_data ={
        "pop": ":,",
        "lifeExp": ":.1f"
    },
    #color_continuous_scale = "Viridis",
    title = "Country Population Sizes (1972)"

)
fig2.show()
