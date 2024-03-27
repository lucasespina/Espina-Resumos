from cocotb_test.simulator import run
import pytest
import os

from telemetry import telemetryMark
pytestmark = telemetryMark()


def source(name):
	dir = os.path.dirname(__file__)
	src_dir = os.path.join(dir, 'src' )
	return os.path.join(src_dir, name)

@pytest.mark.telemetry_files(source('alarme.vhd'))
def test_alarme():
    run(vhdl_sources=[source("alarme.vhd")], toplevel="alarme", module="av2_cocotb" , testcase='tb_alarme', toplevel_lang="vhdl")

@pytest.mark.telemetry_files(source('add4.vhd'))
def test_add4():
    run(vhdl_sources=[source("add4.vhd")], toplevel="add4", module="av2_cocotb" , testcase='tb_add4', toplevel_lang="vhdl")

@pytest.mark.telemetry_files(source('circuito.vhd'),source('flipflopd.vhd'))
def test_circuito():
    run(vhdl_sources=[source("circuito.vhd"),source('flipflopd.vhd')], toplevel="circuito", module="av2_cocotb" , testcase='tb_circuito', toplevel_lang="vhdl")

if __name__ == "__main__":
    test_alarme()
    test_add4()
    test_circuito()
