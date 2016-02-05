# Usepackage Environment Manager 
# Copyright (C) 1995-2003  Jonathan Hogg  <jonathan@onegoodidea.com> 
# 
# Usepackage Sample Configuration File
#
# Format:
#
# 	<packagename> [<arch> [<os> [<release> [<host> [<shell>]]]]]
#          [<= <requires>...] :
#		<setting>[, <setting>...] ;
#
# <packagename>, <arch>, <os>, and <host> may use a restricted shell-style
# pattern matching ('*' for anything, '<pre>*' for prefix, '{<a>,<b>,...}'
# for a choice. <setting>s are of the form '<name>=<value>' or '<name>+=<value>'
# or '<[ ... ]>' - the former defines an environment variable to be set or
# modified, the latter marks a section of script to be evaluated directly
# in the shell.
#
# A <value> is either a path list (colon separated) or a literal string in
# double quotes. New-lines are ignored in path lists and in literal strings.
# A path may begin with '~' or '~user' which will be expanded respectively
# to the home directory of the user invoking usepackage or the specified user.
# The optional <requires> list is a comma-separated list of package or
# group names that must be loaded into the environment before this package.
# Whatever you do, DON'T create a mutually dependant loop!
#
# e.g.:
#
#	X : PATH+=/usr/X11/bin, LD_LIBRARY_PATH+=/usr/X11/lib ;
#	frib * * * mymachine : PATH+=/special/frib/bin ;
#	frib sun4* : PATH+=/usr/local/frib/bin/sun4 ;
#	frib alpha : PATH+=/usr/local/frib/bin/alpha ;
#	cvs <= gnu : CVSROOT=/usr/local/src/cvsroot ;
#       frob : <[ /usr/local/frob/bin/frob-init ]> ;
#
# NOTE: Sun SPARCs identify themselves as 'sun4m' or 'sun4c' not 'sun4',
#       so use 'sun4*' to match both.
#
# Package matching is done sequentially through the file and _every_ record
# that matches will be added to the environment. Path additions (+=) are
# made to the head of a path list and duplicates are removed from the tail.
# Matches are case insensitive.
#
#
# Groups format:
#
#	<groupname> := <packagename>[, <packagename>...] ;
#
# No pattern matching is available for <groupname> or <packagename>. Groups
# cannot reference other groups, only packages. Names are case insensitive.
#
# E.g.:
#
#	standard-user-settings := standard, X, TeX ;
#	openwin-user-settings := standard, OpenWin, TeX ;
#
#
# Annotations:
#
#	>> name : "..." <<
#
# Annotations are used to document packages. The name and description of
# each package should be given. These are listed with the '-l' option of
# usepackage.
#

standard-user-settings := sge6, sysadm, system, basic;
#standard-user-settings := ttaprinter,  ct6, studio11, x11, site, blastwave, ccs, system, basic;

# Abaqus current version
>> abaqus : "Abaqus 64 bit current version" <<
abaqus <= abaqus-6.11 : <[ /bin/true ]> ;

# Abaqus 6.11
>>  abaqus-6.11 : "Abaqus 6.11 64-bit version" <<
abaqus-6.11 :           PATH += "/opt/abaqus/6.11/Commands",
                        PATH += "/bin",
                        LM_LICENSE_FILE += "/opt/abaqus/6.11/License/license.dat";

# Abaqus 6.10
>>  abaqus-6.10 : "Abaqus 6.10 64-bit version" <<
abaqus-6.10 :           PATH += "/opt/abaqus/6.10/Commands",
                        PATH += "/bin",
                        LM_LICENSE_FILE += "/opt/abaqus/6.10/License/license.dat";

>> allpaths-lg : "AllPaths-LG (current version)" <<
allpaths-lg <= allpaths-lg-52488 : <[ /bin/true ]>;

>> allpaths-lg-52488 : "AllPaths-LG (version 52488)" <<
allpaths-lg-52488 <= gcc-4.8.3 :	PATH += /opt/allpathslg/52488/bin ;

>> anaconda20 : "Anaconda Python 2 distribution (includes numpy & scipy)" <<
anaconda20 :			PATH += /opt/python/anaconda2.2.0/bin,
            			LD_LIBRARY_PATH += /opt/python/anaconda2.2.0/lib;

>> anaconda2 : "Anaconda Python 2 distribution (includes numpy & scipy)" <<
anaconda2 <= anaconda20 : <[ /bin/true ]>;

