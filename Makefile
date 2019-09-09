PRJ=strings_services.gpr

all: compil

compil::
	gprbuild.exe -j4 -g -gnatef $(PRJ)

clean::
	gprclean.exe $(PRJ)
