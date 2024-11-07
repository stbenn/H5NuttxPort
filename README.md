# H5NuttxPort


## Utility Files/Functions

### `build_h5nsh.sh`
This bash script does a distclean, configures the nucleo-h563zi:nsh configuration,
and then runs `make -j` to build it. This can be usefull when changing file names, 
as everything must be cleaned and rebuilt when this is done. 

### `do_ci.sh`
Run the python local ci using the sim target. This is *NOT* the same as the CI
that is run when making a pull request. Must have created a python virtual
environment named `.venv` in the base directory (where this README.md file is stored),
and pip installed the `py_requirements.txt` file.

### Nxstyle Check
`nxstyle_check.sh` automates style checking files with Nxstyle. It will make 
nxstyle and then recursively call it on all files that are within an H5 directory:
- `nuttx/arch/arm/src/stm32h5`
- `nuttx/arch/arm/include/stm32h5`
- `nuttx/boards/arm/stm32h5`

If there is a file outside of these directories that was changed, you will need
to run nxstyle on that file separately. 

### Running Pull Request CI through Docker
`pr_ci_run.sh` and `pr_ci_log_cleanup.sh` are used to run some of the pull request
CI through a docker container locally. The former runs the docker container, the
later cleans up a log file if you stored the output to a file.