>> anaconda3 : "Anaconda Python 3 distribution (includes numpy & scipy)" <<
anaconda3 :			PATH += /opt/python/anaconda3-2.3.0/bin,
            			LD_LIBRARY_PATH += /opt/python/anaconda3-2.3.0/lib;

# autodock current version
>> autodock : "Autodock current version" <<
autodock <= autodock425 : <[ /bin/true ]>;

# autodock 4.2.5
>>  autodock425 : "Autodock 4.2.5 64-bit version" <<
autodock425 :           PATH += "/opt/autodock/4.2.5/64";

>> basic: "Initial Settings" <<
basic :				EDITOR = "vi",
				SCRATCHDIR = "/scratch/$LOGNAME",
				WORKDIR = "/u1/work/$LOGNAME";

>> blast : "Blast current version" <<
blast <= blast-2.2.30 : <[ /bin/true ]>;

>> blast-2.2.30 : "Blast 2.2.30+" <<
blast-2.2.30 :			PATH += /opt/blast/2.2.30+/bin ;

>> discovar-denovo : "Discovar De Novo (current version)" <<
discovar-denovo <= discovar-denovo-52488 : <[ /bin/true ]>;

>> discovar-denovo-52488 : "Discovar De Novo (version 52488)" <<
discovar-denovo-52488 <= gcc-4.8.3 :	PATH += /opt/discovar/denovo/52488/bin ;

### If you absolutely insist on such a security hole: ###
>> dot : "append current directory to PATH (possible security hole)" <<
dot * * * * bash :            	<[ PATH=$PATH:. ]> ;
dot * * * * sh :            	<[ PATH=$PATH:. ]> ;
dot * * * * csh :             	<[ set path=($path .) ]> ;
dot * * * * tcsh :             	<[ set path=($path .) ]> ;

# FDS
>> fds : "Fire Dynamic Simulator (version 6)" <<
fds : 			<[ source /opt/fds/FDS6/.bashrc_fds  intel64 ]> ;

# >> fftw2_32bit: "FFTW v. 2.1.5 (with OpenMP, with MPI)" <<
# fftw2_32bit * Linux :	FFTW_DIR = /opt/fftw_32bit-2.1.5,
# 			FFTW_INCLUDE = $FFTW_DIR/include,
# 			FFTW_LIB = $FFTW_DIR/lib,
# 			INFOPATH += $FFTW_DIR/info ;

# Fluent Ansys 14
>> ansys14 : "Fluent (Ansys 14 on Linux)" <<
ansys14 :               PATH += "/opt/fluent/ansys-14.0/v140/fluent/bin",
                        LM_LICENSE_FILE += "/opt/licenses/hpcvl_ansys/license.dat",
                        FLUENT_ARCH = "lnamd64",
                        FLUENT_LICENSE_FILE = "/opt/licenses/hpcvl_ansys/license.dat";

# Fluent Ansys 16
>> ansys16 : "Fluent (Ansys 16 on Linux)" <<
ansys16 :               PATH += "/opt/fluent/ansys-16.1/v161/fluent/bin",
                        LM_LICENSE_FILE += "/opt/licenses/hpcvl_ansys/license.dat",
                        FLUENT_ARCH = "lnamd64",
                        FLUENT_LICENSE_FILE = "/opt/licenses/hpcvl_ansys/license.dat";

# fastx default version
>> fastx : "FastX current version" <<
fastx <= fastx-0.0.13 : <[ /bin/true ]>;

# fastx 0.0.13
>> fastx-0.0.13 : "FastX 0.0.13 (64 bit)" <<
fastx-0.0.13 :	PATH += "/opt/fastx/0.0.13/bin";

# Freefem++ default version
>> freefem : "FreeFem++ current version" <<
freefem <= freefem-3.36 : <[ /bin/true ]>;

# Freefem++ 3.36
>> freefem-3.36 : "FreeFem++ 3.36-1" <<
freefem-3.36 <= gcc-4.8.3, openmpi-1.8 :	PATH += "/opt/freefem/3.36-1/linux64/bin",
						LD_LIBRARY_PATH += "/opt/freefem/3.36-1/linux64/lib";

# Gnuplot
>> gnuplot : "Gnuplot graphics software (latest version)" <<
gnuplot <= gnuplot_4.6.6 : <[ /bin/true ]>;

