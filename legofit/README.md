# Legofit

Legofit is a program that uses genetic data to infer the history of
population size, subdivision, and admixture. This directory contains
the following:

* txt/legotut.pdf: a [Legofit tutorial](txt/legotut.pdf). This
  tutorial describes a complete analysis, from beginning to end.

* xyvdf: directory containing the code and data for the analysis
  described in the tutorial.

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
and by re-expressing the free variable in terms of (uncorrelated)
principal components. The tutorial has details.

In the workshop, we won't have time for a full analysis. I'll do step
1 before the workshop starts. Students can choose from several data
sets, which will focus on populations from different parts of the
world. Students will do steps 2 and 3 during the workshop.
