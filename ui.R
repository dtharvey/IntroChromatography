library(shiny)

shinyUI(fluidPage(
  withMathJax(),
  tabsetPanel(
    
    tabPanel("Home",
             fluidRow(
               column(
                 width = 10, 
                 offset = 1,
                 h1("Introduction to Chromatography", align = "center"),
                 br(),
                 HTML("<p>NEED SOME TEXT HERE. In this learning module we take a
                      closer look at chromatography using the following series 
                      of investigations:</p>"),
                 HTML("<ul> 
                      <li> 
                      <p>Investigation 1: A First Look at a 
                        Chromatogram</p>
                    </li> 
                    <li> 
                    <p>Investigation 2: A Closer Look at the Separation</p>
                    </li>
                    <li> 
                    <p>Investigation 3: The Partition Coefficient and 
                      the Retention Factor</p>
                    </li>
                    <li> 
                    <p>Investigation 4: Theoretical Plates</p>
                      </li>
                      <li> 
                      <p>Investigation 5: A First Look at Chromatographic 
                        Resolution</p>
                    <li>
                    <p>Investigation 6: A Closer Look at Chromatographic 
                        Resolution</p>
                      </li>
                      <li>
                      <p>Investigation 7: Improving Resolution Through 
                        Column Efficiency</p>
                    </li>
                      <li>
                      <p>Investigation 8: Improving Resolution Through 
                        Column Selectivity</p>
                    </li>
                      <li>
                      <p>Investigation 9: Improving Resolution Through 
                        Column Retention</p>
                    </li>
                    </ul>")
             )
          )
      ), # close Home tabPanel
    
    tabPanel("Investigation 1",
             column(
               width = 6,
               h4("A First Look at a Chromatogram"),
               p(
                 "The figure on the right shows the chromatogram for a 
                 mixture of three analytes. The column, which holds 
                 the stationary phase, is 100 mm in length and the 
                 mobile phase moves through the column with a linear 
                 velocity of 1 mm/sec. The separation's progress  
                 was simulated by successively calculating each analyte's 
                 distribution along the column in intervals of 1 sec."
               ),
               p(
                 "The space below the chromatogram displays four 
                 characteristic parameters of a chromatographic peak: 
                 its retention time, its height, its width at the 
                 baseline, and its area. To see these values for a 
                 peak, click and drag the cursor over the peak so that 
                 the whole peak is highlighted; it is okay to include 
                 portions of the baseline. Once the boundary box 
                 is set, you can click and drag inside the box to 
                 adjust its position, and click and drag along a box's 
                 edge to expand or contract its dimensions."
               ),
               h5("Questions"),
               p(
                 "1. For each peak in the chromatogram, report its 
                 retention time, \\({t}_{r}\\), its height, \\(H\\), 
                its width, \\(w\\), and its area, \\(A\\)."
               ),
               p(
                 "2. The sample, as noted above, contains three
                 analytes, but the chromatogram has four peaks. Which 
                 of the four peaks correspond to the three analytes and
                 which peak does not? Explain how you arrived at your
                 assignments. What do you think is the source of this 
                 extra peak and its significance?"
               ),
               p(
                 "3. The three analytes have different
                 retention times. Why should you reasonably expect 
                 that different analytes will have different retention 
                 times?"
               ),
               p(
                 "4. If the detector has an identical response to 
                 all three analytes, what can you deduce about their 
                 relative concentrations in the sample? Explain your 
                 reasoning."
               ),
               p(
                 "5. The peak for the last analyte to elute  
                 is shorter and broader than the peak for 
                 the first analyte to elute. Why should you reasonably 
                 expect later eluting analytes to have relatively 
                 shorter and relatively broader peaks?"
               )
             ),
             column(
               width = 6,
               plotOutput("plot_1a", brush = "brush_1a"),
               verbatimTextOutput("text_1a")
             )
             ), # close first TabPanel
    
    tabPanel("Investigation 2",
             column(
               width = 6,
               h4("A Closer Look at the Separation"),
               p(
                "The figures to the right show two views of the 
                separation from Investigation 1: as viewed at the 
                detector (top) and as viewed along the column (bottom) 
                at the time selected using the retention time slider."
               ),
               h5("Questions"),
               p(
                "1. Adjust the retention time slider to ~150 sec. 
                If the three analytes in the detector view are, from 
                left-to-right, A, B, and C, which peak in the column 
                view is analyte A? Explain the reason(s) for your 
                identification. Check your answer by using the radio 
                button to display analyte A." 
               ),
               p(
                "2. Select analyte A using the radio button and move 
                the retention time slider from 0 sec to 250 sec in 
                several steps of ~50 sec each. What happens to the 
                shape of the analyte's band in the column view as it 
                spends more time on the column. Why?" 
               ),
               p(
                "3. Select the radio button to show the mobile phase 
                and the stationary phase in the column view, which  
                changes the column view so that it shows an analyte's 
                concentration in the mobile phase as a solid line and 
                its concentration in the stationary phase as a dashed 
                line. All concentrations are positive relative to 
                a baseline concentration of 0 shown by the red line. 
                Examine the concentration profiles for each 
                analyte at a retention time of ~150 seconds. What do 
                the similarities in their concentration profiles 
                suggest about the process that controls an analyte's 
                movement between the mobile phase and the stationary 
                phase?"
               ),
               (
                "4. Examine the the mobile phase and the stationary 
                phase concentration profiles for all three analytes at 
                the same time and explain how the differences in  
                their concentration profiles are consistent with their 
                relative retention times."
               ),
               br(),
               br(),
               sliderInput("slider_2a", "retention time (sec)", min = 0,
                           max = out_1$cycles, step = 1, ticks = FALSE,
                           value = 0, width = "80%"),
               radioButtons("radio_2a", "display...",
                            c("all analytes", "analyte A", "analyte B",
                              "analyte C"), selected = "all analytes",
                            inline = TRUE),
               radioButtons("radio_2b", "show mobile phase and
                            stationary phase?", choices = c("no", "yes"),
                            selected = "no", inline = TRUE)
             ),
             column(
               width = 6,
               align = "center",
               plotOutput("plot_2a", height = "300px"),
               plotOutput("plot_2b", height = "300px")
             )
    ), # close second TabPanel
    
    tabPanel("Investigation 3",
      column(
        width = 6,
        h4("The Partition Constant and the Retention Factor"),
        p(
          "The figure to the right shows a column view of the separation 
          from the previous two investigations at a retention time of 150 
          seconds. For the analyte selected by the radio button, the 
          text box at the bottom right gives its concentration in the 
          stationary phase and the mobile phase at the position along
          the column specified by the slider."  
        ),
        p(
          "1. The movement of an analyte from the mobile phase to the 
          stationary phase is an equilibrium process. Write 
          a reaction for analyte A that shows this equilibrium. 
          What is its equilibrium constant expression and the value 
          of this equilibrium constant, which we call its partition 
          coefficient, \\(K\\)? Repeat for analyte B and for analyte C. 
          Do your results make sense given the retention times of the 
          analytes? Explain." 
        ),
        p(
          "2. Another way to think about this equilibrium is to 
          consider the fraction of analyte, by mass, in the mobile 
          phase  
          $${f}_{mp} = \\frac{{\\textrm{(mass A)}}_{mp}}
              {{\\textrm{(mass A)}}_{mp} + {\\textrm{(mass A)}}_{sp}}$$
          where \\(mp\\) indicates the mobile phase and \\(sp\\) 
          indicates the stationary phase. Beginning with this equation 
          and with the equation for \\(K\\), show that 
          \\({f}_{mp} = \\frac{1}{1+k}\\), where \\(k\\), which is 
          called the retention factor, is equal to 
          \\(K \\times \\frac{{V}_{sp}}{{V}_{mp}}\\)
          and where \\({V}_{sp}\\) and \\({V}_{mp}\\) are the volumes 
          of the stationary phase and of the mobile phase in the column. 
          Why is the retention factor a more useful term than the 
          partition coefficient?" 
        ),
        (
          "3. Another way to view \\({f}_{m}\\) for an analyte is as 
          the ratio of the time needed to elute a non-retained solute, 
          \\({t}_{m}\\), and the time needed to elute the analyte, 
          \\({t}_{r}\\). Using this relationship, show that 
          $$k = \\frac{{t}_{r} - {t}_{m}}{{t}_{m}}$$
          Returning to earlier investigations, as needed, report the 
          retention factor for each of the three analytes."
        )
      ),
      column(
        width = 6,
        align = "center",
        plotOutput("plot_3a"),
        sliderInput("slider_3a", "distance on column", min = 1, 
                    max = out_1$length, value = 0, ticks = FALSE, 
                    width = "80%"),
        radioButtons("radio_3a", "results for analyte...", 
                     choices = c("A", "B", "C"), selected = "A",
                     inline = TRUE),
        verbatimTextOutput("text_3a")
      )
    ), # close third TabPanel
    
    tabPanel("Investigation 4",
      column(
        width = 6,
        h4("Theoretical Plates"),
        p(
        "The chromatograms and column views in these investigations 
        were simulated by dividing the column into a series of discrete 
        units, which we call theoretical plates, and modeling the 
        equilibration of each analyte between the mobile phase and the 
        stationary phase. The figure below illustrates the process. 
        First, we introduce the analyte to the mobile phase in the 
        first plate, in this case with a concentration of 1. Second, 
        a portion of the analyte, in this case 70%, 
        extracts into the theoretical plate's stationary phase. Third, 
        and finally, the first theoretical plate's mobile phase moves 
        to the second theoretical plate and is replenished with a new 
        portion of fresh mobile phase. This cycle continues over each 
        theoretical plate until the last analyte elutes from the column."
               ),
        HTML('<center><img src="cce.png"></center>'),
               p(
                 "The chromatogram on the upper right is the simulation 
                 from Investigation 1; the chromatogram on the lower 
                 right is simulated under identical conditions 
                 except for one change: the column was divided into 
                 twice as many theoretical plates."
               ),
               h5("Questions"),
               p(
                 "1. How does an increase in the number of theoretical 
                 plates, \\(N\\), affect a chromatographic peak's characteristic 
                 values? You can measure these values by clicking and 
                 dragging the cursor over a peak so that the whole peak 
                 is highlighted."
               ),
               p(
                 "2. Increasing the number of theoretical plates is 
                 equivalent to decreasing the thickness (more commonly 
                 called the height) of a theoretical plate. For each 
                 of a chromatographic peak's characteristic values, 
                 explain why a decrease in the height of a theoretical 
                 plate has the observed effect."
               ),
               p(
                 "3. Although theoretical plates are useful  
                 for modeling a separation, a column does not actually 
                 contain discrete theoretical plates. With this in mind, 
                 suggest some physical processes that explain why an 
                 analyte's elution band becomes broader as it passes 
                 through a column."
               ),
               p(
                "4. From the perspective of an analyte, the number of 
                theoretical plates in a column, \\(N\\), is equal to 
                \\(16 {\\left( \\frac{{t}_{r}}{w} \\right)}^2 \\). 
                Calculate the number of theoretical plates for last 
                analyte to elute in both chromatograms and comment on 
                your results."
                )
             ),
             column(
               width = 6,
               plotOutput("plot_4a", brush = "brush_4a", 
                          width = "90%", height = "300px"),
               verbatimTextOutput("text_4a"),
               plotOutput("plot_4b", brush = "brush_4b", 
                          width = "90%", height = "300px"),
               verbatimTextOutput("text_4b")
             )
             ), # close fourth TabPanel
    
    tabPanel("Investigation 5",
             column(
               width = 6,
               h4("A First Look at Chromatographic Resolution"),
               p(
                "The figure to the right shows two overlapping 
                chromatographic peaks with retention times, peak 
                widths, and relative concentrations 
                given by the two sliders and the radio buttons. Also 
                shown is a quantitative measure of the resolution, 
                \\(R\\), between the two peaks."
               ),
               h5("Questions"),
               p(
                "1. Explore the effect of retention time on 
                resolution by first clicking on and dragging the blue 
                line that connects the slider's limits, which  
                maintains a fixed \\(\\Delta {t}_{r}\\), and then 
                increasing \\(\\Delta {t}_{r}\\) by changing the 
                retention times for the individual analytes. What do 
                your results suggest about the relationship between 
                resolution and retention time?"
               ),
               p(
                "2. Explore the effect of peak width on resolution by 
                first clicking and dragging the blue line that 
                connects then slider's limits, and then by adjusting 
                the individual peak widths while maintaining the same 
                total peak width. What do your results suggest about 
                the relationship between resolution and peak width?"
               ),
               p(
                "3. Explore the effect of the relative concentrations 
                of the two analytes on resolution while maintaining the 
                same set of retention times and peak widths. What do 
                your results suggest about the relationship between 
                resolution and relative concentrations?"
               ),
               p(
                "4. Based on your results for the previous three 
                questions, propose an equation that describes the 
                resolution between two peaks in terms of the retention 
                times, the peak widths, and the relative 
                concentrations of the two analytes."
               ),
               p(
                "5. Adjust the retention times, the peak widths, and 
                the relative concentrations of the two analytes until you 
                obtain a chromatogram in which there is no overlap 
                between the two peaks (which we call a baseline 
                separation). What is the minimum resolution for baseline 
                separation? Do you think that any combination of 
                retention times, peak widths, and relative 
                concentrations that yields this resolution will result 
                in baseline resolution. Why? Test your prediction."
               ),
               p(
                "6. Given your work here and in earlier investigations, 
                what are some ways you can improve resolution by 
                adjusting the retention times for one or both analytes?"
                ),
             p(
              "7. Given your work here and in earlier investigations, 
              what are some ways you can improve resolution by 
              adjusting the peak widths for one or both analytes?"
              )
             ),
             column(
               width = 6,
               align = "center",
               plotOutput("plot_5a"),
               sliderInput("slider_5a", 
                           "A <-- retention times (min) --> B", 
                           min = 7, max = 10, step = 0.01, 
                           value = c(8, 9), ticks = FALSE, 
                           width = "80%"),
               sliderInput("slider_5b", 
                           "A <-- widths at baseline (min) --> B", 
                           min = 0.1, max = 2, step = 0.01, 
                           value = c(1.0, 1.2), ticks = FALSE, 
                           width = "80%"),
               radioButtons("radio_5a", "relative concentrations: A:B", 
                            choice = c("1:1", "1:2", "1:4", "2:1", "4:1"), 
                            selected = "1:1", inline = TRUE),
               verbatimTextOutput("text_5a")
             )
      
    ), # close fifth TabPanel
    
    tabPanel("Investigation 6",
             column(
               width = 6,
               h4("A Closer Look at Chromatographic Resolution"),
               p(
                 "In Investigation 5 we learned that the resolution 
                 between two chromatographic peaks is equivalent to 
                 $$R = \\frac{2 \\left( {t}_{r,b} - 
                 {t}_{r,a} \\right)} {{w}_{a} + {w}_{b}}$$
                 where \\(a\\) is the earlier eluting peak and \\(b\\) 
                 is the later eluting peak. Another expression for 
                 resolution is
                 $$R \\approx \\left( \\frac{\\sqrt N}{4} \\right) 
                  \\left( \\frac{\\alpha - 1}{\\alpha} \\right)
                  \\left( \\frac{{k}_{b}}{{k}_{b} + 1} \\right)$$
                 where \\(\\alpha = \\frac{{k}_{b}}{{k}_{a}}\\) and 
                 where \\({k}_{b}\\) and \\({k}_{a}\\) are the retention 
                 factors for the two chromatographic peaks labeled such 
                 that \\(b\\) is always the later eluting peak."
               ),
               h5("Questions"),
               p(
                "1. The three terms in the resolution equation are, in 
                particular order, asssociated with the column's 
                general retention of analytes, the efficiency with 
                which the analyte moves within the mobile phase and 
                between the mobile phase and the stationary phase, and 
                the relative selectivity of the stationary phase and the 
                mobile phase for the analytes. Match these descriptive 
                phrases to the specific terms in the equation and 
                explain the reasons for your decisions."
               ),
               p(
                 "2. Beginning with the first equation for resolution, 
                 and using equations from earlier investigations, 
                 derive the second equation for resolution. You may 
                 assume that the peak widths, \\({w}_{a}\\) and 
                 \\({w}_{b}\\) are equal. Why is this a reasonable 
                 assumption?"
               ),
               p(
                "3. Given the second equation for resolution, predict 
                whether you can achieve an acceptable resolution for 
                this pair of analytes by adjusting just \\({k}_{b}\\). 
                Repeat for \\(\\alpha\\) and for \\(N\\). Explain your 
                reasoning and then check your predictions using the 
                sliders."
               ),
               p(
                "4. For each of \\({k}_{b}\\), \\(\\alpha\\), and 
                 \\(N\\), describe at least one way in which you might  
                adjust its value."
               ),
               p(
                "5. For each of \\({k}_{b}\\), \\(\\alpha\\), and 
                 \\(N\\), what practical problems might limit its 
                utility in improving resolution? As you consider this, 
                keep in mind that a sample likely has other constituents, 
                some of which elute earlier and some of which elute 
                later that this pair of analytes. You can explore the effect 
                of \\({k}_{b}\\), \\(\\alpha\\), and \\(N\\) on 
                resolution by examining the chromatogram or by using the 
                radio button to examine a plot of resolution as a 
                function of one of the variables." 
               )
             ),
             column(
               width = 6,
               align = "center",
               plotOutput("plot_6a", height = "300px"),
               sliderInput("slider_6a", "\\({k}_{b}\\)", min = 1, 
                           max = 40, step = 0.01, value = 3.00, 
                           ticks = FALSE, width = "80%"),
               sliderInput("slider_6b", "\\(\\alpha\\)", min = 1, 
                           max = 2, step = 0.01, value = 1.10, 
                           ticks = FALSE, width = "80%"),
               sliderInput("slider_6c", "\\(N\\)", min = 1000, 
                           max = 5000, step = 10, value = 1000,
                           ticks = FALSE, width = "80%"),
               radioButtons("radio_6a", "show plot of \\(R\\) vs...?", 
                            choices = c("no", "\\({k}_{b}\\)", 
                                        "\\(\\alpha\\)", "\\(N\\)"),
                            selected = "no", inline = TRUE),
               verbatimTextOutput("text_6a")
             )
             ), # close sixth TabPanel
    
    tabPanel("Investigation 7",
             column(
               width = 6,
               h4("Improving Resolution Through Column Efficiency"),
               p(
                "Our equation for resolution from the previous 
                investigation suggests that we can use three broad 
                strategies to optimize resolution: 
                improve efficiency by limiting the broadening of an 
                analyte's band as it passes through the column, improve 
                selectivity by increasing the relative difference in 
                the retention factors of the analytes, and improve retention 
                by keeping the analytes on the column for a sufficient 
                length of time. In this investigation, we consider ways
                to improve efficiency by increasing the number of 
                theoretical plates."
               ),
               h5("Questions"),
               p(
                "1. An easy way to increase the number of theoretical 
                plates is to increase the column's length, \\(L\\). 
                Why is this generally not a desirable way to improve 
                resolution?"
               ),
               p(
                "2. A more effective way to increase \\(N\\) is to 
                decrease the height, \\(H\\), of a theoretical plate. 
                As suggested by the data in the
                figure on the right, the height of a theoretical plate 
                is an interesting function of the mobile phase's flow 
                rate, u, that we can model using the van Deemter equation
                $$H = A + \\frac{B}{u} + Cu$$
                where A, B, and C are constants that describe, in no 
                particular order, the contribution to 
                peak width of aan analyte taking paths of different 
                length as it moves through the column, of the analyte's 
                diffusion in the mobile phase as it moves through the 
                column, and the kinetics 
                of the analytes diffusion between the mobile phase and  
                the stationary phase. Match A, B, and C to the 
                appropriate source and explain how you arrived at these 
                assignments."
               ),
               p(
                "3. Among the factors that influence A, B, and C are 
                the following: the analyte's diffusion coefficients in 
                the mobile phase, \\({D}_{m}\\), and the stationary 
                phase, \\({D}_{s}\\), the thickness of the stationary 
                phase, \\({d}_{f}\\), the diameter of the column, 
                \\({d}_{c}\\), and the diameter of the stationary 
                phase's solid support, \\({d}_{p}\\). For each of A, B, 
                and C, identify the parameter(s) that affect its value. 
                Explain your reasoning."
               ),
               p(
                "4. Starting with the van Deemter equation, show that 
                the smallest value for H is when 
                \\(u = \\sqrt {\\frac{B}{C}}\\) and that the value of 
                \\(H\\) at this flow rate is equal to 
                \\(A + 2\\sqrt{BC}\\)."
               ),
               p(
                "5. Adjust the sliders to fit the van Deemter equation 
                to the data. The sum of squares of the residual errors, 
                \\( \\sum { {\\left({H}_{expt} - {H}_{model} \\right)}^2  } \\),
                shows the total difference between the experimental 
                data, \\({H}_{expt}\\) and the values predicted by the 
                van Deemter equation, \\({H}_{model}\\). What is the 
                optimum flow rate and the height of a theoretical plate? 
                Given that the column used to collect the data was 5 m 
                in length, how many theoretical plates are there?"
               )
             ),
             column(
               width = 6,
               align = "center",
               plotOutput("plot_7a"),
               sliderInput("slider_7a", "A (mm)", min = 0, max = 10, 
                           step = 0.01, value = 1, ticks = FALSE,
                           width = "80%"),
               sliderInput("slider_7b", "B (mm•mL/min)", min = 0, max = 40, 
                           step = 0.1, value = 1, ticks = FALSE,
                           width = "80%"),
               sliderInput("slider_7c", "C (mm•min/mL)", min = 0, max = 0.2, 
                           step = 0.0001, value = 0.01, ticks = FALSE, 
                           width = "80%", sep = ""),
               verbatimTextOutput("text_7a")
             )
      
    ), # close seventh TabPanel
    
    tabPanel("Investigation 8",
             column(
               width = 6,
               h4("Improving Resolution Through Column Selectivity"),
               p(
                "A second way to improve resolution is to focus on 
                \\(\\alpha\\) and increase the relative difference 
                between the retention factors for the poorly resolved 
                analytes. Although a change in \\(\\alpha\\) inevitably 
                changes \\({k}_{b}\\), the interest here is not on 
                increasing the range of \\({k}_{b}\\) values. One way 
                to change \\(\\alpha\\) is to alter the 
                composition of the stationary phase or the composition 
                of the mobile phase."
                ),
                p(
                "The simulation on the right, for 
                example, shows the separation of a mixture of four weak 
                acids: terephthalic acid (TP), p-aminobenzoic acid (PA), 
                p-hydroxybenzoic acid (PH), and benzoic acid (BA). The 
                sliders allow you to adjust the composition of the 
                mobile phase by blending together three aqueous buffered 
                mobile phases that are 20% methanol (MeOH), 16% 
                acetonitrile (ACN), and 10% tetrahydrofuran (THF) by 
                volume. These three mobile phases were selected as they 
                providea nearly constant \\({k}_{b}\\) for the last 
                analyte to elute."
                ),
               h5("Questions"),
               p(
                "1. Why might we reasonably expect that a change in the 
                organic composition of the mobile phase will affect the 
                retention times of some or all of the analytes?" 
               ),
               p(
                "2. The mobile phase for the default chromatogram uses 
                just the mobile phase identified as MeOH (no ACN or THF). 
                Make note of each analyte's approximate retention time. 
                Adjust the slider for MeOH to 0 and make note of each 
                analyte's approximate retention time when the mobile 
                phase is just THF. Finally, adjust the slider for ACN 
                to 1 and make note of each analyte's approximate 
                retention time when the mobile phase is just ACN. How 
                sensitive are the different analytes to the composition 
                of the mobile phase?"
               ),
               p(
                "3. Based on your observations from Question 2, adjust 
                the composition of the mobile phase until the resolution 
                for each pair of peaks is greater than 1.5. What is the 
                composition of your mobile phase?"
                ),
               p(
                "4. Explore mobile phase compositions in the area around 
                your result from Question 3. How sensitive is the 
                resolution to a small change in the mobile phase's 
                composition? Why might this be of interest?"
               )
             ),
             column(
               width = 6,
               align = "center",
               plotOutput("plot_8a", height = "350px"),
               verbatimTextOutput("text_8b"),
               sliderInput("slider_8a", "volume fraction of 20% v/v MeOH", 
                           min = 0, max = 1, step = 0.001, value = 1, 
                           ticks = FALSE, width = "80%"),
               sliderInput("slider_8b", "volume fraction of 16% v/v ACN", 
                           min = 0, max = 1, step = 0.001, value = 0, 
                           ticks = FALSE, width = "80%"),
               verbatimTextOutput("text_8a")
             )
             
             ), # end eighth TabPanel
    
    tabPanel("Investigation 9",
             column(
               width = 6,
               h4("Improving Resolution Through Column Retention"),
               p(
                "Because a separation requires time, a third way to 
                improve the resolution between two analytes is to 
                increase the amount of time they spend on the column, 
                which appears as \\({k}_{b}\\) in the equation for 
                resolution. The chromatogram on the right, for example, 
                shows the poorly resolved separation of nine 
                alklybenzenes using 100% acetonitrile (ACN) as the 
                mobile phase. Changing the mobile phase to 70% ACN 
                allows for the separation of all analytes by 
                increasing each analyte's retention time."
               ),
               h5("Questions"),
               p(
                "1. The optimal range for an analyte's retention 
                factor, \\(k\\), is between 2 and 10. Explain why 
                these are desirable limits? You may wish to review 
                the effect of retention factor on resolution from 
                Investigation 6. "
               ),
               p(
                "2. For this separation, non-retained 
                solutes elute after 20 sec. What is the expected 
                retention time for an alkylbenzene that elutes with a 
                \\(k\\) of 2? What is the expected retention time for 
                an alkylbenzene that elutes with a \\(k\\) of 10? What 
                are the experimental values of \\(k\\) for the last 
                alkylbenzene to elute when using 100% ACN as the mobile 
                phase and when using 70% ACN as the mobile phase? These 
                two separations are an example of what is called the 
                general elution problem. What do you think this 
                phrase means?"
               ),
               p(
                "3. The separations of alkylbenzene using 70% ACN or 
                100% ACN are called isocratic elutions because they use 
                a mobile phase of fixed composition. In a gradient 
                elution, we allow the composition of the mobile phase 
                to change during the separation in a way that, ideally, 
                allows each analyte to elute with a \\(k\\) between 2 
                and 10. Use the slider to apply a linear gradient to 
                separation of alklybenzenes. Can you find conditions 
                that allow for the baseline separation of all nine 
                analytes within the expected retention time limits from 
                Question 2? Repeat using a step gradient."
               ),
               p(
                "Note: For a linear gradient, the ends of the slider 
                define the time over which we apply a linear increase 
                from 70% ACN to 100% ACN in the mobile phase. For a 
                step gradient, the ends of the slider define the time 
                when we step the mobile phase from 70% ACN to 85% ACN 
                and then time when we a step the mobile phase from 85% 
                ACN to 100% ACN. The gradient's profile is shown as a 
                dashed red line."
               )
             ),
             column(
               width = 6, 
               align = "center",
               plotOutput("plot_9a", height = "270px"),
               radioButtons("radio_9b", "mobile phase...",
                            choices = c("100% ACN", "70% ACN"), 
                            selected = "100% ACN", inline = TRUE),
               plotOutput("plot_9c", height = "270px"),
               sliderInput("slider_9a", "gradient limits (sec)", 
                           min = 1, max = 300, step = 0.1, 
                           value = c(10, 50), ticks = FALSE, 
                           width = "80%"),
               radioButtons("radio_9a", "gradient type", 
                            choices = c("linear", "step"), 
                            selected = "linear", inline = TRUE)
             )
      
    ), # end ninth TabPanel
    
    tabPanel("Review",
          column
          (width = 12,
          h4("Wrapping Up")
           
          )
      
    ) # end wrap-up
    
    
    
  ) # close tabsetPanel
)) # close all