>> gnuplot_4.6.6 : "Gnuplot graphics software (4.6.6)" <<
gnuplot_4.6.6 : 	PATH += "/opt/gnuplot/4.6.6/bin" ;

# ICS
>> ics : "Intel Compiler Suite" <<
ics : 			<[ source /opt/ics/bin/compilervars.sh  intel64 ]>,
			LM_LICENSE_FILE += "/opt/ics/license/license.dat";

# Intel Compiler + MPI
>> icsmpi : "Intel Compiler Suite plus Intel MPI" <<
icsmpi :  <[ source /opt/ics/bin/compilervars.sh intel64 ]>,
          <[ source /opt/ics/composer_xe_2011_sp1.6.233/mkl/bin/intel64/mklvars_intel64.sh intel64 ]>,
          <[ source /opt/ics/impi/4.0.3.008/bin64/mpivars.sh ]>,
          LM_LICENSE_FILE += "/opt/ics/license/license.dat";

# ICS
# >> ics : "Intel Compiler Suite" <<
# ics : 			PATH += "/opt/ics/bin";

# GCC 4.9.2
>> gcc-4.9.2 : "GNU compiler suite v4.9.2" <<
gcc-4.9.2 :		PATH += "/opt/gcc/4.9.2/bin";

# GCC 4.8.3
>> gcc-4.8.3 : "GNU compiler suite v4.8.3" <<
gcc-4.8.3 :		PATH += "/opt/gcc/4.8.3/bin",
			LD_LIBRARY_PATH += "/opt/gcc/4.8.3/lib64";

# GCC 4.8.2
>> gcc-4.8.2 : "GNU compiler suite v4.8.2" <<
gcc-4.8.2 :		PATH += "/opt/gcc/4.8.2/bin";

# GCC 4.1.2
>> gcc-4.1.2 : "GNU compiler suite v4.1.2" <<
gcc-4.1.2 :		PATH += "/opt/gcc-4.1.2/bin";

# Abinit (current version)

>> Abinit : "Abinit (current version) 32 bit" <<
Abinit <= Abinit6.12.3_32bit :         <[ /bin/true ]> ;

>> Abinit : "Abinit (current version) 64 bit" <<
Abinit_64bit <= Abinit6.12.3_64bit :         <[ /bin/true ]> ;

# Abinit 6.12.3

>> Abinit6.12.3_32bit : "Abinit software (version 6.12.3, 32-bit)" <<
Abinit6.12.3_32bit: 	<[ source /opt/ics/bin/compilervars.sh  ia32 ]> ,
			PATH += /opt/abinit/6.12.3/32bit/bin;

>> Abinit6.12.3_64bit : "Abinit software (version 6.12.3, 64-bit)" <<
abinit6.12.3_64bit:	<[ source /opt/ics/bin/compilervars.sh intel64 ]> ,
			PATH += /opt/abinit/6.12.3/64bit/bin;

# ESPResSo (current version)

>> espresso : "ESPReSso (current version) 32 bit" <<
espresso <= espresso3.1.1_32bit :         <[ /bin/true ]> ;

>> espresso_64bit : "ESPReSso (current version) 64 bit" <<
espresso_64bit <= espresso3.1.1_64bit :         <[ /bin/true ]> ;

# ESPReSso 3.1.1

>> espresso3.1.1_32bit : "ESPReSso software (version 3.1.1, 32-bit)" <<
espresso3.1.1_32bit: 	<[ source /opt/ics/bin/compilervars.sh ia32 ]> ,
			LD_LIBRARY_PATH += /opt/tcl-tk/tcl-tk_x86_8.5/lib ,
			PATH += /opt/tcl-tk/tcl-tk_x86_8.5/bin ,
			PATH += /opt/espresso/3.1.1/32bit/bin ;

>> espresso3.1.1_64bit : "ESPReSso software (version 3.1.1, 64-bit)" <<
espresso3.1.1_64bit:	<[ source /opt/ics/bin/compilervars.sh intel64 ]> ,
			LD_LIBRARY_PATH += /opt/tcl-tk/tcl-tk_x86_64_8.5/lib ,
			PATH += /opt/tcl-tk/tcl-tk_x86_64_8.5/bin ,
			PATH += /opt/espresso/3.1.1/64bit/bin ;

>> instruct : "InStruct" <<
instruct : PATH += /opt/instruct/bin ;

>> jmol : "Jmol (current version)" <<
jmol <= jmol-14.2.7 :   <[ /bin/true ]> ;

