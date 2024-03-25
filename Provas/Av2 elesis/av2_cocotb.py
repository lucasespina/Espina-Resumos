# Adapted from https://github.com/cocotb/cocotb/blob/master/examples/doc_examples/quickstart/test_my_design.py

import cocotb
from cocotb.triggers import Timer, FallingEdge
from cocotb.clock import Clock

@cocotb.test()
async def tb_alarme(dut):

    inA =   [0, 1, 1, 0, 1, 0, 0, 1, 0, 0]
    inB =   [0, 0, 1, 1, 0, 0, 1, 1, 0, 0]
    inC =   [0, 0, 0, 0, 0, 0, 1, 1, 1, 1]
    inD =   [0, 0, 0, 0, 1, 1, 0, 1, 0, 0]
    inE =   [0, 0, 0, 0, 0, 1, 1, 1, 0, 1]
    inF =   [0, 0, 0, 0, 0, 0, 1, 1, 0, 1]
    inG =   [0, 0, 0, 0, 0, 1, 0, 1, 1, 0]
    outS =  [0, 0, 1, 0, 0, 1, 1, 1, 0, 1]


    for i in range(len(inA)):
        dut.A.value = inA[i]
        dut.B.value = inB[i]
        dut.C.value = inC[i]
        dut.D.value = inD[i]
        dut.E.value = inE[i]
        dut.F.value = inF[i]
        dut.G.value = inG[i]

        await Timer(1, units="ns")
        condition = (dut.S.value == outS[i])
        if not condition:
            dut._log.error("Expected value: " + "{0:b}".format(outS[i]) + " Obtained value: " + str(dut.S.value) )
            assert condition, "Error in test {0}!".format(i)
        await Timer(1, units="ns")
        
        
@cocotb.test()
async def tb_add4(dut):

    inA = [0b0000, 0b0001, 0b0001, 0b0101, 0b1001, 0b0111, 0b1111, 0b0000]
    inB = [0b0000, 0b0000, 0b0001, 0b0001, 0b0001, 0b0100, 0b1111, 0b0001]
    outq =[0b0000, 0b0001, 0b0010, 0b0110, 0b1010, 0b1011, 0b1110, 0b0001]
    
    for i in range(len(inA)):
        dut.a.value = inA[i]
        dut.b.value = inB[i]

        await Timer(1, units="ns")
        condition = (dut.q.value == outq[i])
        if not condition:
            dut._log.error("Expected value: " + "{0:016b}".format(outq[i]) + " Obtained value: " + str(dut.q.value) )
            assert condition, "Error in test {0}!".format(i)
        await Timer(1, units="ns")


@cocotb.test()
async def tb_circuito(dut):

    inUp     = [   1,    1,    1,    1,    0,    0,    0]
    outGray  = [0b01, 0b11, 0b10, 0b00, 0b10, 0b11, 0b01]
    
    clock = Clock(dut.clock, len(inUp), units="ns")
    await cocotb.start(clock.start())    

    await FallingEdge(dut.clock)
    for i in range(len(inUp)):
        dut.Up.value = inUp[i]

        await FallingEdge(dut.clock)

        condition = (dut.Gray.value == outGray[i])
        if not condition:
            dut._log.error("Expected value: " + "{0:b}".format(outGray[i]) + " Obtained value: " + str(dut.Gray.value) )
            assert condition, "Error in test {0}!".format(i)

