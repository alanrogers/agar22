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
</table>

ad, a, ab, abc, abcd, abd, ac, acd: these subdirectories contain
analyses of different models. For details, see the README.md file
within each subdirectory.

patfrq.r : R script to graph site pattern frequencies. Generates xyvad-frq.pdf

xyvad-frq.pdf : graph of site pattern frequencies and confidence intervals

all.bma : bootstrap model average of all models. Produced like this:

    booma */b2.bepe -F */b2.flat > all.bma

all.bootci : model-averaged estimates and confidence intervals. Also
has booma weights. Produced like this:

    bootci.py all.bma > all.bootci

bmadot.r : R script to graph estimates. Reads all.bootci. Writes
bmadot.pdf.

bmadot.pdf: graph of parameter estimates and confidence intervals.
