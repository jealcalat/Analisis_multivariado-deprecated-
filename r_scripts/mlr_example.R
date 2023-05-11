library(ggplot2)
# Create example data
set.seed(42)
n <- 100
education <- rnorm(n, mean = 16, sd = 2)
sex <- factor(sample(c("male", "female"), n, replace = TRUE))
intercept <- 50000
b_ed <- 3000
# income = b0 + b1 * educacion + b2 * sex
b_sex <- 10000
income <- intercept + b_ed * education + b_sex * (sex == "male") + rnorm(n, mean = 0, sd = 5000)
datos <- data.frame(income = income, education = education, sex = sex)

# para variables categóricas, el coeficiente se interpreta como una diferencia promedio


# Fit the multiple linear regression model
model <- lm(income ~ education + sex, data = datos)
summary(model)

ggplot(datos,
       aes(x = education, y = income, color = sex)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)


new_data <- data.frame(sex = c("male", "female"),
                       education = c(15, 15))
predictions <- predict(model, newdata = new_data, type = 'response')

cbind(new_data, predictions)

# Añadimos una nueva variable y hacemos comparación de modelos

age <- sample(25:65, n, replace = TRUE)
data <- data.frame(income = income, education = education, sex = sex, age = age)

# Fit the models
model1 <- lm(income ~ education + sex, data = data)
model2 <- lm(income ~ education + sex + age, data = data)
model3 <- lm(income ~ education + age, data = data)
model4 <- lm(income ~ sex + age, data = data)

# Compare AIC values
aics <- AIC(model1, model2, model3, model4)
aics[order(aics$AIC),]

ggplot(datos,
       aes(x = education, y = income, color = sex)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)

summary(model1)
