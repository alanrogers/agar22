# Five-dimensional data set

The files here mirror those used by
[Rogers (2022)](https://doi.org/10.24072/pcjournal.132).  This
analysis differed from that of
[Rogers, Harris, and Achenbach (2020)](https://doi.org/10.1126/sciadv.aay5483)
only in that (a) I used the "-d 0" option of legofit to invoke the
deterministic algorithm, and (b) I didn't use the "--tol 0.001" option
of pclgo. The 2nd change implies that there is no reduction of
dimension when I re-express variables in terms of principal
components.

Populations: X, Yoruba; Y, Europe (France and England); V, Vindija; A,
Altai; D, Denisova. Outgroup=chigor (merged chimp and gorilla
reference sequences).

<table>
<tr>
<th>File</th>
<th>Description</th>
</tr>

<tr>
<td>sitepat.slr</td>
<td>Slurm script to generate data.opf and boot/boot*.opf</td>
</tr>

<tr>
<td>data.opf</td>
<td>observed site pattern frequencies and confidence intervals</td>
</tr>

<tr>
<td>boot</td>
<td>directory for bootstrap replicates</td>
</tr>

<tr>
<td>all.bma</td>
<td>Booma weights of all models; model-averaged parameter
estimates.</td>
</tr>

<tr>
<td>all.bootci</td>
<td>Confidence intervals for model-averaged estimates</td>
</tr>

<tr>
<td>patfrq.r</td>
<td>R script to make patfrq.pdf</td>
</tr>

<tr>
<td>patfrq.pdf</td>
<td>Graph of site pattern frequencies</td>
</tr>

<tr>
<td>bmadot.r</td>
<td>R script to make bmadot.pdf</td>
</tr>

<tr>
<td>bmadot.pdf</td>
<td>Graph of estimates and confidence intervals</td>
</tr>

</table>

ad, a, ab, abc, abcd, abd, ac, acd: these subdirectories contain
analyses of different models. For details, see the README.md file
within each subdirectory.

all.bma, all.bootci, patfrq.pdf, and bmadot.pdf were produced like this:

    booma */b2.bepe -F */b2.flat > all.bma
    bootci.py all.bma > all.bootci
	Rscript patfrq.r
	Rscript bmadot.r

