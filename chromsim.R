# function: isocratic
#   simulates chromatographic separation of mixture using an 
#     isocratic elution
#   K: vector of partition coefficients; default is four with first
#       value for a non-retained solute
#   conc: vector of solute concentrations
#   length: length of column (arbitrary units but program treats as mm)
#   colview: determines whether to return data showing separation on
#     the column as a function of time
#   plates: number of equilibration zones (theoretical plates)
#   max.tr: maximum retention time (equilibration cycles) for the 
#             most strongly retained solute
#   max.sigma: maximum on-column dispersion of the most strong retained 
#                 solute as standard deviation
#   cycles: the amount of time (equilibration cycles) needed to fully
#             elute the most strong retained solute
#   part_coeff: matrix of partition coefficients; for isocratic elution 
#             could use K values alone, but set up this way to parallel
#             code for a gradient elution; dimensions are 
#             [plates, number of solutes]
#   fsp: matrix of fraction of solutes in stationary phase; dimensions 
#         are [plates, number of solutes]
#   fmp: matrix of fraction of solutes in mobile phase; dimensions 
#         are [plates, number of solutes]
#   sp: matrix giving concentration of solutes in stationary phase; 
#         dimensions are [plates, solutes]
#   mp: matrix giving concentration of solutes in mobile phase; 
#         dimensions are [plates, solutes]
#   column: array containing total concentration of solutes on column 
#             for each solute, plate, and equilibration cycle; 
#             dimensions are [plates, solutes, cycles]
#   detect: matrix containing concentration of solutes in the mobile
#             at the detector; dimensions are [cycles, solutes]
#   total: matrix containing total concentration of solutes on column;
#           dimensions are [plates, solutes]
#   detect.all: vector of length cycles containing combined 
#                 concentration of all solutes at detector
#   column.all: matrix with dimensions [plates, cycles] containing
#                 combined concentration of all solutes on colum

isocratic = function(K = c(0, 1, 3, 5), conc = c(1, 100, 100, 100),
                   length = 100, colview = TRUE) {
  
  # initialize the system given the function's inputs
  plates = length + 1
  max.tr = plates * (1 + max(K))
  max.sigma = max.tr/(plates)^0.5
  cycles  = round(max.tr + 4 * max.sigma)
  part_coeff = matrix(K, nrow = plates, ncol = length(K), byrow = TRUE)
  fsp = part_coeff/(part_coeff + 1)
  fmp = 1/(part_coeff + 1)
  # fsp = matrix(K/(K+1), nrow = plates, ncol = length(K), byrow = TRUE)
  # fmp = matrix(1/(K+1), nrow = plates, ncol = length(K), byrow = TRUE)
  sp = matrix(0, nrow = plates, ncol = length(K))
  mp = matrix(0, nrow = plates, ncol = length(K))
  if (colview == TRUE) {
    column = array(0, dim = c(plates, length(K), cycles))
  }
  mp[1, ] = conc
  detect = matrix(0, nrow = cycles, ncol = length(K))
  total = matrix(0, nrow = plates, ncol = length(K))
  
  # each cycle of loop is equilibration of solutes and elution of mp
  for (j in 1:cycles) {
    total = sp + mp
    sp = total*fsp
    mp = total*fmp
    if (colview == TRUE) {
      column[ , , j] = total
    }
    detect[j, ] = mp[plates, ]
    mp = mp[-plates, ]
    mp = rbind(rep(0, length(K)), mp)
  }
  
  # finish by summing across solutes
  detect.all = rowSums(detect)
  if (colview == TRUE) {
    column.all = apply(column, c(1, 3), sum)
  }
  
  # list of items to return
  if (colview == TRUE) {
    output = list("sp" = sp, "mp" = mp, "detect" = detect, "K" = K, 
                "conc" = conc, "length" = length, "fsp" = fsp,
                "fmp" = fmp, "plates" = plates, "cycles" = cycles,
                "detector" = detect.all, "column" = column, 
                "column.all" = column.all, "partition" = part_coeff)
  } else {
    output = list("sp" = sp, "mp" = mp, "detect" = detect, "K" = K, 
                  "conc" = conc, "length" = length, "fsp" = fsp,
                  "fmp" = fmp, "plates" = plates, "cycles" = cycles,
                  "detector" = detect.all, "partition" = part_coeff)
  }
  invisible(output)
}

# function: gradient
# calculates analyte's retention time for a linear or a step gradient;
# linear gradient allows for an initial hold time, a final hold time, 
# and a linear ramp between the two; the step gradient has an initial 
# hold time, a step that is held until a final hold time, and a final step
# k.low: analyte's retention factor for initial mobile phase composition
# k.mid: analyte's retention factor for middle of step gradient
# k.high: analyte's retention factor for final mobile phase composition
# grad.start: time when gradient begins
# grad.end: time when gradient ends
# max_cycles: limit on iterations; no need to change
# t.m: time to elute non-retained solutes
# linear: logical; TRUE is linear; FALSE is step
# k: vector for storing analyte's retention factors

gradient = function(k.low = 1.4105, k.mid = 0.6402, k.high = 0.2906,
                    grad.start = 100, grad.end = 270, 
                    max.cycles = 10000, t.m = 20, linear = TRUE) {
  check = 0
  k = rep(0, max.cycles)
  k[1:(grad.start - 1)] = k.low
  k[(grad.end + 1):max.cycles] = k.high
  if (linear == TRUE) {
  for (i in grad.start:grad.end) {
    k[i] = k[i - 1] + (k.high - k.low)/(grad.end - grad.start + 1)
  }
  } else {
    k[grad.start:grad.end] = k.mid
  }
  for (j in 1:max.cycles) {
    check = check + (t.m * k[j])^-1
    if (check > 1) {
      t.r = j + t.m
      output = list("k" = k, "cycles" = max.cycles, 
                    "grad.times" = c(grad.start, grad.end), 
                    "k.limits" = c(k.low, k.mid, k.high), "tm" = t.m,
                    "tr" = t.r)
      return(invisible(output))
    }
  }
  output1 = "failed"
}

animate_detector = function(filename, speed = 10) {
  for (i in seq(1, filename[["cycles"]], by = speed)) {
    plot(x = seq(1:i), 
         y = filename[["detector"]][1:i],
         xlim = c(1, filename[["cycles"]]),
         ylim = c(0, max(filename[["detector"]])),
         type = "l", lwd = 2, col = "blue", 
         xlab = "time", ylab = "signal (a.u.)", 
         main = "detector view")
    Sys.sleep(0.1)
  }
}

animate_column = function(filename, speed = 10) {
  for (i in seq(1, filename[["cycles"]], by = speed)) {
    plot(x = seq(1:filename[["plates"]]),
         y = filename[["column.all"]][ , i],
         type = "l", lwd = 3, col = "blue",
         ylim = c(0, 0.05 * max(filename[["column.all"]])),
         xlab = "distance", ylab = "concentration",
         main = "column view")
    Sys.sleep(0.1)
  }
}