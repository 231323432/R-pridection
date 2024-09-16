library(kohonen)  # 用于 SOM 分析
library(ggplot2)  # 用于数据可视化
library(RColorBrewer) # 用于颜色方案
library(viridis) # 用于颜色方案
install.packages("viridis")

train_data_som <- as.matrix(train_data_numeric)
grid_size <- ceiling(sqrt(nrow(train_data_som) / 2))
som_grid <- somgrid(xdim = grid_size, ydim = grid_size, topo = "hexagonal")
som_model <- som(
  train_data_som, 
  grid = som_grid, 
  rlen = 100, 
  alpha = c(0.05, 0.01) 
)
summary(som_grid)
color_palette <- viridis(9)
# --- 节点计数图 ---
plot(som_model, type = "counts", main = "Node Counts")
plot(som_model, type = "dist.neighbours", main = "Distance Map")
bmi <- train_data$Weight / (train_data$Height / 100)^2

# 将 BMI 值映射到 SOM 网格
bmi_som <- map(som_model, as.matrix(bmi))

# 绘制 BMI 属性平面图
plot(som_model, type = "property", property = bmi_som, main = "BMI")