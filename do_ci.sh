source .venv/bin/activate
cd nuttx
make distclean -j
./tools/configure.sh sim:citest
make -j
cd tools/ci/testrun/script
python3 -m pytest -m 'common or sim' ./ -B sim -P /home/tbennett/H5NuttxPort/nuttx -L /home/tbennett/H5NuttxPort/ci_logs -R sim -C --json=/home/tbennett/H5NuttxPort/ci_logs/pytest.json

cd ../../../..