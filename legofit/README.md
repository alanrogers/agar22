# Legofit

Legofit is a program that uses genetic data to infer the history of
population size, subdivision, and admixture.  During the workshop,
we'll be doing an exercise that uses it to fit the model in directory
`europe/a`. Students will run a version of the legofit pipeline, which
has been scaled down to run easily on a laptop. They will estimate
parameters describing population history, and use a bootstrap to
assess the uncertainty of those estimates. Finally, they will use R to
make graphs of the results. Details of this exercise are in the
[Legofit tutorial](https://alanrogers.github.io/agar22/legofit/legotut.pdf).

In the first exercise, everyone will study the data in file
`europe/data.opf` and fit the model in directory `europe/a`. If there
is time, we'll do a second exercise in which students will study a
data set (either Europe, Quechua, or Bougainville) and a model of
their choice.

Before the workshop starts, please try to install legofit on your own
computer. Instructions can be found in the tutorial. We'll spend some
time during the workshop sorting out installation issues.

The Legofit module will begin with [these slides](https://alanrogers.github.io/agar22/speda.pdf).

This current directory contains:

* europe: directory containing the code and data for the analysis
  described in the tutorial. The data set studied there includes
  samples from Europe, Africa, Neanderthals, and a Denisovan.

* quechua: directory containing site pattern frequencies and bootstrap
  replicates like those in the "europe" directory, except that the
  Quechua population is used instead of Europe.

* bougainville: as above, but with Bougainville instead of Europe.

* coal_polymorph.py: students in the Msprime module asked how
  coalescent simulations without mutations could be useful. This
  Python script implements a coalescent simulation that calculates the
  probability that a sample has genetic variation, given its size and
  that of the population.

Further information is available in the Legofit
[documentation](https://alanrogers.github.io/legofit/html/index.html).

