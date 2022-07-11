#!/usr/bin/python3

# Before running this: "python3 -m pip install msprime"
import msprime as msp
import os, sys

def usage():
    print("Usage: ./msp.py [options]")
    print("  where options may include:")
    print("  -r or --run: run simulation. Default: run DemographyDebugger")
    sys.exit(1)

do_simulation = False
for arg in sys.argv[1:]:
    if arg == "-r" or arg == "--run":
        do_simulation = True
    else:
        usage()

# time parameters in generations
Txyn = 25920
Txy = 3788
Ta = 1760           # age of Altai fossil
Talpha = 1897       # time of Neanderthal admixture

# population sizes
Nxyn = 64964.1/2.0  # ancestral population
Nxy = 44869.2/2.0
Nn = 9756.8/2.0
Nx = 20000/2.0      # modern Africa
Ny = 20000/2.0      # modern Europe

# admixture
mAlpha = 0.05

nchromosomes = 10   # number of chromosomes: increase to 1000
basepairs = 2e6     # number of nucleotides per chromosome
u_per_site = 1.4e-8 # mutation

# Recombination rate.  recomb is the probability of recombination
# between sites at opposite ends of the simulated sequence.
c = 1e-8 # rate per base pair per generation

dem = msp.Demography()

# Populations
dem.add_population(
    name = "X",
    description = "African",
    initial_size = Nx
)
dem.add_population(
    name = "Y",
    description = "Eurasian",
    initial_size = Ny
)
dem.add_population(
    name = "Y1",
    description = "Y before delta gene flow",
    initial_size = Ny
)
dem.add_population(
    name = "N",
    description = "Neanderthal",
    initial_size = Nn
)
dem.add_population(
    name = "XY",
    description = "early modern humans",
    initial_size = Nxy
)
dem.add_population(
    name = "XYN",
    description = "ancestral population",
    initial_size = Nxyn
)

# N->Y gene flow
dem.add_admixture(
    time = Talpha,
    derived = "Y",
    ancestral = ["Y1", "N"],
    proportions = [1-mAlpha, mAlpha]
)

# X-Y split
dem.add_population_split(
    time = Txy,
    derived = ["X", "Y1"],
    ancestral = "XY"
)

# XY-N split
dem.add_population_split(
    time = Txyn,
    derived = ["XY", "N"],
    ancestral = "XYN"
)

dem.sort_events()

# One haploid sample from each of 3 populations: 2 modern (X,Y),
# and 1 archaic (N).
samples = [
    msp.SampleSet(num_samples=1, population="X", time=0, ploidy=1),
    msp.SampleSet(num_samples=1, population="Y", time=0, ploidy=1),
    msp.SampleSet(num_samples=1, population="N", time=Ta, ploidy=1),
]

if do_simulation:
    # Seed for random number generator. Uses 4 bytes (32 bits) from
    # /dev/urandom.
    seed = int.from_bytes(os.urandom(4), "big")

    # Simulate gene genealogy. When sim_ancestry is called without
    # num_replicates, it returns a value of class
    # tskit.trees.TreeSequence. But when it's called with
    # num_replicates, it returns a "generator", which can be
    # used in a loop to deal with each replicate in turn.
    chr_generator = msp.sim_ancestry(samples = samples,
                                     demography = dem,
                                     sequence_length = basepairs,
                                     random_seed = seed,
                                     recombination_rate = c,
                                     num_replicates = nchromosomes
    )
    
    # header
    lbl = ["x", "y", "n"]
    print("npops = %d" % len(lbl))
    print("%s %s" % ("pop", "sampsize"))
    for s in lbl:
        print("%s %d" % (s, 1))

    # Put mutations onto the gene genealogy
    for i, chr in enumerate(chr_generator):
        sim = msp.sim_mutations(chr, rate = u_per_site)

        for variant in sim.variants():

            # Use only biallelic sites
            if len(variant.alleles) != 2:
                continue
            
            print(i, end="")
            for g in variant.genotypes:
                print("", g, end="")
            print()
else:
    # Run demography debugger and quit
    print(dem.debug())
    print("Use \"./sim -r\" to run simulation")
