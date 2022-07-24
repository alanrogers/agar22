# Legofit

Legofit is a program that uses genetic data to infer the history of
population size, subdivision, and admixture. Click
[here](https://alanrogers.github.io/agar22) for the Legofit tutorial.
This current directory contains:

* europe: directory containing the code and data for the analysis
  described in the tutorial. The data set studied there includes
  samples from Europe, Africa, Neanderthals, and a Denisovan.

* quechua: directory containing site pattern frequencies and bootstrap
  replicates like those in the "europe" directory, except that the
  Quechua population is used instead of Europe.

* bougainville: as above, but with Bougainville instead of Europe.

The complete analysis involves several steps, which are detailed in
the tutorial. Here's a brief synopsis.

1. Quality control and tabulation. This step reads data in .vcf
   format, removes sites of low quality, calls ancestral alleles, and
   tabulates the frequencies of nucleotide site patterns. It works
   with large data files and is best done on a compute cluster. We end
   up with 51 small files, 1 describing site pattern frequencies in
   the full data set, and 50 describing those in bootstrap replicates.

2. Write a file in .lgo format, which describes the model of history
   whose parameters you wish to estimate.

3. Use this model to run legofit 51 times: once for the full data, and
   once for each bootstrap replicate.

It's okay to jump from here straight to the final step, which
involves making graphs of the results and calculating bepe (the
"bootstrap estimate of predictive error") to see how well the model
fits the data. 

It's also possible to improve the fit by doing additional legofit runs
and by re-expressing the free variables in terms of (uncorrelated)
principal components. The tutorial has details.

In the workshop, we won't have time for a full analysis. I'll do step
1 before the workshop starts. Students can choose from several data
sets, which will focus on populations from different parts of the
world. Students will do steps 2 and 3 during the workshop.

Before the workshop starts, please try to install legofit on your own
computer. Instructions can be found in the tutorial. We'll spend some
time during the workshop sorting out installation issues, so don't
worry if you run into problems.

The Legofit documentation is available
[here](https://alanrogers.github.io/legofit/html/index.html). 
