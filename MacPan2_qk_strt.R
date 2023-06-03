library(macpan2)
library(ggplot2)
sir = Compartmental(system.file(
  "starter_models", "sir", package = "macpan2"))
N = 100
simulator = sir$simulators$tmb(time_steps = 100
                               , state = c(S = N - 1, I = 1, R = 0)
                               , flow = c(foi = 0, gamma = 0.1)
                               , N = N
                               , beta = 0.2
)
sir_sims = simulator$report()

# visualizing SIR model
sir_results_wide <- (sir_sims
                     ## drop 'matrix' (has only a single value) and 'col' (empty)
                     |> dplyr::select(-c(matrix, col))
                     |> tidyr::pivot_wider(id_cols = time, names_from = row)
)

head(sir_results_wide, n = 3)

par(las = 1) ## horizontal y-axis ticks
matplot(sir_results_wide[, 1],
        sir_results_wide[,-1],
        type = "l",
        log = "y",
        xlab = "time", ylab = "",
        main = "Macpan 2")
legend("bottom", col = 1:3, lty = 1:3, legend = sir$labels$state())


'''Tried Steve\'s suggestion to use model_starter, but I ended up with this:
model_starter("sir", "C:/Users/kchen/AppData/Local/R/win-library/4.3/macpan2/starter_models/sir")
Error in model_starter("sir", "C:/Users/kchen/AppData/Local/R/win-library/4.3/macpan2/starter_models/sir") :
  Directory for the model already exists.


'''