>> jmol-14.2.7 : "Jmol 14.2.7" <<
jmol-14.2.7 :	        PATH += /opt/jmol/14.2.7 ;

>> migrate-n : "migrate-n current version" <<
migrate-n <= migrate-n-3.6.8 : <[ /bin/true ]> ;

>> migrate-n-3.6.8 : "migrate-n-3.6.8" <<
migrate-n-3.6.8 : PATH += /opt/migrate/3.6.8/bin ;

>> octave : "octave (current version)" <<
octave <= octave-4.0.0 : <[ /bin/true ]> ;

>> octave-4.0.0 : "GNU octave-4.0.0 MATLAB look-alike" <<
octave-4.0.0 : PATH += /opt/octave/4.0.0/bin ;

>> openfoam : "OpenFOAM (current version)" <<
openfoam <= openfoam-2.3.0 : <[ /bin/true ]> ;

>> openfoam-2.1.1 : "OpenFOAM 2.1.1" <<
openfoam-2.1.1 :	<[ source /opt/OpenFOAM/2.1.1/etc/bashrc ]> ;

>> openfoam-2.3.0 : "OpenFOAM 2.3.0" <<
openfoam-2.3.0 <= openmpi : <[ source /opt/OpenFOAM/2.3.0/src/OpenFOAM-2.3.0/etc/bashrc ]> ,
                LD_LIBRARY_PATH+=/opt/gcc/4.8.3/lib64 ,
                ParaView_DIR=/opt/OpenFOAM/2.3.0/linux64/ThirdParty-2.3.0/platforms/linux64Gcc/ParaView-4.1.0 ,
                PATH+=$ParaView_DIR/bin ,
                PV_PLUGIN_PATH=$FOAM_LIBBIN/paraview-4.1 ;

>> openfoam-3.0.0 : "OpenFOAM 3.0.0" <<
openfoam-3.0.0 <= openmpi-1.8.4, gcc-4.8.3 : <[ source /opt/OpenFOAM/3.0.0/linux64/OpenFOAM-3.0.0/etc/bashrc ]> ,
                LD_LIBRARY_PATH+=/opt/gcc/4.8.3/lib64 ;

>> foam-extend : "FoamExtend (current version)" <<
foam-extend <= foam-extend-3.1 : <[ /bin/true ]>;

>> foam-extend-3.1 : "FoamExtend 3.1" <<
foam-extend-3.1 : <[ source /opt/OpenFOAM/fe3.1/foam/foam-extend-3.1/etc/bashrc ]> ;

# qespresso (current version)
>> qespresso : "qespresso (current version) 64 bit" <<
qespresso <= qespresso5.2.1_64bit :         <[ /bin/true ]> ;

>> qespresso5.0.2_64bit : "Quantum Espresso software (version 5.0.2, 64-bit)" <<
qespresso5.0.2_64bit:	<[ source /opt/ics/bin/compilervars.sh intel64 ]> ,
			PATH += /opt/qespresso/5.0.2/64bit/intel/bin;

>> qespresso5.2.1_64bit : "Quantum Espresso software (version 5.2.1, 64-bit)" <<
qespresso5.2.1_64bit <= openmpi : PATH += /opt/qespresso/5.2.1/64bit/gcc/bin;

# CPMD (current version)

>> CPMD : "CPMD (current version) 32 bit" <<
CPMD <= CPMD3.13.2_32bit :         <[ /bin/true ]> ;

>> CPMD_64bit : "CPMD (current version) 64 bit" <<
CPMD_64bit <= CPMD3.13.2_64bit :         <[ /bin/true ]> ;

# CPMD 3.13.2

>> CPMD3.13.2_32bit : "CPMD software (version 3.13.2, 32-bit)" <<
CPMD3.13.2_32bit:       <[ source /opt/ics/bin/compilervars.sh  ia32 ]> ,
                        PATH += /opt/cpmd/3.13.2/32bit;

>> CPMD3.13.2_64bit : "CPMD software (version 3.13.2, 64-bit)" <<
CPMD3.13.2_64bit:       <[ source /opt/ics/bin/compilervars.sh intel64 ]> ,
                        PATH += /opt/cpmd/3.13.2/64bit;

# Gamess (most current version)
>> gamess : "Gamess (Dec 5 2014)" <<
gamess :  PATH += /opt/gamess/Dec5-2014-R1 ;

# Gromacs (new version, test)

