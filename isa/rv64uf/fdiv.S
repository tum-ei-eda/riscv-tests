# See LICENSE for license details.

#*****************************************************************************
# fdiv.S
#-----------------------------------------------------------------------------
#
# Test f{div|sqrt}.s instructions.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UF
RVTEST_CODE_BEGIN

#define TEST_FP_OP2_S_RM( testnum, inst, rm, flags, result, val1, val2 ) \
  TEST_FP_OP_S_INTERNAL( testnum, flags, float result, val1, val2, 0.0, \
                    inst f3, f0, f1, rm; fmv.x.s a0, f3)

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_FP_OP2_S(2,  fdiv.s, 1, 1.1557273520668288, 3.14159265, 2.71828182 );
  TEST_FP_OP2_S(3,  fdiv.s, 1,-0.9991093838555584,      -1234,     1235.1 );
  TEST_FP_OP2_S(4,  fdiv.s, 0,         3.14159265, 3.14159265,        1.0 );

  TEST_FP_OP1_S(5,  fsqrt.s, 1, 1.7724538498928541, 3.14159265 );
  TEST_FP_OP1_S(6,  fsqrt.s, 0,                100,      10000 );

  TEST_FP_OP1_S_DWORD_RESULT(7,  fsqrt.s, 0x10, 0x7FC00000, -1.0 );

  TEST_FP_OP1_S(8,  fsqrt.s, 1, 13.076696, 171.0);

  TEST_FP_OP2_S_RM(9,  fdiv.s, rne, 1, 0.8000000119209289, 4.0, 5.0);
  TEST_FP_OP2_S_RM(10, fdiv.s, rtz, 1, 0.7999999523162841, 4.0, 5.0);
  TEST_FP_OP2_S_RM(11, fdiv.s, rdn, 1, 0.7999999523162841, 4.0, 5.0);
  TEST_FP_OP2_S_RM(12, fdiv.s, rup, 1, 0.8000000119209289, 4.0, 5.0);
  TEST_FP_OP2_S_RM(13, fdiv.s, rmm, 1, 0.8000000119209289, 4.0, 5.0);

  fsrmi 0;
  TEST_FP_OP2_S(14, fdiv.s, 1, 0.8000000119209289, 4.0, 5.0);
  fsrmi 1;
  TEST_FP_OP2_S(15, fdiv.s, 1, 0.7999999523162841, 4.0, 5.0);
  fsrmi 2;
  TEST_FP_OP2_S(16, fdiv.s, 1, 0.7999999523162841, 4.0, 5.0);
  fsrmi 3;
  TEST_FP_OP2_S(17, fdiv.s, 1, 0.8000000119209289, 4.0, 5.0);
  fsrmi 4;
  TEST_FP_OP2_S(18, fdiv.s, 1, 0.8000000119209289, 4.0, 5.0);

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
