# scripts and data sets to read in and objects to create

# source file with script to simulate chromatograms
source(file = "chromsim.R")

# data sets created using isocratic function from chromsim.R
out_1 = isocratic(K = c(0, 1, 3, 9), conc = c(1, 100, 100, 100), 
                  length = 100)
out_2 = isocratic(K = c(0, 1, 3, 9), conc = c(0.5, 100, 100, 100), 
                  length = 200)
out_3 = isocratic(K = c(0, 1, 3, 5), conc = c(1, 100, 100, 100), 
                  length = 100)

# data sets for investigation seven
hetp.exp = c(9.59, 5.29, 3.63, 3.42, 3.46, 3.06, 3.25, 3.31, 3.50, 
             3.86, 4.24, 4.62, 4.67)
flow.exp = c(3.4, 7.1, 16.1, 20.0, 23.1, 34.4, 40.0, 44.7, 65.9, 78.9, 
             96.8, 115.4, 120.0)

# data set for investigation eight
load(file = "invest8.RData")

# retention factors for investigation nine; number is length of 
#   hydrocarbon chain on substituted benzenes; order is for 70% ACN, 
#   85% ACN, and 100% ACN
k0 = c(1.411, 0.6402, 0.2906)
k1 = c(1.9830, 0.8265, 0.3445)
k2 = c(2.690, 1.0183, 0.3855)
k3 = c(3.1857, 1.3107, 0.4502)
k4 = c(5.4676, 1.7047, 0.5315)
k5 = c(7.4511, 2.2435, 0.6755)
k6 = c(10.2522, 2.8985, 0.8194)
k7 = c(14.6311, 3.8354, 1.0054)
k8 = c(20.5151, 5.0578, 1.2469)



      