>> Gromacs_test : "Gromacs (new, test)" <<
Gromacs_test <= Gromacs5.0.6 :         <[ /bin/true ]> ;

>> Gromacs5.0.6 : "Gromacs software (version 5.0, 64-bit)" <<
Gromacs5.0.6:       <[ source /opt/gromacs/5.0/bin/GMXRC ]> ;

# Gromacs (current version)

>> Gromacs : "Gromacs (current version) 32 bit" <<
Gromacs <= Gromacs4.0.7_32bit :         <[ /bin/true ]> ;

>> Gromacs_64bit : "Gromacs (current version) 64 bit" <<
Gromacs_64bit <= Gromacs4.0.7_64bit :         <[ /bin/true ]> ;

# Gromacs 4.0.7

>> Gromacs4.0.7_32bit : "Gromacs software (version 4.0.7, 32-bit)" <<
Gromacs4.0.7_32bit: 	<[ source /opt/ics/bin/compilervars.sh  ia32 ]> ,
			PATH += /opt/gromacs/4.0.7/32bit/bin,
			MANPATH += /opt/gromacs/4.0.7/32bit/share/man;

>> Gromacs4.0.7_64bit : "Gromacs software (version 4.0.7, 64-bit)" <<
Gromacs4.0.7_64bit:	<[ source /opt/ics/bin/compilervars.sh intel64 ]> ,
			PATH += /opt/gromacs/4.0.7/64bit/bin,
			MANPATH += /opt/gromacs/4.0.7/64bit/share/man;

# Gromacs 4.6  

>> Gromacs4.6_32bit : "Gromacs software (version 4.6, 32-bit)" <<
Gromacs4.6_32bit: 	<[ source /opt/ics/bin/compilervars.sh  ia32 ]> ,
			PATH += /opt/gromacs/4.0.7/32bit/bin,
			MANPATH += /opt/gromacs/4.6/32bit/share/man;

>> Gromacs4.6_64bit : "Gromacs software (version 4.6, 64-bit)" <<
Gromacs4.6_64bit:	<[ source /opt/ics/bin/compilervars.sh intel64 ]> ,
			PATH += /opt/gromacs/4.6/64bit/bin,
			MANPATH += /opt/gromacs/4.0.7/64bit/share/man;

>> Gurobi : "Gurobi (newest version, 64-bit)" <<
gurobi : PATH += /opt/gurobi/gurobi605/linux64/bin,
         LD_LIBRARY_PATH += /opt/gurobi/gurobi605/linux64/lib,
         TOKENSERVER = "license01",
         GUROBI_HOME = /opt/gurobi/gurobi605/linux64,
         GRB_LICENSE_FILE += /opt/gurobi/gurobi605/license/gurobi.lic ;

# HPCVL Working Template
>> hwt : "HPCVL Working Template" <<
hwt :			PATH += "/opt/hwt/hwt.v7.2.hpcvl.intel";

>> matlab : "" <<
matlab :			PATH += "/opt/matlab/R2010b/64-bit/bin";

>> matlab-2014a : "" <<
matlab-2014a :			PATH += "/opt/matlab/R2014a/bin";

>> mpich-1 : "MPICH-1 (newest)" <<
mpich-1 * Linux :		PATH += "/opt/mpich-1/script:/opt/mpich-1/bin",
				MPICH_HOME += "/opt/mpich-1",
				MANPATH += "/opt/mpich-1/man",
				P4_RSHCOMMAND = "rsh";

>> namd : "NAMD (current version)" <<
namd <= namd-2.10 : <[ /bin/true ]> ;

>> namd-2.10 : "NAMD 2.10" <<
namd-2.10 :	PATH += "/opt/namd/NAMD_2.10_Linux-x86_64-multicore";

>> nwchem-6.1 : "NWChem 6.1" <<
nwchem-6.1 : 			PATH += "/opt/nwchem/nwchem-6.1/bin/LINUX64",
                        	<[ source /opt/ics/bin/compilervars.sh  intel64 ]> ,
                        	<[ source /opt/ics/impi/4.0.3.008/bin64/mpivars.sh ]> ;


>> nwchem : "NWChem (current)" <<
nwchem <= nwchem-6.1 : 			<[ /bin/true ]> ;

>> lammps : "LAMMPS default version" <<
lammps <= lammps_64bit :                <[ /bin/true ]> ;

