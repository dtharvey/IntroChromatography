# Introduction to Chromatography

This learning module, in the form of a Shiny app, provides an introduction to chromatography with an emphasis on understanding basic chromatographic terms and measurements, and understanding the factors that affect the quality of a separation. The treatment is independent of the form of chromatography and, although data from GC and HPLC experiments are used to illustrate topics presented in some investigations, no emphasis is placed on particular chromatographic techniques. The module consists of the following nine investigations:

* Investigation 1: A First Look at a Chromatogram
* Investigation 2: A Closer Look at the Separation
* Investigation 3: Partition Coefficients and Retention Factors
* Investigation 4: Theoretical Plates
* Investigation 5: A First Look at Chromatographic Resolution
* Investigation 6: A Closer Look at Chromatographic Resolution
* Investigation 7: Improving Resolution Through Efficiency
* Investigation 8: Improving Resolution Through Selectivity
* Investigation 9: Improving Resolution Through Retention

In addition to the required ui.R and the server.R files, the Shiny app also uses a global.R file to provide access to neccesary scripts and data.

The script file chromsim.R contains four functions for simulating chromatograms: isocratic, gradident, animate_column, and animate_detector. The first two of these functions simulates an isocratic elution and the second of these functions calculates a solute's retention time for a gradient separation that uses either a single, linear gradient or a one or two step gradient. Although not used in this Shiny app, the last two functions take the output from the isocratic function and generate an animation of the separation as viewed along the column and at the detector.
