### Homework 6 (olfd)
### E Bansbach
### 2.18.26

library(deSolve)

############################################################
# FUNCTION: run_sir_model
# PURPOSE: Solve deterministic SIR model with deSolve
# INPUTS:
#   beta, gamma : transmission & recovery rates
#   N           : total population
#   S0, I0, R0  : initial conditions
#   t_start     : start time
#   t_end       : end time
#   dt          : timestep
# OUTPUT:
#   data.frame with columns: time, S, I, R
############################################################

run_sir_model <- function(
  beta    = 0.1,
  gamma   = 0.1,
  N       = 1000,
  S0      = 999,
  I0      = 1,
  R0      = 0,
  t_start = 0,
  t_end   = 160,
  dt      = 1
) {

  init  <- c(S = S0, I = I0, R = R0)
  times <- seq(t_start, t_end, by = dt)

  sir_equations <- function(time, state, parameters) {
    with(as.list(c(state, parameters)), {
      dS <- -beta * S * I / N
      dI <-  beta * S * I / N - gamma * I
      dR <-  gamma * I
      list(c(dS, dI, dR))
    })
  }

  out <- ode(
    y     = init,
    times = times,
    func  = sir_equations,
    parms = c(beta = beta, gamma = gamma, N = N)
  )

  as.data.frame(out)
}

####################################################################

step <- 0.01

beta_vec <- seq(from=0, to=0.5, by = step)
gamma_vec <- seq(from=0, to=0.5, by=step)

beta_parms = beta_output
gamma_parms = gamma_output
####################################################################
sir_params <- function(beta_params, gamma_params){
  time_row <- beta_vec*gamma_vec

# max_infected is vetavec*gamma vec
# df row = bet vec * gamma vec

  init_df <- length(beta_vec)*length(gamma_vec)


  max_infected <- rep(NA, init_df)
  beta_output <- rep(NA, init_df)
  gamma_output <- rep(NA, init_df)


  sir_df <- data.frame(beta_output, gamma_output, max_infected)

  counter <- 1
  for (i in seq_along(beta_output)){
    for(j in seq_along(gamma_output)){
      temp_df <- run_sir_model(beta = beta_output[i], gamma = gamma_output[j])

      sir_df$max_infected[counter] <- max(temp_df$I)
      sir_df$beta_output[counter] <- beta_parms[i]
      sir_df$gamma_output[countter] <- gamma_parms[j]
      counter <- counter + 1
    }
  }
  return(sir_df)
}

param_sir_run <-sir_params(beta_parms = beta_vec, gamma_prms = gamm_vec)



###
##########################################################
####
#t_final <- seq(from = 0, to = 0.5, by = step)

#df <- list(beta="Beta", gamma="Gamma", I0="Max Infected")

##################################################
# Question 2:

sir_mat <- function(){
# input: sir_df
# output: heatmap plot
  
  counter <- 1
  loop 1{
    loop 2{
      x <- Do Things
      sir_df <- Store Things      
      counter <- counter + 1 # increase your counter for the next round
    }
}

  for (i in seq_along(sir_df)){
    for (j in seq_along())
      x <- max_infected
      sir_mat <- matrix(data=sir_df, ncol = 3)
      counterr <- counter + 1
  }
  }

  time_row <- beta_vec*gamma_vec

# max_infected is vetavec*gamma vec
# df row = bet vec * gamma vec

  init_df <- length(beta_vec)*length(gamma_vec)


  max_infected <- rep(NA, init_df)
  beta_output <- rep(NA, init_df)
  gamma_output <- rep(NA, init_df)


  sir_df <- data.frame(beta_output, gamma_output, max_infected)

  counter <- 1
  for (i in seq_along(beta_output)){
    for(j in seq_along(gamma_output)){
      temp_df <- run_sir_model(beta = beta_output[i], gamma = gamma_output[j])

      sir_df$max_infected[counter] <- max(temp_df$I)
      sir_df$beta_output[counter] <- beta_parms[i]
      sir_df$gamma_output[countter] <- gamma_parms[j]
      counter <- counter + 1
    }
  return(sir_df)
  }
  return(sir_df)


param_sir_run <-sir_params(beta_parms = beta_vec, gamma_prms = gamm_vec)



###
##########################################################
####
#t_final <- seq(from = 0, to = 0.5, by = step)

#df <- list(beta="Beta", gamma="Gamma", I0="Max Infected")

##################################################
# Question 2:

sir_mat <- function(){
# input: sir_df
# output: heatmap plot
  
  counter <- 1
  loop 1{
    loop 2{
      x <- Do Things
      sir_df <- Store Things      
      counter <- counter + 1 # increase your counter for the next round
    }
}

  for (i in seq_along(sir_df)){
    for (j in seq_along())
      x <- max_infected
      sir_mat <- matrix(data=sir_df, ncol = 3)
      counterr <- counter + 1
  }
  
  
}


sir_mat <- matrix(sir_df)
heatmap(sir_mat, xlab = Transmission Rate β, ylab = Recovery Rate,γ)

####################################
heatmap <- function(dff){
  ggplot(data = dfff, aes(x= , y= , fill = max_infected< )) + 
    geom_tile() + xlab("Beta" + ylab("Gamma") + labs(fill = "Max infected") + scale_fill_gradient2("aquamarine4"))

}
heatmap(dfff)
