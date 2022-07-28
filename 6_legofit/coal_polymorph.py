# Use computer simulation to estimate probability that a sample of
# haploid size K is polymorphic, given constant population size twoN.
from random import expovariate
from math import exp

twoN = 1000  # population size (number of gene copies)
u = 1e-6     # mutation rate
nitr = 1000  # number of iterations

pr_mono = 0.0

for i in range(nitr):
    K = 30       # sample size (number of gene copies)
    brlen = 0.0  # total branch length in generations

    # Each pass through loop deals with one coalescent interval.
    while K > 1:
        h = K*(K-1)/(2.0*twoN) # hazard of a coalescent event
        t = expovariate(h)     # time until next coalescent event

        # The current interval has K lines of descent, each t
        # generations long. It therefore adds K*t to the total
        # length of the gene genealogy.
        brlen += K*t

        K -= 1

    # 0 term of Poisson distribution gives probability
    # of zero mutations in this particular gene genealogy.
    pr_mono += exp(-u*brlen)

# Average estimates probability that sample is monomorphic.
pr_mono /= nitr

print("Probability of polymorphism:", 1 - pr_mono)
