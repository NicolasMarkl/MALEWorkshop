##importing dataset
cars = mtcars
## linear regression model
linear_model = lm(mpg ~ disp + hp + wt, data = cars)
print(linear_model)

# saving the model
saveRDS(linear_model, "mtcars_linear_model.RDS")
