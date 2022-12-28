# Packages
library(lubridate)
library(ggplot2)
library(RColorBrewer)
library(showtext)
library(grid)

################################################################################
########################### Surface temperature anomalies ######################
################################################################################

# Change working dictionary
setwd("~/File/Global Climate Indicators/Surface Temperature Anomalies")

# Specify URL where file is stored
url = "https://www.ncei.noaa.gov/cag/global/time-series/globe/land_ocean/all/1/1880-2022/data.csv"
destfile = "~/File/Global Climate Indicators/Surface Temperature Anomalies/temperature_anomalies.csv"
download.file(url = url, destfile = destfile)

# Read the data 
data = read.csv("temperature_anomalies.csv", header = TRUE, skip = 4)
data$Year = ym(data$Year)
dim(data)
head(data)

# My font
my_font = "Source Sans Pro" 
# Load font for ploting: 
font_add_google(name = my_font, family = my_font) 

# Define color parameters
plt_color = "#17202A"
plt_color2 = "#212F3D"
plt_color3 = "#EAECEE"
plt_color4 = "#FDFEFE" 
color_strip = brewer.pal(name="RdBu", n = 11)

# Define text parameters
p_title = "Surface temperature anomalies"
p_subtitle = "Global Land and Ocean | 1880-2022"
p_caption = "Data source: National Oceanic and Atmospheric Administration (NOAA) | Graphic Designer: @DavidNT96"
legend_y = "Temperature Anomalies (°C)"
legend_x = "Year"

# Create from graph
ggplot() + 
  theme_minimal() + 
  theme(plot.background = element_rect(fill = plt_color, color = NA)) + 
  geom_bar(data = data, aes(x = Year, y = Value, fill= Value), stat='identity') +
  scale_fill_gradientn(colors = rev(color_strip)) +
  theme(panel.grid = element_line(color = plt_color2)) +
  theme(plot.margin = unit(c(0.5, 1, 0.5, 0.9), "cm")) +
  labs(title = p_title, subtitle = p_subtitle, caption = p_caption, x = legend_x, y = legend_y) + 
  theme(axis.title = element_text(family = my_font, color = plt_color3, size = 11)) + 
  theme(axis.text = element_text(family = my_font, color = plt_color3, size = 11)) + 
  theme(plot.title = element_text(family = my_font, color = plt_color4, size = 18, hjust = 0, face = "bold")) + 
  theme(plot.subtitle = element_text(family = my_font, color = plt_color4, size = 12)) + 
  theme(plot.caption = element_text(family = my_font, color = plt_color4, hjust = 1, size = 11, vjust = -1)) + 
  theme(plot.title.position = "plot") +  
  theme(plot.caption.position = "plot") +
  theme(legend.position="none") + 
  scale_x_date(date_breaks = "20 year", date_labels = "%Y")

grid.rect(x = 1, y = 0,
          hjust = 1, vjust = 0.1,
          height = 0.008*1,
          just = c("left", "top"),
          gp = gpar(fill = "#2C3E50", col = "#2C3E50"))
