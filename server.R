library(shiny)

shinyServer(function(input, output) {
  
  # code for investigation 1
  
  output$plot_1a = renderPlot({
    plot(x = seq(0, out_1$cycles), y = c(0, out_1$detector),
         xlim = c(0, out_1$cycles), ylim = c(0, 3), 
         type = "l", lwd = 3, col = "blue",
         xlab = "time (seconds)", ylab = "signal (a.u.)")
  })
  
  output$text_1a = renderText({
    brush = input$brush_1a
    if (!is.null(brush)) {
      xlow = round(brush$xmin)
      xhigh = round(brush$xmax)
      time = which.max(round(
        out_1$detector[xlow:xhigh], digits = 4)) + xlow - 1
      height = round(out_1$detector[time], digits = 2)
      hh = height/2
      hh_low = which.min(abs(out_1$detector[xlow:time] - hh)) + xlow
      hh_high = which.min(abs(out_1$detector[time:xhigh] - hh)) + time
      if (time == 101) {
        width = "NA"
        time = 100
      } else {width = round((hh_high - hh_low) * 1.6986, digits = 2)
      }
      area = 0
      for (i in xlow:xhigh){
        area = area + out_1$detector[i]
      }
      area = round(area, digits = 1)
      paste0("retention time: ", time, " seconds", "\n", 
             "peak height: ", height, " a.u.", "\n", 
             "peak width: ", width, " seconds", "\n", 
             "peak area: ", area, " a.u. * seconds")
    } else {
      paste0("retention time: NA seconds", "\n", 
             "peak height: NA a.u.", "\n", 
             "peak width: NA seconds", "\n", 
             "peak area: NA a.u. * seconds")
    }
  })
  
  # code for investigation 2
  
  output$plot_2a = renderPlot({
    if (input$radio_2a == "all analytes") {
      plot(x = seq(0, out_1$cycles), y = c(0, out_1$detector),
           xlim = c(0, out_1$cycles), ylim = c(0, 3), 
           type = "l", lwd = 3, col = "blue",
           xlab = "time (seconds)", ylab = "signal (a.u.)", 
           main = "Chromatogram as Viewed at the Detector")
      abline(v = input$slider_2a, lwd = 2, col = "red")
    }
    if (input$radio_2a == "analyte A") {
      plot(x = seq(0, out_1$cycles), y = c(0, out_1$detect[ , 2]),
           xlim = c(0, out_1$cycles), ylim = c(0, 3), 
           type = "l", lwd = 3, col = "blue",
           xlab = "time (seconds)", ylab = "signal (a.u.)", 
           main = "Chromatogram as Viewed at the Detector")
      abline(v = input$slider_2a, lwd = 2, col = "red")
    }
    if (input$radio_2a == "analyte B") {
      plot(x = seq(0, out_1$cycles), y = c(0, out_1$detect[ , 3]),
           xlim = c(0, out_1$cycles), ylim = c(0, 3), 
           type = "l", lwd = 3, col = "blue",
           xlab = "time (seconds)", ylab = "signal (a.u.)", 
           main = "Chromatogram as Viewed at the Detector")
      abline(v = input$slider_2a, lwd = 2, col = "red")
    }
    if (input$radio_2a == "analyte C") {
      plot(x = seq(0, out_1$cycles), y = c(0, out_1$detect[ , 4]),
           xlim = c(0, out_1$cycles), ylim = c(0, 3), 
           type = "l", lwd = 3, col = "blue",
           xlab = "time (seconds)", ylab = "signal (a.u.)", 
           main = "Chromatogram as Viewed at the Detector")
      abline(v = input$slider_2a, lwd = 2, col = "red")
    }
  })
  
  output$plot_2b = renderPlot({
    if (input$radio_2b == "no") {
      if (input$radio_2a == "all analytes") {
        plot(x = seq(0, out_1$length), 
             y = out_1$column.all[ , input$slider_2a + 1], 
             ylim = c(0, 20), type = "l", lwd = 3, col = "blue",
             xlab = "distance (mm)", ylab = "[solute] (a.u.)",
             main = paste0("Separation as Viewed on the Column at t = ", 
                           input$slider_2a, " seconds"))
        abline(v = input$slider_2b, lwd = 2, col = "red")
      }
      if (input$radio_2a == "analyte A") {
        plot(x = seq(0, out_1$length), 
             y = out_1$column[ , 2, input$slider_2a + 1], 
             ylim = c(0, 20), type = "l", lwd = 3, col = "blue",
             xlab = "distance (mm)", ylab = "[solute] (a.u.)",
             main = paste0("Separation as Viewed on the Column at t = ", 
                           input$slider_2a, " seconds"))
        abline(v = input$slider_2b, lwd = 2, col = "red")
      }
      if (input$radio_2a == "analyte B") {
        plot(x = seq(0, out_1$length), 
             y = out_1$column[ , 3, input$slider_2a + 1], 
             ylim = c(0, 20), type = "l", lwd = 3, col = "blue",
             xlab = "distance (mm)", ylab = "[solute] (a.u.)",
             main = paste0("Separation as Viewed on the Column at t = ", 
                           input$slider_2a, " seconds"))
        abline(v = input$slider_2b, lwd = 2, col = "red")
      }
      if (input$radio_2a == "analyte C") {
        plot(x = seq(0, out_1$length), 
             y = out_1$column[ , 4, input$slider_2a + 1], 
             ylim = c(0, 20), type = "l", lwd = 3, col = "blue",
             xlab = "distance (mm)", ylab = "[solute] (a.u.)",
             main = paste0("Separation as Viewed on the Column at t = ", 
                           input$slider_2a, " seconds"))
        abline(v = input$slider_2b, lwd = 2, col = "red")
      }
    } else {
      if (input$radio_2a == "all analytes") {
        
        mobphase = out_1$column[ , 2, input$slider_2a + 1] * out_1$fmp[ , 2] + 
          out_1$column[ , 3, input$slider_2a + 1] * out_1$fmp[ , 3] + 
          out_1$column[ , 4, input$slider_2a + 1] * out_1$fmp[ , 4]
        statphase = out_1$column[ , 2, input$slider_2a + 1] * out_1$fsp[ , 2] + 
          out_1$column[ , 3, input$slider_2a + 1] * out_1$fsp[ , 3] + 
          out_1$column[ , 4, input$slider_2a + 1] * out_1$fsp[ , 4]
        plot(x = seq(0, out_1$length), 
             y = mobphase, 
             ylim = c(-10, 10), type = "l", lwd = 3, col = "blue",
             xlab = "distance (mm)", ylab = "[solute] (a.u.)",
             main = paste0(
               "Separation as Viewed on the Column after 150 seconds"), 
             yaxt = "n")
        abline(h = 0, col = "red", lwd = 2)
        legend(x = "topright", legend = "mobile phase", bty = "n")
        legend(x = "bottomright", legend = "stationary phase", bty = "n")
        lines(x = seq(0, out_1$length), 
              y = -statphase,
              lwd = 2, lty = 2, col = "blue")
      }
      if (input$radio_2a == "analyte A") {
        plot(x = seq(0, out_1$length), 
             y = out_1$column[ , 2, input$slider_2a + 1] * out_1$fmp[ , 2], 
             ylim = c(-10, 10), type = "l", lwd = 3, col = "blue",
             xlab = "distance (mm)", ylab = "[solute] (a.u.)",
             main = paste0("Separation as Viewed on the Column at t = ", 
                           input$slider_2a, " seconds"), yaxt = "n")
        abline(h = 0, col = "red", lwd = 2)
        legend(x = "topright", legend = "mobile phase", bty = "n")
        legend(x = "bottomright", legend = "stationary phase", bty = "n")
        lines(x = seq(0, out_1$length), 
              y = -out_1$column[ , 2, input$slider_2a + 1] * out_1$fsp[ , 2],
              lwd = 2, lty = 2, col = "blue")
      }
      if (input$radio_2a == "analyte B") {
        plot(x = seq(0, out_1$length), 
             y = out_1$column[ , 3, input$slider_2a + 1] * out_1$fmp[ , 3], 
             ylim = c(-10, 10), type = "l", lwd = 3, col = "blue",
             xlab = "distance (mm)", ylab = "[solute] (a.u.)",
             main = paste0("Separation as Viewed on the Column at t = ", 
                           input$slider_2a, " seconds"), yaxt = "n")
        legend(x = "topright", legend = "mobile phase", bty = "n")
        abline(h = 0, col = "red", lwd = 2)
        legend(x = "bottomright", legend = "stationary phase", bty = "n")
        lines(x = seq(0, out_1$length), 
              y = -out_1$column[ , 3, input$slider_2a + 1] * out_1$fsp[ , 3],
              lwd = 2, lty = 2, col = "blue")
      }
      if (input$radio_2a == "analyte C") {
        plot(x = seq(0, out_1$length), 
             y = out_1$column[ , 4, input$slider_2a + 1] * out_1$fmp[ , 4], 
             ylim = c(-10, 10), type = "l", lwd = 3, col = "blue",
             xlab = "distance (mm)", ylab = "[solute] (a.u.)",
             main = paste0("Separation as Viewed on the Column at t = ", 
                           input$slider_2a, " seconds"), yaxt = "n")
        abline(h = 0, col = "red", lwd = 2)
        legend(x = "topright", legend = "mobile phase", bty = "n")
        legend(x = "bottomright", legend = "stationary phase", bty = "n")
        lines(x = seq(0, out_1$length), 
              y = -out_1$column[ , 4, input$slider_2a + 1] * out_1$fsp[ , 4],
              lwd = 2, lty = 2, col = "blue")
      }
    }
  })
  
  # code for investigation 3
  
  output$plot_3a = renderPlot({
    mobphase = out_1$column[ , 2, 151] * out_1$fmp[ , 2] + 
      out_1$column[ , 3, 151] * out_1$fmp[ , 3] + 
      out_1$column[ , 4, 151] * out_1$fmp[ , 4]
    statphase = out_1$column[ , 2, 151] * out_1$fsp[ , 2] + 
      out_1$column[ , 3, 151] * out_1$fsp[ , 3] + 
      out_1$column[ , 4, 151] * out_1$fsp[ , 4]
    plot(x = seq(0, out_1$length), 
         y = mobphase, 
         ylim = c(-10, 10), type = "l", lwd = 3, col = "blue",
         xlab = "distance (mm)", ylab = "[solute] (a.u.)",
         main = paste0(
           "Separation as Viewed on the Column after 150 seconds"), 
         yaxt = "n")
    legend(x = "topright", legend = "mobile phase", bty = "n")
    legend(x = "bottomright", legend = "stationary phase", bty = "n")
    lines(x = seq(0, out_1$length), 
          y = -statphase,
          lwd = 2, lty = 2, col = "blue")
    abline(v = input$slider_3a, lwd = 2, col = "red")
  })
  
  solute_conc = reactive({
    if (input$radio_3a == "A") {
      paste0("[solute] in mobile phase = ",
             round(out_1$column[input$slider_3a, 2, 151] * 
                     out_1$fmp[input$slider_3a , 2],
                   digits = 3),
             " and [solute] in stationary phase = ",
             round(out_1$column[input$slider_3a, 2, 151] * 
                     out_1$fsp[input$slider_3a, 2],
                   digits = 3))
    } else if (input$radio_3a == "B"){
      paste0("[solute] in mobile phase = ",
             round(out_1$column[input$slider_3a, 3, 151] * 
                     out_1$fmp[input$slider_3a, 3],
                   digits = 3),
             " and [solute] in stationary phase = ",
             round(out_1$column[input$slider_3a, 3, 151] * 
                     out_1$fsp[input$slider_3a, 3],
                   digits = 3))
    } else if (input$radio_3a == "C"){
      paste0("[analyte] in mobile phase = ",
             round(out_1$column[input$slider_3a, 4, 151] * 
                     out_1$fmp[input$slider_3a, 4],
                   digits = 3),
             " and [analyte] in stationary phase = ",
             round(out_1$column[input$slider_3a, 4, 151] * 
                     out_1$fsp[input$slider_3a, 4],
                   digits = 3))
    } else {paste0("")}
  })
  
  output$text_3a = renderText({
    solute_conc()
  })
  
  # code for investigation 4
  
  output$plot_4a = renderPlot({
    plot(x = seq(0, out_1$cycles), y = c(0, out_1$detector),
         xlim = c(0, out_1$cycles), ylim = c(0, 4), 
         type = "l", lwd = 3, col = "blue",
         xlab = "time (seconds)", ylab = "signal (a.u.)", 
         main = "Original Simulation Using X Theoretical Plates")
    brush = input$brush_4a
  })
  
  output$plot_4b = renderPlot({
    plot(x = 0.5*seq(0,out_2$cycles), y = 2 * c(0, out_2$detector), 
         xlim = c(0, out_1$cycles), ylim = c(0, 4), 
         type = "l", lwd = 3, col = "blue",
         xlab = "time (seconds)", ylab = "signal (a.u.)",
         main = "Simulation Using 2X Theoretical Plates")
    brush = input$brush_4b
  })
  
  output$text_4a = renderText({
    brush = input$brush_4a
    if (!is.null(brush)) {
      xlow = round(brush$xmin)
      xhigh = round(brush$xmax)
      time = which.max(round(
        out_1$detector[xlow:xhigh], digits = 4)) + xlow - 1
      height = round(out_1$detector[time], digits = 2)
      hh = height/2
      hh_low = which.min(abs(out_1$detector[xlow:time] - hh)) + xlow
      hh_high = which.min(abs(out_1$detector[time:xhigh] - hh)) + time
      if (time == 101) {
        width = "NA"
        time = 100
      } else {width = round((hh_high - hh_low) * 1.6986, digits = 2)
      }
      area = 0
      for (i in xlow:xhigh){
        area = area + out_1$detector[i]
      }
      area = round(area, digits = 1)
      paste0("retention time: ", time, " seconds", "\t", "\t",
             "peak height: ", height, " a.u.", "\n", 
             "peak width: ", width, " seconds", "\t", "\t",
             "peak area: ", area, " a.u. * seconds")
    } else {
      paste0("retention time: NA seconds", "\t", "\t",
             "peak height: NA a.u.", "\n", 
             "peak width: NA seconds", "\t", "\t","\t",
             "peak area: NA a.u. * seconds")
    }
  })
  
  output$text_4b = renderText({
    brush = input$brush_4b
    if (!is.null(brush)) {
      xlow = 2*round(brush$xmin)
      xhigh = 2*round(brush$xmax)
      time = which.max(round(
        out_2$detector[xlow:xhigh], digits = 4)) + xlow - 1
      height = round(out_2$detector[time], digits = 2)
      hh = height/2
      hh_low = which.min(abs(out_2$detector[xlow:time] - hh)) + xlow
      hh_high = which.min(abs(out_2$detector[time:xhigh] - hh)) + time
      if (time == 101) {
        width = "NA"
        time = 100
      } else {width = round((hh_high - hh_low) * 1.6986, digits = 2)
      }
      area = 0
      for (i in xlow:xhigh){
        area = area + out_2$detector[i]
      }
      area = round(area, digits = 1)
      paste0("retention time: ", 0.5 * time, " seconds", "\t", "\t",
             "peak height: ", 2 * height, " a.u.", "\n", 
             "peak width: ", 0.5 * width, " seconds", "\t", "\t",
             "peak area: ", area, " a.u. * seconds")
    } else {
      paste0("retention time: NA seconds", "\t", "\t",
             "peak height: NA a.u.", "\n", 
             "peak width: NA seconds", "\t", "\t","\t",
             "peak area: NA a.u. * seconds")
    }
  })
  
  # code for investigation 5
  
  output$plot_5a = renderPlot({
    if (input$radio_5a == "1:2") {
      ac = 1
      bc = 2
    } else if (input$radio_5a == "1:4") {
      ac = 1
      bc = 4
    } else if (input$radio_5a == "2:1") {
      ac = 2
      bc = 1
    } else if (input$radio_5a == "4:1") {
      ac = 4
      bc = 1
    } else {
      ac = 1
      bc = 1
    }
    x = seq(input$slider_5a[1] - 2, input$slider_5a[2] + 2, 0.01)
    ya = ac * dnorm(x, mean = input$slider_5a[1], 
                    sd = input$slider_5b[1]/4)
    yb = bc * dnorm(x, mean = input$slider_5a[2], 
                    sd = input$slider_5b[2]/4)
    plot(x, ya + yb, type = "l", lwd = 3, col = "blue", 
         xlab = "retention time (min)", ylab = "signal (a.u.)")
    lines(x, ya, lty = 3, lwd = 3, col = "gold")
    lines(x, yb, lty = 3, lwd = 3, col = "green")
    legend(x = "topright", legend = c("A", "B"), bty = "n", 
           fill = c("gold", "green"), inset = c(0.05, 0.01))
  })
  
  resolution_5 = reactive({
    deltatr = input$slider_5a[2] - input$slider_5a[1]
    sumwidth = input$slider_5b[2] + input$slider_5b[1]
    r = deltatr/(0.5 * sumwidth)
    paste0("resolution between peaks is ", round(r, digits = 2))
  })
  
  output$text_5a = renderText({
    resolution_5()
  })
  
  # code for investigation 6
  
  output$plot_6a = renderPlot({
    if (input$radio_6a == "no") { 
      tm = 1
      trb = input$slider_6a * tm + tm
      tra = (input$slider_6a/input$slider_6b) * tm + tm
      x = seq(0.8 * tra, 1.2 * trb, 0.01)
      ya = 100 * dnorm(x, mean = tra, sd = tra/(input$slider_6c)^0.5)
      yb = 100 * dnorm(x, mean = trb, sd = trb/(input$slider_6c)^0.5)
      plot(x, ya + yb, type = "l", lwd = 3, col = "blue",
           xlab = "retention time (min)", ylab = "signal (a.u.)")
      lines(x, ya, lty = 3, lwd = 3, col = "gold")
      lines(x, yb, lty = 3, lwd = 3, col = "green")
      legend(x = "topright", legend = c("A", "B"), bty = "n", 
             fill = c("gold", "green"), inset = c(0.05, 0.01))
    } else if (input$radio_6a == "\\({k}_{b}\\)") {
      kb = seq(1, 40, 0.01)
      r = (0.25 * (input$slider_6c)^0.5) * 
        ((input$slider_6b - 1)/input$slider_6b) * 
        (kb/(kb + 1))
      plot(kb, r, type = "l", lwd = 3, col = "blue", 
           xlab = "retention factor for analyte B", 
           ylab = "resolution")
    } else if (input$radio_6a == "\\(\\alpha\\)") {
      alpha = seq(1, 2, 0.001)
      r = (0.25 * (input$slider_6c)^0.5) * 
        ((alpha - 1)/alpha) * 
        (input$slider_6a/(input$slider_6a + 1)) 
      plot(alpha, r, type = "l", lwd = 3, col = "blue", 
           xlab = "alpha", ylab = "resolutions")
    } else {
      n = seq(1000, 5000, 5)
      r = (0.25 * (n)^0.5) * 
        ((input$slider_6b - 1)/input$slider_6b) * 
        (input$slider_6a/(input$slider_6a + 1)) 
      plot(n, r, type = "l", lwd = 3, col = "blue", 
           xlab = "number of theoretical plates", ylab = "resolution")
    }
  })
  
  resolution_6 = reactive({
    tm = 1
    trb = input$slider_6a * tm + tm
    tra = (input$slider_6a/input$slider_6b) * tm + tm
    wb = 4*trb/(input$slider_6c)^0.5
    wa = 4*tra/(input$slider_6c)^0.5
    r = 2 * (trb - tra)/(wa + wb)
    # r = (0.25 * (input$slider_6c)^0.5) * 
    #   ((input$slider_6b - 1)/input$slider_6b) * 
    #   (input$slider_6a/(input$slider_6a + 1)) 
    paste0("resolution between peaks is ", round(r, digits = 2))
  })
  
  output$text_6a = renderText({
    resolution_6()
  })
  
  # code for investigation 7
  
  output$plot_7a = renderPlot({
    flowrate = seq(1, 120, 1)
    hetp = input$slider_7a + (input$slider_7b/flowrate) + 
      (input$slider_7c * flowrate)
    plot(flowrate, hetp, type = "l", lwd = 3, col = "blue", ylim = c(0, 10),
         xlab = "flow rate (mL/min)", 
         ylab = "height equivalent theoretical plate (mm)", 
         main = "data adapted from H. W. Moody, J. Chem. Educ. 1982, 59, 290-291.")
    points(flow.exp, hetp.exp, pch = 19, col = "blue")
  })
  
  error = reactive({
    model = input$slider_7a + (input$slider_7b/flow.exp) + 
      (input$slider_7c * flow.exp)
    err = round(sum((model - hetp.exp)^2), digits = 2)
    paste0("sum of squares of residual errors = ", err)
  })
  
  output$text_7a = renderText({
    error()
  })
  
  # code for investigation 8
  
  output$plot_8a = renderPlot({
    x.m = input$slider_8a
    x.a = input$slider_8b
    x.t = 1 - x.m - x.a
    if (x.m + x.a > 1) {
      plot(NULL, xlim = c(0, 1), ylim = c(0, 1), bty = "n", 
           axes = FALSE, xlab = "", ylab = "")
      legend(x = 0.1, y = 0.5, legend = "volume fraction exceeds 1", 
             bty = "n", cex = 2)
    } else {
      n = 300
      data = inv8data
      tr.ba = data[1,1]*x.m + data[2,1]*x.a + data[3,1]*x.t + 
        data[4,1]*x.m*x.a + data[5,1]*x.m*x.t + data[6,1]*x.a*x.t + 
        data[7,1]*x.m*x.a*x.t
      tr.ph = data[1,2]*x.m + data[2,2]*x.a + data[3,2]*x.t + 
        data[4,2]*x.m*x.a + data[5,2]*x.m*x.t + data[6,2]*x.a*x.t + 
        data[7,2]*x.m*x.a*x.t
      tr.pa = data[1,3]*x.m + data[2,3]*x.a + data[3,3]*x.t + 
        data[4,3]*x.m*x.a + data[5,3]*x.m*x.t + data[6,3]*x.a*x.t + 
        data[7,3]*x.m*x.a*x.t
      tr.tp = data[1,4]*x.m + data[2,4]*x.a + data[3,4]*x.t + 
        data[4,4]*x.m*x.a + data[5,4]*x.m*x.t + data[6,4]*x.a*x.t + 
        data[7,4]*x.m*x.a*x.t
      w.ba = 4*tr.ba/(n)^0.5
      w.ph = 4*tr.ph/(n)^0.5
      w.pa = 4*tr.pa/(n)^0.5
      w.tp = 4*tr.tp/(n)^0.5
      x = seq(0, 8, 0.01)
      y.mp = 0.05 * dnorm(x, mean = 0.5, sd = 0.001)
      y.ba = 125 * dnorm(x, mean = tr.ba, sd = w.ba/4)
      y.ph = 200 * dnorm(x, mean = tr.ph, sd = w.ph/4)
      y.pa = 50* dnorm(x, mean = tr.pa, sd = w.pa/4)
      y.tp = 10 * dnorm(x, mean = tr.tp, sd = w.tp/4)
      plot(x, y.mp + y.ba + y.ph + y.pa + y.tp, type = "l", lwd = 3, 
           ylim = c(0, 600), col = "blue", 
           xlab = "time (min)", ylab = "signal (a.u.)", 
           main = "data adapted from D.T. Harvey, J. Chem. Educ. 1991, 68, 162-168")
      legend(x = "topright", legend = "order of elution is TP, PA, PH, and BA", 
             bty = "n")
    }
  })
  
  resolution_8 = reactive({
    x.m = input$slider_8a
    x.a = input$slider_8b
    x.t = 1 - x.m - x.a
    n = 300
    data = inv8data
    tr.ba = data[1,1]*x.m + data[2,1]*x.a + data[3,1]*x.t + 
      data[4,1]*x.m*x.a + data[5,1]*x.m*x.t + data[6,1]*x.a*x.t + 
      data[7,1]*x.m*x.a*x.t
    tr.ph = data[1,2]*x.m + data[2,2]*x.a + data[3,2]*x.t + 
      data[4,2]*x.m*x.a + data[5,2]*x.m*x.t + data[6,2]*x.a*x.t + 
      data[7,2]*x.m*x.a*x.t
    tr.pa = data[1,3]*x.m + data[2,3]*x.a + data[3,3]*x.t + 
      data[4,3]*x.m*x.a + data[5,3]*x.m*x.t + data[6,3]*x.a*x.t + 
      data[7,3]*x.m*x.a*x.t
    tr.tp = data[1,4]*x.m + data[2,4]*x.a + data[3,4]*x.t + 
      data[4,4]*x.m*x.a + data[5,4]*x.m*x.t + data[6,4]*x.a*x.t + 
      data[7,4]*x.m*x.a*x.t
    w.ba = 4*tr.ba/(n)^0.5
    w.ph = 4*tr.ph/(n)^0.5
    w.pa = 4*tr.pa/(n)^0.5
    w.tp = 4*tr.tp/(n)^0.5
    a1 = round((tr.pa - 0.5)/(tr.tp - 0.5), digits = 2)
    a2 = round((tr.ph - 0.5)/(tr.pa - 0.5), digits = 2)
    a3 = round((tr.ba - 0.5)/(tr.pa - 0.5), digits = 2)
    r1 = round(2 * (tr.pa - tr.tp)/(w.pa + w.tp), digits = 2)
    r2 = round(2 * (tr.ph - tr.pa)/(w.ph + w.pa), digits = 2)
    r3 = round(2 * (tr.ba - tr.ph)/(w.ba + w.ph), digits = 2)
    paste0("TP & PA: resolution = ", r1, "\n", 
           "PA & PH: resolution = ", r2, "\n",
           "PH & BA: resolution = ", r3)
  })
  
  output$text_8b = renderText({
    resolution_8()
  })
  
  mobilephase = reactive({
    x.methanol = input$slider_8a
    x.acetonitrile = input$slider_8b
    x.thf = 1 - x.methanol - x.acetonitrile
    paste0("volume fraction of 20% v/v MeOH: ", 
           round(x.methanol, digits = 3), "\n",
           "volume fraction of 16% v/v ACN: ", 
           round(x.acetonitrile, digits = 3), "\n",
           "volume fraction of 10% v/v THF: ", 
           round(x.thf, digits = 3)
    )
  })
  
  output$text_8a = renderText({
    mobilephase()
  })
  
  # code for investigation 9
  
  # output$plot_9b = renderPlot({
  #   x = seq(0, 6000)
  #   ym = 0.001 * dnorm(x, mean = 200, sd = 0.001)
  #   y0 = 100 * dnorm(x, mean = k0[1]*200 + 200, sd = (k0[1]*200 + 200)/sqrt(2500))
  #   y1 = 100 * dnorm(x, mean = k1[1]*200 + 200, sd = (k1[1]*200 + 200)/sqrt(2500))
  #   y2 = 100 * dnorm(x, mean = k2[1]*200 + 200, sd = (k2[1]*200 + 200)/sqrt(2500))
  #   y3 = 100 * dnorm(x, mean = k3[1]*200 + 200, sd = (k3[1]*200 + 200)/sqrt(2500))
  #   y4 = 100 * dnorm(x, mean = k4[1]*200 + 200, sd = (k4[1]*200 + 200)/sqrt(2500))
  #   y5 = 100 * dnorm(x, mean = k5[1]*200 + 200, sd = (k5[1]*200 + 200)/sqrt(2500))
  #   y6 = 100 * dnorm(x, mean = k6[1]*200 + 200, sd = (k6[1]*200 + 200)/sqrt(2500))
  #   y7 = 100 * dnorm(x, mean = k7[1]*200 + 200, sd = (k7[1]*200 + 200)/sqrt(2500))
  #   y8 = 100 * dnorm(x, mean = k8[1]*200 + 200, sd = (k8[1]*200 + 200)/sqrt(2500))
  #   plot(x, y = ym + y0 + y1 + y2 + y3 + y4 + y5 + y6 + y7 + y8, 
  #        type = "l", lwd = 3, col = "blue", 
  #        xlab = "retention time (sec)", ylab = "signal (a.u.)")
  #   legend(x = "topright", legend = "isocratic elution using 70% ACN", 
  #          bty = "n")
  # })
  
  output$plot_9a = renderPlot({
    if (input$radio_9b == "100% ACN") {
      x = seq(0, 60, 0.01)
      ym = 0.01 * dnorm(x, mean = 20, sd = 0.001)
      y0 = 100 * dnorm(x, mean = k0[3]*20 + 20, sd = (k0[3]*20 + 20)/sqrt(2500))
      y1 = 100 * dnorm(x, mean = k0[3]*20 + 20, sd = (k1[3]*20 + 20)/sqrt(2500))
      y2 = 100 * dnorm(x, mean = k2[3]*20 + 20, sd = (k2[3]*20 + 20)/sqrt(2500))
      y3 = 100 * dnorm(x, mean = k3[3]*20 + 20, sd = (k3[3]*20 + 20)/sqrt(2500))
      y4 = 100 * dnorm(x, mean = k4[3]*20 + 20, sd = (k4[3]*20 + 20)/sqrt(2500))
      y5 = 100 * dnorm(x, mean = k5[3]*20 + 20, sd = (k5[3]*20 + 20)/sqrt(2500))
      y6 = 100 * dnorm(x, mean = k6[3]*20 + 20, sd = (k6[3]*20 + 20)/sqrt(2500))
      y7 = 100 * dnorm(x, mean = k7[3]*20 + 20, sd = (k7[3]*20 + 20)/sqrt(2500))
      y8 = 100 * dnorm(x, mean = k8[3]*20 + 20, sd = (k8[3]*20 + 20)/sqrt(2500))
      plot(x, y = ym + y0 + y1 + y2 + y3 + y4 + y5 + y6 + y7 + y8, 
           type = "l", lwd = 3, col = "blue", 
           xlab = "retention time (sec)", ylab = "signal (a.u.)", 
           main = "data adapted from W.R. Melander, et. al., J. Chromatogr. 1979, 185, 99-109")
      legend(x = "topright", legend = "isocratic elution using 100% ACN", 
             bty = "n")
    } else {
      x = seq(0, 600)
      ym = 0.01 * dnorm(x, mean = 20, sd = 0.001)
      y0 = 100 * dnorm(x, mean = k0[1]*20 + 20, sd = (k0[1]*20 + 20)/sqrt(2500))
      y1 = 100 * dnorm(x, mean = k1[1]*20 + 20, sd = (k1[1]*20 + 20)/sqrt(2500))
      y2 = 100 * dnorm(x, mean = k2[1]*20 + 20, sd = (k2[1]*20 + 20)/sqrt(2500))
      y3 = 100 * dnorm(x, mean = k3[1]*20 + 20, sd = (k3[1]*20 + 20)/sqrt(2500))
      y4 = 100 * dnorm(x, mean = k4[1]*20 + 20, sd = (k4[1]*20 + 20)/sqrt(2500))
      y5 = 100 * dnorm(x, mean = k5[1]*20 + 20, sd = (k5[1]*20 + 20)/sqrt(2500))
      y6 = 100 * dnorm(x, mean = k6[1]*20 + 20, sd = (k6[1]*20 + 20)/sqrt(2500))
      y7 = 100 * dnorm(x, mean = k7[1]*20 + 20, sd = (k7[1]*20 + 20)/sqrt(2500))
      y8 = 100 * dnorm(x, mean = k8[1]*20 + 20, sd = (k8[1]*20 + 20)/sqrt(2500))
      plot(x, y = ym + y0 + y1 + y2 + y3 + y4 + y5 + y6 + y7 + y8, 
           type = "l", lwd = 3, col = "blue", 
           xlab = "retention time (sec)", ylab = "signal (a.u.)", 
           main = "data adapted from W.R. Melander, et. al., J. Chromatogr. 1979, 185, 99-109")
      legend(x = "topright", legend = "isocratic elution using 70% ACN", 
             bty = "n")
    }
  })
  
  output$plot_9c = renderPlot({
    x = seq(0, 6000)
    ym = 0.01 * dnorm(x, mean = 20, sd = 0.001)
    if (input$radio_9a == "linear") {
      grad.type = TRUE
    } else {
      grad.type = FALSE
    }
    tr0 = gradient(k.low = k0[1], k.mid = k0[2], k.high = k0[3], 
                   grad.start = input$slider_9a[1], 
                   grad.end = input$slider_9a[2], 
                   max.cycles = 6000, t.m = 20, 
                   linear = grad.type)
    tr1 = gradient(k.low = k1[1], k.mid = k1[2], k.high = k1[3], 
                   grad.start = input$slider_9a[1], 
                   grad.end = input$slider_9a[2], 
                   max.cycles = 6000, t.m = 20, 
                   linear = grad.type)
    tr2 = gradient(k.low = k2[1], k.mid = k2[2], k.high = k2[3], 
                   grad.start = input$slider_9a[1], 
                   grad.end = input$slider_9a[2], 
                   max.cycles = 6000, t.m = 20, 
                   linear = grad.type)
    tr3 = gradient(k.low = k3[1], k.mid = k3[2], k.high = k3[3], 
                   grad.start = input$slider_9a[1], 
                   grad.end = input$slider_9a[2], 
                   max.cycles = 6000, t.m = 20,
                   linear = grad.type)
    tr4 = gradient(k.low = k4[1], k.mid = k4[2], k.high = k4[3], 
                   grad.start = input$slider_9a[1], 
                   grad.end = input$slider_9a[2], 
                   max.cycles = 6000, t.m = 20, 
                   linear = grad.type)
    tr5 = gradient(k.low = k5[1], k.mid = k5[2], k.high = k5[3], 
                   grad.start = input$slider_9a[1], 
                   grad.end = input$slider_9a[2], 
                   max.cycles = 6000, t.m = 20, 
                   linear = grad.type)
    tr6 = gradient(k.low = k6[1], k.mid = k6[2], k.high = k6[3], 
                   grad.start = input$slider_9a[1], 
                   grad.end = input$slider_9a[2], 
                   max.cycles = 6000, t.m = 20, 
                   linear = grad.type)
    tr7 = gradient(k.low = k7[1], k.mid = k7[2], k.high = k7[3], 
                   grad.start = input$slider_9a[1], 
                   grad.end = input$slider_9a[2], 
                   max.cycles = 6000, t.m = 20, 
                   linear = grad.type)
    tr8 = gradient(k.low = k8[1], k.mid = k8[2], k.high = k8[3], 
                   grad.start = input$slider_9a[1], 
                   grad.end = input$slider_9a[2], 
                   max.cycles = 6000, t.m = 20,
                   linear = grad.type)
    y0 = 100 * dnorm(x, mean = tr0$tr, sd = tr0$tr/sqrt(2500))
    y1 = 100 * dnorm(x, mean = tr1$tr, sd = tr1$tr/sqrt(2500))
    y2 = 100 * dnorm(x, mean = tr2$tr, sd = tr2$tr/sqrt(2500))
    y3 = 100 * dnorm(x, mean = tr3$tr, sd = tr3$tr/sqrt(2500))
    y4 = 100 * dnorm(x, mean = tr4$tr, sd = tr4$tr/sqrt(2500))
    y5 = 100 * dnorm(x, mean = tr5$tr, sd = tr5$tr/sqrt(2500))
    y6 = 100 * dnorm(x, mean = tr6$tr, sd = tr6$tr/sqrt(2500))
    y7 = 100 * dnorm(x, mean = tr7$tr, sd = tr7$tr/sqrt(2500))
    y8 = 100 * dnorm(x, mean = tr8$tr, sd = tr8$tr/sqrt(2500))
    y = ym + y0 + y1 + y2 + y3 + y4 + y5 + y6 + y7 + y8
    maxx = round(1.2 * tr8$tr)
    old.par = par(mar = c(5, 4, 4, 6) + 0.1)
    plot(x[1:maxx], y = y[1:maxx], type = "l", lwd = 3, col = "blue", 
         xlab = "retention time (sec)", ylab = "signal (a.u.)")
    legend(x = "topright", legend = "gradient elution", bty = "n")
    par(new = TRUE)
    if (input$radio_9a == "linear") {
      plot(x = c(0, input$slider_9a[1], input$slider_9a[2], maxx), 
           y = c(70, 70, 100, 100), type = "l", lwd = 2, col = "red",
           axes = FALSE, ylim = c(70, 100), xlab = "", ylab = "", 
           lty = 2)
    } else {
      if (input$slider_9a[2] > maxx) {
        plot(x = c(0, input$slider_9a[1], input$slider_9a[1], 
                   maxx, maxx, maxx),
             y = c(70, 70, 85, 85, 100, 100), type = "l", lwd = 2, 
             col = "red", axes = FALSE, ylim = c(70, 100), xlab = "", 
             ylab = "", lty = 2)
      } else {
        plot(x = c(0, input$slider_9a[1], input$slider_9a[1], 
                   input$slider_9a[2], input$slider_9a[2], maxx),
             y = c(70, 70, 85, 85, 100, 100), type = "l", lwd = 2, 
             col = "red", axes = FALSE, ylim = c(70, 100), xlab = "", 
             ylab = "", lty = 2)
      }
    }
    axis(4, ylim =c(70, 100))
    mtext("gradient", side = 4, line = 4)
    par(old.par)
  })
  
}) # close the server function