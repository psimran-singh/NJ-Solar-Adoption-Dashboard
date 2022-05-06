### creating trend lines for each graph on the analysis page
# Income
x_sort_income <- sort(Solar_Res_Zip$Income)
y_sort_income <- Solar_Res_Zip$Adoption_Rate[order(Solar_Res_Zip$Income)]

loess_fit_income <- loess(y_sort_income ~ x_sort_income)
rl_income <- predict(loess_fit_income)

income_trendline <- data.frame(x = x_sort_income, y = rl_income)

remove(x_sort_income, y_sort_income, loess_fit_income, rl_income)

# Housing Value
x_sort_val <- sort(Solar_Res_Zip$House_Value)
y_sort_val <- Solar_Res_Zip$Adoption_Rate[order(Solar_Res_Zip$House_Value)]

loess_fit_val <- loess(y_sort_val ~ x_sort_val)
rl_val <- predict(loess_fit_val)

val_trendline <- data.frame(x = x_sort_val, y = rl_val)

remove(x_sort_val, y_sort_val, loess_fit_val, rl_val)

# White Population
x_sort_white <- sort(Solar_Res_Zip$Perc_White)
y_sort_white <- Solar_Res_Zip$Adoption_Rate[order(Solar_Res_Zip$Perc_White)]

loess_fit_white <- loess(y_sort_white ~ x_sort_white)
rl_white <- predict(loess_fit_white)

white_trendline <- data.frame(x = x_sort_white, y = rl_white)

remove(x_sort_white, y_sort_white, loess_fit_white, rl_white)

# House Ownership
x_sort_own <- sort(Solar_Res_Zip$Perc_House_Owned)
y_sort_own <- Solar_Res_Zip$Adoption_Rate[order(Solar_Res_Zip$Perc_House_Owned)]

loess_fit_own <- loess(y_sort_own ~ x_sort_own)
rl_own <- predict(loess_fit_own)

own_trendline <- data.frame(x = x_sort_own, y = rl_own)

remove(x_sort_own, y_sort_own, loess_fit_own, rl_own)