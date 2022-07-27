# AGAR Workshop on Computational Genetics

Tim Webster and Alan Rogers are hosting the AGAR Workshop on
Computational Genetics July 27-29, 2022. The workshop will focus on
methods for inferring population history and admixture. It will be
virtual, with lectures via Zoom and materials made available on
[github](https://github.com/alanrogers/agar22.git).

# How to apply

Applications are now closed.

# If you've already applied

We've set up a google group for communicating with participants. If
you applied to the workshop, you should have received an invitation to
join this group. If you accepted that invitation, you should be
receiving posts.

Several people, who applied using their institutional email addresses,
have had trouble accessing the google group. We've been fixing those
problems by using alternate email addresses, such as gmail.

If you're having problems of this sort, or if you haven't received the
emails described above, please get in touch: sregorra@gmail.com

# Schedule

We will meet each day from 9am-12pm and from 1-4pm, Mountain Daylight
Time (UTC-6).

<table>
<tr>
<th>Day</th>
<th>Time</th>
<th>Speaker</th>
<th>Topic</th>
</tr>

<tr>
<td>2022-7-27</td>
<td>AM</td>
<td>Ainash Childebayeva</td>
<td>Working with genomic data</td>
</tr>

<tr>
<td>2022-7-27</td>
<td>PM</td>
<td>Tim Webster</td>
<td>Building a reproducible pipeline to map reads and call variants</td>
</tr>

<tr>
<td>2022-7-28</td>
<td>AM</td>
<td>Colin Brand</td>
<td>Simulation with msprime</td>
</tr>

<tr>
<td>2022-7-28</td>
<td>PM</td>
<td>Shyamalika Gopalan</td>
<td>Introgression: background and theory</td>
</tr>

<tr>
<td>2022-7-29</td>
<td>AM</td>
<td>Robert Maier</td>
<td>Admixtools</td>
</tr>

<tr>
<td>2022-7-29</td>
<td>PM</td>
<td>Alan Rogers</td>
<td>Legofit</td>
</tr>
</table>

# What to do before the workshop starts

### Computer set up

1. Set up Bash (Mac and Windows) and Command Line Tools (Mac) (both available by default on Linux)
	* During the workshop, we will make use of the
	[Bash shell](https://www.gnu.org/software/bash/manual), a command-line
	interpreter that is widely used in computational genetics.
	* **It is available on MacOS** through the "Terminal" application
	(located in the "Utilities" subdirectory of your "Applications" folder). If you're using
	a newer operating system on your Mac (Catalina or later) and haven't changed
	your shell, you might be using "zsh" instead. To check, type ```echo $SHELL``` into your terminal.
	If the result is ```/bin/bash```, you're all set. If not, [see this tutorial for changing your
	default shell](https://support.apple.com/en-us/HT208050).
	* **If you're using a Mac** and have never used "Terminal" before on your machine, you might have to install "Command Line Tools", which, as it sounds, adds a slew of command line tools. [This tutorial](https://mac.install.guide/commandlinetools/index.html) gives three options for installation.
	* **On Windows**, bash is available through the
	[Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install) (WSL); that link contains
	instructions for installation.
2. We won't try to teach you Bash, but you should familiarize yourself with the basic
	commands--"ls", "pwd", "cd", "rm", and "mkdir"--and also with bash
	pipes, and the redirection of input and output. In addition to these
	basic commands, please read up on
	"[seq](https://linuxhandbook.com/seq-command/)" and
	"[xargs](https://en.wikipedia.org/wiki/Xargs)", which are used
	extensively in pipelines.
3. Module 4 (Day 2) will require RStudio. Please ensure you have [R](https://www.r-project.org/) and
[RStudio](https://www.rstudio.com/products/rstudio/download/)
installed on your machine. On a Mac, using homebrew, you can
install R and Rstudio by typing
<pre><code>brew install r
brew install rstudio
</code></pre>	
at the bash prompt. Please familiarize yourself with how to change
directories and source scripts in R.

4. You will need `git` both to download the code and data for this
   workshop, and also to install Legofit on your computer. See the
   [Legofit tutorial](legofit/legotut.pdf) to find out how to install
   git and Legofit. Once git is up and running, you can download the
   agar22 repository as follows, using a bash terminal. First use `cd`
   to move to the directory within which you want to install
   agar22. Then type
<pre><code>git clone https://github.com/alanrogers/agar22.git agar22
</code></pre>	
   When that has run, you should find a directory named "agar22",
   which contains all the files related to the workshop. As we make
   changes to the workshop files, it's easy to keep your own copy up
   to date. Use `cd` to move into the agar22 directory and type
<pre><code>git pull
</code></pre>	

### Reading

1. Suggested reading for Day 2 and Day 3
	* [Just enough probability](http://content.csbs.utah.edu/~rogers/pubs/Rogers-JEP.pdf)

	* Chs. 4-5 of [Lecture notes on gene genealogies](ggeneal.pdf)

	* [Rogers 2022](https://arxiv.org/abs/2201.02668) Using genetic data
    to build intuition about population history.

# Tutorials

* [AdmixTools](https://uqrmaie1.github.io/admixtools/articles/admixtools.html)

* [Legofit](legofit/legotut.pdf)

* [Msprime](msprime/msptut.pdf)

# Faculty

* [Colin Brand](https://colinmbrand.weebly.com) is a postdoc in the
  [Capra Lab](https://http://www.capralab.org) at UCSF. His current
  research focuses on characterizing adaptation and introgression in non-human
  primates and predicting phenotypes from genomic data in archaic hominins.

* [Ainash Childebayeva](https://sph.umich.edu/stories/2020posts/ainash-childebayeva.html)
  is in the Dept of Archaeogenetics, in the
  [Max Planck Instute of Evolutionary Anthropology](https://pure.mpg.de/cone/persons/resource/persons242932).

* Shyamalika Gopalan is a postdoc in the
  [Goldberg lab](https://www.goldberglab.org/people) at Duke
  University. She has
  [extensive experience](https://scholar.google.com/citations?user=mZhqPRMAAAAJ&hl=en)
  using genetic data to infer population history.

* [Robert Maier](https://heb.fas.harvard.edu/people/robert-maier) is a
  Research Fellow at the Broad Institute, Harvard University. He is
  the lead developer of AdmixTools2, which he will teach during the
  workshop.

* [Alan Rogers](https://anthro.utah.edu/profile.php?unid=u0028949) is
  in the Anthro Dept of the University of Utah. He has developed
  several methods for inferring population history from genetic
  data. He will cover one of those methods,
  [Legofit](https://alanrogers.github.io/legofit/html/index.html),
  during the workshop.

* [Tim Webster](https://faculty.utah.edu/u6023206-TIM_WEBSTER/hm/index.hml)
  is in the Anthropology Department at the University of Utah. He uses genomic
  data and computational methods to understand primate evolution,
  ecology, and behavior. In particular, he explores (1)
  macroevolutionary processes, especially speciation, adaptation, and
  lineage-specific demographic history, (2) modern and historical
  aspects of behavioral ecology and social organization, and (3) sex
  chromosome evolution.