>> lammps_64bit : "LAMMPS (Dec 2013) 64 bit Intel" <<
lammps_64bit <= ics :		LAMMPSDIR = "/opt/lammps/1Dec13/64bit",
				PATH += "/opt/lammps/1Dec13/64bit" ;

>> lammps_aug15 : "LAMMPS (August 2015) 64 bit gcc/openmpi 1.8" <<
lammps_aug15 <= openmpi :	LAMMPSDIR = "/opt/lammps/10Aug15",
				PATH += "/opt/lammps/10Aug15/bin" ;

>> petsc-intel : "PETSc scientific library (current version, Intel compilers/MPI)" <<
petsc-intel <= petsc-3.6.0-intel :      <[ /bin/true ]>;

>> petsc : "PETSc scientific library (current version)" <<
petsc <= petsc-3.5.2 :			<[ /bin/true ]>;

>> petsc-3.5.2 : "PETSc scientific library (version 3.5.2 using OpenMPI 1.8, gcc 4.4.6" <<
petsc-3.5.2 <= openmpi-1.8 :	PETSC_DIR = "/opt/petsc/3.5.2",
				PETSC_ARCH = "",
				PATH += "/opt/petsc/3.5.2/bin";


>> petsc-3.6.0-intel : "PETSc scientific library (version 3.6.0 using Intel compilers and MPI" <<
petsc-3.6.0-intel <= icsmpi :   PETSC_DIR = "/opt/petsc/3.6.0-linux",
				PETSC_ARCH = "linux-gnu-intel",
				PATH += "/opt/petsc/3.6.0-intel/bin";

### Empty path: ###
>> none : "empty paths" <<
none :				PATH = "",
				MANPATH = "",
				INFOPATH = "",
				LD_LIBRARY_PATH = "",
				PKG_CONFIG_PATH = "";
none * Darwin :			DYLD_LIBRARY_PATH = "" ;

#>> site : "Locally installed commands" <<
#site :				PATH += /opt/local/bin,
#				MANPATH += /opt/local/man,
#				INFOPATH += /opt/local/share/info;

>> orca : "orca (production - r2131)" <<
orca <= openmpi :		PATH += "/opt/orca/r2131/64-bit";

>> orca-2360 : "orca (production - r2360)" <<
orca-2360 <= openmpi :		PATH += "/opt/orca/r2360/64-bit";

>> openmpi-1.2 : "openmpi (development - v1.2)" <<
openmpi-1.2 :			PATH += /opt/openmpi-1.2/bin,
				MANPATH += /opt/openmpi-1.2/man,
				LD_LIBRARY_PATH += /opt/openmpi-1.2/lib;

>> openmpi-1.8 : "openmpi (development - v1.8)" <<
openmpi-1.8 :			PATH += /opt/openmpi-1.8/bin,
				MANPATH += /opt/openmpi-1.8/man,
				LD_LIBRARY_PATH += /opt/openmpi-1.8/lib;

>> openmpi : "openmpi (default version)" <<
openmpi <= openmpi-1.8 :	<[ /bin/true ]> ;

>> openmpi-1.8.4 : "openmpi (development - v1.8.4)" <<
openmpi-1.8.4 :			PATH += /opt/openmpi/1.8.4/bin,
				MANPATH += /opt/openmpi/1.8.4/man,
				LD_LIBRARY_PATH += /opt/openmpi/1.8.4/lib;

>> paraview : "Paraview (current version)" <<
paraview <= paraview-4.3 :	<[ /bin/true ]> ;

>> paraview-4.3 : "Paraview (64 bit version 1.4)" <<
paraview-4.3 :			PATH += /opt/paraview/ParaView-4.3.1-Linux-64bit/bin;

>> pyzo2015a : "Pyzo Python distribution (includes numpy & scipy)" <<
pyzo2015a :			PATH += /opt/python/pyzo2015a/bin,
				LD_LIBRARY_PATH += /opt/python/pyzo2015a/lib;

>> python-3.4 : "Python (version 3.4.3)" <<
python-3.4 :			PATH += /opt/python/3.4.3/bin,
				LD_LIBRARY_PATH += /opt/python/3.4.3/lib;

>> PyRx : "PyRx 0.9.2 Drug Screening Software" <<
PyRx :			PATH += /opt/PyRx/0.9.2;

>> PyRx-0.9 : "PyRx 0.9 Drug Screening Software" <<
PyRx-0.9 :			PATH += /usr/local/PyRx-0.9;

