import msprime
import sys
import argparse as ap
import numpy as np

def main(args):
	argp = ap.ArgumentParser(description="Simulate genomic data under a 3-way admixture model")
	argp.add_argument("--out", type=str, default="3_way_admix_output.vcf", help="Desired file name for the output vcf")
	argp.add_argument("--SP1_Ne", type=int, default=5e3, help="Effective population size of source population 1")
	argp.add_argument("--SP2_Ne", type=int, default=5e3, help="Effective population size of source population 2")
	argp.add_argument("--SP3_Ne", type=int, default=5e3, help="Effective population size of source population 3")
	argp.add_argument("--AP_Ne", type=int, default=1e3, help="Effective population size of the admixed population")
	argp.add_argument("--SP1_SP2_anc_Ne", type=int, default=5e3, help="Effective population size of the ancestral population of SP1 and SP2")
	argp.add_argument("--t_split_all", type=int, default=1000, help="Split time of all three source populations (generations ago)")
	argp.add_argument("--t_split_SP1_SP2", type=int, default=250, help="Split time of SP1 and SP2 (generations ago)")
	argp.add_argument("--t_admix", type=int, default=10, help="Time of admixture (generations ago)")
	argp.add_argument("--SP1_prop", type=float, default=0.33333, help="Admixture proportion contributed by source population 1")
	argp.add_argument("--SP2_prop", type=float, default=0.33333, help="Admixture proportion contributed by source population 2")
	args = argp.parse_args(args)
	
	sample_size=50

	demography = msprime.Demography()
	demography.add_population(name="SP1", initial_size=args.SP1_Ne)
	demography.add_population(name="SP2", initial_size=args.SP2_Ne)
	demography.add_population(name="SP3", initial_size=args.SP3_Ne)
	demography.add_population(name="AP", initial_size=args.AP_Ne)
	demography.add_population(name="SP1_SP2_anc", initial_size=args.SP1_SP2_anc_Ne)
	demography.add_population(name="anc_of_all", initial_size=10000)
	demography.add_admixture(time=args.t_admix, derived="AP", ancestral=["SP1", "SP2", "SP3"], proportions=[args.SP1_prop, args.SP2_prop, 1 - (args.SP1_prop + args.SP2_prop)])
	demography.add_population_split(time=args.t_split_SP1_SP2, derived=["SP1", "SP2"], ancestral="SP1_SP2_anc")
	demography.add_population_split(time=args.t_split_all, derived=["SP1_SP2_anc", "SP3"], ancestral="anc_of_all")
	ts = msprime.sim_ancestry(samples={"SP1": sample_size, "SP2": sample_size, "SP3": sample_size, "AP": sample_size}, sequence_length=3e7, recombination_rate=1e-8, demography=demography)
	mts = msprime.sim_mutations(ts, rate=1e-8)

	print("\nSource population 1 has an Ne of " + str(args.SP1_Ne) + " and makes up " + str(np.round(args.SP1_prop*100, decimals=3)) + "% of the admixed population")
	print("Source population 2 has an Ne of " + str(args.SP2_Ne) + " and makes up " + str(np.round(args.SP2_prop*100, decimals=3)) + "% of the admixed population")
	print("Source population 3 has an Ne of " + str(args.SP3_Ne) + " and makes up " + str(np.round((1 - (args.SP1_prop + args.SP2_prop))*100, decimals=3)) + "% of the admixed population")
	print("The ancestral population of SP1 and SP2 had an Ne of " + str(args.SP1_SP2_anc_Ne))
	print("The population ancestral to everyone had an Ne of 10000 (fixed)")
	print("\nThe admixed population was founded " + str(args.t_admix) + " generations ago")
	print("SP1 and SP2 split " + str(args.t_split_SP1_SP2) + " generations ago")
	print("The initial population split was " + str(args.t_split_all) + " generations ago")
	print("\n** VCF output for " + str(sample_size) + " diploid samples per population being written to " + str(args.out) + " **\n")
	pop_ids = np.repeat(["SP1", "SP2", "SP3", "AP"], repeats=np.repeat(sample_size, 4))
	ind_ids = [str(x) for x in np.tile(range(1, sample_size+1), 4)]
	with open(args.out, "w") as vcf_file:
		mts.write_vcf(vcf_file, individual_names=np.char.add(np.char.add(pop_ids, np.repeat("_", sample_size*4)), ind_ids))
        	
## Run script
if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))