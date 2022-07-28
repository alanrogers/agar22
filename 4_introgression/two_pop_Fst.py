import msprime
import sys
import argparse as ap
import numpy as np

def main(args):
	argp = ap.ArgumentParser(description="Calculate Fst for a two-population demographic model")
	argp.add_argument("--Ne", type=int, default=1000, help="Effective population size of the descendent populations")
	argp.add_argument("--t_split", type=int, default=200, help="Split time of descendent populations (generations ago)")
	argp.add_argument("--mig_rate", type=float, default=0, help="Post-split migration rate between populations")
	args = argp.parse_args(args)

	demography = msprime.Demography()
	demography.add_population(name="A", initial_size=args.Ne)
	demography.add_population(name="B", initial_size=args.Ne)
	demography.add_population(name="C", initial_size=1e4)
	demography.add_population_split(time=args.t_split, derived=["A", "B"], ancestral="C")
	demography.add_symmetric_migration_rate_change(time=args.t_split, populations=["A", "B"], rate=args.mig_rate)
	ts = msprime.sim_ancestry(samples={"A": 100, "B": 100}, sequence_length=1e6, demography=demography)
	mts = msprime.sim_mutations(ts, rate=1e-8)

	fst = mts.Fst(sample_sets=[range(0, 200), range(201, 400)])
	print("\nNe of descendent populations is " + str(args.Ne))
	print("Populations split " + str(args.t_split) + " generations ago\n")
	print("The post-split migraton rate is " + str(args.mig_rate) + " per generation (symmetric)\n")
	print("   * Fst between descendent populations is " + str(np.around(fst, decimals=5)) + "\n")

## Run script
if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
