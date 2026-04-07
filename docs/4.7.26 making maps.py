# 4.7.26 making maps
# maps_part_1
# Using plotly to create maps in python

# load packages:
# conda install plotly (terminal)
# will also use pandas
import json
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go

# chloropleth map-use for avg population of a county eg

# load data here (gapminder)
gap = px.data.gapminder().query("year==2007") # use query() to select the year we want to work with
gap.head()
# country codes = iso_xyz

# minimal level chloropleth
fig = px.choropleth(
    gap,
    locations = "iso_alpha",  # want to use iso code
    color = "lifeExp",
    hover_name = "country"  # when hover over country, it tells you the country name and actual values
)
fig.show()

# add title, change coloration
fig = px.choropleth(
    gap,
    locations = "iso_alpha",  
    color = "lifeExp",
    hover_name = "country",
    color_continuous_scale = "Viridis",
    title = "Life Expectancy By Country (2007)"  
)
fig.show()

# crop this map - less white filler spaces, and improve labels:
fig.update_layout(
    coloraxis_colorbar_title = "Years",
    margin = dict(l=0, r=0, t=50, b=0)   # left, right, top, bottom dimesions
)

# gdp with more hovering information:
fig = px.choropleth(
    gap,
    locations="iso_alpha",
    color="gdpPercap",
    hover_name="country",
    hover_data={
        "lifeExp": ":.1f",
        "pop": ":,",
        "gdpPercap": ":,.0f",
        "iso_alpha": False
    },
    color_continuous_scale="Plasma",
    title="GDP per capita by country (2007)"
)
fig.show()

# update outlines of GDP map
fig.update_geos(
    showframe = False,
    showcoastlines = False
)

# crop map to one region
americas = gap.query("continent == 'Americas'")
print(americas)
americas

fig = px.choropleth(
    americas,
    locations = "iso_alpha",  
    color = "lifeExp",
    hover_name = "country",
    color_continuous_scale = "Tealgrn",
    title = "Life Expectancy in the Americas (2007)"  
)
fig.show()

fig.update_geos(
    scope = "north america",
    showland = True,
    landcolor = "rgb(240,240,240)"
)
fig.show()

# look at some projections (prj.)
fig.update_geos(projection_type="natural earth")
fig.show()
# plotly.com/python-api-reference/plotly.express.html

fig.update_geos(projection_type="mercator")

fig.update_geos(projection_type="orthographic")

# every projection solves some type of problem

# tile based chloropleths
# json files
from urllib.request import urlopen

with urlopen("https://raw.githubusercontent.com/plotly/datasets/master/geojson-counties-fips.json") as response:
    county_geojson = json.load(response)

county_df = pd.read_csv(
    "https://raw.githubusercontent.com/plotly/datasets/master/fips-unemp-16.csv",
    dtype={"fips": str}
)

county_df.head()

#
fig = px.choropleth_map(
    county_df,
    geojson=county_geojson,
    locations="fips",
    featureidkey="id",
    color="unemp", # the data you are showing
    color_continuous_scale="Viridis",
    zoom=3,
    center={"lat": 37.8, "lon": -96},
    map_style="carto-positron", 
    opacity=0.7,
    title="US county unemployment"
)
fig.show()

#
fig = px.choropleth_map(
    county_df,
    geojson=county_geojson,
    locations="fips",
    featureidkey="id",
    color="unemp", # the data you are showing
    color_continuous_scale="Viridis",
    zoom=3,
    center={"lat": 37.8, "lon": -96},
    map_style="open-street-map",  ## changed map style
    opacity=0.7,
    title="US county unemployment"
)
fig.show()

#
fig = px.choropleth_map(
    county_df,
    geojson=county_geojson,
    locations="fips",
    featureidkey="id",
    color="unemp", # the data you are showing
    color_continuous_scale="Viridis",
    zoom=3,
    center={"lat": 37.8, "lon": -96},
    map_style="carto-darkmatter", 
    opacity=0.7,
    title="US county unemployment"
)
fig.show()

