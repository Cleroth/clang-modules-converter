# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=znver3 -iterations=1000 -timeline -register-file-stats < %s | FileCheck %s

# LLVM-MCA-BEGIN
fxch %st(0)
fxch %st(1)
fxch %st(2)
fxch %st(3)
fxch %st(4)
fxch %st(5)
fxch %st(6)
fxch %st(7)
fxch %st(0)
# LLVM-MCA-END

# CHECK:      [0] Code Region

# CHECK:      Iterations:        1000
# CHECK-NEXT: Instructions:      9000
# CHECK-NEXT: Total Cycles:      9000
# CHECK-NEXT: Total uOps:        9000

# CHECK:      Dispatch Width:    6
# CHECK-NEXT: uOps Per Cycle:    1.00
# CHECK-NEXT: IPC:               1.00
# CHECK-NEXT: Block RThroughput: 9.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     1.00                  U     fxch	%st(0)
# CHECK-NEXT:  1      1     1.00                  U     fxch	%st(1)
# CHECK-NEXT:  1      1     1.00                  U     fxch	%st(2)
# CHECK-NEXT:  1      1     1.00                  U     fxch	%st(3)
# CHECK-NEXT:  1      1     1.00                  U     fxch	%st(4)
# CHECK-NEXT:  1      1     1.00                  U     fxch	%st(5)
# CHECK-NEXT:  1      1     1.00                  U     fxch	%st(6)
# CHECK-NEXT:  1      1     1.00                  U     fxch	%st(7)
# CHECK-NEXT:  1      1     1.00                  U     fxch	%st(0)

# CHECK:      Register File statistics:
# CHECK-NEXT: Total number of mappings created:    9000
# CHECK-NEXT: Max number of mappings used:         100

# CHECK:      *  Register File #1 -- Zn3FpPRF:
# CHECK-NEXT:    Number of physical registers:     160
# CHECK-NEXT:    Total number of mappings created: 0
# CHECK-NEXT:    Max number of mappings used:      0

# CHECK:      *  Register File #2 -- Zn3IntegerPRF:
# CHECK-NEXT:    Number of physical registers:     192
# CHECK-NEXT:    Total number of mappings created: 0
# CHECK-NEXT:    Max number of mappings used:      0

# CHECK:      Resources:
# CHECK-NEXT: [0]   - Zn3AGU0
# CHECK-NEXT: [1]   - Zn3AGU1
# CHECK-NEXT: [2]   - Zn3AGU2
# CHECK-NEXT: [3]   - Zn3ALU0
# CHECK-NEXT: [4]   - Zn3ALU1
# CHECK-NEXT: [5]   - Zn3ALU2
# CHECK-NEXT: [6]   - Zn3ALU3
# CHECK-NEXT: [7]   - Zn3BRU1
# CHECK-NEXT: [8]   - Zn3FP0
# CHECK-NEXT: [9]   - Zn3FP1
# CHECK-NEXT: [10]  - Zn3FP2
# CHECK-NEXT: [11]  - Zn3FP3
# CHECK-NEXT: [12.0] - Zn3FP45
# CHECK-NEXT: [12.1] - Zn3FP45
# CHECK-NEXT: [13]  - Zn3FPSt
# CHECK-NEXT: [14.0] - Zn3LSU
# CHECK-NEXT: [14.1] - Zn3LSU
# CHECK-NEXT: [14.2] - Zn3LSU
# CHECK-NEXT: [15.0] - Zn3Load
# CHECK-NEXT: [15.1] - Zn3Load
# CHECK-NEXT: [15.2] - Zn3Load
# CHECK-NEXT: [16.0] - Zn3Store
# CHECK-NEXT: [16.1] - Zn3Store

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12.0] [12.1] [13]   [14.0] [14.1] [14.2] [15.0] [15.1] [15.2] [16.0] [16.1]
# CHECK-NEXT:  -      -      -     9.00   9.00   9.00   9.00    -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12.0] [12.1] [13]   [14.0] [14.1] [14.2] [15.0] [15.1] [15.2] [16.0] [16.1] Instructions:
# CHECK-NEXT:  -      -      -     1.00   1.00   1.00   1.00    -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -     fxch	%st(0)
# CHECK-NEXT:  -      -      -     1.00   1.00   1.00   1.00    -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -     fxch	%st(1)
# CHECK-NEXT:  -      -      -     1.00   1.00   1.00   1.00    -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -     fxch	%st(2)
# CHECK-NEXT:  -      -      -     1.00   1.00   1.00   1.00    -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -     fxch	%st(3)
# CHECK-NEXT:  -      -      -     1.00   1.00   1.00   1.00    -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -     fxch	%st(4)
# CHECK-NEXT:  -      -      -     1.00   1.00   1.00   1.00    -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -     fxch	%st(5)
# CHECK-NEXT:  -      -      -     1.00   1.00   1.00   1.00    -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -     fxch	%st(6)
# CHECK-NEXT:  -      -      -     1.00   1.00   1.00   1.00    -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -     fxch	%st(7)
# CHECK-NEXT:  -      -      -     1.00   1.00   1.00   1.00    -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -     fxch	%st(0)

