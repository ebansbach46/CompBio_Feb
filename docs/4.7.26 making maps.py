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
    hover_data={   # the {} indicate a dictionary
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

####################################################
#4.9.26

# density heat maps
# how to find path of an image or dataset in the console/terminal of laptop

eq = pd.read_csv(
    "https://raw.githubusercontent.com/plotly/datasets/master/earthquakes-23k.csv"
)
eq.head()

# 3D map, so z is the name of the variable that were measuring here

fig = px.density_map(
    eq,
    lat = "Latitude",
    lon = "Longitude",
    z = "Magnitude",
    radius = 5,
    zoom = 0,
    center={"lat": 0, "lon": 180},
    map_style = "open-street-map",
    title = "Global Earthquake Density"
)
fig.show()

# increase radius 
fig = px.density_map(
    eq,
    lat = "Latitude",
    lon = "Longitude",
    z = "Magnitude",
    radius = 10,
    zoom = 0,
    center={"lat": 0, "lon": 180},
    map_style = "open-street-map",
    title = "Global Earthquake Density"
)
fig.show()
# bigger value for radius is better for when your zooming in on a location/map

# changing opacity 
fig.update_traces(opacity = 0.7)
fig.show()

# focusing in on a region, using query()
pacific = eq.query("Latitude > -60 and Latitude < 60 and Longitude > 100")

fig = px.density_map(
    pacific,
    lat = "Latitude",
    lon = "Longitude",
    z = "Magnitude",
    radius = 12,
    zoom = 2,  # zoom values only 1-7
    center={"lat": 0, "lon": 160},
    map_style = "carto-darkmatter",
    title = "Pacific Earthquake Density"
)
fig.show()

# can do a heatmap with any continuus variable, and with lat and long values


# bubble map
gap

fig = px.scatter_geo(
    gap,
    locations = "iso_alpha",
    color = "continent",  # maps the continents colors
    hover_name = "country",
    size = "pop",
    projection = "natural earth"
)
fig.show()


# animation

df = px.data.gapminder()

fig = px.scatter_geo(
    df,
    locations = "iso_alpha",
    color = "continent",  # maps the continents colors
    hover_name = "country",
    size = "pop",
    animation_frame = "year",
    projection = "natural earth"
)
fig.show()


# go to terminal: conda install dash
# from dash, import:
from dash import Dash, dcc, html

app = Dash()

app.layout = html.Div({
    dcc.Graph(figure=fig)  # fig = the handle we just created
})

app.run(debug = True, use_reloader = False)
