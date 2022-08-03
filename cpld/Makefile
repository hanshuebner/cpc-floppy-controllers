project_name ?= cpc-fdc-cpld
target ?= xc9572xl-5-VQ64

# alternative speed, density
optimize ?= speed

all: lso synthesis ngdbuild cpldfit tsim jedec

lso:
	echo "work" > ${project_name}.lso

# Synthesis
synthesis:  ${project_name}.xst ${project_name}.lso
	if [ ! -d tmp ] ; then mkdir tmp ; fi
	xst -ifn ./${project_name}.xst -intstyle xflow -ofn ./${project_name}.syr


ngdbuild: ${project_name}.ucf ${project_name}.ngc 
	ngdbuild -dd _ngo -p ${target} -uc ${project_name}.ucf ${project_name}.ngc  ${project_name}.ngd


# Fit the selected device and generate reports
cpldfit:  ${project_name}.ngd
	cpldfit -p ${target} \
	    -ofmt vhdl \
	    -optimize ${optimize} \
	    -loc on \
	    -slew slow \
	    -init low \
	    -inputs 22 \
	    -pterms 24 \
	    -power std \
	    -exhaust ${project_name}.ngd

# Run the TA engine and generate reports
tsim:   
	tsim ${project_name} ${project_name}.nga
	taengine -f ${project_name} -detail

# Generate the JEDEC file for programming
jedec: 
	hprep6  -s IEEE1149 -n ${project_name} -i ${project_name}
	mv ${project_name}.jed ${project_name}_${target}.jed

# dump a verilog netlist
netgen:
	netgen -w -ofmt verilog  -aka ${project_name}.ngd



clean:
	$(RM) -fr _ngo/ \
		_xmsgs/ \
		cpc-fdc-cpld.bld \
		cpc-fdc-cpld.gyd \
		cpc-fdc-cpld.lso \
		cpc-fdc-cpld.mfd \
		cpc-fdc-cpld.nga \
		cpc-fdc-cpld.ngd \
		cpc-fdc-cpld.nlf \
		cpc-fdc-cpld.pad \
		cpc-fdc-cpld.pnx \
		cpc-fdc-cpld.rpt \
		cpc-fdc-cpld.syr \
		cpc-fdc-cpld.tim \
		cpc-fdc-cpld.vm6 \
		cpc-fdc-cpld.xml \
		cpc-fdc-cpld_build.xml \
		cpc-fdc-cpld_ngdbuild.xrpt \
		cpc-fdc-cpld_pad.csv \
		cpc-fdc-cpld_xc9572xl-5-VQ64.jed \
		cpc-fdc-cpld_xst.xrpt \
		tmperr.err \
		CPC_FDC.lso \
		cpc-fdc-cpld.ngc \
		cpc-fdc-cpld.ngr \
		tmperr.err \
		xlnx_auto_0_xdb/ \
		xst/ \
		*~
