import msprime
import sys
import argparse as ap

def main(args):
	argp = ap.ArgumentParser(description="Generate multi-locus genotype data for a human-Neanderthal introgression model")
	argp.add_argument("--intro_prop", type=float, default=0.0, help="Introgression proportion - proportion of human population that was comprised of Neanderthals when introgression occurred")
	argp.add_argument("--out", type=str, default="introgression_sim_output.vcf", help="Desired file name for .vcf output")
	args = argp.parse_args(args)

	demography = msprime.Demography()
	demography.add_population(name="H1_Eur", initial_size=10000)
	demography.add_population(name="H_unadmixed", initial_size=10000)
	demography.add_population(name="H2_Afr", initial_size=10000)
	demography.add_population(name="H_anc", initial_size=10000)
	demography.add_population(name="N", initial_size=1000)
	demography.add_population(name="N_H_anc", initial_size=10000)
	demography.add_population(name="Pan", initial_size=10000)
	demography.add_population(name="ape_anc", initial_size=50000)
	demography.add_admixture(time=1500, derived="H1_Eur", ancestral=["N", "H_unadmixed"], proportions=[args.intro_prop, 1-args.intro_prop])
	demography.add_population_split(time=1800, derived=["H_unadmixed", "H2_Afr"], ancestral="H_anc")
	demography.add_population_split(time=25000, derived=["H_anc", "N"], ancestral="N_H_anc")
	demography.add_population_split(time=500000, derived=["N_H_anc", "Pan"], ancestral="ape_anc")
	ts = msprime.sim_ancestry(samples={"H1_Eur": 1, "H2_Afr": 1, "N": 1, "Pan": 1}, sequence_length=1e7, demography=demography, recombination_rate=1e-8)
	mts = msprime.sim_mutations(ts, rate=1e-8)

	with open(args.out, "w") as vcf_file:
		mts.write_vcf(vcf_file, individual_names=["H1_Eur", "H2_Afr", "N", "Pan"])
        	
	print("\nThe Neanderthal introgression proportion is " + str(args.intro_prop))
	print("Genotype output written to " + args.out + "\n")

## Run script
if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))