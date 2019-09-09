PRJ=tests_strings_services.gpr
EXE=tests_strings_services-run.exe

all: compil run

compil::
	gprbuild.exe -j4 -g -gnatef $(PRJ)

clean::
	gprclean.exe $(PRJ)

run::
	bin/$(EXE)