# CHECK:      Timeline view:
# CHECK-NEXT:                     0123456789          0123456789          0123456789          0123456789
# CHECK-NEXT: Index     0123456789          0123456789          0123456789          0123456789

# CHECK:      [0,0]     DeER .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(0)
# CHECK-NEXT: [0,1]     DeER .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(1)
# CHECK-NEXT: [0,2]     DeER .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(2)
# CHECK-NEXT: [0,3]     DeER .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(3)
# CHECK-NEXT: [0,4]     D====eER  .    .    .    .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(4)
# CHECK-NEXT: [0,5]     D====eER  .    .    .    .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(5)
# CHECK-NEXT: [0,6]     .D===eER  .    .    .    .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(6)
# CHECK-NEXT: [0,7]     .D===eER  .    .    .    .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(7)
# CHECK-NEXT: [0,8]     .D=======eER   .    .    .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(0)
# CHECK-NEXT: [1,0]     .D=======eER   .    .    .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(0)
# CHECK-NEXT: [1,1]     .D=======eER   .    .    .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(1)
# CHECK-NEXT: [1,2]     .D=======eER   .    .    .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(2)
# CHECK-NEXT: [1,3]     . D==========eER    .    .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(3)
# CHECK-NEXT: [1,4]     . D==========eER    .    .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(4)
# CHECK-NEXT: [1,5]     . D==========eER    .    .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(5)
# CHECK-NEXT: [1,6]     . D==========eER    .    .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(6)
# CHECK-NEXT: [1,7]     . D==============eER.    .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(7)
# CHECK-NEXT: [1,8]     . D==============eER.    .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(0)
# CHECK-NEXT: [2,0]     .  D=============eER.    .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(0)
# CHECK-NEXT: [2,1]     .  D=============eER.    .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(1)
# CHECK-NEXT: [2,2]     .  D=================eER .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(2)
# CHECK-NEXT: [2,3]     .  D=================eER .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(3)
# CHECK-NEXT: [2,4]     .  D=================eER .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(4)
# CHECK-NEXT: [2,5]     .  D=================eER .    .    .    .    .    .    .    .    .    .    .   .   fxch	%st(5)
# CHECK-NEXT: [2,6]     .   D====================eER  .    .    .    .    .    .    .    .    .    .   .   fxch	%st(6)
# CHECK-NEXT: [2,7]     .   D====================eER  .    .    .    .    .    .    .    .    .    .   .   fxch	%st(7)
# CHECK-NEXT: [2,8]     .   D====================eER  .    .    .    .    .    .    .    .    .    .   .   fxch	%st(0)
# CHECK-NEXT: [3,0]     .   D====================eER  .    .    .    .    .    .    .    .    .    .   .   fxch	%st(0)
# CHECK-NEXT: [3,1]     .   D========================eER   .    .    .    .    .    .    .    .    .   .   fxch	%st(1)
# CHECK-NEXT: [3,2]     .   D========================eER   .    .    .    .    .    .    .    .    .   .   fxch	%st(2)
# CHECK-NEXT: [3,3]     .    D=======================eER   .    .    .    .    .    .    .    .    .   .   fxch	%st(3)
# CHECK-NEXT: [3,4]     .    D=======================eER   .    .    .    .    .    .    .    .    .   .   fxch	%st(4)
# CHECK-NEXT: [3,5]     .    D===========================eER    .    .    .    .    .    .    .    .   .   fxch	%st(5)
# CHECK-NEXT: [3,6]     .    D===========================eER    .    .    .    .    .    .    .    .   .   fxch	%st(6)
# CHECK-NEXT: [3,7]     .    D===========================eER    .    .    .    .    .    .    .    .   .   fxch	%st(7)
# CHECK-NEXT: [3,8]     .    D===========================eER    .    .    .    .    .    .    .    .   .   fxch	%st(0)
# CHECK-NEXT: [4,0]     .    .D==============================eER.    .    .    .    .    .    .    .   .   fxch	%st(0)
# CHECK-NEXT: [4,1]     .    .D==============================eER.    .    .    .    .    .    .    .   .   fxch	%st(1)
# CHECK-NEXT: [4,2]     .    .D==============================eER.    .    .    .    .    .    .    .   .   fxch	%st(2)
# CHECK-NEXT: [4,3]     .    .D==============================eER.    .    .    .    .    .    .    .   .   fxch	%st(3)
# CHECK-NEXT: [4,4]     .    .D==================================eER .    .    .    .    .    .    .   .   fxch	%st(4)
# CHECK-NEXT: [4,5]     .    .D==================================eER .    .    .    .    .    .    .   .   fxch	%st(5)
# CHECK-NEXT: [4,6]     .    . D=================================eER .    .    .    .    .    .    .   .   fxch	%st(6)
# CHECK-NEXT: [4,7]     .    . D=================================eER .    .    .    .    .    .    .   .   fxch	%st(7)
# CHECK-NEXT: [4,8]     .    . D=====================================eER  .    .    .    .    .    .   .   fxch	%st(0)
# CHECK-NEXT: [5,0]     .    . D=====================================eER  .    .    .    .    .    .   .   fxch	%st(0)
# CHECK-NEXT: [5,1]     .    . D=====================================eER  .    .    .    .    .    .   .   fxch	%st(1)
# CHECK-NEXT: [5,2]     .    . D=====================================eER  .    .    .    .    .    .   .   fxch	%st(2)
# CHECK-NEXT: [5,3]     .    .  D========================================eER   .    .    .    .    .   .   fxch	%st(3)
# CHECK-NEXT: [5,4]     .    .  D========================================eER   .    .    .    .    .   .   fxch	%st(4)
# CHECK-NEXT: [5,5]     .    .  D========================================eER   .    .    .    .    .   .   fxch	%st(5)
# CHECK-NEXT: [5,6]     .    .  D========================================eER   .    .    .    .    .   .   fxch	%st(6)
# CHECK-NEXT: [5,7]     .    .  D============================================eER    .    .    .    .   .   fxch	%st(7)
# CHECK-NEXT: [5,8]     .    .  D============================================eER    .    .    .    .   .   fxch	%st(0)
# CHECK-NEXT: [6,0]     .    .   D===========================================eER    .    .    .    .   .   fxch	%st(0)
# CHECK-NEXT: [6,1]     .    .   D===========================================eER    .    .    .    .   .   fxch	%st(1)
# CHECK-NEXT: [6,2]     .    .   D===============================================eER.    .    .    .   .   fxch	%st(2)
# CHECK-NEXT: [6,3]     .    .   D===============================================eER.    .    .    .   .   fxch	%st(3)
# CHECK-NEXT: [6,4]     .    .   D===============================================eER.    .    .    .   .   fxch	%st(4)
# CHECK-NEXT: [6,5]     .    .   D===============================================eER.    .    .    .   .   fxch	%st(5)
# CHECK-NEXT: [6,6]     .    .    D==================================================eER .    .    .   .   fxch	%st(6)
# CHECK-NEXT: [6,7]     .    .    D==================================================eER .    .    .   .   fxch	%st(7)
# CHECK-NEXT: [6,8]     .    .    D==================================================eER .    .    .   .   fxch	%st(0)
# CHECK-NEXT: [7,0]     .    .    D==================================================eER .    .    .   .   fxch	%st(0)
# CHECK-NEXT: [7,1]     .    .    D======================================================eER  .    .   .   fxch	%st(1)
# CHECK-NEXT: [7,2]     .    .    D======================================================eER  .    .   .   fxch	%st(2)
# CHECK-NEXT: [7,3]     .    .    .D=====================================================eER  .    .   .   fxch	%st(3)
# CHECK-NEXT: [7,4]     .    .    .D=====================================================eER  .    .   .   fxch	%st(4)
# CHECK-NEXT: [7,5]     .    .    .D=========================================================eER   .   .   fxch	%st(5)
# CHECK-NEXT: [7,6]     .    .    .D=========================================================eER   .   .   fxch	%st(6)
# CHECK-NEXT: [7,7]     .    .    .D=========================================================eER   .   .   fxch	%st(7)
# CHECK-NEXT: [7,8]     .    .    .D=========================================================eER   .   .   fxch	%st(0)
# CHECK-NEXT: [8,0]     .    .    . D============================================================eER   .   fxch	%st(0)
# CHECK-NEXT: [8,1]     .    .    . D============================================================eER   .   fxch	%st(1)
# CHECK-NEXT: [8,2]     .    .    . D============================================================eER   .   fxch	%st(2)
# CHECK-NEXT: [8,3]     .    .    . D============================================================eER   .   fxch	%st(3)
# CHECK-NEXT: [8,4]     .    .    . D================================================================eER   fxch	%st(4)
# CHECK-NEXT: [8,5]     .    .    . D================================================================eER   fxch	%st(5)
# CHECK-NEXT: [8,6]     .    .    .  D===============================================================eER   fxch	%st(6)
# CHECK-NEXT: [8,7]     .    .    .  D===============================================================eER   fxch	%st(7)
# CHECK-NEXT: Truncated display due to cycle limit

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     10    33.7   33.7   0.0       fxch	%st(0)
# CHECK-NEXT: 1.     10    34.5   34.5   0.0       fxch	%st(1)
# CHECK-NEXT: 2.     10    35.3   35.3   0.0       fxch	%st(2)
# CHECK-NEXT: 3.     10    36.0   36.0   0.0       fxch	%st(3)
# CHECK-NEXT: 4.     10    37.2   37.2   0.0       fxch	%st(4)
# CHECK-NEXT: 5.     10    38.0   38.0   0.0       fxch	%st(5)
# CHECK-NEXT: 6.     10    38.3   38.3   0.0       fxch	%st(6)
# CHECK-NEXT: 7.     10    39.5   39.5   0.0       fxch	%st(7)
# CHECK-NEXT: 8.     10    40.7   40.7   0.0       fxch	%st(0)
# CHECK-NEXT:        10    37.0   37.0   0.0       <total>