>> R : "R statistical software (system version)" <<
R <= R-3.2.3 :        <[ /bin/true ]> ;

>> R-2.15.2 : "R statistical software (older version, 32-bit)" <<
R-2.15.2 :              PATH += /opt/R/2.15.2/32bit/bin,
                        MANPATH += /opt/R-2.15.2/32bit/share/man,
                        INFOPATH += /opt/R-2.15.2/32bit/info ;

>> R-2.15.2_64bit : "R statistical software (older version, 64-bit)" <<
R-2.15.2_64bit :        PATH += /opt/R/2.15.2/64bit/bin,
                        MANPATH += /opt/R-2.15.2/64bit/share/man,
                        INFOPATH += /opt/R-2.15.2/64bit/info ;

>> R-3.2.3 : "R version 3.2.3 (64-bit)" <<
R-3.2.3 :        PATH += /opt/R/3.2.3/R-3.2.3/bin;


>> weka : "Java based data mining (version 3.6)" <<
weka :			PATH += /opt/weka/3.6.12;

#############################
#### begin jeff entries #####
############################

>> abyss : "ABySS 1.9.0" <<
abyss : PATH += "/opt/abyss/1.9.0/bin";

# bowtie2 & original bowtie
>> bowtie2 : "Bowtie2 (current version)" <<
bowtie2 <= bowtie2-2.2.6 : <[ /bin/true ]> ;

>> bowtie2-2.2.6 : "Bowtie2 2.2.6" <<
bowtie2-2.2.6 :	PATH += "/opt/bowtie2/2.2.6/bowtie2-2.2.6";

>> bowtie : "Bowtie (VERSION 1!!!)" <<
bowtie <= bowtie-1.1.2 : <[ /bin/true ]> ;

>> bowtie-1.1.2 : "Bowtie 1.1.2" <<
bowtie-1.1.2 :	PATH += "/opt/bowtie2/1.1.2/bowtie-1.1.2";

# samtools
>> samtools : "SAMtools (current version)" <<
samtools <= samtools-1.3 : <[ /bin/true ]> ;

>> samtools-0.1.19 : "SAMtools 0.1.19" <<
samtools-0.1.19 :	PATH += "/opt/samtools/0.1.19/bin";

>> samtools-1.3 : "SAMtools 1.3" <<
samtools-1.3 :	PATH += "/opt/samtools/1.3/bin";

# bwa
>> bwa : "BWA (current version)" <<
bwa <= bwa-0.7.12 : <[ /bin/true ]> ;

>> bwa-0.7.12 : "BWA 0.7.12" <<
bwa-0.7.12 :	PATH += "/opt/bwa/0.7.12";

# hmmer 
>> hmmer : "HMMER (current version)" <<
hmmer <= hmmer-3.1b2 : <[ /bin/true ]> ;

>> hmmer-3.1b2 : "HMMER 3.1b2" <<
hmmer-3.1b2 :	PATH += "/opt/hmmer/3.1b2/hmmer-3.1b2-linux-intel-x86_64/binaries";

# beast
>> beast : "BEAST (current version)" <<
beast <= beast-1.8.2 : <[ /bin/true ]> ;

>> beast-1.8.2 : "BEAST 1.8.2" <<
beast-1.8.2 :	PATH += "/opt/beast/1.8.2/BEASTv1.8.2/bin";

# fastqc 
>> fastqc : "FastQC (current version)" <<
fastqc <= fastqc-0.11.4 : <[ /bin/true ]> ;

>> fastqc-0.11.4 : "FastQC 0.11.4" <<
fastqc-0.11.4 :	PATH += "/opt/fastqc/0.11.4/FastQC";

>> freesurfer : "FreeSurfer" <<
freesurfer :	PATH += "/opt/freesurfer/freesurfer/bin",
		FREESURFER_HOME += "/opt/freesurfer/freesurfer",
		<[source $FREESURFER_HOME/SetUpFreeSurfer.sh]>;

>> fsl : "FSL 5.0.9" <<
fsl :	PATH += "/opt/fsl/5.0.9/fsl/bin",
	FSLDIR += "/opt/fsl/5.0.9/fsl",
	<[source ${FSLDIR}/etc/fslconf/fsl.sh]>;

>> java8 : "Java 8" <<
java8 :	PATH += "/opt/java/1.8/jdk1.8.0_65/bin";

>> mrtrix : "mrtrix3" <<
mrtrix <= anaconda2 :	PATH += "/opt/mrtrix/mrtrix3/bin",
			PATH += "/opt/mrtrix/mrtrix3/scripts";

>> samtstat : "samstat 1.5.1" <<
samstat :	PATH += "/opt/samstat/1.5.1/samstat-1.5.1/bin";

# seqtk 
>> seqtk : "seqtk (current version)" <<
seqtk :	PATH += "/opt/seqtk/bin";

# sratoolkit
>> sratoolkit : "SRA Toolkit (current version)" <<
sratoolkit <= sratoolkit-2.5.7 : <[ /bin/true ]> ;

>> sratoolkit-2.5.7 : "SRA Toolkit 2.5.7" <<
sratoolkit-2.5.7 :	PATH += "/opt/sratoolkit/2.5.7/sratoolkit.2.5.7-centos_linux64/bin";

>> star : "STAR 2.5.1b" <<
star : PATH += "/opt/star/2.5.1b/STAR/bin/Linux_x86_64_static";

# trinity - rewrite later for multiple deps?
>> trinity : "Trinity (current version)" <<
trinity <= trinity-2.1.1 : <[ /bin/true ]> ;

>> trinity-2.1.1 : "Trinity 2.1.1" <<
trinity-2.1.1 :	PATH += "/opt/trinity/2.1.1/trinityrnaseq-2.1.1",
				PATH += "/opt/bowtie2/1.1.2/bowtie-1.1.2";

>> tophat2 : "Tophat2 (current version)" <<
tophat2 <= tophat2-2.1.0 : <[ /bin/true ]> ;

>> tophat2-2.1.0 : "Tophat2 2.1.0" <<
tophat2-2.1.0 : PATH += "/opt/tophat2/2.1.0/tophat-2.1.0.Linux_x86_64",
		PATH += "/opt/bowtie2/2.2.6/bowtie2-2.2.6",
		PATH += "/opt/samtools/1.3/bin";

# cufflinks
>> cufflinks : "Cufflinks (current version)" <<
cufflinks <= cufflinks-2.2.1 : <[ /bin/true ]> ;

>> cufflinks-2.2.1 : "Cufflinks 2.2.1" <<
cufflinks-2.2.1 :	PATH += "/opt/cufflinks/2.2.1/cufflinks-2.2.1.Linux_x86_64";

# stacks
>> stacks : "Stacks (current version)" <<
stacks <= stacks-1.35 : <[ /bin/true ]> ;

>> stacks-1.35 : "Stacks 1.35" <<
stacks-1.35 :	PATH += "/opt/stacks/1.35/bin/bin";

#plink is actually already on $PATH but is old 1.07 version
>> plink-1.9 : "PLINK 1.9 beta 3.30" <<
plink-1.9 : 	PATH += "/opt/plink/1.9-beta3.30";

>> plink-seq : "PLINK/SEQ 0.10" <<
plink-seq :	PATH += "/opt/plink/plink-seq/plinkseq-0.10";

# fbat
>> fbat-2.0.4 : "FBAT 2.0.4" <<
fbat-2.0.4 :	PATH += "/opt/fbat/2.0.4";

########################
### end jeff entries ###
########################


# "root" version 5.34.20

root :			ROOTSYS = /opt/ROOT/5.34.20/root ,
			PATH += $ROOTSYS/bin ,
			LD_LIBRARY_PATH += $ROOTSYS/lib ;

# Sun Grid Engine 6 
>> sge6 : "Sun Grid Engine 6" <<
sge6 * * * * bash :            <[ . /opt/n1ge6/default/common/settings.sh ]> ;
sge6 * * * * sh :              <[ . /opt/n1ge6/default/common/settings.sh ]> ;
sge6 * * * * ksh :              <[ . /opt/n1ge6/default/common/settings.sh ]> ;
sge6 * * * * csh :             <[ source /opt/n1ge6/default/common/settings.csh ]> ;
sge6 * * * * tcsh :            <[ source /opt/n1ge6/default/common/settings.csh ]> ;

# System administration binaries
>> sysadm : "system administration commands" <<
sysadm :			PATH += /usr/sbin:/sbin ;


### Standard things that everyone should have: ###
>> system : "Standard Linux commands" <<
system :			PATH += /usr/bin,
				MANPATH += /usr/share/man,
				INFOPATH += /usr/share/info;


### Include user's own packages information: ###
(include ~/.packages)
