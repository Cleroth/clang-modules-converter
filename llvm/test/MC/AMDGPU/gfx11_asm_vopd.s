// RUN: llvm-mc -triple=amdgcn -mcpu=gfx1100 -mattr=+wavefrontsize32 -show-encoding %s | FileCheck --check-prefixes=GFX11 %s
// RUN: llvm-mc -triple=amdgcn -mcpu=gfx1100 -show-encoding %s | FileCheck --check-prefixes=GFX11 %s
// RUN: not llvm-mc -triple=amdgcn -mcpu=gfx1100 -mattr=+wavefrontsize64 -show-encoding %s 2>&1 | FileCheck --check-prefixes=W64-ERR --implicit-check-not=error: %s

v_dual_add_f32 v255, v4, v2 :: v_dual_add_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x08,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v1, v2 :: v_dual_add_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x08,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v255, v2 :: v_dual_add_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x08,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v2, v2 :: v_dual_add_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x08,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v3, v2 :: v_dual_add_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x08,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s105, v2 :: v_dual_add_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x08,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s1, v2 :: v_dual_add_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x08,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, ttmp15, v2 :: v_dual_add_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x08,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_hi, v2 :: v_dual_add_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x08,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_lo, v2 :: v_dual_add_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x08,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, m0, v2 :: v_dual_add_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x08,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_hi, v2 :: v_dual_add_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x08,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_lo, v2 :: v_dual_add_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x08,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0xaf123456, v2 :: v_dual_add_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x08,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, src_scc, v2 :: v_dual_add_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x08,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0.5, v3 :: v_dual_add_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x08,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, -1, v4 :: v_dual_add_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x08,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v6, null, v5 :: v_dual_add_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x08,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v4, v2 :: v_dual_add_nc_u32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x20,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v1, v2 :: v_dual_add_nc_u32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x20,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v255, v2 :: v_dual_add_nc_u32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x20,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v2, v2 :: v_dual_add_nc_u32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x20,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v3, v2 :: v_dual_add_nc_u32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x20,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s105, v2 :: v_dual_add_nc_u32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x20,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s1, v2 :: v_dual_add_nc_u32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x20,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, ttmp15, v2 :: v_dual_add_nc_u32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x20,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_hi, v2 :: v_dual_add_nc_u32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x20,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_lo, v2 :: v_dual_add_nc_u32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x20,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, m0, v2 :: v_dual_add_nc_u32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x20,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_hi, v2 :: v_dual_add_nc_u32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x20,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_lo, v2 :: v_dual_add_nc_u32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x20,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0xaf123456, v2 :: v_dual_add_nc_u32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x20,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, src_scc, v2 :: v_dual_add_nc_u32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x20,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0.5, v3 :: v_dual_add_nc_u32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x20,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, -1, v4 :: v_dual_add_nc_u32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x20,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v6, null, v5 :: v_dual_add_nc_u32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x20,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v4, v2 :: v_dual_and_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x24,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v1, v2 :: v_dual_and_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x24,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v255, v2 :: v_dual_and_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x24,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v2, v2 :: v_dual_and_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x24,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v3, v2 :: v_dual_and_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x24,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s105, v2 :: v_dual_and_b32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x24,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s1, v2 :: v_dual_and_b32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x24,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, ttmp15, v2 :: v_dual_and_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x24,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_hi, v2 :: v_dual_and_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x24,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_lo, v2 :: v_dual_and_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x24,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, m0, v2 :: v_dual_and_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x24,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_hi, v2 :: v_dual_and_b32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x24,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_lo, v2 :: v_dual_and_b32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x24,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0xaf123456, v2 :: v_dual_and_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x24,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, src_scc, v2 :: v_dual_and_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x24,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0.5, v3 :: v_dual_and_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x24,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, -1, v4 :: v_dual_and_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x24,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v6, null, v5 :: v_dual_and_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x24,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v4, v2 :: v_dual_cndmask_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x12,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v1, v2 :: v_dual_cndmask_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x12,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v255, v2 :: v_dual_cndmask_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x12,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v2, v2 :: v_dual_cndmask_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x12,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v3, v2 :: v_dual_cndmask_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x12,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s105, v2 :: v_dual_cndmask_b32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x12,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s1, v2 :: v_dual_cndmask_b32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x12,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, ttmp15, v2 :: v_dual_cndmask_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x12,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_hi, v2 :: v_dual_cndmask_b32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x12,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_lo, v2 :: v_dual_cndmask_b32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x12,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, m0, v2 :: v_dual_cndmask_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x12,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_hi, v2 :: v_dual_cndmask_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x12,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_lo, v2 :: v_dual_cndmask_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x12,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0xaf123456, v2 :: v_dual_cndmask_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x12,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, src_scc, v2 :: v_dual_cndmask_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x12,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0.5, v3 :: v_dual_cndmask_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x12,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, -1, v4 :: v_dual_cndmask_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x12,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v6, null, v5 :: v_dual_cndmask_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x12,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v4, v2 :: v_dual_dot2acc_f32_f16 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x18,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v1, v2 :: v_dual_dot2acc_f32_f16 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x18,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v255, v2 :: v_dual_dot2acc_f32_f16 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x18,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v2, v2 :: v_dual_dot2acc_f32_f16 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x18,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v3, v2 :: v_dual_dot2acc_f32_f16 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x18,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s105, v2 :: v_dual_dot2acc_f32_f16 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x18,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s1, v2 :: v_dual_dot2acc_f32_f16 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x18,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, ttmp15, v2 :: v_dual_dot2acc_f32_f16 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x18,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_hi, v2 :: v_dual_dot2acc_f32_f16 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x18,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_lo, v2 :: v_dual_dot2acc_f32_f16 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x18,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, m0, v2 :: v_dual_dot2acc_f32_f16 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x18,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_hi, v2 :: v_dual_dot2acc_f32_f16 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x18,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_lo, v2 :: v_dual_dot2acc_f32_f16 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x18,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0xaf123456, v2 :: v_dual_dot2acc_f32_f16 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x18,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, src_scc, v2 :: v_dual_dot2acc_f32_f16 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x18,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0.5, v3 :: v_dual_dot2acc_f32_f16 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x18,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, -1, v4 :: v_dual_dot2acc_f32_f16 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x18,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v6, null, v5 :: v_dual_dot2acc_f32_f16 v255, 0xfe0b, v4
// GFX11: encoding: [0x7c,0x0a,0x18,0xc9,0xff,0x08,0xfe,0x06,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v4, v2 :: v_dual_fmaak_f32 v6, v1, v3, 0xaf123456
// GFX11: encoding: [0x04,0x05,0x02,0xc9,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v1, v2 :: v_dual_fmaak_f32 v6, v255, v3, 0xaf123456
// GFX11: encoding: [0x01,0x05,0x02,0xc9,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v255, v2 :: v_dual_fmaak_f32 v6, v2, v3, 0xaf123456
// GFX11: encoding: [0xff,0x05,0x02,0xc9,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v2, v2 :: v_dual_fmaak_f32 v6, v3, v3, 0xaf123456
// GFX11: encoding: [0x02,0x05,0x02,0xc9,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v3, v2 :: v_dual_fmaak_f32 v6, v4, v3, 0xaf123456
// GFX11: encoding: [0x03,0x05,0x02,0xc9,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s105, v2 :: v_dual_fmaak_f32 v6, s105, v3, 0xaf123456
// GFX11: encoding: [0x69,0x04,0x02,0xc9,0x69,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s1, v2 :: v_dual_fmaak_f32 v6, s1, v3, 0xaf123456
// GFX11: encoding: [0x01,0x04,0x02,0xc9,0x01,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, ttmp15, v2 :: v_dual_fmaak_f32 v6, ttmp15, v3, 0xaf123456
// GFX11: encoding: [0x7b,0x04,0x02,0xc9,0x7b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_hi, v2 :: v_dual_fmaak_f32 v6, exec_hi, v3, 0xaf123456
// GFX11: encoding: [0x7f,0x04,0x02,0xc9,0x7f,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_lo, v2 :: v_dual_fmaak_f32 v6, exec_lo, v3, 0xaf123456
// GFX11: encoding: [0x7e,0x04,0x02,0xc9,0x7e,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, m0, v2 :: v_dual_fmaak_f32 v6, m0, v3, 0xaf123456
// GFX11: encoding: [0x7d,0x04,0x02,0xc9,0x7d,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_hi, v2 :: v_dual_fmaak_f32 v6, vcc_hi, v3, 0xaf123456
// GFX11: encoding: [0x6b,0x04,0x02,0xc9,0x6b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_lo, v2 :: v_dual_fmaak_f32 v6, vcc_lo, v3, 0xaf123456
// GFX11: encoding: [0x6a,0x04,0x02,0xc9,0x6a,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0xaf123456, v2 :: v_dual_fmaak_f32 v6, null, v3, 0xaf123456
// GFX11: encoding: [0xff,0x04,0x02,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, src_scc, v2 :: v_dual_fmaak_f32 v6, -1, v3, 0xaf123456
// GFX11: encoding: [0xfd,0x04,0x02,0xc9,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0.5, v3 :: v_dual_fmaak_f32 v6, 0.5, v2, 0xaf123456
// GFX11: encoding: [0xf0,0x06,0x02,0xc9,0xf0,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, -1, v4 :: v_dual_fmaak_f32 v6, src_scc, v5, 0xaf123456
// GFX11: encoding: [0xc1,0x08,0x02,0xc9,0xfd,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v6, null, v5 :: v_dual_fmaak_f32 v255, 0xaf123456, v4, 0xaf123456
// GFX11: encoding: [0x7c,0x0a,0x02,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v4, v2 :: v_dual_fmac_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x00,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v1, v2 :: v_dual_fmac_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x00,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v255, v2 :: v_dual_fmac_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x00,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v2, v2 :: v_dual_fmac_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x00,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v3, v2 :: v_dual_fmac_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x00,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s105, v2 :: v_dual_fmac_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x00,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s1, v2 :: v_dual_fmac_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x00,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, ttmp15, v2 :: v_dual_fmac_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x00,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_hi, v2 :: v_dual_fmac_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x00,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_lo, v2 :: v_dual_fmac_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x00,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, m0, v2 :: v_dual_fmac_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x00,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_hi, v2 :: v_dual_fmac_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x00,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_lo, v2 :: v_dual_fmac_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x00,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0xaf123456, v2 :: v_dual_fmac_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x00,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, src_scc, v2 :: v_dual_fmac_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x00,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0.5, v3 :: v_dual_fmac_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x00,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, -1, v4 :: v_dual_fmac_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x00,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v6, null, v5 :: v_dual_fmac_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x00,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v4, v255 :: v_dual_fmamk_f32 v6, v1, 0xaf123456, v255
// GFX11: encoding: [0x04,0xff,0x05,0xc9,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v1, v255 :: v_dual_fmamk_f32 v6, v255, 0xaf123456, v255
// GFX11: encoding: [0x01,0xff,0x05,0xc9,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v255, v255 :: v_dual_fmamk_f32 v6, v2, 0xaf123456, v255
// GFX11: encoding: [0xff,0xff,0x05,0xc9,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v2, v255 :: v_dual_fmamk_f32 v6, v3, 0xaf123456, v255
// GFX11: encoding: [0x02,0xff,0x05,0xc9,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v3, v255 :: v_dual_fmamk_f32 v6, v4, 0xaf123456, v255
// GFX11: encoding: [0x03,0xff,0x05,0xc9,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s105, v255 :: v_dual_fmamk_f32 v6, s105, 0xaf123456, v255
// GFX11: encoding: [0x69,0xfe,0x05,0xc9,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s1, v255 :: v_dual_fmamk_f32 v6, s1, 0xaf123456, v255
// GFX11: encoding: [0x01,0xfe,0x05,0xc9,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, ttmp15, v255 :: v_dual_fmamk_f32 v6, ttmp15, 0xaf123456, v255
// GFX11: encoding: [0x7b,0xfe,0x05,0xc9,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_hi, v255 :: v_dual_fmamk_f32 v6, exec_hi, 0xaf123456, v255
// GFX11: encoding: [0x7f,0xfe,0x05,0xc9,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_lo, v255 :: v_dual_fmamk_f32 v6, exec_lo, 0xaf123456, v255
// GFX11: encoding: [0x7e,0xfe,0x05,0xc9,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, m0, v255 :: v_dual_fmamk_f32 v6, m0, 0xaf123456, v255
// GFX11: encoding: [0x7d,0xfe,0x05,0xc9,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_hi, v255 :: v_dual_fmamk_f32 v6, vcc_hi, 0xaf123456, v255
// GFX11: encoding: [0x6b,0xfe,0x05,0xc9,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_lo, v255 :: v_dual_fmamk_f32 v6, vcc_lo, 0xaf123456, v255
// GFX11: encoding: [0x6a,0xfe,0x05,0xc9,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, null, 0xaf123456, v255
// GFX11: encoding: [0xff,0xfe,0x05,0xc9,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, src_scc, v255 :: v_dual_fmamk_f32 v6, -1, 0xaf123456, v255
// GFX11: encoding: [0xfd,0xfe,0x05,0xc9,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0.5, v3 :: v_dual_fmamk_f32 v6, 0.5, 0xaf123456, v255
// GFX11: encoding: [0xf0,0x06,0x04,0xc9,0xf0,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, -1, v4 :: v_dual_fmamk_f32 v6, src_scc, 0xaf123456, v255
// GFX11: encoding: [0xc1,0x08,0x04,0xc9,0xfd,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v6, null, v5 :: v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x04,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v4, v2 :: v_dual_lshlrev_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x22,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v1, v2 :: v_dual_lshlrev_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x22,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v255, v2 :: v_dual_lshlrev_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x22,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v2, v2 :: v_dual_lshlrev_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x22,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v3, v2 :: v_dual_lshlrev_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x22,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s105, v2 :: v_dual_lshlrev_b32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x22,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s1, v2 :: v_dual_lshlrev_b32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x22,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, ttmp15, v2 :: v_dual_lshlrev_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x22,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_hi, v2 :: v_dual_lshlrev_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x22,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_lo, v2 :: v_dual_lshlrev_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x22,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, m0, v2 :: v_dual_lshlrev_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x22,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_hi, v2 :: v_dual_lshlrev_b32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x22,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_lo, v2 :: v_dual_lshlrev_b32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x22,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0xaf123456, v2 :: v_dual_lshlrev_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x22,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, src_scc, v2 :: v_dual_lshlrev_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x22,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0.5, v3 :: v_dual_lshlrev_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x22,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, -1, v4 :: v_dual_lshlrev_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x22,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v6, null, v5 :: v_dual_lshlrev_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x22,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v4, v2 :: v_dual_max_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x14,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v1, v2 :: v_dual_max_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x14,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v255, v2 :: v_dual_max_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x14,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v2, v2 :: v_dual_max_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x14,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v3, v2 :: v_dual_max_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x14,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s105, v2 :: v_dual_max_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x14,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s1, v2 :: v_dual_max_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x14,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, ttmp15, v2 :: v_dual_max_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x14,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_hi, v2 :: v_dual_max_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x14,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_lo, v2 :: v_dual_max_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x14,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, m0, v2 :: v_dual_max_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x14,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_hi, v2 :: v_dual_max_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x14,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_lo, v2 :: v_dual_max_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x14,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0xaf123456, v2 :: v_dual_max_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x14,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, src_scc, v2 :: v_dual_max_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x14,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0.5, v3 :: v_dual_max_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x14,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, -1, v4 :: v_dual_max_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x14,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v6, null, v5 :: v_dual_max_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x14,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v4, v2 :: v_dual_min_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x16,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v1, v2 :: v_dual_min_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x16,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v255, v2 :: v_dual_min_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x16,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v2, v2 :: v_dual_min_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x16,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v3, v2 :: v_dual_min_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x16,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s105, v2 :: v_dual_min_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x16,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s1, v2 :: v_dual_min_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x16,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, ttmp15, v2 :: v_dual_min_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x16,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_hi, v2 :: v_dual_min_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x16,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_lo, v2 :: v_dual_min_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x16,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, m0, v2 :: v_dual_min_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x16,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_hi, v2 :: v_dual_min_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x16,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_lo, v2 :: v_dual_min_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x16,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0xaf123456, v2 :: v_dual_min_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x16,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, src_scc, v2 :: v_dual_min_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x16,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0.5, v3 :: v_dual_min_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x16,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, -1, v4 :: v_dual_min_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x16,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v6, null, v5 :: v_dual_min_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x16,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v4, v255 :: v_dual_mov_b32 v6, v1
// GFX11: encoding: [0x04,0xff,0x11,0xc9,0x01,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v1, v255 :: v_dual_mov_b32 v6, v255
// GFX11: encoding: [0x01,0xff,0x11,0xc9,0xff,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v255, v255 :: v_dual_mov_b32 v6, v2
// GFX11: encoding: [0xff,0xff,0x11,0xc9,0x02,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v2, v255 :: v_dual_mov_b32 v6, v3
// GFX11: encoding: [0x02,0xff,0x11,0xc9,0x03,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v3, v255 :: v_dual_mov_b32 v6, v4
// GFX11: encoding: [0x03,0xff,0x11,0xc9,0x04,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s105, v255 :: v_dual_mov_b32 v6, s1
// GFX11: encoding: [0x69,0xfe,0x11,0xc9,0x01,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s1, v255 :: v_dual_mov_b32 v6, s105
// GFX11: encoding: [0x01,0xfe,0x11,0xc9,0x69,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, ttmp15, v255 :: v_dual_mov_b32 v6, vcc_lo
// GFX11: encoding: [0x7b,0xfe,0x11,0xc9,0x6a,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_hi, v255 :: v_dual_mov_b32 v6, vcc_hi
// GFX11: encoding: [0x7f,0xfe,0x11,0xc9,0x6b,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_lo, v255 :: v_dual_mov_b32 v6, ttmp15
// GFX11: encoding: [0x7e,0xfe,0x11,0xc9,0x7b,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, m0, v255 :: v_dual_mov_b32 v6, m0
// GFX11: encoding: [0x7d,0xfe,0x11,0xc9,0x7d,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_hi, v255 :: v_dual_mov_b32 v6, exec_lo
// GFX11: encoding: [0x6b,0xfe,0x11,0xc9,0x7e,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_lo, v255 :: v_dual_mov_b32 v6, exec_hi
// GFX11: encoding: [0x6a,0xfe,0x11,0xc9,0x7f,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0xaf123456, v255 :: v_dual_mov_b32 v6, null
// GFX11: encoding: [0xff,0xfe,0x11,0xc9,0x7c,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, src_scc, v255 :: v_dual_mov_b32 v6, -1
// GFX11: encoding: [0xfd,0xfe,0x11,0xc9,0xc1,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0.5, v3 :: v_dual_mov_b32 v6, 0.5
// GFX11: encoding: [0xf0,0x06,0x10,0xc9,0xf0,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, -1, v4 :: v_dual_mov_b32 v6, src_scc
// GFX11: encoding: [0xc1,0x08,0x10,0xc9,0xfd,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v6, null, v5 :: v_dual_mov_b32 v255, 0xaf123456
// GFX11: encoding: [0x7c,0x0a,0x10,0xc9,0xff,0x00,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v4, v2 :: v_dual_mul_dx9_zero_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x0e,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v1, v2 :: v_dual_mul_dx9_zero_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x0e,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v255, v2 :: v_dual_mul_dx9_zero_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x0e,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v2, v2 :: v_dual_mul_dx9_zero_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x0e,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v3, v2 :: v_dual_mul_dx9_zero_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x0e,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s105, v2 :: v_dual_mul_dx9_zero_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x0e,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s1, v2 :: v_dual_mul_dx9_zero_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x0e,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, ttmp15, v2 :: v_dual_mul_dx9_zero_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x0e,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_hi, v2 :: v_dual_mul_dx9_zero_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x0e,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_lo, v2 :: v_dual_mul_dx9_zero_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x0e,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, m0, v2 :: v_dual_mul_dx9_zero_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x0e,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_hi, v2 :: v_dual_mul_dx9_zero_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x0e,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_lo, v2 :: v_dual_mul_dx9_zero_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x0e,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0xaf123456, v2 :: v_dual_mul_dx9_zero_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x0e,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, src_scc, v2 :: v_dual_mul_dx9_zero_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x0e,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0.5, v3 :: v_dual_mul_dx9_zero_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x0e,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, -1, v4 :: v_dual_mul_dx9_zero_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x0e,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v6, null, v5 :: v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x0e,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v4, v2 :: v_dual_mul_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x06,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v1, v2 :: v_dual_mul_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x06,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v255, v2 :: v_dual_mul_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x06,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v2, v2 :: v_dual_mul_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x06,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v3, v2 :: v_dual_mul_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x06,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s105, v2 :: v_dual_mul_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x06,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s1, v2 :: v_dual_mul_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x06,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, ttmp15, v2 :: v_dual_mul_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x06,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_hi, v2 :: v_dual_mul_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x06,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_lo, v2 :: v_dual_mul_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x06,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, m0, v2 :: v_dual_mul_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x06,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_hi, v2 :: v_dual_mul_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x06,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_lo, v2 :: v_dual_mul_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x06,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0xaf123456, v2 :: v_dual_mul_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x06,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, src_scc, v2 :: v_dual_mul_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x06,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0.5, v3 :: v_dual_mul_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x06,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, -1, v4 :: v_dual_mul_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x06,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v6, null, v5 :: v_dual_mul_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x06,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v4, v2 :: v_dual_sub_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x0a,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v1, v2 :: v_dual_sub_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x0a,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v255, v2 :: v_dual_sub_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x0a,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v2, v2 :: v_dual_sub_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x0a,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v3, v2 :: v_dual_sub_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x0a,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s105, v2 :: v_dual_sub_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x0a,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s1, v2 :: v_dual_sub_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x0a,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, ttmp15, v2 :: v_dual_sub_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x0a,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_hi, v2 :: v_dual_sub_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x0a,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_lo, v2 :: v_dual_sub_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x0a,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, m0, v2 :: v_dual_sub_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x0a,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_hi, v2 :: v_dual_sub_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x0a,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_lo, v2 :: v_dual_sub_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x0a,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0xaf123456, v2 :: v_dual_sub_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x0a,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, src_scc, v2 :: v_dual_sub_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x0a,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0.5, v3 :: v_dual_sub_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x0a,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, -1, v4 :: v_dual_sub_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x0a,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v6, null, v5 :: v_dual_sub_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x0a,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v4, v2 :: v_dual_subrev_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x0c,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v1, v2 :: v_dual_subrev_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x0c,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v255, v2 :: v_dual_subrev_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x0c,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v2, v2 :: v_dual_subrev_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x0c,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, v3, v2 :: v_dual_subrev_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x0c,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s105, v2 :: v_dual_subrev_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x0c,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, s1, v2 :: v_dual_subrev_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x0c,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, ttmp15, v2 :: v_dual_subrev_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x0c,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_hi, v2 :: v_dual_subrev_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x0c,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, exec_lo, v2 :: v_dual_subrev_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x0c,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, m0, v2 :: v_dual_subrev_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x0c,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_hi, v2 :: v_dual_subrev_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x0c,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, vcc_lo, v2 :: v_dual_subrev_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x0c,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0xaf123456, v2 :: v_dual_subrev_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x0c,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, src_scc, v2 :: v_dual_subrev_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x0c,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, 0.5, v3 :: v_dual_subrev_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x0c,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v255, -1, v4 :: v_dual_subrev_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x0c,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_add_f32 v6, null, v5 :: v_dual_subrev_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x0c,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v4, v2 :: v_dual_add_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x48,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v1, v2 :: v_dual_add_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x48,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v255, v2 :: v_dual_add_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x48,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v2, v2 :: v_dual_add_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x48,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v3, v2 :: v_dual_add_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x48,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s105, v2 :: v_dual_add_f32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x48,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s1, v2 :: v_dual_add_f32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x48,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, ttmp15, v2 :: v_dual_add_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x48,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_hi, v2 :: v_dual_add_f32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x48,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_lo, v2 :: v_dual_add_f32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x48,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, m0, v2 :: v_dual_add_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x48,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_hi, v2 :: v_dual_add_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x48,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_lo, v2 :: v_dual_add_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x48,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0xaf123456, v2 :: v_dual_add_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x48,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, src_scc, v2 :: v_dual_add_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x48,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0.5, v3 :: v_dual_add_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x48,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, -1, v4 :: v_dual_add_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x48,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v6, null, v5 :: v_dual_add_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x48,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v4, v2 :: v_dual_add_nc_u32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x60,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v1, v2 :: v_dual_add_nc_u32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x60,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v255, v2 :: v_dual_add_nc_u32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x60,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v2, v2 :: v_dual_add_nc_u32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x60,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v3, v2 :: v_dual_add_nc_u32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x60,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s105, v2 :: v_dual_add_nc_u32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x60,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s1, v2 :: v_dual_add_nc_u32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x60,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, ttmp15, v2 :: v_dual_add_nc_u32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x60,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_hi, v2 :: v_dual_add_nc_u32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x60,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_lo, v2 :: v_dual_add_nc_u32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x60,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, m0, v2 :: v_dual_add_nc_u32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x60,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_hi, v2 :: v_dual_add_nc_u32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x60,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_lo, v2 :: v_dual_add_nc_u32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x60,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0xaf123456, v2 :: v_dual_add_nc_u32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x60,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, src_scc, v2 :: v_dual_add_nc_u32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x60,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0.5, v3 :: v_dual_add_nc_u32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x60,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, -1, v4 :: v_dual_add_nc_u32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x60,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v6, null, v5 :: v_dual_add_nc_u32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x60,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v4, v2 :: v_dual_and_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x64,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v1, v2 :: v_dual_and_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x64,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v255, v2 :: v_dual_and_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x64,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v2, v2 :: v_dual_and_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x64,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v3, v2 :: v_dual_and_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x64,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s105, v2 :: v_dual_and_b32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x64,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s1, v2 :: v_dual_and_b32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x64,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, ttmp15, v2 :: v_dual_and_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x64,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_hi, v2 :: v_dual_and_b32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x64,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_lo, v2 :: v_dual_and_b32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x64,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, m0, v2 :: v_dual_and_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x64,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_hi, v2 :: v_dual_and_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x64,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_lo, v2 :: v_dual_and_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x64,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0xaf123456, v2 :: v_dual_and_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x64,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, src_scc, v2 :: v_dual_and_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x64,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0.5, v3 :: v_dual_and_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x64,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, -1, v4 :: v_dual_and_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x64,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v6, null, v5 :: v_dual_and_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x64,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v4, v2 :: v_dual_cndmask_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x52,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v1, v2 :: v_dual_cndmask_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x52,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v255, v2 :: v_dual_cndmask_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x52,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v2, v2 :: v_dual_cndmask_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x52,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v3, v2 :: v_dual_cndmask_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x52,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s105, v2 :: v_dual_cndmask_b32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x52,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s1, v2 :: v_dual_cndmask_b32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x52,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, ttmp15, v2 :: v_dual_cndmask_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x52,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_hi, v2 :: v_dual_cndmask_b32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x52,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_lo, v2 :: v_dual_cndmask_b32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x52,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, m0, v2 :: v_dual_cndmask_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x52,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_hi, v2 :: v_dual_cndmask_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x52,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_lo, v2 :: v_dual_cndmask_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x52,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0xaf123456, v2 :: v_dual_cndmask_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x52,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, src_scc, v2 :: v_dual_cndmask_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x52,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0.5, v3 :: v_dual_cndmask_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x52,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, -1, v4 :: v_dual_cndmask_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x52,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v6, null, v5 :: v_dual_cndmask_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x52,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v4, v2 :: v_dual_dot2acc_f32_f16 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x58,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v1, v2 :: v_dual_dot2acc_f32_f16 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x58,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v255, v2 :: v_dual_dot2acc_f32_f16 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x58,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v2, v2 :: v_dual_dot2acc_f32_f16 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x58,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v3, v2 :: v_dual_dot2acc_f32_f16 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x58,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s105, v2 :: v_dual_dot2acc_f32_f16 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x58,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s1, v2 :: v_dual_dot2acc_f32_f16 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x58,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, ttmp15, v2 :: v_dual_dot2acc_f32_f16 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x58,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_hi, v2 :: v_dual_dot2acc_f32_f16 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x58,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_lo, v2 :: v_dual_dot2acc_f32_f16 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x58,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, m0, v2 :: v_dual_dot2acc_f32_f16 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x58,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_hi, v2 :: v_dual_dot2acc_f32_f16 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x58,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_lo, v2 :: v_dual_dot2acc_f32_f16 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x58,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0xaf123456, v2 :: v_dual_dot2acc_f32_f16 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x58,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, src_scc, v2 :: v_dual_dot2acc_f32_f16 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x58,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0.5, v3 :: v_dual_dot2acc_f32_f16 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x58,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, -1, v4 :: v_dual_dot2acc_f32_f16 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x58,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v6, null, v5 :: v_dual_dot2acc_f32_f16 v255, 0xfe0b, v4
// GFX11: encoding: [0x7c,0x0a,0x58,0xca,0xff,0x08,0xfe,0x06,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v4, v2 :: v_dual_fmaak_f32 v6, v1, v3, 0xaf123456
// GFX11: encoding: [0x04,0x05,0x42,0xca,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v1, v2 :: v_dual_fmaak_f32 v6, v255, v3, 0xaf123456
// GFX11: encoding: [0x01,0x05,0x42,0xca,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v255, v2 :: v_dual_fmaak_f32 v6, v2, v3, 0xaf123456
// GFX11: encoding: [0xff,0x05,0x42,0xca,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v2, v2 :: v_dual_fmaak_f32 v6, v3, v3, 0xaf123456
// GFX11: encoding: [0x02,0x05,0x42,0xca,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v3, v2 :: v_dual_fmaak_f32 v6, v4, v3, 0xaf123456
// GFX11: encoding: [0x03,0x05,0x42,0xca,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0xaf123456, v2 :: v_dual_fmaak_f32 v6, null, v3, 0xaf123456
// GFX11: encoding: [0xff,0x04,0x42,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0.5, v3 :: v_dual_fmaak_f32 v6, -1, v2, 0xaf123456
// GFX11: encoding: [0xf0,0x06,0x42,0xca,0xc1,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, -1, v4 :: v_dual_fmaak_f32 v6, 0.5, v5, 0xaf123456
// GFX11: encoding: [0xc1,0x08,0x42,0xca,0xf0,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v6, null, v5 :: v_dual_fmaak_f32 v255, 0xaf123456, v4, 0xaf123456
// GFX11: encoding: [0x7c,0x0a,0x42,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v4, v2 :: v_dual_fmac_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x40,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v1, v2 :: v_dual_fmac_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x40,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v255, v2 :: v_dual_fmac_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x40,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v2, v2 :: v_dual_fmac_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x40,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v3, v2 :: v_dual_fmac_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x40,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s105, v2 :: v_dual_fmac_f32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x40,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s1, v2 :: v_dual_fmac_f32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x40,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, ttmp15, v2 :: v_dual_fmac_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x40,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_hi, v2 :: v_dual_fmac_f32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x40,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_lo, v2 :: v_dual_fmac_f32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x40,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, m0, v2 :: v_dual_fmac_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x40,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_hi, v2 :: v_dual_fmac_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x40,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_lo, v2 :: v_dual_fmac_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x40,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0xaf123456, v2 :: v_dual_fmac_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x40,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, src_scc, v2 :: v_dual_fmac_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x40,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0.5, v3 :: v_dual_fmac_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x40,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, -1, v4 :: v_dual_fmac_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x40,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v6, null, v5 :: v_dual_fmac_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x40,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v4, v255 :: v_dual_fmamk_f32 v6, v1, 0xaf123456, v255
// GFX11: encoding: [0x04,0xff,0x45,0xca,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v1, v255 :: v_dual_fmamk_f32 v6, v255, 0xaf123456, v255
// GFX11: encoding: [0x01,0xff,0x45,0xca,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v255, v255 :: v_dual_fmamk_f32 v6, v2, 0xaf123456, v255
// GFX11: encoding: [0xff,0xff,0x45,0xca,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v2, v255 :: v_dual_fmamk_f32 v6, v3, 0xaf123456, v255
// GFX11: encoding: [0x02,0xff,0x45,0xca,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v3, v255 :: v_dual_fmamk_f32 v6, v4, 0xaf123456, v255
// GFX11: encoding: [0x03,0xff,0x45,0xca,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, null, 0xaf123456, v255
// GFX11: encoding: [0xff,0xfe,0x45,0xca,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0.5, v3 :: v_dual_fmamk_f32 v6, -1, 0xaf123456, v255
// GFX11: encoding: [0xf0,0x06,0x44,0xca,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, -1, v4 :: v_dual_fmamk_f32 v6, 0.5, 0xaf123456, v255
// GFX11: encoding: [0xc1,0x08,0x44,0xca,0xf0,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v6, null, v5 :: v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x44,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v4, v2 :: v_dual_lshlrev_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x62,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v1, v2 :: v_dual_lshlrev_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x62,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v255, v2 :: v_dual_lshlrev_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x62,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v2, v2 :: v_dual_lshlrev_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x62,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v3, v2 :: v_dual_lshlrev_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x62,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s105, v2 :: v_dual_lshlrev_b32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x62,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s1, v2 :: v_dual_lshlrev_b32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x62,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, ttmp15, v2 :: v_dual_lshlrev_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x62,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_hi, v2 :: v_dual_lshlrev_b32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x62,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_lo, v2 :: v_dual_lshlrev_b32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x62,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, m0, v2 :: v_dual_lshlrev_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x62,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_hi, v2 :: v_dual_lshlrev_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x62,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_lo, v2 :: v_dual_lshlrev_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x62,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0xaf123456, v2 :: v_dual_lshlrev_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x62,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, src_scc, v2 :: v_dual_lshlrev_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x62,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0.5, v3 :: v_dual_lshlrev_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x62,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, -1, v4 :: v_dual_lshlrev_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x62,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v6, null, v5 :: v_dual_lshlrev_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x62,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v4, v2 :: v_dual_max_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x54,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v1, v2 :: v_dual_max_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x54,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v255, v2 :: v_dual_max_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x54,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v2, v2 :: v_dual_max_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x54,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v3, v2 :: v_dual_max_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x54,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s105, v2 :: v_dual_max_f32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x54,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s1, v2 :: v_dual_max_f32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x54,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, ttmp15, v2 :: v_dual_max_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x54,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_hi, v2 :: v_dual_max_f32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x54,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_lo, v2 :: v_dual_max_f32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x54,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, m0, v2 :: v_dual_max_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x54,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_hi, v2 :: v_dual_max_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x54,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_lo, v2 :: v_dual_max_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x54,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0xaf123456, v2 :: v_dual_max_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x54,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, src_scc, v2 :: v_dual_max_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x54,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0.5, v3 :: v_dual_max_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x54,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, -1, v4 :: v_dual_max_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x54,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v6, null, v5 :: v_dual_max_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x54,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v4, v2 :: v_dual_min_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x56,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v1, v2 :: v_dual_min_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x56,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v255, v2 :: v_dual_min_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x56,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v2, v2 :: v_dual_min_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x56,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v3, v2 :: v_dual_min_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x56,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s105, v2 :: v_dual_min_f32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x56,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s1, v2 :: v_dual_min_f32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x56,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, ttmp15, v2 :: v_dual_min_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x56,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_hi, v2 :: v_dual_min_f32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x56,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_lo, v2 :: v_dual_min_f32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x56,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, m0, v2 :: v_dual_min_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x56,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_hi, v2 :: v_dual_min_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x56,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_lo, v2 :: v_dual_min_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x56,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0xaf123456, v2 :: v_dual_min_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x56,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, src_scc, v2 :: v_dual_min_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x56,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0.5, v3 :: v_dual_min_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x56,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, -1, v4 :: v_dual_min_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x56,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v6, null, v5 :: v_dual_min_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x56,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v4, v255 :: v_dual_mov_b32 v6, v1
// GFX11: encoding: [0x04,0xff,0x51,0xca,0x01,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v1, v255 :: v_dual_mov_b32 v6, v255
// GFX11: encoding: [0x01,0xff,0x51,0xca,0xff,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v255, v255 :: v_dual_mov_b32 v6, v2
// GFX11: encoding: [0xff,0xff,0x51,0xca,0x02,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v2, v255 :: v_dual_mov_b32 v6, v3
// GFX11: encoding: [0x02,0xff,0x51,0xca,0x03,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v3, v255 :: v_dual_mov_b32 v6, v4
// GFX11: encoding: [0x03,0xff,0x51,0xca,0x04,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s105, v255 :: v_dual_mov_b32 v6, s105
// GFX11: encoding: [0x69,0xfe,0x51,0xca,0x69,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s1, v255 :: v_dual_mov_b32 v6, s1
// GFX11: encoding: [0x01,0xfe,0x51,0xca,0x01,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, ttmp15, v255 :: v_dual_mov_b32 v6, ttmp15
// GFX11: encoding: [0x7b,0xfe,0x51,0xca,0x7b,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_hi, v255 :: v_dual_mov_b32 v6, exec_hi
// GFX11: encoding: [0x7f,0xfe,0x51,0xca,0x7f,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_lo, v255 :: v_dual_mov_b32 v6, exec_lo
// GFX11: encoding: [0x7e,0xfe,0x51,0xca,0x7e,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, m0, v255 :: v_dual_mov_b32 v6, m0
// GFX11: encoding: [0x7d,0xfe,0x51,0xca,0x7d,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_hi, v255 :: v_dual_mov_b32 v6, vcc_hi
// GFX11: encoding: [0x6b,0xfe,0x51,0xca,0x6b,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_lo, v255 :: v_dual_mov_b32 v6, vcc_lo
// GFX11: encoding: [0x6a,0xfe,0x51,0xca,0x6a,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0xaf123456, v255 :: v_dual_mov_b32 v6, null
// GFX11: encoding: [0xff,0xfe,0x51,0xca,0x7c,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, src_scc, v255 :: v_dual_mov_b32 v6, -1
// GFX11: encoding: [0xfd,0xfe,0x51,0xca,0xc1,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0.5, v3 :: v_dual_mov_b32 v6, 0.5
// GFX11: encoding: [0xf0,0x06,0x50,0xca,0xf0,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, -1, v4 :: v_dual_mov_b32 v6, src_scc
// GFX11: encoding: [0xc1,0x08,0x50,0xca,0xfd,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v6, null, v5 :: v_dual_mov_b32 v255, 0xaf123456
// GFX11: encoding: [0x7c,0x0a,0x50,0xca,0xff,0x00,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v4, v2 :: v_dual_mul_dx9_zero_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x4e,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v1, v2 :: v_dual_mul_dx9_zero_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x4e,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v255, v2 :: v_dual_mul_dx9_zero_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x4e,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v2, v2 :: v_dual_mul_dx9_zero_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x4e,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v3, v2 :: v_dual_mul_dx9_zero_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x4e,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s105, v2 :: v_dual_mul_dx9_zero_f32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x4e,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s1, v2 :: v_dual_mul_dx9_zero_f32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x4e,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, ttmp15, v2 :: v_dual_mul_dx9_zero_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x4e,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_hi, v2 :: v_dual_mul_dx9_zero_f32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x4e,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_lo, v2 :: v_dual_mul_dx9_zero_f32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x4e,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, m0, v2 :: v_dual_mul_dx9_zero_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x4e,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_hi, v2 :: v_dual_mul_dx9_zero_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x4e,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_lo, v2 :: v_dual_mul_dx9_zero_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x4e,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0xaf123456, v2 :: v_dual_mul_dx9_zero_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x4e,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, src_scc, v2 :: v_dual_mul_dx9_zero_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x4e,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0.5, v3 :: v_dual_mul_dx9_zero_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x4e,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, -1, v4 :: v_dual_mul_dx9_zero_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x4e,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v6, null, v5 :: v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x4e,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v4, v2 :: v_dual_mul_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x46,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v1, v2 :: v_dual_mul_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x46,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v255, v2 :: v_dual_mul_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x46,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v2, v2 :: v_dual_mul_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x46,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v3, v2 :: v_dual_mul_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x46,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s105, v2 :: v_dual_mul_f32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x46,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s1, v2 :: v_dual_mul_f32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x46,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, ttmp15, v2 :: v_dual_mul_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x46,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_hi, v2 :: v_dual_mul_f32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x46,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_lo, v2 :: v_dual_mul_f32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x46,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, m0, v2 :: v_dual_mul_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x46,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_hi, v2 :: v_dual_mul_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x46,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_lo, v2 :: v_dual_mul_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x46,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0xaf123456, v2 :: v_dual_mul_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x46,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, src_scc, v2 :: v_dual_mul_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x46,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0.5, v3 :: v_dual_mul_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x46,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, -1, v4 :: v_dual_mul_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x46,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v6, null, v5 :: v_dual_mul_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x46,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v4, v2 :: v_dual_sub_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x4a,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v1, v2 :: v_dual_sub_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x4a,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v255, v2 :: v_dual_sub_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x4a,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v2, v2 :: v_dual_sub_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x4a,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v3, v2 :: v_dual_sub_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x4a,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s105, v2 :: v_dual_sub_f32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x4a,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s1, v2 :: v_dual_sub_f32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x4a,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, ttmp15, v2 :: v_dual_sub_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x4a,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_hi, v2 :: v_dual_sub_f32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x4a,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_lo, v2 :: v_dual_sub_f32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x4a,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, m0, v2 :: v_dual_sub_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x4a,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_hi, v2 :: v_dual_sub_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x4a,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_lo, v2 :: v_dual_sub_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x4a,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0xaf123456, v2 :: v_dual_sub_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x4a,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, src_scc, v2 :: v_dual_sub_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x4a,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0.5, v3 :: v_dual_sub_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x4a,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, -1, v4 :: v_dual_sub_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x4a,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v6, null, v5 :: v_dual_sub_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x4a,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v4, v2 :: v_dual_subrev_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x4c,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v1, v2 :: v_dual_subrev_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x4c,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v255, v2 :: v_dual_subrev_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x4c,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v2, v2 :: v_dual_subrev_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x4c,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, v3, v2 :: v_dual_subrev_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x4c,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s105, v2 :: v_dual_subrev_f32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x4c,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, s1, v2 :: v_dual_subrev_f32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x4c,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, ttmp15, v2 :: v_dual_subrev_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x4c,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_hi, v2 :: v_dual_subrev_f32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x4c,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, exec_lo, v2 :: v_dual_subrev_f32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x4c,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, m0, v2 :: v_dual_subrev_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x4c,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_hi, v2 :: v_dual_subrev_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x4c,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, vcc_lo, v2 :: v_dual_subrev_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x4c,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0xaf123456, v2 :: v_dual_subrev_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x4c,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, src_scc, v2 :: v_dual_subrev_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x4c,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, 0.5, v3 :: v_dual_subrev_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x4c,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v255, -1, v4 :: v_dual_subrev_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x4c,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_cndmask_b32 v6, null, v5 :: v_dual_subrev_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x4c,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v4, v2 :: v_dual_add_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x08,0xcb,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v1, v2 :: v_dual_add_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x08,0xcb,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v255, v2 :: v_dual_add_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x08,0xcb,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v2, v2 :: v_dual_add_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x08,0xcb,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v3, v2 :: v_dual_add_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x08,0xcb,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s105, v2 :: v_dual_add_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x08,0xcb,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s1, v2 :: v_dual_add_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x08,0xcb,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, ttmp15, v2 :: v_dual_add_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x08,0xcb,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_hi, v2 :: v_dual_add_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x08,0xcb,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_lo, v2 :: v_dual_add_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x08,0xcb,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, m0, v2 :: v_dual_add_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x08,0xcb,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_hi, v2 :: v_dual_add_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x08,0xcb,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_lo, v2 :: v_dual_add_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x08,0xcb,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0xfe0b, v2 :: v_dual_add_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x08,0xcb,0x7c,0x06,0x06,0xff,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, src_scc, v2 :: v_dual_add_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x08,0xcb,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0.5, v3 :: v_dual_add_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x08,0xcb,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, -1, v4 :: v_dual_add_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x08,0xcb,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v6, null, v5 :: v_dual_add_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x08,0xcb,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v4, v2 :: v_dual_add_nc_u32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x20,0xcb,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v1, v2 :: v_dual_add_nc_u32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x20,0xcb,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v255, v2 :: v_dual_add_nc_u32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x20,0xcb,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v2, v2 :: v_dual_add_nc_u32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x20,0xcb,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v3, v2 :: v_dual_add_nc_u32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x20,0xcb,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s105, v2 :: v_dual_add_nc_u32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x20,0xcb,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s1, v2 :: v_dual_add_nc_u32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x20,0xcb,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, ttmp15, v2 :: v_dual_add_nc_u32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x20,0xcb,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_hi, v2 :: v_dual_add_nc_u32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x20,0xcb,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_lo, v2 :: v_dual_add_nc_u32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x20,0xcb,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, m0, v2 :: v_dual_add_nc_u32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x20,0xcb,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_hi, v2 :: v_dual_add_nc_u32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x20,0xcb,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_lo, v2 :: v_dual_add_nc_u32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x20,0xcb,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0xfe0b, v2 :: v_dual_add_nc_u32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x20,0xcb,0x7c,0x06,0x06,0xff,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, src_scc, v2 :: v_dual_add_nc_u32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x20,0xcb,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0.5, v3 :: v_dual_add_nc_u32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x20,0xcb,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, -1, v4 :: v_dual_add_nc_u32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x20,0xcb,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v6, null, v5 :: v_dual_add_nc_u32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x20,0xcb,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v4, v2 :: v_dual_and_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x24,0xcb,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v1, v2 :: v_dual_and_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x24,0xcb,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v255, v2 :: v_dual_and_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x24,0xcb,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v2, v2 :: v_dual_and_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x24,0xcb,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v3, v2 :: v_dual_and_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x24,0xcb,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s105, v2 :: v_dual_and_b32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x24,0xcb,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s1, v2 :: v_dual_and_b32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x24,0xcb,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, ttmp15, v2 :: v_dual_and_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x24,0xcb,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_hi, v2 :: v_dual_and_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x24,0xcb,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_lo, v2 :: v_dual_and_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x24,0xcb,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, m0, v2 :: v_dual_and_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x24,0xcb,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_hi, v2 :: v_dual_and_b32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x24,0xcb,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_lo, v2 :: v_dual_and_b32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x24,0xcb,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0xfe0b, v2 :: v_dual_and_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x24,0xcb,0x7c,0x06,0x06,0xff,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, src_scc, v2 :: v_dual_and_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x24,0xcb,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0.5, v3 :: v_dual_and_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x24,0xcb,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, -1, v4 :: v_dual_and_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x24,0xcb,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v6, null, v5 :: v_dual_and_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x24,0xcb,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v4, v2 :: v_dual_cndmask_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x12,0xcb,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v1, v2 :: v_dual_cndmask_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x12,0xcb,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v255, v2 :: v_dual_cndmask_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x12,0xcb,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v2, v2 :: v_dual_cndmask_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x12,0xcb,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v3, v2 :: v_dual_cndmask_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x12,0xcb,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s105, v2 :: v_dual_cndmask_b32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x12,0xcb,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s1, v2 :: v_dual_cndmask_b32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x12,0xcb,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, ttmp15, v2 :: v_dual_cndmask_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x12,0xcb,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_hi, v2 :: v_dual_cndmask_b32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x12,0xcb,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_lo, v2 :: v_dual_cndmask_b32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x12,0xcb,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, m0, v2 :: v_dual_cndmask_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x12,0xcb,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_hi, v2 :: v_dual_cndmask_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x12,0xcb,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_lo, v2 :: v_dual_cndmask_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x12,0xcb,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0xfe0b, v2 :: v_dual_cndmask_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x12,0xcb,0x7c,0x06,0x06,0xff,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, src_scc, v2 :: v_dual_cndmask_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x12,0xcb,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0.5, v3 :: v_dual_cndmask_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x12,0xcb,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, -1, v4 :: v_dual_cndmask_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x12,0xcb,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v6, null, v5 :: v_dual_cndmask_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x12,0xcb,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v4, v2 :: v_dual_dot2acc_f32_f16 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x18,0xcb,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v1, v2 :: v_dual_dot2acc_f32_f16 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x18,0xcb,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v255, v2 :: v_dual_dot2acc_f32_f16 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x18,0xcb,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v2, v2 :: v_dual_dot2acc_f32_f16 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x18,0xcb,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v3, v2 :: v_dual_dot2acc_f32_f16 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x18,0xcb,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s105, v2 :: v_dual_dot2acc_f32_f16 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x18,0xcb,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s1, v2 :: v_dual_dot2acc_f32_f16 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x18,0xcb,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, ttmp15, v2 :: v_dual_dot2acc_f32_f16 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x18,0xcb,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_hi, v2 :: v_dual_dot2acc_f32_f16 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x18,0xcb,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_lo, v2 :: v_dual_dot2acc_f32_f16 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x18,0xcb,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, m0, v2 :: v_dual_dot2acc_f32_f16 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x18,0xcb,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_hi, v2 :: v_dual_dot2acc_f32_f16 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x18,0xcb,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_lo, v2 :: v_dual_dot2acc_f32_f16 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x18,0xcb,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0xfe0b, v2 :: v_dual_dot2acc_f32_f16 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x18,0xcb,0x7c,0x06,0x06,0xff,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, src_scc, v2 :: v_dual_dot2acc_f32_f16 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x18,0xcb,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0.5, v3 :: v_dual_dot2acc_f32_f16 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x18,0xcb,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, -1, v4 :: v_dual_dot2acc_f32_f16 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x18,0xcb,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v6, null, v5 :: v_dual_dot2acc_f32_f16 v255, 0xfe0b, v4
// GFX11: encoding: [0x7c,0x0a,0x18,0xcb,0xff,0x08,0xfe,0x06,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v4, v2 :: v_dual_fmaak_f32 v6, v255, v3, 0xaf123456
// GFX11: encoding: [0x04,0x05,0x02,0xcb,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v1, v2 :: v_dual_fmaak_f32 v6, v3, v3, 0xaf123456
// GFX11: encoding: [0x01,0x05,0x02,0xcb,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v255, v2 :: v_dual_fmaak_f32 v6, v2, v3, 0xaf123456
// GFX11: encoding: [0xff,0x05,0x02,0xcb,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v2, v2 :: v_dual_fmaak_f32 v6, v4, v3, 0xaf123456
// GFX11: encoding: [0x02,0x05,0x02,0xcb,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v3, v2 :: v_dual_fmaak_f32 v6, vcc_lo, v3, 0xaf123456
// GFX11: encoding: [0x03,0x05,0x02,0xcb,0x6a,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s105, v2 :: v_dual_fmaak_f32 v6, s105, v3, 0xaf123456
// GFX11: encoding: [0x69,0x04,0x02,0xcb,0x69,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s1, v2 :: v_dual_fmaak_f32 v6, s1, v3, 0xaf123456
// GFX11: encoding: [0x01,0x04,0x02,0xcb,0x01,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, ttmp15, v2 :: v_dual_fmaak_f32 v6, ttmp15, v3, 0xaf123456
// GFX11: encoding: [0x7b,0x04,0x02,0xcb,0x7b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_hi, v2 :: v_dual_fmaak_f32 v6, exec_hi, v3, 0xaf123456
// GFX11: encoding: [0x7f,0x04,0x02,0xcb,0x7f,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_lo, v2 :: v_dual_fmaak_f32 v6, exec_lo, v3, 0xaf123456
// GFX11: encoding: [0x7e,0x04,0x02,0xcb,0x7e,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, m0, v2 :: v_dual_fmaak_f32 v6, m0, v3, 0xaf123456
// GFX11: encoding: [0x7d,0x04,0x02,0xcb,0x7d,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_hi, v2 :: v_dual_fmaak_f32 v6, vcc_hi, v3, 0xaf123456
// GFX11: encoding: [0x6b,0x04,0x02,0xcb,0x6b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_lo, v2 :: v_dual_fmaak_f32 v6, null, v3, 0xaf123456
// GFX11: encoding: [0x6a,0x04,0x02,0xcb,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, src_scc, v2 :: v_dual_fmaak_f32 v6, -1, v3, 0xaf123456
// GFX11: encoding: [0xfd,0x04,0x02,0xcb,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0.5, v3 :: v_dual_fmaak_f32 v6, 0.5, v2, 0xaf123456
// GFX11: encoding: [0xf0,0x06,0x02,0xcb,0xf0,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, -1, v4 :: v_dual_fmaak_f32 v6, src_scc, v5, 0xaf123456
// GFX11: encoding: [0xc1,0x08,0x02,0xcb,0xfd,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v6, null, v5 :: v_dual_fmaak_f32 v255, 0xaf123456, v4, 0xaf123456
// GFX11: encoding: [0x7c,0x0a,0x02,0xcb,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v4, v2 :: v_dual_fmac_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x00,0xcb,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v1, v2 :: v_dual_fmac_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x00,0xcb,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v255, v2 :: v_dual_fmac_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x00,0xcb,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v2, v2 :: v_dual_fmac_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x00,0xcb,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v3, v2 :: v_dual_fmac_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x00,0xcb,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s105, v2 :: v_dual_fmac_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x00,0xcb,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s1, v2 :: v_dual_fmac_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x00,0xcb,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, ttmp15, v2 :: v_dual_fmac_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x00,0xcb,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_hi, v2 :: v_dual_fmac_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x00,0xcb,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_lo, v2 :: v_dual_fmac_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x00,0xcb,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, m0, v2 :: v_dual_fmac_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x00,0xcb,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_hi, v2 :: v_dual_fmac_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x00,0xcb,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_lo, v2 :: v_dual_fmac_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x00,0xcb,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0xfe0b, v2 :: v_dual_fmac_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x00,0xcb,0x7c,0x06,0x06,0xff,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, src_scc, v2 :: v_dual_fmac_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x00,0xcb,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0.5, v3 :: v_dual_fmac_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x00,0xcb,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, -1, v4 :: v_dual_fmac_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x00,0xcb,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v6, null, v5 :: v_dual_fmac_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x00,0xcb,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v4, v255 :: v_dual_fmamk_f32 v6, v255, 0xaf123456, v4
// GFX11: encoding: [0x04,0xff,0x05,0xcb,0xff,0x09,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v1, v255 :: v_dual_fmamk_f32 v6, v3, 0xaf123456, v4
// GFX11: encoding: [0x01,0xff,0x05,0xcb,0x03,0x09,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v255, v255 :: v_dual_fmamk_f32 v6, v2, 0xaf123456, v4
// GFX11: encoding: [0xff,0xff,0x05,0xcb,0x02,0x09,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v2, v255 :: v_dual_fmamk_f32 v6, v4, 0xaf123456, v4
// GFX11: encoding: [0x02,0xff,0x05,0xcb,0x04,0x09,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v3, v255 :: v_dual_fmamk_f32 v6, vcc_lo, 0xaf123456, v4
// GFX11: encoding: [0x03,0xff,0x05,0xcb,0x6a,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s105, v255 :: v_dual_fmamk_f32 v6, s105, 0xaf123456, v4
// GFX11: encoding: [0x69,0xfe,0x05,0xcb,0x69,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s1, v255 :: v_dual_fmamk_f32 v6, s1, 0xaf123456, v4
// GFX11: encoding: [0x01,0xfe,0x05,0xcb,0x01,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, ttmp15, v255 :: v_dual_fmamk_f32 v6, ttmp15, 0xaf123456, v4
// GFX11: encoding: [0x7b,0xfe,0x05,0xcb,0x7b,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_hi, v255 :: v_dual_fmamk_f32 v6, exec_hi, 0xaf123456, v4
// GFX11: encoding: [0x7f,0xfe,0x05,0xcb,0x7f,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_lo, v255 :: v_dual_fmamk_f32 v6, exec_lo, 0xaf123456, v4
// GFX11: encoding: [0x7e,0xfe,0x05,0xcb,0x7e,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, m0, v255 :: v_dual_fmamk_f32 v6, m0, 0xaf123456, v4
// GFX11: encoding: [0x7d,0xfe,0x05,0xcb,0x7d,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_hi, v255 :: v_dual_fmamk_f32 v6, vcc_hi, 0xaf123456, v4
// GFX11: encoding: [0x6b,0xfe,0x05,0xcb,0x6b,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_lo, v255 :: v_dual_fmamk_f32 v6, null, 0xaf123456, v4
// GFX11: encoding: [0x6a,0xfe,0x05,0xcb,0x7c,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, src_scc, v255 :: v_dual_fmamk_f32 v6, -1, 0xaf123456, v4
// GFX11: encoding: [0xfd,0xfe,0x05,0xcb,0xc1,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0.5, v3 :: v_dual_fmamk_f32 v6, 0.5, 0xaf123456, v4
// GFX11: encoding: [0xf0,0x06,0x04,0xcb,0xf0,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, -1, v4 :: v_dual_fmamk_f32 v6, src_scc, 0xaf123456, v4
// GFX11: encoding: [0xc1,0x08,0x04,0xcb,0xfd,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v6, null, v5 :: v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v255
// GFX11: encoding: [0x7c,0x0a,0x04,0xcb,0xff,0xfe,0xff,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v4, v2 :: v_dual_lshlrev_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x22,0xcb,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v1, v2 :: v_dual_lshlrev_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x22,0xcb,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v255, v2 :: v_dual_lshlrev_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x22,0xcb,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v2, v2 :: v_dual_lshlrev_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x22,0xcb,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v3, v2 :: v_dual_lshlrev_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x22,0xcb,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s105, v2 :: v_dual_lshlrev_b32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x22,0xcb,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s1, v2 :: v_dual_lshlrev_b32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x22,0xcb,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, ttmp15, v2 :: v_dual_lshlrev_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x22,0xcb,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_hi, v2 :: v_dual_lshlrev_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x22,0xcb,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_lo, v2 :: v_dual_lshlrev_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x22,0xcb,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, m0, v2 :: v_dual_lshlrev_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x22,0xcb,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_hi, v2 :: v_dual_lshlrev_b32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x22,0xcb,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_lo, v2 :: v_dual_lshlrev_b32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x22,0xcb,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0xfe0b, v2 :: v_dual_lshlrev_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x22,0xcb,0x7c,0x06,0x06,0xff,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, src_scc, v2 :: v_dual_lshlrev_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x22,0xcb,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0.5, v3 :: v_dual_lshlrev_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x22,0xcb,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, -1, v4 :: v_dual_lshlrev_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x22,0xcb,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v6, null, v5 :: v_dual_lshlrev_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x22,0xcb,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v4, v2 :: v_dual_max_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x14,0xcb,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v1, v2 :: v_dual_max_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x14,0xcb,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v255, v2 :: v_dual_max_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x14,0xcb,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v2, v2 :: v_dual_max_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x14,0xcb,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v3, v2 :: v_dual_max_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x14,0xcb,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s105, v2 :: v_dual_max_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x14,0xcb,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s1, v2 :: v_dual_max_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x14,0xcb,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, ttmp15, v2 :: v_dual_max_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x14,0xcb,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_hi, v2 :: v_dual_max_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x14,0xcb,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_lo, v2 :: v_dual_max_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x14,0xcb,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, m0, v2 :: v_dual_max_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x14,0xcb,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_hi, v2 :: v_dual_max_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x14,0xcb,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_lo, v2 :: v_dual_max_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x14,0xcb,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0xfe0b, v2 :: v_dual_max_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x14,0xcb,0x7c,0x06,0x06,0xff,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, src_scc, v2 :: v_dual_max_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x14,0xcb,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0.5, v3 :: v_dual_max_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x14,0xcb,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, -1, v4 :: v_dual_max_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x14,0xcb,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v6, null, v5 :: v_dual_max_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x14,0xcb,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v4, v2 :: v_dual_min_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x16,0xcb,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v1, v2 :: v_dual_min_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x16,0xcb,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v255, v2 :: v_dual_min_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x16,0xcb,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v2, v2 :: v_dual_min_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x16,0xcb,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v3, v2 :: v_dual_min_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x16,0xcb,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s105, v2 :: v_dual_min_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x16,0xcb,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s1, v2 :: v_dual_min_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x16,0xcb,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, ttmp15, v2 :: v_dual_min_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x16,0xcb,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_hi, v2 :: v_dual_min_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x16,0xcb,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_lo, v2 :: v_dual_min_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x16,0xcb,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, m0, v2 :: v_dual_min_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x16,0xcb,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_hi, v2 :: v_dual_min_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x16,0xcb,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_lo, v2 :: v_dual_min_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x16,0xcb,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0xfe0b, v2 :: v_dual_min_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x16,0xcb,0x7c,0x06,0x06,0xff,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, src_scc, v2 :: v_dual_min_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x16,0xcb,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0.5, v3 :: v_dual_min_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x16,0xcb,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, -1, v4 :: v_dual_min_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x16,0xcb,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v6, null, v5 :: v_dual_min_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x16,0xcb,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v4, v255 :: v_dual_mov_b32 v6, v1
// GFX11: encoding: [0x04,0xff,0x11,0xcb,0x01,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v1, v255 :: v_dual_mov_b32 v6, v255
// GFX11: encoding: [0x01,0xff,0x11,0xcb,0xff,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v255, v255 :: v_dual_mov_b32 v6, v2
// GFX11: encoding: [0xff,0xff,0x11,0xcb,0x02,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v2, v255 :: v_dual_mov_b32 v6, v3
// GFX11: encoding: [0x02,0xff,0x11,0xcb,0x03,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v3, v255 :: v_dual_mov_b32 v6, v4
// GFX11: encoding: [0x03,0xff,0x11,0xcb,0x04,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s105, v255 :: v_dual_mov_b32 v6, s1
// GFX11: encoding: [0x69,0xfe,0x11,0xcb,0x01,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s1, v255 :: v_dual_mov_b32 v6, s105
// GFX11: encoding: [0x01,0xfe,0x11,0xcb,0x69,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, ttmp15, v255 :: v_dual_mov_b32 v6, vcc_lo
// GFX11: encoding: [0x7b,0xfe,0x11,0xcb,0x6a,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_hi, v255 :: v_dual_mov_b32 v6, vcc_hi
// GFX11: encoding: [0x7f,0xfe,0x11,0xcb,0x6b,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_lo, v255 :: v_dual_mov_b32 v6, ttmp15
// GFX11: encoding: [0x7e,0xfe,0x11,0xcb,0x7b,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, m0, v255 :: v_dual_mov_b32 v6, m0
// GFX11: encoding: [0x7d,0xfe,0x11,0xcb,0x7d,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_hi, v255 :: v_dual_mov_b32 v6, exec_lo
// GFX11: encoding: [0x6b,0xfe,0x11,0xcb,0x7e,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_lo, v255 :: v_dual_mov_b32 v6, exec_hi
// GFX11: encoding: [0x6a,0xfe,0x11,0xcb,0x7f,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0xfe0b, v255 :: v_dual_mov_b32 v6, null
// GFX11: encoding: [0xff,0xfe,0x11,0xcb,0x7c,0x00,0x06,0xff,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, src_scc, v255 :: v_dual_mov_b32 v6, -1
// GFX11: encoding: [0xfd,0xfe,0x11,0xcb,0xc1,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0.5, v3 :: v_dual_mov_b32 v6, 0.5
// GFX11: encoding: [0xf0,0x06,0x10,0xcb,0xf0,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, -1, v4 :: v_dual_mov_b32 v6, src_scc
// GFX11: encoding: [0xc1,0x08,0x10,0xcb,0xfd,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v6, null, v5 :: v_dual_mov_b32 v255, 0xaf123456
// GFX11: encoding: [0x7c,0x0a,0x10,0xcb,0xff,0x00,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v4, v2 :: v_dual_mul_dx9_zero_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x0e,0xcb,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v1, v2 :: v_dual_mul_dx9_zero_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x0e,0xcb,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v255, v2 :: v_dual_mul_dx9_zero_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x0e,0xcb,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v2, v2 :: v_dual_mul_dx9_zero_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x0e,0xcb,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v3, v2 :: v_dual_mul_dx9_zero_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x0e,0xcb,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s105, v2 :: v_dual_mul_dx9_zero_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x0e,0xcb,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s1, v2 :: v_dual_mul_dx9_zero_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x0e,0xcb,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, ttmp15, v2 :: v_dual_mul_dx9_zero_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x0e,0xcb,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_hi, v2 :: v_dual_mul_dx9_zero_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x0e,0xcb,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_lo, v2 :: v_dual_mul_dx9_zero_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x0e,0xcb,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, m0, v2 :: v_dual_mul_dx9_zero_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x0e,0xcb,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_hi, v2 :: v_dual_mul_dx9_zero_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x0e,0xcb,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_lo, v2 :: v_dual_mul_dx9_zero_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x0e,0xcb,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0xfe0b, v2 :: v_dual_mul_dx9_zero_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x0e,0xcb,0x7c,0x06,0x06,0xff,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, src_scc, v2 :: v_dual_mul_dx9_zero_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x0e,0xcb,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0.5, v3 :: v_dual_mul_dx9_zero_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x0e,0xcb,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, -1, v4 :: v_dual_mul_dx9_zero_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x0e,0xcb,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v6, null, v5 :: v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x0e,0xcb,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v4, v2 :: v_dual_mul_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x06,0xcb,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v1, v2 :: v_dual_mul_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x06,0xcb,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v255, v2 :: v_dual_mul_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x06,0xcb,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v2, v2 :: v_dual_mul_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x06,0xcb,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v3, v2 :: v_dual_mul_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x06,0xcb,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s105, v2 :: v_dual_mul_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x06,0xcb,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s1, v2 :: v_dual_mul_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x06,0xcb,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, ttmp15, v2 :: v_dual_mul_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x06,0xcb,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_hi, v2 :: v_dual_mul_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x06,0xcb,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_lo, v2 :: v_dual_mul_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x06,0xcb,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, m0, v2 :: v_dual_mul_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x06,0xcb,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_hi, v2 :: v_dual_mul_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x06,0xcb,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_lo, v2 :: v_dual_mul_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x06,0xcb,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0xfe0b, v2 :: v_dual_mul_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x06,0xcb,0x7c,0x06,0x06,0xff,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, src_scc, v2 :: v_dual_mul_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x06,0xcb,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0.5, v3 :: v_dual_mul_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x06,0xcb,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, -1, v4 :: v_dual_mul_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x06,0xcb,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v6, null, v5 :: v_dual_mul_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x06,0xcb,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v4, v2 :: v_dual_sub_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x0a,0xcb,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v1, v2 :: v_dual_sub_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x0a,0xcb,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v255, v2 :: v_dual_sub_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x0a,0xcb,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v2, v2 :: v_dual_sub_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x0a,0xcb,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v3, v2 :: v_dual_sub_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x0a,0xcb,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s105, v2 :: v_dual_sub_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x0a,0xcb,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s1, v2 :: v_dual_sub_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x0a,0xcb,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, ttmp15, v2 :: v_dual_sub_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x0a,0xcb,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_hi, v2 :: v_dual_sub_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x0a,0xcb,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_lo, v2 :: v_dual_sub_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x0a,0xcb,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, m0, v2 :: v_dual_sub_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x0a,0xcb,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_hi, v2 :: v_dual_sub_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x0a,0xcb,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_lo, v2 :: v_dual_sub_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x0a,0xcb,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0xfe0b, v2 :: v_dual_sub_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x0a,0xcb,0x7c,0x06,0x06,0xff,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, src_scc, v2 :: v_dual_sub_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x0a,0xcb,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0.5, v3 :: v_dual_sub_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x0a,0xcb,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, -1, v4 :: v_dual_sub_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x0a,0xcb,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v6, null, v5 :: v_dual_sub_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x0a,0xcb,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v4, v2 :: v_dual_subrev_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x0c,0xcb,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v1, v2 :: v_dual_subrev_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x0c,0xcb,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v255, v2 :: v_dual_subrev_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x0c,0xcb,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v2, v2 :: v_dual_subrev_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x0c,0xcb,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, v3, v2 :: v_dual_subrev_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x0c,0xcb,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s105, v2 :: v_dual_subrev_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x0c,0xcb,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, s1, v2 :: v_dual_subrev_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x0c,0xcb,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, ttmp15, v2 :: v_dual_subrev_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x0c,0xcb,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_hi, v2 :: v_dual_subrev_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x0c,0xcb,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, exec_lo, v2 :: v_dual_subrev_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x0c,0xcb,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, m0, v2 :: v_dual_subrev_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x0c,0xcb,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_hi, v2 :: v_dual_subrev_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x0c,0xcb,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, vcc_lo, v2 :: v_dual_subrev_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x0c,0xcb,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0xfe0b, v2 :: v_dual_subrev_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x0c,0xcb,0x7c,0x06,0x06,0xff,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, src_scc, v2 :: v_dual_subrev_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x0c,0xcb,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, 0.5, v3 :: v_dual_subrev_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x0c,0xcb,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v255, -1, v4 :: v_dual_subrev_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x0c,0xcb,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_dot2acc_f32_f16 v6, null, v5 :: v_dual_subrev_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x0c,0xcb,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v4, v2, 0xaf123456 :: v_dual_add_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x48,0xc8,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v1, v2, 0xaf123456 :: v_dual_add_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x48,0xc8,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v255, v2, 0xaf123456 :: v_dual_add_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x48,0xc8,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v2, v2, 0xaf123456 :: v_dual_add_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x48,0xc8,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v3, v2, 0xaf123456 :: v_dual_add_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x48,0xc8,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s105, v2, 0xaf123456 :: v_dual_add_f32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x48,0xc8,0x69,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s1, v2, 0xaf123456 :: v_dual_add_f32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x48,0xc8,0x01,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, ttmp15, v2, 0xaf123456 :: v_dual_add_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x48,0xc8,0x7b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_hi, v2, 0xaf123456 :: v_dual_add_f32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x48,0xc8,0x7f,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_lo, v2, 0xaf123456 :: v_dual_add_f32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x48,0xc8,0x7e,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, m0, v2, 0xaf123456 :: v_dual_add_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x48,0xc8,0x7d,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_hi, v2, 0xaf123456 :: v_dual_add_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x48,0xc8,0x6b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_lo, v2, 0xaf123456 :: v_dual_add_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x48,0xc8,0x6a,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0xaf123456, v2, 0xaf123456 :: v_dual_add_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x48,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, src_scc, v2, 0xaf123456 :: v_dual_add_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x48,0xc8,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0.5, v3, 0xaf123456 :: v_dual_add_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x48,0xc8,0xf0,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, -1, v4, 0xaf123456 :: v_dual_add_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x48,0xc8,0xfd,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v6, null, v5, 0xaf123456 :: v_dual_add_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x48,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v4, v2, 0xaf123456 :: v_dual_add_nc_u32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x60,0xc8,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v1, v2, 0xaf123456 :: v_dual_add_nc_u32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x60,0xc8,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v255, v2, 0xaf123456 :: v_dual_add_nc_u32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x60,0xc8,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v2, v2, 0xaf123456 :: v_dual_add_nc_u32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x60,0xc8,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v3, v2, 0xaf123456 :: v_dual_add_nc_u32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x60,0xc8,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s105, v2, 0xaf123456 :: v_dual_add_nc_u32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x60,0xc8,0x69,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s1, v2, 0xaf123456 :: v_dual_add_nc_u32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x60,0xc8,0x01,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, ttmp15, v2, 0xaf123456 :: v_dual_add_nc_u32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x60,0xc8,0x7b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_hi, v2, 0xaf123456 :: v_dual_add_nc_u32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x60,0xc8,0x7f,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_lo, v2, 0xaf123456 :: v_dual_add_nc_u32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x60,0xc8,0x7e,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, m0, v2, 0xaf123456 :: v_dual_add_nc_u32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x60,0xc8,0x7d,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_hi, v2, 0xaf123456 :: v_dual_add_nc_u32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x60,0xc8,0x6b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_lo, v2, 0xaf123456 :: v_dual_add_nc_u32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x60,0xc8,0x6a,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0xaf123456, v2, 0xaf123456 :: v_dual_add_nc_u32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x60,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, src_scc, v2, 0xaf123456 :: v_dual_add_nc_u32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x60,0xc8,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0.5, v3, 0xaf123456 :: v_dual_add_nc_u32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x60,0xc8,0xf0,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, -1, v4, 0xaf123456 :: v_dual_add_nc_u32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x60,0xc8,0xfd,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v6, null, v5, 0xaf123456 :: v_dual_add_nc_u32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x60,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v4, v2, 0xaf123456 :: v_dual_and_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x64,0xc8,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v1, v2, 0xaf123456 :: v_dual_and_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x64,0xc8,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v255, v2, 0xaf123456 :: v_dual_and_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x64,0xc8,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v2, v2, 0xaf123456 :: v_dual_and_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x64,0xc8,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v3, v2, 0xaf123456 :: v_dual_and_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x64,0xc8,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s105, v2, 0xaf123456 :: v_dual_and_b32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x64,0xc8,0x69,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s1, v2, 0xaf123456 :: v_dual_and_b32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x64,0xc8,0x01,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, ttmp15, v2, 0xaf123456 :: v_dual_and_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x64,0xc8,0x7b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_hi, v2, 0xaf123456 :: v_dual_and_b32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x64,0xc8,0x7f,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_lo, v2, 0xaf123456 :: v_dual_and_b32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x64,0xc8,0x7e,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, m0, v2, 0xaf123456 :: v_dual_and_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x64,0xc8,0x7d,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_hi, v2, 0xaf123456 :: v_dual_and_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x64,0xc8,0x6b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_lo, v2, 0xaf123456 :: v_dual_and_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x64,0xc8,0x6a,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0xaf123456, v2, 0xaf123456 :: v_dual_and_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x64,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, src_scc, v2, 0xaf123456 :: v_dual_and_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x64,0xc8,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0.5, v3, 0xaf123456 :: v_dual_and_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x64,0xc8,0xf0,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, -1, v4, 0xaf123456 :: v_dual_and_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x64,0xc8,0xfd,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v6, null, v5, 0xaf123456 :: v_dual_and_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x64,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v4, v2, 0xaf123456 :: v_dual_cndmask_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x52,0xc8,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v1, v2, 0xaf123456 :: v_dual_cndmask_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x52,0xc8,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v255, v2, 0xaf123456 :: v_dual_cndmask_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x52,0xc8,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v2, v2, 0xaf123456 :: v_dual_cndmask_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x52,0xc8,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v3, v2, 0xaf123456 :: v_dual_cndmask_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x52,0xc8,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0xaf123456, v2, 0xaf123456 :: v_dual_cndmask_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x52,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0.5, v3, 0xaf123456 :: v_dual_cndmask_b32 v6, -1, v2
// GFX11: encoding: [0xf0,0x06,0x52,0xc8,0xc1,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, -1, v4, 0xaf123456 :: v_dual_cndmask_b32 v6, 0.5, v5
// GFX11: encoding: [0xc1,0x08,0x52,0xc8,0xf0,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v6, null, v5, 0xaf123456 :: v_dual_cndmask_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x52,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v1, v2, 0xaf123456 :: v_dual_dot2acc_f32_f16 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x58,0xc8,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v255, v2, 0xaf123456 :: v_dual_dot2acc_f32_f16 v6, v1, v3
// GFX11: encoding: [0xff,0x05,0x58,0xc8,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v2, v2, 0xaf123456 :: v_dual_dot2acc_f32_f16 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x58,0xc8,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v3, v2, 0xaf123456 :: v_dual_dot2acc_f32_f16 v6, v2, v3
// GFX11: encoding: [0x03,0x05,0x58,0xc8,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s105, v2, 0xaf123456 :: v_dual_dot2acc_f32_f16 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x58,0xc8,0x69,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s1, v2, 0xaf123456 :: v_dual_dot2acc_f32_f16 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x58,0xc8,0x01,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, ttmp15, v2, 0xaf123456 :: v_dual_dot2acc_f32_f16 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x58,0xc8,0x7b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_hi, v2, 0xaf123456 :: v_dual_dot2acc_f32_f16 v6, v4, v3
// GFX11: encoding: [0x7f,0x04,0x58,0xc8,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_lo, v2, 0xaf123456 :: v_dual_dot2acc_f32_f16 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x58,0xc8,0x7e,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, m0, v2, 0xaf123456 :: v_dual_dot2acc_f32_f16 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x58,0xc8,0x7d,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_hi, v2, 0xaf123456 :: v_dual_dot2acc_f32_f16 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x58,0xc8,0x6b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_lo, v2, 0xaf123456 :: v_dual_dot2acc_f32_f16 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x58,0xc8,0x6a,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0xaf123456, v2, 0xaf123456 :: v_dual_dot2acc_f32_f16 v6, exec_hi, v3
// GFX11: encoding: [0xff,0x04,0x58,0xc8,0x7f,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, src_scc, v2, 0xaf123456 :: v_dual_dot2acc_f32_f16 v6, null, v3
// GFX11: encoding: [0xfd,0x04,0x58,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0.5, v3, 0xaf123456 :: v_dual_dot2acc_f32_f16 v6, -1, v2
// GFX11: encoding: [0xf0,0x06,0x58,0xc8,0xc1,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, -1, v4, 0xaf123456 :: v_dual_dot2acc_f32_f16 v6, 0.5, v5
// GFX11: encoding: [0xc1,0x08,0x58,0xc8,0xf0,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v6, null, v5, 0xaf123456 :: v_dual_dot2acc_f32_f16 v255, src_scc, v4
// GFX11: encoding: [0x7c,0x0a,0x58,0xc8,0xfd,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v4, v2, 0xaf123456 :: v_dual_fmaak_f32 v6, v1, v3, 0xaf123456
// GFX11: encoding: [0x04,0x05,0x42,0xc8,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v1, v2, 0xaf123456 :: v_dual_fmaak_f32 v6, v255, v3, 0xaf123456
// GFX11: encoding: [0x01,0x05,0x42,0xc8,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v255, v2, 0xaf123456 :: v_dual_fmaak_f32 v6, v2, v3, 0xaf123456
// GFX11: encoding: [0xff,0x05,0x42,0xc8,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v2, v2, 0xaf123456 :: v_dual_fmaak_f32 v6, v3, v3, 0xaf123456
// GFX11: encoding: [0x02,0x05,0x42,0xc8,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v3, v2, 0xaf123456 :: v_dual_fmaak_f32 v6, v4, v3, 0xaf123456
// GFX11: encoding: [0x03,0x05,0x42,0xc8,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s105, v2, 0xaf123456 :: v_dual_fmaak_f32 v6, s105, v3, 0xaf123456
// GFX11: encoding: [0x69,0x04,0x42,0xc8,0x69,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s1, v2, 0xaf123456 :: v_dual_fmaak_f32 v6, s1, v3, 0xaf123456
// GFX11: encoding: [0x01,0x04,0x42,0xc8,0x01,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, ttmp15, v2, 0xaf123456 :: v_dual_fmaak_f32 v6, ttmp15, v3, 0xaf123456
// GFX11: encoding: [0x7b,0x04,0x42,0xc8,0x7b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_hi, v2, 0xaf123456 :: v_dual_fmaak_f32 v6, exec_hi, v3, 0xaf123456
// GFX11: encoding: [0x7f,0x04,0x42,0xc8,0x7f,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_lo, v2, 0xaf123456 :: v_dual_fmaak_f32 v6, exec_lo, v3, 0xaf123456
// GFX11: encoding: [0x7e,0x04,0x42,0xc8,0x7e,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, m0, v2, 0xaf123456 :: v_dual_fmaak_f32 v6, m0, v3, 0xaf123456
// GFX11: encoding: [0x7d,0x04,0x42,0xc8,0x7d,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_hi, v2, 0xaf123456 :: v_dual_fmaak_f32 v6, vcc_hi, v3, 0xaf123456
// GFX11: encoding: [0x6b,0x04,0x42,0xc8,0x6b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_lo, v2, 0xaf123456 :: v_dual_fmaak_f32 v6, vcc_lo, v3, 0xaf123456
// GFX11: encoding: [0x6a,0x04,0x42,0xc8,0x6a,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0xaf123456, v2, 0xaf123456 :: v_dual_fmaak_f32 v6, null, v3, 0xaf123456
// GFX11: encoding: [0xff,0x04,0x42,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, src_scc, v2, 0xaf123456 :: v_dual_fmaak_f32 v6, -1, v3, 0xaf123456
// GFX11: encoding: [0xfd,0x04,0x42,0xc8,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0.5, v3, 0xaf123456 :: v_dual_fmaak_f32 v6, 0.5, v2, 0xaf123456
// GFX11: encoding: [0xf0,0x06,0x42,0xc8,0xf0,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, -1, v4, 0xaf123456 :: v_dual_fmaak_f32 v6, src_scc, v5, 0xaf123456
// GFX11: encoding: [0xc1,0x08,0x42,0xc8,0xfd,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v6, null, v5, 0xaf123456 :: v_dual_fmaak_f32 v255, 0xaf123456, v4, 0xaf123456
// GFX11: encoding: [0x7c,0x0a,0x42,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v4, v2, 0xaf123456 :: v_dual_fmac_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x40,0xc8,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v1, v2, 0xaf123456 :: v_dual_fmac_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x40,0xc8,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v255, v2, 0xaf123456 :: v_dual_fmac_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x40,0xc8,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v2, v2, 0xaf123456 :: v_dual_fmac_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x40,0xc8,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v3, v2, 0xaf123456 :: v_dual_fmac_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x40,0xc8,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s105, v2, 0xaf123456 :: v_dual_fmac_f32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x40,0xc8,0x69,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s1, v2, 0xaf123456 :: v_dual_fmac_f32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x40,0xc8,0x01,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, ttmp15, v2, 0xaf123456 :: v_dual_fmac_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x40,0xc8,0x7b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_hi, v2, 0xaf123456 :: v_dual_fmac_f32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x40,0xc8,0x7f,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_lo, v2, 0xaf123456 :: v_dual_fmac_f32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x40,0xc8,0x7e,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, m0, v2, 0xaf123456 :: v_dual_fmac_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x40,0xc8,0x7d,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_hi, v2, 0xaf123456 :: v_dual_fmac_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x40,0xc8,0x6b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_lo, v2, 0xaf123456 :: v_dual_fmac_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x40,0xc8,0x6a,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0xaf123456, v2, 0xaf123456 :: v_dual_fmac_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x40,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, src_scc, v2, 0xaf123456 :: v_dual_fmac_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x40,0xc8,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0.5, v3, 0xaf123456 :: v_dual_fmac_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x40,0xc8,0xf0,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, -1, v4, 0xaf123456 :: v_dual_fmac_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x40,0xc8,0xfd,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v6, null, v5, 0xaf123456 :: v_dual_fmac_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x40,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v4, v255, 0xaf123456 :: v_dual_fmamk_f32 v6, v1, 0xaf123456, v255
// GFX11: encoding: [0x04,0xff,0x45,0xc8,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v1, v255, 0xaf123456 :: v_dual_fmamk_f32 v6, v255, 0xaf123456, v255
// GFX11: encoding: [0x01,0xff,0x45,0xc8,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v255, v255, 0xaf123456 :: v_dual_fmamk_f32 v6, v2, 0xaf123456, v255
// GFX11: encoding: [0xff,0xff,0x45,0xc8,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v2, v255, 0xaf123456 :: v_dual_fmamk_f32 v6, v3, 0xaf123456, v255
// GFX11: encoding: [0x02,0xff,0x45,0xc8,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v3, v255, 0xaf123456 :: v_dual_fmamk_f32 v6, v4, 0xaf123456, v255
// GFX11: encoding: [0x03,0xff,0x45,0xc8,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s105, v255, 0xaf123456 :: v_dual_fmamk_f32 v6, s105, 0xaf123456, v255
// GFX11: encoding: [0x69,0xfe,0x45,0xc8,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s1, v255, 0xaf123456 :: v_dual_fmamk_f32 v6, s1, 0xaf123456, v255
// GFX11: encoding: [0x01,0xfe,0x45,0xc8,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, ttmp15, v255, 0xaf123456 :: v_dual_fmamk_f32 v6, ttmp15, 0xaf123456, v255
// GFX11: encoding: [0x7b,0xfe,0x45,0xc8,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_hi, v255, 0xaf123456 :: v_dual_fmamk_f32 v6, exec_hi, 0xaf123456, v255
// GFX11: encoding: [0x7f,0xfe,0x45,0xc8,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_lo, v255, 0xaf123456 :: v_dual_fmamk_f32 v6, exec_lo, 0xaf123456, v255
// GFX11: encoding: [0x7e,0xfe,0x45,0xc8,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, m0, v255, 0xaf123456 :: v_dual_fmamk_f32 v6, m0, 0xaf123456, v255
// GFX11: encoding: [0x7d,0xfe,0x45,0xc8,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_hi, v255, 0xaf123456 :: v_dual_fmamk_f32 v6, vcc_hi, 0xaf123456, v255
// GFX11: encoding: [0x6b,0xfe,0x45,0xc8,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_lo, v255, 0xaf123456 :: v_dual_fmamk_f32 v6, vcc_lo, 0xaf123456, v255
// GFX11: encoding: [0x6a,0xfe,0x45,0xc8,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0xaf123456, v255, 0xaf123456 :: v_dual_fmamk_f32 v6, null, 0xaf123456, v255
// GFX11: encoding: [0xff,0xfe,0x45,0xc8,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, src_scc, v255, 0xaf123456 :: v_dual_fmamk_f32 v6, -1, 0xaf123456, v255
// GFX11: encoding: [0xfd,0xfe,0x45,0xc8,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0.5, v3, 0xaf123456 :: v_dual_fmamk_f32 v6, 0.5, 0xaf123456, v255
// GFX11: encoding: [0xf0,0x06,0x44,0xc8,0xf0,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, -1, v4, 0xaf123456 :: v_dual_fmamk_f32 v6, src_scc, 0xaf123456, v255
// GFX11: encoding: [0xc1,0x08,0x44,0xc8,0xfd,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v6, null, v5, 0xaf123456 :: v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x44,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v4, v2, 0xaf123456 :: v_dual_lshlrev_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x62,0xc8,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v1, v2, 0xaf123456 :: v_dual_lshlrev_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x62,0xc8,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v255, v2, 0xaf123456 :: v_dual_lshlrev_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x62,0xc8,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v2, v2, 0xaf123456 :: v_dual_lshlrev_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x62,0xc8,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v3, v2, 0xaf123456 :: v_dual_lshlrev_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x62,0xc8,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s105, v2, 0xaf123456 :: v_dual_lshlrev_b32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x62,0xc8,0x69,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s1, v2, 0xaf123456 :: v_dual_lshlrev_b32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x62,0xc8,0x01,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, ttmp15, v2, 0xaf123456 :: v_dual_lshlrev_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x62,0xc8,0x7b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_hi, v2, 0xaf123456 :: v_dual_lshlrev_b32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x62,0xc8,0x7f,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_lo, v2, 0xaf123456 :: v_dual_lshlrev_b32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x62,0xc8,0x7e,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, m0, v2, 0xaf123456 :: v_dual_lshlrev_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x62,0xc8,0x7d,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_hi, v2, 0xaf123456 :: v_dual_lshlrev_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x62,0xc8,0x6b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_lo, v2, 0xaf123456 :: v_dual_lshlrev_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x62,0xc8,0x6a,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0xaf123456, v2, 0xaf123456 :: v_dual_lshlrev_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x62,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, src_scc, v2, 0xaf123456 :: v_dual_lshlrev_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x62,0xc8,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0.5, v3, 0xaf123456 :: v_dual_lshlrev_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x62,0xc8,0xf0,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, -1, v4, 0xaf123456 :: v_dual_lshlrev_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x62,0xc8,0xfd,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v6, null, v5, 0xaf123456 :: v_dual_lshlrev_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x62,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v4, v2, 0xaf123456 :: v_dual_max_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x54,0xc8,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v1, v2, 0xaf123456 :: v_dual_max_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x54,0xc8,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v255, v2, 0xaf123456 :: v_dual_max_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x54,0xc8,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v2, v2, 0xaf123456 :: v_dual_max_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x54,0xc8,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v3, v2, 0xaf123456 :: v_dual_max_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x54,0xc8,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s105, v2, 0xaf123456 :: v_dual_max_f32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x54,0xc8,0x69,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s1, v2, 0xaf123456 :: v_dual_max_f32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x54,0xc8,0x01,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, ttmp15, v2, 0xaf123456 :: v_dual_max_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x54,0xc8,0x7b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_hi, v2, 0xaf123456 :: v_dual_max_f32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x54,0xc8,0x7f,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_lo, v2, 0xaf123456 :: v_dual_max_f32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x54,0xc8,0x7e,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, m0, v2, 0xaf123456 :: v_dual_max_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x54,0xc8,0x7d,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_hi, v2, 0xaf123456 :: v_dual_max_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x54,0xc8,0x6b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_lo, v2, 0xaf123456 :: v_dual_max_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x54,0xc8,0x6a,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0xaf123456, v2, 0xaf123456 :: v_dual_max_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x54,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, src_scc, v2, 0xaf123456 :: v_dual_max_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x54,0xc8,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0.5, v3, 0xaf123456 :: v_dual_max_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x54,0xc8,0xf0,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, -1, v4, 0xaf123456 :: v_dual_max_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x54,0xc8,0xfd,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v6, null, v5, 0xaf123456 :: v_dual_max_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x54,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v4, v2, 0xaf123456 :: v_dual_min_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x56,0xc8,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v1, v2, 0xaf123456 :: v_dual_min_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x56,0xc8,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v255, v2, 0xaf123456 :: v_dual_min_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x56,0xc8,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v2, v2, 0xaf123456 :: v_dual_min_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x56,0xc8,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v3, v2, 0xaf123456 :: v_dual_min_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x56,0xc8,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s105, v2, 0xaf123456 :: v_dual_min_f32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x56,0xc8,0x69,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s1, v2, 0xaf123456 :: v_dual_min_f32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x56,0xc8,0x01,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, ttmp15, v2, 0xaf123456 :: v_dual_min_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x56,0xc8,0x7b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_hi, v2, 0xaf123456 :: v_dual_min_f32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x56,0xc8,0x7f,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_lo, v2, 0xaf123456 :: v_dual_min_f32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x56,0xc8,0x7e,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, m0, v2, 0xaf123456 :: v_dual_min_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x56,0xc8,0x7d,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_hi, v2, 0xaf123456 :: v_dual_min_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x56,0xc8,0x6b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_lo, v2, 0xaf123456 :: v_dual_min_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x56,0xc8,0x6a,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0xaf123456, v2, 0xaf123456 :: v_dual_min_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x56,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, src_scc, v2, 0xaf123456 :: v_dual_min_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x56,0xc8,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0.5, v3, 0xaf123456 :: v_dual_min_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x56,0xc8,0xf0,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, -1, v4, 0xaf123456 :: v_dual_min_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x56,0xc8,0xfd,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v6, null, v5, 0xaf123456 :: v_dual_min_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x56,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v4, v255, 0xaf123456 :: v_dual_mov_b32 v6, v1
// GFX11: encoding: [0x04,0xff,0x51,0xc8,0x01,0x01,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v1, v255, 0xaf123456 :: v_dual_mov_b32 v6, v255
// GFX11: encoding: [0x01,0xff,0x51,0xc8,0xff,0x01,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v255, v255, 0xaf123456 :: v_dual_mov_b32 v6, v2
// GFX11: encoding: [0xff,0xff,0x51,0xc8,0x02,0x01,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v2, v255, 0xaf123456 :: v_dual_mov_b32 v6, v3
// GFX11: encoding: [0x02,0xff,0x51,0xc8,0x03,0x01,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v3, v255, 0xaf123456 :: v_dual_mov_b32 v6, v4
// GFX11: encoding: [0x03,0xff,0x51,0xc8,0x04,0x01,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s105, v255, 0xaf123456 :: v_dual_mov_b32 v6, s105
// GFX11: encoding: [0x69,0xfe,0x51,0xc8,0x69,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s1, v255, 0xaf123456 :: v_dual_mov_b32 v6, s1
// GFX11: encoding: [0x01,0xfe,0x51,0xc8,0x01,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, ttmp15, v255, 0xaf123456 :: v_dual_mov_b32 v6, ttmp15
// GFX11: encoding: [0x7b,0xfe,0x51,0xc8,0x7b,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_hi, v255, 0xaf123456 :: v_dual_mov_b32 v6, exec_hi
// GFX11: encoding: [0x7f,0xfe,0x51,0xc8,0x7f,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_lo, v255, 0xaf123456 :: v_dual_mov_b32 v6, exec_lo
// GFX11: encoding: [0x7e,0xfe,0x51,0xc8,0x7e,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, m0, v255, 0xaf123456 :: v_dual_mov_b32 v6, m0
// GFX11: encoding: [0x7d,0xfe,0x51,0xc8,0x7d,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_hi, v255, 0xaf123456 :: v_dual_mov_b32 v6, vcc_hi
// GFX11: encoding: [0x6b,0xfe,0x51,0xc8,0x6b,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_lo, v255, 0xaf123456 :: v_dual_mov_b32 v6, vcc_lo
// GFX11: encoding: [0x6a,0xfe,0x51,0xc8,0x6a,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0xaf123456, v255, 0xaf123456 :: v_dual_mov_b32 v6, null
// GFX11: encoding: [0xff,0xfe,0x51,0xc8,0x7c,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, src_scc, v255, 0xaf123456 :: v_dual_mov_b32 v6, -1
// GFX11: encoding: [0xfd,0xfe,0x51,0xc8,0xc1,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0.5, v3, 0xaf123456 :: v_dual_mov_b32 v6, 0.5
// GFX11: encoding: [0xf0,0x06,0x50,0xc8,0xf0,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, -1, v4, 0xaf123456 :: v_dual_mov_b32 v6, src_scc
// GFX11: encoding: [0xc1,0x08,0x50,0xc8,0xfd,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v6, null, v5, 0xaf123456 :: v_dual_mov_b32 v255, 0xaf123456
// GFX11: encoding: [0x7c,0x0a,0x50,0xc8,0xff,0x00,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v4, v2, 0xaf123456 :: v_dual_mul_dx9_zero_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x4e,0xc8,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v1, v2, 0xaf123456 :: v_dual_mul_dx9_zero_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x4e,0xc8,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v255, v2, 0xaf123456 :: v_dual_mul_dx9_zero_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x4e,0xc8,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v2, v2, 0xaf123456 :: v_dual_mul_dx9_zero_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x4e,0xc8,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v3, v2, 0xaf123456 :: v_dual_mul_dx9_zero_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x4e,0xc8,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s105, v2, 0xaf123456 :: v_dual_mul_dx9_zero_f32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x4e,0xc8,0x69,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s1, v2, 0xaf123456 :: v_dual_mul_dx9_zero_f32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x4e,0xc8,0x01,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, ttmp15, v2, 0xaf123456 :: v_dual_mul_dx9_zero_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x4e,0xc8,0x7b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_hi, v2, 0xaf123456 :: v_dual_mul_dx9_zero_f32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x4e,0xc8,0x7f,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_lo, v2, 0xaf123456 :: v_dual_mul_dx9_zero_f32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x4e,0xc8,0x7e,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, m0, v2, 0xaf123456 :: v_dual_mul_dx9_zero_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x4e,0xc8,0x7d,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_hi, v2, 0xaf123456 :: v_dual_mul_dx9_zero_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x4e,0xc8,0x6b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_lo, v2, 0xaf123456 :: v_dual_mul_dx9_zero_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x4e,0xc8,0x6a,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0xaf123456, v2, 0xaf123456 :: v_dual_mul_dx9_zero_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x4e,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, src_scc, v2, 0xaf123456 :: v_dual_mul_dx9_zero_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x4e,0xc8,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0.5, v3, 0xaf123456 :: v_dual_mul_dx9_zero_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x4e,0xc8,0xf0,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, -1, v4, 0xaf123456 :: v_dual_mul_dx9_zero_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x4e,0xc8,0xfd,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v6, null, v5, 0xaf123456 :: v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x4e,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v4, v2, 0xaf123456 :: v_dual_mul_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x46,0xc8,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v1, v2, 0xaf123456 :: v_dual_mul_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x46,0xc8,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v255, v2, 0xaf123456 :: v_dual_mul_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x46,0xc8,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v2, v2, 0xaf123456 :: v_dual_mul_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x46,0xc8,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v3, v2, 0xaf123456 :: v_dual_mul_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x46,0xc8,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s105, v2, 0xaf123456 :: v_dual_mul_f32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x46,0xc8,0x69,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s1, v2, 0xaf123456 :: v_dual_mul_f32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x46,0xc8,0x01,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, ttmp15, v2, 0xaf123456 :: v_dual_mul_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x46,0xc8,0x7b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_hi, v2, 0xaf123456 :: v_dual_mul_f32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x46,0xc8,0x7f,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_lo, v2, 0xaf123456 :: v_dual_mul_f32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x46,0xc8,0x7e,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, m0, v2, 0xaf123456 :: v_dual_mul_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x46,0xc8,0x7d,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_hi, v2, 0xaf123456 :: v_dual_mul_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x46,0xc8,0x6b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_lo, v2, 0xaf123456 :: v_dual_mul_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x46,0xc8,0x6a,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0xaf123456, v2, 0xaf123456 :: v_dual_mul_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x46,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, src_scc, v2, 0xaf123456 :: v_dual_mul_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x46,0xc8,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0.5, v3, 0xaf123456 :: v_dual_mul_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x46,0xc8,0xf0,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, -1, v4, 0xaf123456 :: v_dual_mul_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x46,0xc8,0xfd,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v6, null, v5, 0xaf123456 :: v_dual_mul_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x46,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v4, v2, 0xaf123456 :: v_dual_sub_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x4a,0xc8,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v1, v2, 0xaf123456 :: v_dual_sub_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x4a,0xc8,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v255, v2, 0xaf123456 :: v_dual_sub_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x4a,0xc8,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v2, v2, 0xaf123456 :: v_dual_sub_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x4a,0xc8,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v3, v2, 0xaf123456 :: v_dual_sub_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x4a,0xc8,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s105, v2, 0xaf123456 :: v_dual_sub_f32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x4a,0xc8,0x69,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s1, v2, 0xaf123456 :: v_dual_sub_f32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x4a,0xc8,0x01,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, ttmp15, v2, 0xaf123456 :: v_dual_sub_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x4a,0xc8,0x7b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_hi, v2, 0xaf123456 :: v_dual_sub_f32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x4a,0xc8,0x7f,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_lo, v2, 0xaf123456 :: v_dual_sub_f32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x4a,0xc8,0x7e,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, m0, v2, 0xaf123456 :: v_dual_sub_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x4a,0xc8,0x7d,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_hi, v2, 0xaf123456 :: v_dual_sub_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x4a,0xc8,0x6b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_lo, v2, 0xaf123456 :: v_dual_sub_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x4a,0xc8,0x6a,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0xaf123456, v2, 0xaf123456 :: v_dual_sub_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x4a,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, src_scc, v2, 0xaf123456 :: v_dual_sub_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x4a,0xc8,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0.5, v3, 0xaf123456 :: v_dual_sub_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x4a,0xc8,0xf0,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, -1, v4, 0xaf123456 :: v_dual_sub_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x4a,0xc8,0xfd,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v6, null, v5, 0xaf123456 :: v_dual_sub_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x4a,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v4, v2, 0xaf123456 :: v_dual_subrev_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x4c,0xc8,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v1, v2, 0xaf123456 :: v_dual_subrev_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x4c,0xc8,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v255, v2, 0xaf123456 :: v_dual_subrev_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x4c,0xc8,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v2, v2, 0xaf123456 :: v_dual_subrev_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x4c,0xc8,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, v3, v2, 0xaf123456 :: v_dual_subrev_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x4c,0xc8,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s105, v2, 0xaf123456 :: v_dual_subrev_f32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x4c,0xc8,0x69,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, s1, v2, 0xaf123456 :: v_dual_subrev_f32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x4c,0xc8,0x01,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, ttmp15, v2, 0xaf123456 :: v_dual_subrev_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x4c,0xc8,0x7b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_hi, v2, 0xaf123456 :: v_dual_subrev_f32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x4c,0xc8,0x7f,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, exec_lo, v2, 0xaf123456 :: v_dual_subrev_f32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x4c,0xc8,0x7e,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, m0, v2, 0xaf123456 :: v_dual_subrev_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x4c,0xc8,0x7d,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_hi, v2, 0xaf123456 :: v_dual_subrev_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x4c,0xc8,0x6b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, vcc_lo, v2, 0xaf123456 :: v_dual_subrev_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x4c,0xc8,0x6a,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0xaf123456, v2, 0xaf123456 :: v_dual_subrev_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x4c,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, src_scc, v2, 0xaf123456 :: v_dual_subrev_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x4c,0xc8,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, 0.5, v3, 0xaf123456 :: v_dual_subrev_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x4c,0xc8,0xf0,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v255, -1, v4, 0xaf123456 :: v_dual_subrev_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x4c,0xc8,0xfd,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmaak_f32 v6, null, v5, 0xaf123456 :: v_dual_subrev_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x4c,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v4, v2 :: v_dual_add_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x08,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v1, v2 :: v_dual_add_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x08,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v255, v2 :: v_dual_add_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x08,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v2, v2 :: v_dual_add_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x08,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v3, v2 :: v_dual_add_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x08,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s105, v2 :: v_dual_add_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x08,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s1, v2 :: v_dual_add_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x08,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, ttmp15, v2 :: v_dual_add_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x08,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_hi, v2 :: v_dual_add_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x08,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_lo, v2 :: v_dual_add_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x08,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, m0, v2 :: v_dual_add_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x08,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_hi, v2 :: v_dual_add_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x08,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_lo, v2 :: v_dual_add_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x08,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0xaf123456, v2 :: v_dual_add_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x08,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, src_scc, v2 :: v_dual_add_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x08,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0.5, v3 :: v_dual_add_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x08,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, -1, v4 :: v_dual_add_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x08,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v6, null, v5 :: v_dual_add_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x08,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v4, v2 :: v_dual_add_nc_u32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x20,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v1, v2 :: v_dual_add_nc_u32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x20,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v255, v2 :: v_dual_add_nc_u32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x20,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v2, v2 :: v_dual_add_nc_u32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x20,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v3, v2 :: v_dual_add_nc_u32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x20,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s105, v2 :: v_dual_add_nc_u32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x20,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s1, v2 :: v_dual_add_nc_u32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x20,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, ttmp15, v2 :: v_dual_add_nc_u32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x20,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_hi, v2 :: v_dual_add_nc_u32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x20,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_lo, v2 :: v_dual_add_nc_u32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x20,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, m0, v2 :: v_dual_add_nc_u32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x20,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_hi, v2 :: v_dual_add_nc_u32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x20,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_lo, v2 :: v_dual_add_nc_u32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x20,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0xaf123456, v2 :: v_dual_add_nc_u32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x20,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, src_scc, v2 :: v_dual_add_nc_u32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x20,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0.5, v3 :: v_dual_add_nc_u32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x20,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, -1, v4 :: v_dual_add_nc_u32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x20,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v6, null, v5 :: v_dual_add_nc_u32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x20,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v4, v2 :: v_dual_and_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x24,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v1, v2 :: v_dual_and_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x24,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v255, v2 :: v_dual_and_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x24,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v2, v2 :: v_dual_and_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x24,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v3, v2 :: v_dual_and_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x24,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s105, v2 :: v_dual_and_b32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x24,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s1, v2 :: v_dual_and_b32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x24,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, ttmp15, v2 :: v_dual_and_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x24,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_hi, v2 :: v_dual_and_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x24,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_lo, v2 :: v_dual_and_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x24,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, m0, v2 :: v_dual_and_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x24,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_hi, v2 :: v_dual_and_b32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x24,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_lo, v2 :: v_dual_and_b32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x24,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0xaf123456, v2 :: v_dual_and_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x24,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, src_scc, v2 :: v_dual_and_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x24,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0.5, v3 :: v_dual_and_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x24,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, -1, v4 :: v_dual_and_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x24,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v6, null, v5 :: v_dual_and_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x24,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v4, v2 :: v_dual_cndmask_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x12,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v1, v2 :: v_dual_cndmask_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x12,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v255, v2 :: v_dual_cndmask_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x12,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v2, v2 :: v_dual_cndmask_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x12,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v3, v2 :: v_dual_cndmask_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x12,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s105, v2 :: v_dual_cndmask_b32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x12,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s1, v2 :: v_dual_cndmask_b32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x12,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, ttmp15, v2 :: v_dual_cndmask_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x12,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_hi, v2 :: v_dual_cndmask_b32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x12,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_lo, v2 :: v_dual_cndmask_b32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x12,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, m0, v2 :: v_dual_cndmask_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x12,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_hi, v2 :: v_dual_cndmask_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x12,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_lo, v2 :: v_dual_cndmask_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x12,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0xaf123456, v2 :: v_dual_cndmask_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x12,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, src_scc, v2 :: v_dual_cndmask_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x12,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0.5, v3 :: v_dual_cndmask_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x12,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, -1, v4 :: v_dual_cndmask_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x12,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v6, null, v5 :: v_dual_cndmask_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x12,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v4, v2 :: v_dual_dot2acc_f32_f16 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x18,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v1, v2 :: v_dual_dot2acc_f32_f16 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x18,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v255, v2 :: v_dual_dot2acc_f32_f16 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x18,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v2, v2 :: v_dual_dot2acc_f32_f16 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x18,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v3, v2 :: v_dual_dot2acc_f32_f16 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x18,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s105, v2 :: v_dual_dot2acc_f32_f16 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x18,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s1, v2 :: v_dual_dot2acc_f32_f16 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x18,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, ttmp15, v2 :: v_dual_dot2acc_f32_f16 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x18,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_hi, v2 :: v_dual_dot2acc_f32_f16 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x18,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_lo, v2 :: v_dual_dot2acc_f32_f16 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x18,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, m0, v2 :: v_dual_dot2acc_f32_f16 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x18,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_hi, v2 :: v_dual_dot2acc_f32_f16 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x18,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_lo, v2 :: v_dual_dot2acc_f32_f16 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x18,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0xaf123456, v2 :: v_dual_dot2acc_f32_f16 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x18,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, src_scc, v2 :: v_dual_dot2acc_f32_f16 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x18,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0.5, v3 :: v_dual_dot2acc_f32_f16 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x18,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, -1, v4 :: v_dual_dot2acc_f32_f16 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x18,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v6, null, v5 :: v_dual_dot2acc_f32_f16 v255, 0xfe0b, v4
// GFX11: encoding: [0x7c,0x0a,0x18,0xc8,0xff,0x08,0xfe,0x06,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v4, v2 :: v_dual_fmaak_f32 v6, v1, v3, 0xaf123456
// GFX11: encoding: [0x04,0x05,0x02,0xc8,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v1, v2 :: v_dual_fmaak_f32 v6, v255, v3, 0xaf123456
// GFX11: encoding: [0x01,0x05,0x02,0xc8,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v255, v2 :: v_dual_fmaak_f32 v6, v2, v3, 0xaf123456
// GFX11: encoding: [0xff,0x05,0x02,0xc8,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v2, v2 :: v_dual_fmaak_f32 v6, v3, v3, 0xaf123456
// GFX11: encoding: [0x02,0x05,0x02,0xc8,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v3, v2 :: v_dual_fmaak_f32 v6, v4, v3, 0xaf123456
// GFX11: encoding: [0x03,0x05,0x02,0xc8,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s105, v2 :: v_dual_fmaak_f32 v6, s105, v3, 0xaf123456
// GFX11: encoding: [0x69,0x04,0x02,0xc8,0x69,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s1, v2 :: v_dual_fmaak_f32 v6, s1, v3, 0xaf123456
// GFX11: encoding: [0x01,0x04,0x02,0xc8,0x01,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, ttmp15, v2 :: v_dual_fmaak_f32 v6, ttmp15, v3, 0xaf123456
// GFX11: encoding: [0x7b,0x04,0x02,0xc8,0x7b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_hi, v2 :: v_dual_fmaak_f32 v6, exec_hi, v3, 0xaf123456
// GFX11: encoding: [0x7f,0x04,0x02,0xc8,0x7f,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_lo, v2 :: v_dual_fmaak_f32 v6, exec_lo, v3, 0xaf123456
// GFX11: encoding: [0x7e,0x04,0x02,0xc8,0x7e,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, m0, v2 :: v_dual_fmaak_f32 v6, m0, v3, 0xaf123456
// GFX11: encoding: [0x7d,0x04,0x02,0xc8,0x7d,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_hi, v2 :: v_dual_fmaak_f32 v6, vcc_hi, v3, 0xaf123456
// GFX11: encoding: [0x6b,0x04,0x02,0xc8,0x6b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_lo, v2 :: v_dual_fmaak_f32 v6, vcc_lo, v3, 0xaf123456
// GFX11: encoding: [0x6a,0x04,0x02,0xc8,0x6a,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0xaf123456, v2 :: v_dual_fmaak_f32 v6, null, v3, 0xaf123456
// GFX11: encoding: [0xff,0x04,0x02,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, src_scc, v2 :: v_dual_fmaak_f32 v6, -1, v3, 0xaf123456
// GFX11: encoding: [0xfd,0x04,0x02,0xc8,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0.5, v3 :: v_dual_fmaak_f32 v6, 0.5, v2, 0xaf123456
// GFX11: encoding: [0xf0,0x06,0x02,0xc8,0xf0,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, -1, v4 :: v_dual_fmaak_f32 v6, src_scc, v5, 0xaf123456
// GFX11: encoding: [0xc1,0x08,0x02,0xc8,0xfd,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v6, null, v5 :: v_dual_fmaak_f32 v255, 0xaf123456, v4, 0xaf123456
// GFX11: encoding: [0x7c,0x0a,0x02,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v4, v2 :: v_dual_fmac_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x00,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v1, v2 :: v_dual_fmac_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x00,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v255, v2 :: v_dual_fmac_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x00,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v2, v2 :: v_dual_fmac_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x00,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v3, v2 :: v_dual_fmac_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x00,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s105, v2 :: v_dual_fmac_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x00,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s1, v2 :: v_dual_fmac_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x00,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, ttmp15, v2 :: v_dual_fmac_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x00,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_hi, v2 :: v_dual_fmac_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x00,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_lo, v2 :: v_dual_fmac_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x00,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, m0, v2 :: v_dual_fmac_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x00,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_hi, v2 :: v_dual_fmac_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x00,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_lo, v2 :: v_dual_fmac_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x00,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0xaf123456, v2 :: v_dual_fmac_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x00,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, src_scc, v2 :: v_dual_fmac_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x00,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0.5, v3 :: v_dual_fmac_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x00,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, -1, v4 :: v_dual_fmac_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x00,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v6, null, v5 :: v_dual_fmac_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x00,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v4, v255 :: v_dual_fmamk_f32 v6, v1, 0xaf123456, v4
// GFX11: encoding: [0x04,0xff,0x05,0xc8,0x01,0x09,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v1, v255 :: v_dual_fmamk_f32 v6, v255, 0xaf123456, v4
// GFX11: encoding: [0x01,0xff,0x05,0xc8,0xff,0x09,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v255, v255 :: v_dual_fmamk_f32 v6, v2, 0xaf123456, v4
// GFX11: encoding: [0xff,0xff,0x05,0xc8,0x02,0x09,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v2, v255 :: v_dual_fmamk_f32 v6, v3, 0xaf123456, v4
// GFX11: encoding: [0x02,0xff,0x05,0xc8,0x03,0x09,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v3, v255 :: v_dual_fmamk_f32 v6, v4, 0xaf123456, v4
// GFX11: encoding: [0x03,0xff,0x05,0xc8,0x04,0x09,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s105, v255 :: v_dual_fmamk_f32 v6, s105, 0xaf123456, v4
// GFX11: encoding: [0x69,0xfe,0x05,0xc8,0x69,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s1, v255 :: v_dual_fmamk_f32 v6, s1, 0xaf123456, v4
// GFX11: encoding: [0x01,0xfe,0x05,0xc8,0x01,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, ttmp15, v255 :: v_dual_fmamk_f32 v6, ttmp15, 0xaf123456, v4
// GFX11: encoding: [0x7b,0xfe,0x05,0xc8,0x7b,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_hi, v255 :: v_dual_fmamk_f32 v6, exec_hi, 0xaf123456, v4
// GFX11: encoding: [0x7f,0xfe,0x05,0xc8,0x7f,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_lo, v255 :: v_dual_fmamk_f32 v6, exec_lo, 0xaf123456, v4
// GFX11: encoding: [0x7e,0xfe,0x05,0xc8,0x7e,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, m0, v255 :: v_dual_fmamk_f32 v6, m0, 0xaf123456, v4
// GFX11: encoding: [0x7d,0xfe,0x05,0xc8,0x7d,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_hi, v255 :: v_dual_fmamk_f32 v6, vcc_hi, 0xaf123456, v4
// GFX11: encoding: [0x6b,0xfe,0x05,0xc8,0x6b,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_lo, v255 :: v_dual_fmamk_f32 v6, vcc_lo, 0xaf123456, v4
// GFX11: encoding: [0x6a,0xfe,0x05,0xc8,0x6a,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, null, 0xaf123456, v4
// GFX11: encoding: [0xff,0xfe,0x05,0xc8,0x7c,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, src_scc, v255 :: v_dual_fmamk_f32 v6, -1, 0xaf123456, v4
// GFX11: encoding: [0xfd,0xfe,0x05,0xc8,0xc1,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0.5, v3 :: v_dual_fmamk_f32 v6, 0.5, 0xaf123456, v4
// GFX11: encoding: [0xf0,0x06,0x04,0xc8,0xf0,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, -1, v4 :: v_dual_fmamk_f32 v6, src_scc, 0xaf123456, v4
// GFX11: encoding: [0xc1,0x08,0x04,0xc8,0xfd,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v6, null, v5 :: v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v255
// GFX11: encoding: [0x7c,0x0a,0x04,0xc8,0xff,0xfe,0xff,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v4, v2 :: v_dual_lshlrev_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x22,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v1, v2 :: v_dual_lshlrev_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x22,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v255, v2 :: v_dual_lshlrev_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x22,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v2, v2 :: v_dual_lshlrev_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x22,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v3, v2 :: v_dual_lshlrev_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x22,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s105, v2 :: v_dual_lshlrev_b32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x22,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s1, v2 :: v_dual_lshlrev_b32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x22,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, ttmp15, v2 :: v_dual_lshlrev_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x22,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_hi, v2 :: v_dual_lshlrev_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x22,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_lo, v2 :: v_dual_lshlrev_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x22,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, m0, v2 :: v_dual_lshlrev_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x22,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_hi, v2 :: v_dual_lshlrev_b32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x22,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_lo, v2 :: v_dual_lshlrev_b32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x22,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0xaf123456, v2 :: v_dual_lshlrev_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x22,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, src_scc, v2 :: v_dual_lshlrev_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x22,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0.5, v3 :: v_dual_lshlrev_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x22,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, -1, v4 :: v_dual_lshlrev_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x22,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v6, null, v5 :: v_dual_lshlrev_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x22,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v4, v2 :: v_dual_max_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x14,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v1, v2 :: v_dual_max_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x14,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v255, v2 :: v_dual_max_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x14,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v2, v2 :: v_dual_max_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x14,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v3, v2 :: v_dual_max_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x14,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s105, v2 :: v_dual_max_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x14,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s1, v2 :: v_dual_max_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x14,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, ttmp15, v2 :: v_dual_max_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x14,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_hi, v2 :: v_dual_max_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x14,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_lo, v2 :: v_dual_max_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x14,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, m0, v2 :: v_dual_max_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x14,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_hi, v2 :: v_dual_max_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x14,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_lo, v2 :: v_dual_max_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x14,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0xaf123456, v2 :: v_dual_max_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x14,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, src_scc, v2 :: v_dual_max_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x14,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0.5, v3 :: v_dual_max_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x14,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, -1, v4 :: v_dual_max_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x14,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v6, null, v5 :: v_dual_max_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x14,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v4, v2 :: v_dual_min_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x16,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v1, v2 :: v_dual_min_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x16,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v255, v2 :: v_dual_min_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x16,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v2, v2 :: v_dual_min_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x16,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v3, v2 :: v_dual_min_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x16,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s105, v2 :: v_dual_min_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x16,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s1, v2 :: v_dual_min_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x16,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, ttmp15, v2 :: v_dual_min_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x16,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_hi, v2 :: v_dual_min_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x16,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_lo, v2 :: v_dual_min_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x16,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, m0, v2 :: v_dual_min_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x16,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_hi, v2 :: v_dual_min_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x16,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_lo, v2 :: v_dual_min_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x16,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0xaf123456, v2 :: v_dual_min_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x16,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, src_scc, v2 :: v_dual_min_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x16,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0.5, v3 :: v_dual_min_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x16,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, -1, v4 :: v_dual_min_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x16,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v6, null, v5 :: v_dual_min_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x16,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v4, v255 :: v_dual_mov_b32 v6, v1
// GFX11: encoding: [0x04,0xff,0x11,0xc8,0x01,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v1, v255 :: v_dual_mov_b32 v6, v255
// GFX11: encoding: [0x01,0xff,0x11,0xc8,0xff,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v255, v255 :: v_dual_mov_b32 v6, v2
// GFX11: encoding: [0xff,0xff,0x11,0xc8,0x02,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v2, v255 :: v_dual_mov_b32 v6, v3
// GFX11: encoding: [0x02,0xff,0x11,0xc8,0x03,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v3, v255 :: v_dual_mov_b32 v6, v4
// GFX11: encoding: [0x03,0xff,0x11,0xc8,0x04,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s105, v255 :: v_dual_mov_b32 v6, s1
// GFX11: encoding: [0x69,0xfe,0x11,0xc8,0x01,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s1, v255 :: v_dual_mov_b32 v6, s105
// GFX11: encoding: [0x01,0xfe,0x11,0xc8,0x69,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, ttmp15, v255 :: v_dual_mov_b32 v6, vcc_lo
// GFX11: encoding: [0x7b,0xfe,0x11,0xc8,0x6a,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_hi, v255 :: v_dual_mov_b32 v6, vcc_hi
// GFX11: encoding: [0x7f,0xfe,0x11,0xc8,0x6b,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_lo, v255 :: v_dual_mov_b32 v6, ttmp15
// GFX11: encoding: [0x7e,0xfe,0x11,0xc8,0x7b,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, m0, v255 :: v_dual_mov_b32 v6, m0
// GFX11: encoding: [0x7d,0xfe,0x11,0xc8,0x7d,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_hi, v255 :: v_dual_mov_b32 v6, exec_lo
// GFX11: encoding: [0x6b,0xfe,0x11,0xc8,0x7e,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_lo, v255 :: v_dual_mov_b32 v6, exec_hi
// GFX11: encoding: [0x6a,0xfe,0x11,0xc8,0x7f,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0xaf123456, v255 :: v_dual_mov_b32 v6, null
// GFX11: encoding: [0xff,0xfe,0x11,0xc8,0x7c,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, src_scc, v255 :: v_dual_mov_b32 v6, -1
// GFX11: encoding: [0xfd,0xfe,0x11,0xc8,0xc1,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0.5, v3 :: v_dual_mov_b32 v6, 0.5
// GFX11: encoding: [0xf0,0x06,0x10,0xc8,0xf0,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, -1, v4 :: v_dual_mov_b32 v6, src_scc
// GFX11: encoding: [0xc1,0x08,0x10,0xc8,0xfd,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v6, null, v5 :: v_dual_mov_b32 v255, 0xaf123456
// GFX11: encoding: [0x7c,0x0a,0x10,0xc8,0xff,0x00,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v4, v2 :: v_dual_mul_dx9_zero_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x0e,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v1, v2 :: v_dual_mul_dx9_zero_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x0e,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v255, v2 :: v_dual_mul_dx9_zero_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x0e,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v2, v2 :: v_dual_mul_dx9_zero_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x0e,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v3, v2 :: v_dual_mul_dx9_zero_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x0e,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s105, v2 :: v_dual_mul_dx9_zero_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x0e,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s1, v2 :: v_dual_mul_dx9_zero_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x0e,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, ttmp15, v2 :: v_dual_mul_dx9_zero_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x0e,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_hi, v2 :: v_dual_mul_dx9_zero_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x0e,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_lo, v2 :: v_dual_mul_dx9_zero_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x0e,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, m0, v2 :: v_dual_mul_dx9_zero_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x0e,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_hi, v2 :: v_dual_mul_dx9_zero_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x0e,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_lo, v2 :: v_dual_mul_dx9_zero_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x0e,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0xaf123456, v2 :: v_dual_mul_dx9_zero_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x0e,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, src_scc, v2 :: v_dual_mul_dx9_zero_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x0e,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0.5, v3 :: v_dual_mul_dx9_zero_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x0e,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, -1, v4 :: v_dual_mul_dx9_zero_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x0e,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v6, null, v5 :: v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x0e,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v4, v2 :: v_dual_mul_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x06,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v1, v2 :: v_dual_mul_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x06,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v255, v2 :: v_dual_mul_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x06,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v2, v2 :: v_dual_mul_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x06,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v3, v2 :: v_dual_mul_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x06,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s105, v2 :: v_dual_mul_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x06,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s1, v2 :: v_dual_mul_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x06,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, ttmp15, v2 :: v_dual_mul_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x06,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_hi, v2 :: v_dual_mul_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x06,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_lo, v2 :: v_dual_mul_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x06,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, m0, v2 :: v_dual_mul_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x06,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_hi, v2 :: v_dual_mul_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x06,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_lo, v2 :: v_dual_mul_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x06,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0xaf123456, v2 :: v_dual_mul_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x06,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, src_scc, v2 :: v_dual_mul_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x06,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0.5, v3 :: v_dual_mul_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x06,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, -1, v4 :: v_dual_mul_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x06,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v6, null, v5 :: v_dual_mul_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x06,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v4, v2 :: v_dual_sub_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x0a,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v1, v2 :: v_dual_sub_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x0a,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v255, v2 :: v_dual_sub_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x0a,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v2, v2 :: v_dual_sub_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x0a,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v3, v2 :: v_dual_sub_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x0a,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s105, v2 :: v_dual_sub_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x0a,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s1, v2 :: v_dual_sub_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x0a,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, ttmp15, v2 :: v_dual_sub_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x0a,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_hi, v2 :: v_dual_sub_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x0a,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_lo, v2 :: v_dual_sub_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x0a,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, m0, v2 :: v_dual_sub_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x0a,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_hi, v2 :: v_dual_sub_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x0a,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_lo, v2 :: v_dual_sub_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x0a,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0xaf123456, v2 :: v_dual_sub_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x0a,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, src_scc, v2 :: v_dual_sub_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x0a,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0.5, v3 :: v_dual_sub_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x0a,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, -1, v4 :: v_dual_sub_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x0a,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v6, null, v5 :: v_dual_sub_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x0a,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v4, v2 :: v_dual_subrev_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x0c,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v1, v2 :: v_dual_subrev_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x0c,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v255, v2 :: v_dual_subrev_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x0c,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v2, v2 :: v_dual_subrev_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x0c,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, v3, v2 :: v_dual_subrev_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x0c,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s105, v2 :: v_dual_subrev_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x0c,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, s1, v2 :: v_dual_subrev_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x0c,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, ttmp15, v2 :: v_dual_subrev_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x0c,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_hi, v2 :: v_dual_subrev_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x0c,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, exec_lo, v2 :: v_dual_subrev_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x0c,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, m0, v2 :: v_dual_subrev_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x0c,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_hi, v2 :: v_dual_subrev_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x0c,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, vcc_lo, v2 :: v_dual_subrev_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x0c,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0xaf123456, v2 :: v_dual_subrev_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x0c,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, src_scc, v2 :: v_dual_subrev_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x0c,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, 0.5, v3 :: v_dual_subrev_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x0c,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v255, -1, v4 :: v_dual_subrev_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x0c,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmac_f32 v6, null, v5 :: v_dual_subrev_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x0c,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v4, 0xaf123456, v255 :: v_dual_add_f32 v6, v1, v255
// GFX11: encoding: [0x04,0xff,0x89,0xc8,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v1, 0xaf123456, v255 :: v_dual_add_f32 v6, v255, v255
// GFX11: encoding: [0x01,0xff,0x89,0xc8,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v255, 0xaf123456, v255 :: v_dual_add_f32 v6, v2, v255
// GFX11: encoding: [0xff,0xff,0x89,0xc8,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v2, 0xaf123456, v255 :: v_dual_add_f32 v6, v3, v255
// GFX11: encoding: [0x02,0xff,0x89,0xc8,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v3, 0xaf123456, v255 :: v_dual_add_f32 v6, v4, v255
// GFX11: encoding: [0x03,0xff,0x89,0xc8,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s105, 0xaf123456, v255 :: v_dual_add_f32 v6, s105, v255
// GFX11: encoding: [0x69,0xfe,0x89,0xc8,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s1, 0xaf123456, v255 :: v_dual_add_f32 v6, s1, v255
// GFX11: encoding: [0x01,0xfe,0x89,0xc8,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, ttmp15, 0xaf123456, v255 :: v_dual_add_f32 v6, ttmp15, v255
// GFX11: encoding: [0x7b,0xfe,0x89,0xc8,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_hi, 0xaf123456, v255 :: v_dual_add_f32 v6, exec_hi, v255
// GFX11: encoding: [0x7f,0xfe,0x89,0xc8,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_lo, 0xaf123456, v255 :: v_dual_add_f32 v6, exec_lo, v255
// GFX11: encoding: [0x7e,0xfe,0x89,0xc8,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, m0, 0xaf123456, v255 :: v_dual_add_f32 v6, m0, v255
// GFX11: encoding: [0x7d,0xfe,0x89,0xc8,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_hi, 0xaf123456, v255 :: v_dual_add_f32 v6, vcc_hi, v255
// GFX11: encoding: [0x6b,0xfe,0x89,0xc8,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_lo, 0xaf123456, v255 :: v_dual_add_f32 v6, vcc_lo, v255
// GFX11: encoding: [0x6a,0xfe,0x89,0xc8,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v255 :: v_dual_add_f32 v6, null, v255
// GFX11: encoding: [0xff,0xfe,0x89,0xc8,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, src_scc, 0xaf123456, v255 :: v_dual_add_f32 v6, -1, v255
// GFX11: encoding: [0xfd,0xfe,0x89,0xc8,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0.5, 0xaf123456, v255 :: v_dual_add_f32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0xfe,0x89,0xc8,0xf0,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, -1, 0xaf123456, v255 :: v_dual_add_f32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0xfe,0x89,0xc8,0xfd,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v6, null, 0xaf123456, v4 :: v_dual_add_f32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x08,0x88,0xc8,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v4, 0xaf123456, v255 :: v_dual_add_nc_u32 v6, v1, v255
// GFX11: encoding: [0x04,0xff,0xa1,0xc8,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v1, 0xaf123456, v255 :: v_dual_add_nc_u32 v6, v255, v255
// GFX11: encoding: [0x01,0xff,0xa1,0xc8,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v255, 0xaf123456, v255 :: v_dual_add_nc_u32 v6, v2, v255
// GFX11: encoding: [0xff,0xff,0xa1,0xc8,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v2, 0xaf123456, v255 :: v_dual_add_nc_u32 v6, v3, v255
// GFX11: encoding: [0x02,0xff,0xa1,0xc8,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v3, 0xaf123456, v255 :: v_dual_add_nc_u32 v6, v4, v255
// GFX11: encoding: [0x03,0xff,0xa1,0xc8,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s105, 0xaf123456, v255 :: v_dual_add_nc_u32 v6, s105, v255
// GFX11: encoding: [0x69,0xfe,0xa1,0xc8,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s1, 0xaf123456, v255 :: v_dual_add_nc_u32 v6, s1, v255
// GFX11: encoding: [0x01,0xfe,0xa1,0xc8,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, ttmp15, 0xaf123456, v255 :: v_dual_add_nc_u32 v6, ttmp15, v255
// GFX11: encoding: [0x7b,0xfe,0xa1,0xc8,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_hi, 0xaf123456, v255 :: v_dual_add_nc_u32 v6, exec_hi, v255
// GFX11: encoding: [0x7f,0xfe,0xa1,0xc8,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_lo, 0xaf123456, v255 :: v_dual_add_nc_u32 v6, exec_lo, v255
// GFX11: encoding: [0x7e,0xfe,0xa1,0xc8,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, m0, 0xaf123456, v255 :: v_dual_add_nc_u32 v6, m0, v255
// GFX11: encoding: [0x7d,0xfe,0xa1,0xc8,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_hi, 0xaf123456, v255 :: v_dual_add_nc_u32 v6, vcc_hi, v255
// GFX11: encoding: [0x6b,0xfe,0xa1,0xc8,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_lo, 0xaf123456, v255 :: v_dual_add_nc_u32 v6, vcc_lo, v255
// GFX11: encoding: [0x6a,0xfe,0xa1,0xc8,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v255 :: v_dual_add_nc_u32 v6, null, v255
// GFX11: encoding: [0xff,0xfe,0xa1,0xc8,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, src_scc, 0xaf123456, v255 :: v_dual_add_nc_u32 v6, -1, v255
// GFX11: encoding: [0xfd,0xfe,0xa1,0xc8,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0.5, 0xaf123456, v255 :: v_dual_add_nc_u32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0xfe,0xa1,0xc8,0xf0,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, -1, 0xaf123456, v255 :: v_dual_add_nc_u32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0xfe,0xa1,0xc8,0xfd,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v6, null, 0xaf123456, v4 :: v_dual_add_nc_u32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x08,0xa0,0xc8,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v4, 0xaf123456, v255 :: v_dual_and_b32 v6, v1, v255
// GFX11: encoding: [0x04,0xff,0xa5,0xc8,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v1, 0xaf123456, v255 :: v_dual_and_b32 v6, v255, v255
// GFX11: encoding: [0x01,0xff,0xa5,0xc8,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v255, 0xaf123456, v255 :: v_dual_and_b32 v6, v2, v255
// GFX11: encoding: [0xff,0xff,0xa5,0xc8,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v2, 0xaf123456, v255 :: v_dual_and_b32 v6, v3, v255
// GFX11: encoding: [0x02,0xff,0xa5,0xc8,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v3, 0xaf123456, v255 :: v_dual_and_b32 v6, v4, v255
// GFX11: encoding: [0x03,0xff,0xa5,0xc8,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s105, 0xaf123456, v255 :: v_dual_and_b32 v6, s105, v255
// GFX11: encoding: [0x69,0xfe,0xa5,0xc8,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s1, 0xaf123456, v255 :: v_dual_and_b32 v6, s1, v255
// GFX11: encoding: [0x01,0xfe,0xa5,0xc8,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, ttmp15, 0xaf123456, v255 :: v_dual_and_b32 v6, ttmp15, v255
// GFX11: encoding: [0x7b,0xfe,0xa5,0xc8,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_hi, 0xaf123456, v255 :: v_dual_and_b32 v6, exec_hi, v255
// GFX11: encoding: [0x7f,0xfe,0xa5,0xc8,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_lo, 0xaf123456, v255 :: v_dual_and_b32 v6, exec_lo, v255
// GFX11: encoding: [0x7e,0xfe,0xa5,0xc8,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, m0, 0xaf123456, v255 :: v_dual_and_b32 v6, m0, v255
// GFX11: encoding: [0x7d,0xfe,0xa5,0xc8,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_hi, 0xaf123456, v255 :: v_dual_and_b32 v6, vcc_hi, v255
// GFX11: encoding: [0x6b,0xfe,0xa5,0xc8,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_lo, 0xaf123456, v255 :: v_dual_and_b32 v6, vcc_lo, v255
// GFX11: encoding: [0x6a,0xfe,0xa5,0xc8,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v255 :: v_dual_and_b32 v6, null, v255
// GFX11: encoding: [0xff,0xfe,0xa5,0xc8,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, src_scc, 0xaf123456, v255 :: v_dual_and_b32 v6, -1, v255
// GFX11: encoding: [0xfd,0xfe,0xa5,0xc8,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0.5, 0xaf123456, v255 :: v_dual_and_b32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0xfe,0xa5,0xc8,0xf0,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, -1, 0xaf123456, v255 :: v_dual_and_b32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0xfe,0xa5,0xc8,0xfd,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v6, null, 0xaf123456, v4 :: v_dual_and_b32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x08,0xa4,0xc8,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v4, 0xaf123456, v255 :: v_dual_cndmask_b32 v6, v1, v255
// GFX11: encoding: [0x04,0xff,0x93,0xc8,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v1, 0xaf123456, v255 :: v_dual_cndmask_b32 v6, v255, v255
// GFX11: encoding: [0x01,0xff,0x93,0xc8,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v255, 0xaf123456, v255 :: v_dual_cndmask_b32 v6, v2, v255
// GFX11: encoding: [0xff,0xff,0x93,0xc8,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v2, 0xaf123456, v255 :: v_dual_cndmask_b32 v6, v3, v255
// GFX11: encoding: [0x02,0xff,0x93,0xc8,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v3, 0xaf123456, v255 :: v_dual_cndmask_b32 v6, v4, v255
// GFX11: encoding: [0x03,0xff,0x93,0xc8,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v255 :: v_dual_cndmask_b32 v6, null, v255
// GFX11: encoding: [0xff,0xfe,0x93,0xc8,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0.5, 0xaf123456, v255 :: v_dual_cndmask_b32 v6, -1, v3
// GFX11: encoding: [0xf0,0xfe,0x93,0xc8,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, -1, 0xaf123456, v255 :: v_dual_cndmask_b32 v6, 0.5, v4
// GFX11: encoding: [0xc1,0xfe,0x93,0xc8,0xf0,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v6, null, 0xaf123456, v4 :: v_dual_cndmask_b32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x08,0x92,0xc8,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v1, 0xaf123456, v255 :: v_dual_dot2acc_f32_f16 v6, v255, v255
// GFX11: encoding: [0x01,0xff,0x99,0xc8,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v255, 0xaf123456, v255 :: v_dual_dot2acc_f32_f16 v6, v1, v255
// GFX11: encoding: [0xff,0xff,0x99,0xc8,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v2, 0xaf123456, v255 :: v_dual_dot2acc_f32_f16 v6, v3, v255
// GFX11: encoding: [0x02,0xff,0x99,0xc8,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v3, 0xaf123456, v255 :: v_dual_dot2acc_f32_f16 v6, v2, v255
// GFX11: encoding: [0x03,0xff,0x99,0xc8,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s105, 0xaf123456, v255 :: v_dual_dot2acc_f32_f16 v6, s105, v255
// GFX11: encoding: [0x69,0xfe,0x99,0xc8,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s1, 0xaf123456, v255 :: v_dual_dot2acc_f32_f16 v6, s1, v255
// GFX11: encoding: [0x01,0xfe,0x99,0xc8,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, ttmp15, 0xaf123456, v255 :: v_dual_dot2acc_f32_f16 v6, ttmp15, v255
// GFX11: encoding: [0x7b,0xfe,0x99,0xc8,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_hi, 0xaf123456, v255 :: v_dual_dot2acc_f32_f16 v6, v4, v255
// GFX11: encoding: [0x7f,0xfe,0x99,0xc8,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_lo, 0xaf123456, v255 :: v_dual_dot2acc_f32_f16 v6, exec_lo, v255
// GFX11: encoding: [0x7e,0xfe,0x99,0xc8,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, m0, 0xaf123456, v255 :: v_dual_dot2acc_f32_f16 v6, m0, v255
// GFX11: encoding: [0x7d,0xfe,0x99,0xc8,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_hi, 0xaf123456, v255 :: v_dual_dot2acc_f32_f16 v6, vcc_hi, v255
// GFX11: encoding: [0x6b,0xfe,0x99,0xc8,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_lo, 0xaf123456, v255 :: v_dual_dot2acc_f32_f16 v6, vcc_lo, v255
// GFX11: encoding: [0x6a,0xfe,0x99,0xc8,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v255 :: v_dual_dot2acc_f32_f16 v6, exec_hi, v255
// GFX11: encoding: [0xff,0xfe,0x99,0xc8,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, src_scc, 0xaf123456, v255 :: v_dual_dot2acc_f32_f16 v6, null, v255
// GFX11: encoding: [0xfd,0xfe,0x99,0xc8,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0.5, 0xaf123456, v255 :: v_dual_dot2acc_f32_f16 v6, -1, v3
// GFX11: encoding: [0xf0,0xfe,0x99,0xc8,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, -1, 0xaf123456, v255 :: v_dual_dot2acc_f32_f16 v6, 0.5, v4
// GFX11: encoding: [0xc1,0xfe,0x99,0xc8,0xf0,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v6, null, 0xaf123456, v4 :: v_dual_dot2acc_f32_f16 v255, src_scc, v5
// GFX11: encoding: [0x7c,0x08,0x98,0xc8,0xfd,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v4, 0xaf123456, v255 :: v_dual_fmaak_f32 v6, v1, v255, 0xaf123456
// GFX11: encoding: [0x04,0xff,0x83,0xc8,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v1, 0xaf123456, v255 :: v_dual_fmaak_f32 v6, v255, v255, 0xaf123456
// GFX11: encoding: [0x01,0xff,0x83,0xc8,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v255, 0xaf123456, v255 :: v_dual_fmaak_f32 v6, v2, v255, 0xaf123456
// GFX11: encoding: [0xff,0xff,0x83,0xc8,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v2, 0xaf123456, v255 :: v_dual_fmaak_f32 v6, v3, v255, 0xaf123456
// GFX11: encoding: [0x02,0xff,0x83,0xc8,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v3, 0xaf123456, v255 :: v_dual_fmaak_f32 v6, v4, v255, 0xaf123456
// GFX11: encoding: [0x03,0xff,0x83,0xc8,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s105, 0xaf123456, v255 :: v_dual_fmaak_f32 v6, s105, v255, 0xaf123456
// GFX11: encoding: [0x69,0xfe,0x83,0xc8,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s1, 0xaf123456, v255 :: v_dual_fmaak_f32 v6, s1, v255, 0xaf123456
// GFX11: encoding: [0x01,0xfe,0x83,0xc8,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, ttmp15, 0xaf123456, v255 :: v_dual_fmaak_f32 v6, ttmp15, v255, 0xaf123456
// GFX11: encoding: [0x7b,0xfe,0x83,0xc8,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_hi, 0xaf123456, v255 :: v_dual_fmaak_f32 v6, exec_hi, v255, 0xaf123456
// GFX11: encoding: [0x7f,0xfe,0x83,0xc8,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_lo, 0xaf123456, v255 :: v_dual_fmaak_f32 v6, exec_lo, v255, 0xaf123456
// GFX11: encoding: [0x7e,0xfe,0x83,0xc8,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, m0, 0xaf123456, v255 :: v_dual_fmaak_f32 v6, m0, v255, 0xaf123456
// GFX11: encoding: [0x7d,0xfe,0x83,0xc8,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_hi, 0xaf123456, v255 :: v_dual_fmaak_f32 v6, vcc_hi, v255, 0xaf123456
// GFX11: encoding: [0x6b,0xfe,0x83,0xc8,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_lo, 0xaf123456, v255 :: v_dual_fmaak_f32 v6, vcc_lo, v255, 0xaf123456
// GFX11: encoding: [0x6a,0xfe,0x83,0xc8,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v255 :: v_dual_fmaak_f32 v6, null, v255, 0xaf123456
// GFX11: encoding: [0xff,0xfe,0x83,0xc8,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, src_scc, 0xaf123456, v255 :: v_dual_fmaak_f32 v6, -1, v255, 0xaf123456
// GFX11: encoding: [0xfd,0xfe,0x83,0xc8,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0.5, 0xaf123456, v255 :: v_dual_fmaak_f32 v6, 0.5, v3, 0xaf123456
// GFX11: encoding: [0xf0,0xfe,0x83,0xc8,0xf0,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, -1, 0xaf123456, v255 :: v_dual_fmaak_f32 v6, src_scc, v4, 0xaf123456
// GFX11: encoding: [0xc1,0xfe,0x83,0xc8,0xfd,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v6, null, 0xaf123456, v4 :: v_dual_fmaak_f32 v255, 0xaf123456, v5, 0xaf123456
// GFX11: encoding: [0x7c,0x08,0x82,0xc8,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v4, 0xaf123456, v255 :: v_dual_fmac_f32 v6, v1, v255
// GFX11: encoding: [0x04,0xff,0x81,0xc8,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v1, 0xaf123456, v255 :: v_dual_fmac_f32 v6, v255, v255
// GFX11: encoding: [0x01,0xff,0x81,0xc8,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v255, 0xaf123456, v255 :: v_dual_fmac_f32 v6, v2, v255
// GFX11: encoding: [0xff,0xff,0x81,0xc8,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v2, 0xaf123456, v255 :: v_dual_fmac_f32 v6, v3, v255
// GFX11: encoding: [0x02,0xff,0x81,0xc8,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v3, 0xaf123456, v255 :: v_dual_fmac_f32 v6, v4, v255
// GFX11: encoding: [0x03,0xff,0x81,0xc8,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s105, 0xaf123456, v255 :: v_dual_fmac_f32 v6, s105, v255
// GFX11: encoding: [0x69,0xfe,0x81,0xc8,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s1, 0xaf123456, v255 :: v_dual_fmac_f32 v6, s1, v255
// GFX11: encoding: [0x01,0xfe,0x81,0xc8,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, ttmp15, 0xaf123456, v255 :: v_dual_fmac_f32 v6, ttmp15, v255
// GFX11: encoding: [0x7b,0xfe,0x81,0xc8,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_hi, 0xaf123456, v255 :: v_dual_fmac_f32 v6, exec_hi, v255
// GFX11: encoding: [0x7f,0xfe,0x81,0xc8,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_lo, 0xaf123456, v255 :: v_dual_fmac_f32 v6, exec_lo, v255
// GFX11: encoding: [0x7e,0xfe,0x81,0xc8,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, m0, 0xaf123456, v255 :: v_dual_fmac_f32 v6, m0, v255
// GFX11: encoding: [0x7d,0xfe,0x81,0xc8,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_hi, 0xaf123456, v255 :: v_dual_fmac_f32 v6, vcc_hi, v255
// GFX11: encoding: [0x6b,0xfe,0x81,0xc8,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_lo, 0xaf123456, v255 :: v_dual_fmac_f32 v6, vcc_lo, v255
// GFX11: encoding: [0x6a,0xfe,0x81,0xc8,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v255 :: v_dual_fmac_f32 v6, null, v255
// GFX11: encoding: [0xff,0xfe,0x81,0xc8,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, src_scc, 0xaf123456, v255 :: v_dual_fmac_f32 v6, -1, v255
// GFX11: encoding: [0xfd,0xfe,0x81,0xc8,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0.5, 0xaf123456, v255 :: v_dual_fmac_f32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0xfe,0x81,0xc8,0xf0,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, -1, 0xaf123456, v255 :: v_dual_fmac_f32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0xfe,0x81,0xc8,0xfd,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v6, null, 0xaf123456, v4 :: v_dual_fmac_f32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x08,0x80,0xc8,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v4, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, v1, 0xaf123456, v4
// GFX11: encoding: [0x04,0xff,0x85,0xc8,0x01,0x09,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v1, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, v255, 0xaf123456, v4
// GFX11: encoding: [0x01,0xff,0x85,0xc8,0xff,0x09,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v255, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, v2, 0xaf123456, v4
// GFX11: encoding: [0xff,0xff,0x85,0xc8,0x02,0x09,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v2, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, v3, 0xaf123456, v4
// GFX11: encoding: [0x02,0xff,0x85,0xc8,0x03,0x09,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v3, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, v4, 0xaf123456, v4
// GFX11: encoding: [0x03,0xff,0x85,0xc8,0x04,0x09,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s105, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, s105, 0xaf123456, v4
// GFX11: encoding: [0x69,0xfe,0x85,0xc8,0x69,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s1, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, s1, 0xaf123456, v4
// GFX11: encoding: [0x01,0xfe,0x85,0xc8,0x01,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, ttmp15, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, ttmp15, 0xaf123456, v4
// GFX11: encoding: [0x7b,0xfe,0x85,0xc8,0x7b,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_hi, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, exec_hi, 0xaf123456, v4
// GFX11: encoding: [0x7f,0xfe,0x85,0xc8,0x7f,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_lo, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, exec_lo, 0xaf123456, v4
// GFX11: encoding: [0x7e,0xfe,0x85,0xc8,0x7e,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, m0, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, m0, 0xaf123456, v4
// GFX11: encoding: [0x7d,0xfe,0x85,0xc8,0x7d,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_hi, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, vcc_hi, 0xaf123456, v4
// GFX11: encoding: [0x6b,0xfe,0x85,0xc8,0x6b,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_lo, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, vcc_lo, 0xaf123456, v4
// GFX11: encoding: [0x6a,0xfe,0x85,0xc8,0x6a,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, null, 0xaf123456, v4
// GFX11: encoding: [0xff,0xfe,0x85,0xc8,0x7c,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, src_scc, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, -1, 0xaf123456, v4
// GFX11: encoding: [0xfd,0xfe,0x85,0xc8,0xc1,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0.5, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, 0.5, 0xaf123456, v4
// GFX11: encoding: [0xf0,0xfe,0x85,0xc8,0xf0,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, -1, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, src_scc, 0xaf123456, v4
// GFX11: encoding: [0xc1,0xfe,0x85,0xc8,0xfd,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v6, null, 0xaf123456, v4 :: v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v255
// GFX11: encoding: [0x7c,0x08,0x84,0xc8,0xff,0xfe,0xff,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v4, 0xaf123456, v255 :: v_dual_lshlrev_b32 v6, v1, v255
// GFX11: encoding: [0x04,0xff,0xa3,0xc8,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v1, 0xaf123456, v255 :: v_dual_lshlrev_b32 v6, v255, v255
// GFX11: encoding: [0x01,0xff,0xa3,0xc8,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v255, 0xaf123456, v255 :: v_dual_lshlrev_b32 v6, v2, v255
// GFX11: encoding: [0xff,0xff,0xa3,0xc8,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v2, 0xaf123456, v255 :: v_dual_lshlrev_b32 v6, v3, v255
// GFX11: encoding: [0x02,0xff,0xa3,0xc8,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v3, 0xaf123456, v255 :: v_dual_lshlrev_b32 v6, v4, v255
// GFX11: encoding: [0x03,0xff,0xa3,0xc8,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s105, 0xaf123456, v255 :: v_dual_lshlrev_b32 v6, s105, v255
// GFX11: encoding: [0x69,0xfe,0xa3,0xc8,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s1, 0xaf123456, v255 :: v_dual_lshlrev_b32 v6, s1, v255
// GFX11: encoding: [0x01,0xfe,0xa3,0xc8,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, ttmp15, 0xaf123456, v255 :: v_dual_lshlrev_b32 v6, ttmp15, v255
// GFX11: encoding: [0x7b,0xfe,0xa3,0xc8,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_hi, 0xaf123456, v255 :: v_dual_lshlrev_b32 v6, exec_hi, v255
// GFX11: encoding: [0x7f,0xfe,0xa3,0xc8,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_lo, 0xaf123456, v255 :: v_dual_lshlrev_b32 v6, exec_lo, v255
// GFX11: encoding: [0x7e,0xfe,0xa3,0xc8,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, m0, 0xaf123456, v255 :: v_dual_lshlrev_b32 v6, m0, v255
// GFX11: encoding: [0x7d,0xfe,0xa3,0xc8,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_hi, 0xaf123456, v255 :: v_dual_lshlrev_b32 v6, vcc_hi, v255
// GFX11: encoding: [0x6b,0xfe,0xa3,0xc8,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_lo, 0xaf123456, v255 :: v_dual_lshlrev_b32 v6, vcc_lo, v255
// GFX11: encoding: [0x6a,0xfe,0xa3,0xc8,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v255 :: v_dual_lshlrev_b32 v6, null, v255
// GFX11: encoding: [0xff,0xfe,0xa3,0xc8,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, src_scc, 0xaf123456, v255 :: v_dual_lshlrev_b32 v6, -1, v255
// GFX11: encoding: [0xfd,0xfe,0xa3,0xc8,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0.5, 0xaf123456, v255 :: v_dual_lshlrev_b32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0xfe,0xa3,0xc8,0xf0,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, -1, 0xaf123456, v255 :: v_dual_lshlrev_b32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0xfe,0xa3,0xc8,0xfd,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v6, null, 0xaf123456, v4 :: v_dual_lshlrev_b32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x08,0xa2,0xc8,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v4, 0xaf123456, v255 :: v_dual_max_f32 v6, v1, v255
// GFX11: encoding: [0x04,0xff,0x95,0xc8,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v1, 0xaf123456, v255 :: v_dual_max_f32 v6, v255, v255
// GFX11: encoding: [0x01,0xff,0x95,0xc8,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v255, 0xaf123456, v255 :: v_dual_max_f32 v6, v2, v255
// GFX11: encoding: [0xff,0xff,0x95,0xc8,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v2, 0xaf123456, v255 :: v_dual_max_f32 v6, v3, v255
// GFX11: encoding: [0x02,0xff,0x95,0xc8,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v3, 0xaf123456, v255 :: v_dual_max_f32 v6, v4, v255
// GFX11: encoding: [0x03,0xff,0x95,0xc8,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s105, 0xaf123456, v255 :: v_dual_max_f32 v6, s105, v255
// GFX11: encoding: [0x69,0xfe,0x95,0xc8,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s1, 0xaf123456, v255 :: v_dual_max_f32 v6, s1, v255
// GFX11: encoding: [0x01,0xfe,0x95,0xc8,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, ttmp15, 0xaf123456, v255 :: v_dual_max_f32 v6, ttmp15, v255
// GFX11: encoding: [0x7b,0xfe,0x95,0xc8,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_hi, 0xaf123456, v255 :: v_dual_max_f32 v6, exec_hi, v255
// GFX11: encoding: [0x7f,0xfe,0x95,0xc8,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_lo, 0xaf123456, v255 :: v_dual_max_f32 v6, exec_lo, v255
// GFX11: encoding: [0x7e,0xfe,0x95,0xc8,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, m0, 0xaf123456, v255 :: v_dual_max_f32 v6, m0, v255
// GFX11: encoding: [0x7d,0xfe,0x95,0xc8,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_hi, 0xaf123456, v255 :: v_dual_max_f32 v6, vcc_hi, v255
// GFX11: encoding: [0x6b,0xfe,0x95,0xc8,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_lo, 0xaf123456, v255 :: v_dual_max_f32 v6, vcc_lo, v255
// GFX11: encoding: [0x6a,0xfe,0x95,0xc8,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v255 :: v_dual_max_f32 v6, null, v255
// GFX11: encoding: [0xff,0xfe,0x95,0xc8,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, src_scc, 0xaf123456, v255 :: v_dual_max_f32 v6, -1, v255
// GFX11: encoding: [0xfd,0xfe,0x95,0xc8,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0.5, 0xaf123456, v255 :: v_dual_max_f32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0xfe,0x95,0xc8,0xf0,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, -1, 0xaf123456, v255 :: v_dual_max_f32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0xfe,0x95,0xc8,0xfd,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v6, null, 0xaf123456, v4 :: v_dual_max_f32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x08,0x94,0xc8,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v4, 0xaf123456, v255 :: v_dual_min_f32 v6, v1, v255
// GFX11: encoding: [0x04,0xff,0x97,0xc8,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v1, 0xaf123456, v255 :: v_dual_min_f32 v6, v255, v255
// GFX11: encoding: [0x01,0xff,0x97,0xc8,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v255, 0xaf123456, v255 :: v_dual_min_f32 v6, v2, v255
// GFX11: encoding: [0xff,0xff,0x97,0xc8,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v2, 0xaf123456, v255 :: v_dual_min_f32 v6, v3, v255
// GFX11: encoding: [0x02,0xff,0x97,0xc8,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v3, 0xaf123456, v255 :: v_dual_min_f32 v6, v4, v255
// GFX11: encoding: [0x03,0xff,0x97,0xc8,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s105, 0xaf123456, v255 :: v_dual_min_f32 v6, s105, v255
// GFX11: encoding: [0x69,0xfe,0x97,0xc8,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s1, 0xaf123456, v255 :: v_dual_min_f32 v6, s1, v255
// GFX11: encoding: [0x01,0xfe,0x97,0xc8,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, ttmp15, 0xaf123456, v255 :: v_dual_min_f32 v6, ttmp15, v255
// GFX11: encoding: [0x7b,0xfe,0x97,0xc8,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_hi, 0xaf123456, v255 :: v_dual_min_f32 v6, exec_hi, v255
// GFX11: encoding: [0x7f,0xfe,0x97,0xc8,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_lo, 0xaf123456, v255 :: v_dual_min_f32 v6, exec_lo, v255
// GFX11: encoding: [0x7e,0xfe,0x97,0xc8,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, m0, 0xaf123456, v255 :: v_dual_min_f32 v6, m0, v255
// GFX11: encoding: [0x7d,0xfe,0x97,0xc8,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_hi, 0xaf123456, v255 :: v_dual_min_f32 v6, vcc_hi, v255
// GFX11: encoding: [0x6b,0xfe,0x97,0xc8,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_lo, 0xaf123456, v255 :: v_dual_min_f32 v6, vcc_lo, v255
// GFX11: encoding: [0x6a,0xfe,0x97,0xc8,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v255 :: v_dual_min_f32 v6, null, v255
// GFX11: encoding: [0xff,0xfe,0x97,0xc8,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, src_scc, 0xaf123456, v255 :: v_dual_min_f32 v6, -1, v255
// GFX11: encoding: [0xfd,0xfe,0x97,0xc8,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0.5, 0xaf123456, v255 :: v_dual_min_f32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0xfe,0x97,0xc8,0xf0,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, -1, 0xaf123456, v255 :: v_dual_min_f32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0xfe,0x97,0xc8,0xfd,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v6, null, 0xaf123456, v4 :: v_dual_min_f32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x08,0x96,0xc8,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v4, 0xaf123456, v255 :: v_dual_mov_b32 v6, v1
// GFX11: encoding: [0x04,0xff,0x91,0xc8,0x01,0x01,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v1, 0xaf123456, v255 :: v_dual_mov_b32 v6, v255
// GFX11: encoding: [0x01,0xff,0x91,0xc8,0xff,0x01,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v255, 0xaf123456, v255 :: v_dual_mov_b32 v6, v2
// GFX11: encoding: [0xff,0xff,0x91,0xc8,0x02,0x01,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v2, 0xaf123456, v255 :: v_dual_mov_b32 v6, v3
// GFX11: encoding: [0x02,0xff,0x91,0xc8,0x03,0x01,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v3, 0xaf123456, v255 :: v_dual_mov_b32 v6, v4
// GFX11: encoding: [0x03,0xff,0x91,0xc8,0x04,0x01,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s105, 0xaf123456, v255 :: v_dual_mov_b32 v6, s105
// GFX11: encoding: [0x69,0xfe,0x91,0xc8,0x69,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s1, 0xaf123456, v255 :: v_dual_mov_b32 v6, s1
// GFX11: encoding: [0x01,0xfe,0x91,0xc8,0x01,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, ttmp15, 0xaf123456, v255 :: v_dual_mov_b32 v6, ttmp15
// GFX11: encoding: [0x7b,0xfe,0x91,0xc8,0x7b,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_hi, 0xaf123456, v255 :: v_dual_mov_b32 v6, exec_hi
// GFX11: encoding: [0x7f,0xfe,0x91,0xc8,0x7f,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_lo, 0xaf123456, v255 :: v_dual_mov_b32 v6, exec_lo
// GFX11: encoding: [0x7e,0xfe,0x91,0xc8,0x7e,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, m0, 0xaf123456, v255 :: v_dual_mov_b32 v6, m0
// GFX11: encoding: [0x7d,0xfe,0x91,0xc8,0x7d,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_hi, 0xaf123456, v255 :: v_dual_mov_b32 v6, vcc_hi
// GFX11: encoding: [0x6b,0xfe,0x91,0xc8,0x6b,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_lo, 0xaf123456, v255 :: v_dual_mov_b32 v6, vcc_lo
// GFX11: encoding: [0x6a,0xfe,0x91,0xc8,0x6a,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v255 :: v_dual_mov_b32 v6, null
// GFX11: encoding: [0xff,0xfe,0x91,0xc8,0x7c,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, src_scc, 0xaf123456, v255 :: v_dual_mov_b32 v6, -1
// GFX11: encoding: [0xfd,0xfe,0x91,0xc8,0xc1,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0.5, 0xaf123456, v255 :: v_dual_mov_b32 v6, 0.5
// GFX11: encoding: [0xf0,0xfe,0x91,0xc8,0xf0,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, -1, 0xaf123456, v255 :: v_dual_mov_b32 v6, src_scc
// GFX11: encoding: [0xc1,0xfe,0x91,0xc8,0xfd,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v6, null, 0xaf123456, v4 :: v_dual_mov_b32 v255, 0xaf123456
// GFX11: encoding: [0x7c,0x08,0x90,0xc8,0xff,0x00,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v4, 0xaf123456, v255 :: v_dual_mul_dx9_zero_f32 v6, v1, v255
// GFX11: encoding: [0x04,0xff,0x8f,0xc8,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v1, 0xaf123456, v255 :: v_dual_mul_dx9_zero_f32 v6, v255, v255
// GFX11: encoding: [0x01,0xff,0x8f,0xc8,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v255, 0xaf123456, v255 :: v_dual_mul_dx9_zero_f32 v6, v2, v255
// GFX11: encoding: [0xff,0xff,0x8f,0xc8,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v2, 0xaf123456, v255 :: v_dual_mul_dx9_zero_f32 v6, v3, v255
// GFX11: encoding: [0x02,0xff,0x8f,0xc8,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v3, 0xaf123456, v255 :: v_dual_mul_dx9_zero_f32 v6, v4, v255
// GFX11: encoding: [0x03,0xff,0x8f,0xc8,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s105, 0xaf123456, v255 :: v_dual_mul_dx9_zero_f32 v6, s105, v255
// GFX11: encoding: [0x69,0xfe,0x8f,0xc8,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s1, 0xaf123456, v255 :: v_dual_mul_dx9_zero_f32 v6, s1, v255
// GFX11: encoding: [0x01,0xfe,0x8f,0xc8,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, ttmp15, 0xaf123456, v255 :: v_dual_mul_dx9_zero_f32 v6, ttmp15, v255
// GFX11: encoding: [0x7b,0xfe,0x8f,0xc8,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_hi, 0xaf123456, v255 :: v_dual_mul_dx9_zero_f32 v6, exec_hi, v255
// GFX11: encoding: [0x7f,0xfe,0x8f,0xc8,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_lo, 0xaf123456, v255 :: v_dual_mul_dx9_zero_f32 v6, exec_lo, v255
// GFX11: encoding: [0x7e,0xfe,0x8f,0xc8,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, m0, 0xaf123456, v255 :: v_dual_mul_dx9_zero_f32 v6, m0, v255
// GFX11: encoding: [0x7d,0xfe,0x8f,0xc8,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_hi, 0xaf123456, v255 :: v_dual_mul_dx9_zero_f32 v6, vcc_hi, v255
// GFX11: encoding: [0x6b,0xfe,0x8f,0xc8,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_lo, 0xaf123456, v255 :: v_dual_mul_dx9_zero_f32 v6, vcc_lo, v255
// GFX11: encoding: [0x6a,0xfe,0x8f,0xc8,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v255 :: v_dual_mul_dx9_zero_f32 v6, null, v255
// GFX11: encoding: [0xff,0xfe,0x8f,0xc8,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, src_scc, 0xaf123456, v255 :: v_dual_mul_dx9_zero_f32 v6, -1, v255
// GFX11: encoding: [0xfd,0xfe,0x8f,0xc8,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0.5, 0xaf123456, v255 :: v_dual_mul_dx9_zero_f32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0xfe,0x8f,0xc8,0xf0,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, -1, 0xaf123456, v255 :: v_dual_mul_dx9_zero_f32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0xfe,0x8f,0xc8,0xfd,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v6, null, 0xaf123456, v4 :: v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x08,0x8e,0xc8,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v4, 0xaf123456, v255 :: v_dual_mul_f32 v6, v1, v255
// GFX11: encoding: [0x04,0xff,0x87,0xc8,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v1, 0xaf123456, v255 :: v_dual_mul_f32 v6, v255, v255
// GFX11: encoding: [0x01,0xff,0x87,0xc8,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v255, 0xaf123456, v255 :: v_dual_mul_f32 v6, v2, v255
// GFX11: encoding: [0xff,0xff,0x87,0xc8,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v2, 0xaf123456, v255 :: v_dual_mul_f32 v6, v3, v255
// GFX11: encoding: [0x02,0xff,0x87,0xc8,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v3, 0xaf123456, v255 :: v_dual_mul_f32 v6, v4, v255
// GFX11: encoding: [0x03,0xff,0x87,0xc8,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s105, 0xaf123456, v255 :: v_dual_mul_f32 v6, s105, v255
// GFX11: encoding: [0x69,0xfe,0x87,0xc8,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s1, 0xaf123456, v255 :: v_dual_mul_f32 v6, s1, v255
// GFX11: encoding: [0x01,0xfe,0x87,0xc8,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, ttmp15, 0xaf123456, v255 :: v_dual_mul_f32 v6, ttmp15, v255
// GFX11: encoding: [0x7b,0xfe,0x87,0xc8,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_hi, 0xaf123456, v255 :: v_dual_mul_f32 v6, exec_hi, v255
// GFX11: encoding: [0x7f,0xfe,0x87,0xc8,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_lo, 0xaf123456, v255 :: v_dual_mul_f32 v6, exec_lo, v255
// GFX11: encoding: [0x7e,0xfe,0x87,0xc8,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, m0, 0xaf123456, v255 :: v_dual_mul_f32 v6, m0, v255
// GFX11: encoding: [0x7d,0xfe,0x87,0xc8,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_hi, 0xaf123456, v255 :: v_dual_mul_f32 v6, vcc_hi, v255
// GFX11: encoding: [0x6b,0xfe,0x87,0xc8,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_lo, 0xaf123456, v255 :: v_dual_mul_f32 v6, vcc_lo, v255
// GFX11: encoding: [0x6a,0xfe,0x87,0xc8,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v255 :: v_dual_mul_f32 v6, null, v255
// GFX11: encoding: [0xff,0xfe,0x87,0xc8,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, src_scc, 0xaf123456, v255 :: v_dual_mul_f32 v6, -1, v255
// GFX11: encoding: [0xfd,0xfe,0x87,0xc8,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0.5, 0xaf123456, v255 :: v_dual_mul_f32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0xfe,0x87,0xc8,0xf0,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, -1, 0xaf123456, v255 :: v_dual_mul_f32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0xfe,0x87,0xc8,0xfd,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v6, null, 0xaf123456, v4 :: v_dual_mul_f32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x08,0x86,0xc8,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v4, 0xaf123456, v255 :: v_dual_sub_f32 v6, v1, v255
// GFX11: encoding: [0x04,0xff,0x8b,0xc8,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v1, 0xaf123456, v255 :: v_dual_sub_f32 v6, v255, v255
// GFX11: encoding: [0x01,0xff,0x8b,0xc8,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v255, 0xaf123456, v255 :: v_dual_sub_f32 v6, v2, v255
// GFX11: encoding: [0xff,0xff,0x8b,0xc8,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v2, 0xaf123456, v255 :: v_dual_sub_f32 v6, v3, v255
// GFX11: encoding: [0x02,0xff,0x8b,0xc8,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v3, 0xaf123456, v255 :: v_dual_sub_f32 v6, v4, v255
// GFX11: encoding: [0x03,0xff,0x8b,0xc8,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s105, 0xaf123456, v255 :: v_dual_sub_f32 v6, s105, v255
// GFX11: encoding: [0x69,0xfe,0x8b,0xc8,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s1, 0xaf123456, v255 :: v_dual_sub_f32 v6, s1, v255
// GFX11: encoding: [0x01,0xfe,0x8b,0xc8,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, ttmp15, 0xaf123456, v255 :: v_dual_sub_f32 v6, ttmp15, v255
// GFX11: encoding: [0x7b,0xfe,0x8b,0xc8,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_hi, 0xaf123456, v255 :: v_dual_sub_f32 v6, exec_hi, v255
// GFX11: encoding: [0x7f,0xfe,0x8b,0xc8,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_lo, 0xaf123456, v255 :: v_dual_sub_f32 v6, exec_lo, v255
// GFX11: encoding: [0x7e,0xfe,0x8b,0xc8,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, m0, 0xaf123456, v255 :: v_dual_sub_f32 v6, m0, v255
// GFX11: encoding: [0x7d,0xfe,0x8b,0xc8,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_hi, 0xaf123456, v255 :: v_dual_sub_f32 v6, vcc_hi, v255
// GFX11: encoding: [0x6b,0xfe,0x8b,0xc8,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_lo, 0xaf123456, v255 :: v_dual_sub_f32 v6, vcc_lo, v255
// GFX11: encoding: [0x6a,0xfe,0x8b,0xc8,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v255 :: v_dual_sub_f32 v6, null, v255
// GFX11: encoding: [0xff,0xfe,0x8b,0xc8,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, src_scc, 0xaf123456, v255 :: v_dual_sub_f32 v6, -1, v255
// GFX11: encoding: [0xfd,0xfe,0x8b,0xc8,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0.5, 0xaf123456, v255 :: v_dual_sub_f32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0xfe,0x8b,0xc8,0xf0,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, -1, 0xaf123456, v255 :: v_dual_sub_f32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0xfe,0x8b,0xc8,0xfd,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v6, null, 0xaf123456, v4 :: v_dual_sub_f32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x08,0x8a,0xc8,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v4, 0xaf123456, v255 :: v_dual_subrev_f32 v6, v1, v255
// GFX11: encoding: [0x04,0xff,0x8d,0xc8,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v1, 0xaf123456, v255 :: v_dual_subrev_f32 v6, v255, v255
// GFX11: encoding: [0x01,0xff,0x8d,0xc8,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v255, 0xaf123456, v255 :: v_dual_subrev_f32 v6, v2, v255
// GFX11: encoding: [0xff,0xff,0x8d,0xc8,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v2, 0xaf123456, v255 :: v_dual_subrev_f32 v6, v3, v255
// GFX11: encoding: [0x02,0xff,0x8d,0xc8,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, v3, 0xaf123456, v255 :: v_dual_subrev_f32 v6, v4, v255
// GFX11: encoding: [0x03,0xff,0x8d,0xc8,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s105, 0xaf123456, v255 :: v_dual_subrev_f32 v6, s105, v255
// GFX11: encoding: [0x69,0xfe,0x8d,0xc8,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, s1, 0xaf123456, v255 :: v_dual_subrev_f32 v6, s1, v255
// GFX11: encoding: [0x01,0xfe,0x8d,0xc8,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, ttmp15, 0xaf123456, v255 :: v_dual_subrev_f32 v6, ttmp15, v255
// GFX11: encoding: [0x7b,0xfe,0x8d,0xc8,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_hi, 0xaf123456, v255 :: v_dual_subrev_f32 v6, exec_hi, v255
// GFX11: encoding: [0x7f,0xfe,0x8d,0xc8,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, exec_lo, 0xaf123456, v255 :: v_dual_subrev_f32 v6, exec_lo, v255
// GFX11: encoding: [0x7e,0xfe,0x8d,0xc8,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, m0, 0xaf123456, v255 :: v_dual_subrev_f32 v6, m0, v255
// GFX11: encoding: [0x7d,0xfe,0x8d,0xc8,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_hi, 0xaf123456, v255 :: v_dual_subrev_f32 v6, vcc_hi, v255
// GFX11: encoding: [0x6b,0xfe,0x8d,0xc8,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, vcc_lo, 0xaf123456, v255 :: v_dual_subrev_f32 v6, vcc_lo, v255
// GFX11: encoding: [0x6a,0xfe,0x8d,0xc8,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v255 :: v_dual_subrev_f32 v6, null, v255
// GFX11: encoding: [0xff,0xfe,0x8d,0xc8,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, src_scc, 0xaf123456, v255 :: v_dual_subrev_f32 v6, -1, v255
// GFX11: encoding: [0xfd,0xfe,0x8d,0xc8,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, 0.5, 0xaf123456, v255 :: v_dual_subrev_f32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0xfe,0x8d,0xc8,0xf0,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v255, -1, 0xaf123456, v255 :: v_dual_subrev_f32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0xfe,0x8d,0xc8,0xfd,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_fmamk_f32 v6, null, 0xaf123456, v4 :: v_dual_subrev_f32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x08,0x8c,0xc8,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v4, v2 :: v_dual_add_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x88,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v1, v2 :: v_dual_add_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x88,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v255, v2 :: v_dual_add_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x88,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v2, v2 :: v_dual_add_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x88,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v3, v2 :: v_dual_add_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x88,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s105, v2 :: v_dual_add_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x88,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s1, v2 :: v_dual_add_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x88,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, ttmp15, v2 :: v_dual_add_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x88,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_hi, v2 :: v_dual_add_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x88,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_lo, v2 :: v_dual_add_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x88,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, m0, v2 :: v_dual_add_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x88,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_hi, v2 :: v_dual_add_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x88,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_lo, v2 :: v_dual_add_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x88,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0xaf123456, v2 :: v_dual_add_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x88,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, src_scc, v2 :: v_dual_add_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x88,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0.5, v3 :: v_dual_add_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x88,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, -1, v4 :: v_dual_add_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x88,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v6, null, v5 :: v_dual_add_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x88,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v4, v2 :: v_dual_add_nc_u32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xa0,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v1, v2 :: v_dual_add_nc_u32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xa0,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v255, v2 :: v_dual_add_nc_u32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xa0,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v2, v2 :: v_dual_add_nc_u32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xa0,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v3, v2 :: v_dual_add_nc_u32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xa0,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s105, v2 :: v_dual_add_nc_u32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xa0,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s1, v2 :: v_dual_add_nc_u32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xa0,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, ttmp15, v2 :: v_dual_add_nc_u32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xa0,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_hi, v2 :: v_dual_add_nc_u32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xa0,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_lo, v2 :: v_dual_add_nc_u32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xa0,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, m0, v2 :: v_dual_add_nc_u32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xa0,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_hi, v2 :: v_dual_add_nc_u32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xa0,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_lo, v2 :: v_dual_add_nc_u32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xa0,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0xaf123456, v2 :: v_dual_add_nc_u32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xa0,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, src_scc, v2 :: v_dual_add_nc_u32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xa0,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0.5, v3 :: v_dual_add_nc_u32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xa0,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, -1, v4 :: v_dual_add_nc_u32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xa0,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v6, null, v5 :: v_dual_add_nc_u32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xa0,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v4, v2 :: v_dual_and_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xa4,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v1, v2 :: v_dual_and_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xa4,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v255, v2 :: v_dual_and_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xa4,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v2, v2 :: v_dual_and_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xa4,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v3, v2 :: v_dual_and_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xa4,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s105, v2 :: v_dual_and_b32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xa4,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s1, v2 :: v_dual_and_b32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xa4,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, ttmp15, v2 :: v_dual_and_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xa4,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_hi, v2 :: v_dual_and_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xa4,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_lo, v2 :: v_dual_and_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xa4,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, m0, v2 :: v_dual_and_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xa4,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_hi, v2 :: v_dual_and_b32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xa4,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_lo, v2 :: v_dual_and_b32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xa4,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0xaf123456, v2 :: v_dual_and_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xa4,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, src_scc, v2 :: v_dual_and_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xa4,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0.5, v3 :: v_dual_and_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xa4,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, -1, v4 :: v_dual_and_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xa4,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v6, null, v5 :: v_dual_and_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xa4,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v4, v2 :: v_dual_cndmask_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x92,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v1, v2 :: v_dual_cndmask_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x92,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v255, v2 :: v_dual_cndmask_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x92,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v2, v2 :: v_dual_cndmask_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x92,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v3, v2 :: v_dual_cndmask_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x92,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s105, v2 :: v_dual_cndmask_b32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x92,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s1, v2 :: v_dual_cndmask_b32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x92,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, ttmp15, v2 :: v_dual_cndmask_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x92,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_hi, v2 :: v_dual_cndmask_b32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x92,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_lo, v2 :: v_dual_cndmask_b32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x92,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, m0, v2 :: v_dual_cndmask_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x92,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_hi, v2 :: v_dual_cndmask_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x92,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_lo, v2 :: v_dual_cndmask_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x92,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0xaf123456, v2 :: v_dual_cndmask_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x92,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, src_scc, v2 :: v_dual_cndmask_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x92,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0.5, v3 :: v_dual_cndmask_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x92,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, -1, v4 :: v_dual_cndmask_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x92,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v6, null, v5 :: v_dual_cndmask_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x92,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v4, v2 :: v_dual_dot2acc_f32_f16 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x98,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v1, v2 :: v_dual_dot2acc_f32_f16 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x98,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v255, v2 :: v_dual_dot2acc_f32_f16 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x98,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v2, v2 :: v_dual_dot2acc_f32_f16 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x98,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v3, v2 :: v_dual_dot2acc_f32_f16 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x98,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s105, v2 :: v_dual_dot2acc_f32_f16 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x98,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s1, v2 :: v_dual_dot2acc_f32_f16 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x98,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, ttmp15, v2 :: v_dual_dot2acc_f32_f16 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x98,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_hi, v2 :: v_dual_dot2acc_f32_f16 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x98,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_lo, v2 :: v_dual_dot2acc_f32_f16 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x98,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, m0, v2 :: v_dual_dot2acc_f32_f16 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x98,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_hi, v2 :: v_dual_dot2acc_f32_f16 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x98,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_lo, v2 :: v_dual_dot2acc_f32_f16 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x98,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0xaf123456, v2 :: v_dual_dot2acc_f32_f16 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x98,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, src_scc, v2 :: v_dual_dot2acc_f32_f16 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x98,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0.5, v3 :: v_dual_dot2acc_f32_f16 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x98,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, -1, v4 :: v_dual_dot2acc_f32_f16 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x98,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v6, null, v5 :: v_dual_dot2acc_f32_f16 v255, 0xfe0b, v4
// GFX11: encoding: [0x7c,0x0a,0x98,0xca,0xff,0x08,0xfe,0x06,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v4, v2 :: v_dual_fmaak_f32 v6, v1, v3, 0xaf123456
// GFX11: encoding: [0x04,0x05,0x82,0xca,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v1, v2 :: v_dual_fmaak_f32 v6, v255, v3, 0xaf123456
// GFX11: encoding: [0x01,0x05,0x82,0xca,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v255, v2 :: v_dual_fmaak_f32 v6, v2, v3, 0xaf123456
// GFX11: encoding: [0xff,0x05,0x82,0xca,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v2, v2 :: v_dual_fmaak_f32 v6, v3, v3, 0xaf123456
// GFX11: encoding: [0x02,0x05,0x82,0xca,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v3, v2 :: v_dual_fmaak_f32 v6, v4, v3, 0xaf123456
// GFX11: encoding: [0x03,0x05,0x82,0xca,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s105, v2 :: v_dual_fmaak_f32 v6, s105, v3, 0xaf123456
// GFX11: encoding: [0x69,0x04,0x82,0xca,0x69,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s1, v2 :: v_dual_fmaak_f32 v6, s1, v3, 0xaf123456
// GFX11: encoding: [0x01,0x04,0x82,0xca,0x01,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, ttmp15, v2 :: v_dual_fmaak_f32 v6, ttmp15, v3, 0xaf123456
// GFX11: encoding: [0x7b,0x04,0x82,0xca,0x7b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_hi, v2 :: v_dual_fmaak_f32 v6, exec_hi, v3, 0xaf123456
// GFX11: encoding: [0x7f,0x04,0x82,0xca,0x7f,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_lo, v2 :: v_dual_fmaak_f32 v6, exec_lo, v3, 0xaf123456
// GFX11: encoding: [0x7e,0x04,0x82,0xca,0x7e,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, m0, v2 :: v_dual_fmaak_f32 v6, m0, v3, 0xaf123456
// GFX11: encoding: [0x7d,0x04,0x82,0xca,0x7d,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_hi, v2 :: v_dual_fmaak_f32 v6, vcc_hi, v3, 0xaf123456
// GFX11: encoding: [0x6b,0x04,0x82,0xca,0x6b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_lo, v2 :: v_dual_fmaak_f32 v6, vcc_lo, v3, 0xaf123456
// GFX11: encoding: [0x6a,0x04,0x82,0xca,0x6a,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0xaf123456, v2 :: v_dual_fmaak_f32 v6, null, v3, 0xaf123456
// GFX11: encoding: [0xff,0x04,0x82,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, src_scc, v2 :: v_dual_fmaak_f32 v6, -1, v3, 0xaf123456
// GFX11: encoding: [0xfd,0x04,0x82,0xca,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0.5, v3 :: v_dual_fmaak_f32 v6, 0.5, v2, 0xaf123456
// GFX11: encoding: [0xf0,0x06,0x82,0xca,0xf0,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, -1, v4 :: v_dual_fmaak_f32 v6, src_scc, v5, 0xaf123456
// GFX11: encoding: [0xc1,0x08,0x82,0xca,0xfd,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v6, null, v5 :: v_dual_fmaak_f32 v255, 0xaf123456, v4, 0xaf123456
// GFX11: encoding: [0x7c,0x0a,0x82,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v4, v2 :: v_dual_fmac_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x80,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v1, v2 :: v_dual_fmac_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x80,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v255, v2 :: v_dual_fmac_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x80,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v2, v2 :: v_dual_fmac_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x80,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v3, v2 :: v_dual_fmac_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x80,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s105, v2 :: v_dual_fmac_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x80,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s1, v2 :: v_dual_fmac_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x80,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, ttmp15, v2 :: v_dual_fmac_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x80,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_hi, v2 :: v_dual_fmac_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x80,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_lo, v2 :: v_dual_fmac_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x80,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, m0, v2 :: v_dual_fmac_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x80,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_hi, v2 :: v_dual_fmac_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x80,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_lo, v2 :: v_dual_fmac_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x80,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0xaf123456, v2 :: v_dual_fmac_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x80,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, src_scc, v2 :: v_dual_fmac_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x80,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0.5, v3 :: v_dual_fmac_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x80,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, -1, v4 :: v_dual_fmac_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x80,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v6, null, v5 :: v_dual_fmac_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x80,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v4, v255 :: v_dual_fmamk_f32 v6, v1, 0xaf123456, v255
// GFX11: encoding: [0x04,0xff,0x85,0xca,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v1, v255 :: v_dual_fmamk_f32 v6, v255, 0xaf123456, v255
// GFX11: encoding: [0x01,0xff,0x85,0xca,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v255, v255 :: v_dual_fmamk_f32 v6, v2, 0xaf123456, v255
// GFX11: encoding: [0xff,0xff,0x85,0xca,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v2, v255 :: v_dual_fmamk_f32 v6, v3, 0xaf123456, v255
// GFX11: encoding: [0x02,0xff,0x85,0xca,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v3, v255 :: v_dual_fmamk_f32 v6, v4, 0xaf123456, v255
// GFX11: encoding: [0x03,0xff,0x85,0xca,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s105, v255 :: v_dual_fmamk_f32 v6, s105, 0xaf123456, v255
// GFX11: encoding: [0x69,0xfe,0x85,0xca,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s1, v255 :: v_dual_fmamk_f32 v6, s1, 0xaf123456, v255
// GFX11: encoding: [0x01,0xfe,0x85,0xca,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, ttmp15, v255 :: v_dual_fmamk_f32 v6, ttmp15, 0xaf123456, v255
// GFX11: encoding: [0x7b,0xfe,0x85,0xca,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_hi, v255 :: v_dual_fmamk_f32 v6, exec_hi, 0xaf123456, v255
// GFX11: encoding: [0x7f,0xfe,0x85,0xca,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_lo, v255 :: v_dual_fmamk_f32 v6, exec_lo, 0xaf123456, v255
// GFX11: encoding: [0x7e,0xfe,0x85,0xca,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, m0, v255 :: v_dual_fmamk_f32 v6, m0, 0xaf123456, v255
// GFX11: encoding: [0x7d,0xfe,0x85,0xca,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_hi, v255 :: v_dual_fmamk_f32 v6, vcc_hi, 0xaf123456, v255
// GFX11: encoding: [0x6b,0xfe,0x85,0xca,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_lo, v255 :: v_dual_fmamk_f32 v6, vcc_lo, 0xaf123456, v255
// GFX11: encoding: [0x6a,0xfe,0x85,0xca,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, null, 0xaf123456, v255
// GFX11: encoding: [0xff,0xfe,0x85,0xca,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, src_scc, v255 :: v_dual_fmamk_f32 v6, -1, 0xaf123456, v255
// GFX11: encoding: [0xfd,0xfe,0x85,0xca,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0.5, v3 :: v_dual_fmamk_f32 v6, 0.5, 0xaf123456, v255
// GFX11: encoding: [0xf0,0x06,0x84,0xca,0xf0,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, -1, v4 :: v_dual_fmamk_f32 v6, src_scc, 0xaf123456, v255
// GFX11: encoding: [0xc1,0x08,0x84,0xca,0xfd,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v6, null, v5 :: v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x84,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v4, v2 :: v_dual_lshlrev_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xa2,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v1, v2 :: v_dual_lshlrev_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xa2,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v255, v2 :: v_dual_lshlrev_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xa2,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v2, v2 :: v_dual_lshlrev_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xa2,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v3, v2 :: v_dual_lshlrev_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xa2,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s105, v2 :: v_dual_lshlrev_b32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xa2,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s1, v2 :: v_dual_lshlrev_b32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xa2,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, ttmp15, v2 :: v_dual_lshlrev_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xa2,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_hi, v2 :: v_dual_lshlrev_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xa2,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_lo, v2 :: v_dual_lshlrev_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xa2,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, m0, v2 :: v_dual_lshlrev_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xa2,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_hi, v2 :: v_dual_lshlrev_b32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xa2,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_lo, v2 :: v_dual_lshlrev_b32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xa2,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0xaf123456, v2 :: v_dual_lshlrev_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xa2,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, src_scc, v2 :: v_dual_lshlrev_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xa2,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0.5, v3 :: v_dual_lshlrev_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xa2,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, -1, v4 :: v_dual_lshlrev_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xa2,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v6, null, v5 :: v_dual_lshlrev_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xa2,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v4, v2 :: v_dual_max_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x94,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v1, v2 :: v_dual_max_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x94,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v255, v2 :: v_dual_max_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x94,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v2, v2 :: v_dual_max_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x94,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v3, v2 :: v_dual_max_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x94,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s105, v2 :: v_dual_max_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x94,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s1, v2 :: v_dual_max_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x94,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, ttmp15, v2 :: v_dual_max_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x94,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_hi, v2 :: v_dual_max_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x94,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_lo, v2 :: v_dual_max_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x94,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, m0, v2 :: v_dual_max_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x94,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_hi, v2 :: v_dual_max_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x94,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_lo, v2 :: v_dual_max_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x94,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0xaf123456, v2 :: v_dual_max_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x94,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, src_scc, v2 :: v_dual_max_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x94,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0.5, v3 :: v_dual_max_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x94,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, -1, v4 :: v_dual_max_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x94,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v6, null, v5 :: v_dual_max_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x94,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v4, v2 :: v_dual_min_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x96,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v1, v2 :: v_dual_min_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x96,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v255, v2 :: v_dual_min_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x96,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v2, v2 :: v_dual_min_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x96,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v3, v2 :: v_dual_min_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x96,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s105, v2 :: v_dual_min_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x96,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s1, v2 :: v_dual_min_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x96,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, ttmp15, v2 :: v_dual_min_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x96,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_hi, v2 :: v_dual_min_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x96,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_lo, v2 :: v_dual_min_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x96,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, m0, v2 :: v_dual_min_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x96,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_hi, v2 :: v_dual_min_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x96,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_lo, v2 :: v_dual_min_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x96,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0xaf123456, v2 :: v_dual_min_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x96,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, src_scc, v2 :: v_dual_min_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x96,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0.5, v3 :: v_dual_min_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x96,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, -1, v4 :: v_dual_min_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x96,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v6, null, v5 :: v_dual_min_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x96,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v4, v255 :: v_dual_mov_b32 v6, v1
// GFX11: encoding: [0x04,0xff,0x91,0xca,0x01,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v1, v255 :: v_dual_mov_b32 v6, v255
// GFX11: encoding: [0x01,0xff,0x91,0xca,0xff,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v255, v255 :: v_dual_mov_b32 v6, v2
// GFX11: encoding: [0xff,0xff,0x91,0xca,0x02,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v2, v255 :: v_dual_mov_b32 v6, v3
// GFX11: encoding: [0x02,0xff,0x91,0xca,0x03,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v3, v255 :: v_dual_mov_b32 v6, v4
// GFX11: encoding: [0x03,0xff,0x91,0xca,0x04,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s105, v255 :: v_dual_mov_b32 v6, s1
// GFX11: encoding: [0x69,0xfe,0x91,0xca,0x01,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s1, v255 :: v_dual_mov_b32 v6, s105
// GFX11: encoding: [0x01,0xfe,0x91,0xca,0x69,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, ttmp15, v255 :: v_dual_mov_b32 v6, vcc_lo
// GFX11: encoding: [0x7b,0xfe,0x91,0xca,0x6a,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_hi, v255 :: v_dual_mov_b32 v6, vcc_hi
// GFX11: encoding: [0x7f,0xfe,0x91,0xca,0x6b,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_lo, v255 :: v_dual_mov_b32 v6, ttmp15
// GFX11: encoding: [0x7e,0xfe,0x91,0xca,0x7b,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, m0, v255 :: v_dual_mov_b32 v6, m0
// GFX11: encoding: [0x7d,0xfe,0x91,0xca,0x7d,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_hi, v255 :: v_dual_mov_b32 v6, exec_lo
// GFX11: encoding: [0x6b,0xfe,0x91,0xca,0x7e,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_lo, v255 :: v_dual_mov_b32 v6, exec_hi
// GFX11: encoding: [0x6a,0xfe,0x91,0xca,0x7f,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0xaf123456, v255 :: v_dual_mov_b32 v6, null
// GFX11: encoding: [0xff,0xfe,0x91,0xca,0x7c,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, src_scc, v255 :: v_dual_mov_b32 v6, -1
// GFX11: encoding: [0xfd,0xfe,0x91,0xca,0xc1,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0.5, v3 :: v_dual_mov_b32 v6, 0.5
// GFX11: encoding: [0xf0,0x06,0x90,0xca,0xf0,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, -1, v4 :: v_dual_mov_b32 v6, src_scc
// GFX11: encoding: [0xc1,0x08,0x90,0xca,0xfd,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v6, null, v5 :: v_dual_mov_b32 v255, 0xaf123456
// GFX11: encoding: [0x7c,0x0a,0x90,0xca,0xff,0x00,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v4, v2 :: v_dual_mul_dx9_zero_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x8e,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v1, v2 :: v_dual_mul_dx9_zero_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x8e,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v255, v2 :: v_dual_mul_dx9_zero_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x8e,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v2, v2 :: v_dual_mul_dx9_zero_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x8e,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v3, v2 :: v_dual_mul_dx9_zero_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x8e,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s105, v2 :: v_dual_mul_dx9_zero_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x8e,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s1, v2 :: v_dual_mul_dx9_zero_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x8e,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, ttmp15, v2 :: v_dual_mul_dx9_zero_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x8e,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_hi, v2 :: v_dual_mul_dx9_zero_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x8e,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_lo, v2 :: v_dual_mul_dx9_zero_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x8e,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, m0, v2 :: v_dual_mul_dx9_zero_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x8e,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_hi, v2 :: v_dual_mul_dx9_zero_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x8e,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_lo, v2 :: v_dual_mul_dx9_zero_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x8e,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0xaf123456, v2 :: v_dual_mul_dx9_zero_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x8e,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, src_scc, v2 :: v_dual_mul_dx9_zero_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x8e,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0.5, v3 :: v_dual_mul_dx9_zero_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x8e,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, -1, v4 :: v_dual_mul_dx9_zero_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x8e,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v6, null, v5 :: v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x8e,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v4, v2 :: v_dual_mul_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x86,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v1, v2 :: v_dual_mul_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x86,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v255, v2 :: v_dual_mul_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x86,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v2, v2 :: v_dual_mul_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x86,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v3, v2 :: v_dual_mul_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x86,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s105, v2 :: v_dual_mul_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x86,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s1, v2 :: v_dual_mul_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x86,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, ttmp15, v2 :: v_dual_mul_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x86,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_hi, v2 :: v_dual_mul_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x86,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_lo, v2 :: v_dual_mul_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x86,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, m0, v2 :: v_dual_mul_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x86,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_hi, v2 :: v_dual_mul_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x86,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_lo, v2 :: v_dual_mul_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x86,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0xaf123456, v2 :: v_dual_mul_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x86,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, src_scc, v2 :: v_dual_mul_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x86,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0.5, v3 :: v_dual_mul_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x86,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, -1, v4 :: v_dual_mul_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x86,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v6, null, v5 :: v_dual_mul_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x86,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v4, v2 :: v_dual_sub_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x8a,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v1, v2 :: v_dual_sub_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x8a,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v255, v2 :: v_dual_sub_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x8a,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v2, v2 :: v_dual_sub_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x8a,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v3, v2 :: v_dual_sub_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x8a,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s105, v2 :: v_dual_sub_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x8a,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s1, v2 :: v_dual_sub_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x8a,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, ttmp15, v2 :: v_dual_sub_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x8a,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_hi, v2 :: v_dual_sub_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x8a,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_lo, v2 :: v_dual_sub_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x8a,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, m0, v2 :: v_dual_sub_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x8a,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_hi, v2 :: v_dual_sub_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x8a,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_lo, v2 :: v_dual_sub_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x8a,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0xaf123456, v2 :: v_dual_sub_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x8a,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, src_scc, v2 :: v_dual_sub_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x8a,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0.5, v3 :: v_dual_sub_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x8a,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, -1, v4 :: v_dual_sub_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x8a,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v6, null, v5 :: v_dual_sub_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x8a,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v4, v2 :: v_dual_subrev_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x8c,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v1, v2 :: v_dual_subrev_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x8c,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v255, v2 :: v_dual_subrev_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x8c,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v2, v2 :: v_dual_subrev_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x8c,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, v3, v2 :: v_dual_subrev_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x8c,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s105, v2 :: v_dual_subrev_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x8c,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, s1, v2 :: v_dual_subrev_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x8c,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, ttmp15, v2 :: v_dual_subrev_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x8c,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_hi, v2 :: v_dual_subrev_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x8c,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, exec_lo, v2 :: v_dual_subrev_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x8c,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, m0, v2 :: v_dual_subrev_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x8c,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_hi, v2 :: v_dual_subrev_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x8c,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, vcc_lo, v2 :: v_dual_subrev_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x8c,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0xaf123456, v2 :: v_dual_subrev_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x8c,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, src_scc, v2 :: v_dual_subrev_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x8c,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, 0.5, v3 :: v_dual_subrev_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x8c,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v255, -1, v4 :: v_dual_subrev_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x8c,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_max_f32 v6, null, v5 :: v_dual_subrev_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x8c,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v4, v2 :: v_dual_add_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xc8,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v1, v2 :: v_dual_add_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xc8,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v255, v2 :: v_dual_add_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xc8,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v2, v2 :: v_dual_add_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xc8,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v3, v2 :: v_dual_add_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xc8,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s105, v2 :: v_dual_add_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xc8,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s1, v2 :: v_dual_add_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xc8,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, ttmp15, v2 :: v_dual_add_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xc8,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_hi, v2 :: v_dual_add_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xc8,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_lo, v2 :: v_dual_add_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xc8,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, m0, v2 :: v_dual_add_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xc8,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_hi, v2 :: v_dual_add_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xc8,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_lo, v2 :: v_dual_add_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xc8,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0xaf123456, v2 :: v_dual_add_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xc8,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, src_scc, v2 :: v_dual_add_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xc8,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0.5, v3 :: v_dual_add_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xc8,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, -1, v4 :: v_dual_add_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xc8,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v6, null, v5 :: v_dual_add_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xc8,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v4, v2 :: v_dual_add_nc_u32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xe0,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v1, v2 :: v_dual_add_nc_u32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xe0,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v255, v2 :: v_dual_add_nc_u32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xe0,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v2, v2 :: v_dual_add_nc_u32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xe0,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v3, v2 :: v_dual_add_nc_u32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xe0,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s105, v2 :: v_dual_add_nc_u32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xe0,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s1, v2 :: v_dual_add_nc_u32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xe0,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, ttmp15, v2 :: v_dual_add_nc_u32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xe0,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_hi, v2 :: v_dual_add_nc_u32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xe0,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_lo, v2 :: v_dual_add_nc_u32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xe0,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, m0, v2 :: v_dual_add_nc_u32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xe0,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_hi, v2 :: v_dual_add_nc_u32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xe0,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_lo, v2 :: v_dual_add_nc_u32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xe0,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0xaf123456, v2 :: v_dual_add_nc_u32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xe0,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, src_scc, v2 :: v_dual_add_nc_u32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xe0,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0.5, v3 :: v_dual_add_nc_u32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xe0,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, -1, v4 :: v_dual_add_nc_u32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xe0,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v6, null, v5 :: v_dual_add_nc_u32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xe0,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v4, v2 :: v_dual_and_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xe4,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v1, v2 :: v_dual_and_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xe4,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v255, v2 :: v_dual_and_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xe4,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v2, v2 :: v_dual_and_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xe4,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v3, v2 :: v_dual_and_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xe4,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s105, v2 :: v_dual_and_b32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xe4,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s1, v2 :: v_dual_and_b32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xe4,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, ttmp15, v2 :: v_dual_and_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xe4,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_hi, v2 :: v_dual_and_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xe4,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_lo, v2 :: v_dual_and_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xe4,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, m0, v2 :: v_dual_and_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xe4,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_hi, v2 :: v_dual_and_b32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xe4,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_lo, v2 :: v_dual_and_b32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xe4,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0xaf123456, v2 :: v_dual_and_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xe4,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, src_scc, v2 :: v_dual_and_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xe4,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0.5, v3 :: v_dual_and_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xe4,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, -1, v4 :: v_dual_and_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xe4,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v6, null, v5 :: v_dual_and_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xe4,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v4, v2 :: v_dual_cndmask_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xd2,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v1, v2 :: v_dual_cndmask_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xd2,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v255, v2 :: v_dual_cndmask_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xd2,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v2, v2 :: v_dual_cndmask_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xd2,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v3, v2 :: v_dual_cndmask_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xd2,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s105, v2 :: v_dual_cndmask_b32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0xd2,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s1, v2 :: v_dual_cndmask_b32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0xd2,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, ttmp15, v2 :: v_dual_cndmask_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0xd2,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_hi, v2 :: v_dual_cndmask_b32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0xd2,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_lo, v2 :: v_dual_cndmask_b32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0xd2,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, m0, v2 :: v_dual_cndmask_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xd2,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_hi, v2 :: v_dual_cndmask_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0xd2,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_lo, v2 :: v_dual_cndmask_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0xd2,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0xaf123456, v2 :: v_dual_cndmask_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xd2,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, src_scc, v2 :: v_dual_cndmask_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xd2,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0.5, v3 :: v_dual_cndmask_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xd2,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, -1, v4 :: v_dual_cndmask_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xd2,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v6, null, v5 :: v_dual_cndmask_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xd2,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v4, v2 :: v_dual_dot2acc_f32_f16 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xd8,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v1, v2 :: v_dual_dot2acc_f32_f16 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xd8,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v255, v2 :: v_dual_dot2acc_f32_f16 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xd8,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v2, v2 :: v_dual_dot2acc_f32_f16 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xd8,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v3, v2 :: v_dual_dot2acc_f32_f16 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xd8,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s105, v2 :: v_dual_dot2acc_f32_f16 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xd8,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s1, v2 :: v_dual_dot2acc_f32_f16 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xd8,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, ttmp15, v2 :: v_dual_dot2acc_f32_f16 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xd8,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_hi, v2 :: v_dual_dot2acc_f32_f16 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xd8,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_lo, v2 :: v_dual_dot2acc_f32_f16 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xd8,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, m0, v2 :: v_dual_dot2acc_f32_f16 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xd8,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_hi, v2 :: v_dual_dot2acc_f32_f16 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xd8,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_lo, v2 :: v_dual_dot2acc_f32_f16 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xd8,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0xaf123456, v2 :: v_dual_dot2acc_f32_f16 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xd8,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, src_scc, v2 :: v_dual_dot2acc_f32_f16 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xd8,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0.5, v3 :: v_dual_dot2acc_f32_f16 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xd8,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, -1, v4 :: v_dual_dot2acc_f32_f16 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xd8,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v6, null, v5 :: v_dual_dot2acc_f32_f16 v255, 0xfe0b, v4
// GFX11: encoding: [0x7c,0x0a,0xd8,0xca,0xff,0x08,0xfe,0x06,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v4, v2 :: v_dual_fmaak_f32 v6, v1, v3, 0xaf123456
// GFX11: encoding: [0x04,0x05,0xc2,0xca,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v1, v2 :: v_dual_fmaak_f32 v6, v255, v3, 0xaf123456
// GFX11: encoding: [0x01,0x05,0xc2,0xca,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v255, v2 :: v_dual_fmaak_f32 v6, v2, v3, 0xaf123456
// GFX11: encoding: [0xff,0x05,0xc2,0xca,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v2, v2 :: v_dual_fmaak_f32 v6, v3, v3, 0xaf123456
// GFX11: encoding: [0x02,0x05,0xc2,0xca,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v3, v2 :: v_dual_fmaak_f32 v6, v4, v3, 0xaf123456
// GFX11: encoding: [0x03,0x05,0xc2,0xca,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s105, v2 :: v_dual_fmaak_f32 v6, s105, v3, 0xaf123456
// GFX11: encoding: [0x69,0x04,0xc2,0xca,0x69,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s1, v2 :: v_dual_fmaak_f32 v6, s1, v3, 0xaf123456
// GFX11: encoding: [0x01,0x04,0xc2,0xca,0x01,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, ttmp15, v2 :: v_dual_fmaak_f32 v6, ttmp15, v3, 0xaf123456
// GFX11: encoding: [0x7b,0x04,0xc2,0xca,0x7b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_hi, v2 :: v_dual_fmaak_f32 v6, exec_hi, v3, 0xaf123456
// GFX11: encoding: [0x7f,0x04,0xc2,0xca,0x7f,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_lo, v2 :: v_dual_fmaak_f32 v6, exec_lo, v3, 0xaf123456
// GFX11: encoding: [0x7e,0x04,0xc2,0xca,0x7e,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, m0, v2 :: v_dual_fmaak_f32 v6, m0, v3, 0xaf123456
// GFX11: encoding: [0x7d,0x04,0xc2,0xca,0x7d,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_hi, v2 :: v_dual_fmaak_f32 v6, vcc_hi, v3, 0xaf123456
// GFX11: encoding: [0x6b,0x04,0xc2,0xca,0x6b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_lo, v2 :: v_dual_fmaak_f32 v6, vcc_lo, v3, 0xaf123456
// GFX11: encoding: [0x6a,0x04,0xc2,0xca,0x6a,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0xaf123456, v2 :: v_dual_fmaak_f32 v6, null, v3, 0xaf123456
// GFX11: encoding: [0xff,0x04,0xc2,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, src_scc, v2 :: v_dual_fmaak_f32 v6, -1, v3, 0xaf123456
// GFX11: encoding: [0xfd,0x04,0xc2,0xca,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0.5, v3 :: v_dual_fmaak_f32 v6, 0.5, v2, 0xaf123456
// GFX11: encoding: [0xf0,0x06,0xc2,0xca,0xf0,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, -1, v4 :: v_dual_fmaak_f32 v6, src_scc, v5, 0xaf123456
// GFX11: encoding: [0xc1,0x08,0xc2,0xca,0xfd,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v6, null, v5 :: v_dual_fmaak_f32 v255, 0xaf123456, v4, 0xaf123456
// GFX11: encoding: [0x7c,0x0a,0xc2,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v4, v2 :: v_dual_fmac_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xc0,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v1, v2 :: v_dual_fmac_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xc0,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v255, v2 :: v_dual_fmac_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xc0,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v2, v2 :: v_dual_fmac_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xc0,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v3, v2 :: v_dual_fmac_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xc0,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s105, v2 :: v_dual_fmac_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xc0,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s1, v2 :: v_dual_fmac_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xc0,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, ttmp15, v2 :: v_dual_fmac_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xc0,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_hi, v2 :: v_dual_fmac_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xc0,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_lo, v2 :: v_dual_fmac_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xc0,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, m0, v2 :: v_dual_fmac_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xc0,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_hi, v2 :: v_dual_fmac_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xc0,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_lo, v2 :: v_dual_fmac_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xc0,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0xaf123456, v2 :: v_dual_fmac_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xc0,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, src_scc, v2 :: v_dual_fmac_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xc0,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0.5, v3 :: v_dual_fmac_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xc0,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, -1, v4 :: v_dual_fmac_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xc0,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v6, null, v5 :: v_dual_fmac_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xc0,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v4, v255 :: v_dual_fmamk_f32 v6, v1, 0xaf123456, v255
// GFX11: encoding: [0x04,0xff,0xc5,0xca,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v1, v255 :: v_dual_fmamk_f32 v6, v255, 0xaf123456, v255
// GFX11: encoding: [0x01,0xff,0xc5,0xca,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v255, v255 :: v_dual_fmamk_f32 v6, v2, 0xaf123456, v255
// GFX11: encoding: [0xff,0xff,0xc5,0xca,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v2, v255 :: v_dual_fmamk_f32 v6, v3, 0xaf123456, v255
// GFX11: encoding: [0x02,0xff,0xc5,0xca,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v3, v255 :: v_dual_fmamk_f32 v6, v4, 0xaf123456, v255
// GFX11: encoding: [0x03,0xff,0xc5,0xca,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s105, v255 :: v_dual_fmamk_f32 v6, s105, 0xaf123456, v255
// GFX11: encoding: [0x69,0xfe,0xc5,0xca,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s1, v255 :: v_dual_fmamk_f32 v6, s1, 0xaf123456, v255
// GFX11: encoding: [0x01,0xfe,0xc5,0xca,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, ttmp15, v255 :: v_dual_fmamk_f32 v6, ttmp15, 0xaf123456, v255
// GFX11: encoding: [0x7b,0xfe,0xc5,0xca,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_hi, v255 :: v_dual_fmamk_f32 v6, exec_hi, 0xaf123456, v255
// GFX11: encoding: [0x7f,0xfe,0xc5,0xca,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_lo, v255 :: v_dual_fmamk_f32 v6, exec_lo, 0xaf123456, v255
// GFX11: encoding: [0x7e,0xfe,0xc5,0xca,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, m0, v255 :: v_dual_fmamk_f32 v6, m0, 0xaf123456, v255
// GFX11: encoding: [0x7d,0xfe,0xc5,0xca,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_hi, v255 :: v_dual_fmamk_f32 v6, vcc_hi, 0xaf123456, v255
// GFX11: encoding: [0x6b,0xfe,0xc5,0xca,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_lo, v255 :: v_dual_fmamk_f32 v6, vcc_lo, 0xaf123456, v255
// GFX11: encoding: [0x6a,0xfe,0xc5,0xca,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, null, 0xaf123456, v255
// GFX11: encoding: [0xff,0xfe,0xc5,0xca,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, src_scc, v255 :: v_dual_fmamk_f32 v6, -1, 0xaf123456, v255
// GFX11: encoding: [0xfd,0xfe,0xc5,0xca,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0.5, v3 :: v_dual_fmamk_f32 v6, 0.5, 0xaf123456, v255
// GFX11: encoding: [0xf0,0x06,0xc4,0xca,0xf0,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, -1, v4 :: v_dual_fmamk_f32 v6, src_scc, 0xaf123456, v255
// GFX11: encoding: [0xc1,0x08,0xc4,0xca,0xfd,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v6, null, v5 :: v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xc4,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v4, v2 :: v_dual_lshlrev_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xe2,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v1, v2 :: v_dual_lshlrev_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xe2,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v255, v2 :: v_dual_lshlrev_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xe2,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v2, v2 :: v_dual_lshlrev_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xe2,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v3, v2 :: v_dual_lshlrev_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xe2,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s105, v2 :: v_dual_lshlrev_b32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xe2,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s1, v2 :: v_dual_lshlrev_b32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xe2,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, ttmp15, v2 :: v_dual_lshlrev_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xe2,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_hi, v2 :: v_dual_lshlrev_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xe2,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_lo, v2 :: v_dual_lshlrev_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xe2,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, m0, v2 :: v_dual_lshlrev_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xe2,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_hi, v2 :: v_dual_lshlrev_b32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xe2,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_lo, v2 :: v_dual_lshlrev_b32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xe2,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0xaf123456, v2 :: v_dual_lshlrev_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xe2,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, src_scc, v2 :: v_dual_lshlrev_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xe2,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0.5, v3 :: v_dual_lshlrev_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xe2,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, -1, v4 :: v_dual_lshlrev_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xe2,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v6, null, v5 :: v_dual_lshlrev_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xe2,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v4, v2 :: v_dual_max_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xd4,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v1, v2 :: v_dual_max_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xd4,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v255, v2 :: v_dual_max_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xd4,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v2, v2 :: v_dual_max_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xd4,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v3, v2 :: v_dual_max_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xd4,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s105, v2 :: v_dual_max_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xd4,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s1, v2 :: v_dual_max_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xd4,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, ttmp15, v2 :: v_dual_max_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xd4,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_hi, v2 :: v_dual_max_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xd4,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_lo, v2 :: v_dual_max_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xd4,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, m0, v2 :: v_dual_max_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xd4,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_hi, v2 :: v_dual_max_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xd4,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_lo, v2 :: v_dual_max_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xd4,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0xaf123456, v2 :: v_dual_max_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xd4,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, src_scc, v2 :: v_dual_max_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xd4,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0.5, v3 :: v_dual_max_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xd4,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, -1, v4 :: v_dual_max_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xd4,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v6, null, v5 :: v_dual_max_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xd4,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v4, v2 :: v_dual_min_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xd6,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v1, v2 :: v_dual_min_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xd6,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v255, v2 :: v_dual_min_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xd6,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v2, v2 :: v_dual_min_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xd6,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v3, v2 :: v_dual_min_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xd6,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s105, v2 :: v_dual_min_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xd6,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s1, v2 :: v_dual_min_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xd6,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, ttmp15, v2 :: v_dual_min_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xd6,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_hi, v2 :: v_dual_min_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xd6,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_lo, v2 :: v_dual_min_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xd6,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, m0, v2 :: v_dual_min_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xd6,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_hi, v2 :: v_dual_min_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xd6,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_lo, v2 :: v_dual_min_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xd6,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0xaf123456, v2 :: v_dual_min_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xd6,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, src_scc, v2 :: v_dual_min_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xd6,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0.5, v3 :: v_dual_min_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xd6,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, -1, v4 :: v_dual_min_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xd6,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v6, null, v5 :: v_dual_min_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xd6,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v4, v255 :: v_dual_mov_b32 v6, v1
// GFX11: encoding: [0x04,0xff,0xd1,0xca,0x01,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v1, v255 :: v_dual_mov_b32 v6, v255
// GFX11: encoding: [0x01,0xff,0xd1,0xca,0xff,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v255, v255 :: v_dual_mov_b32 v6, v2
// GFX11: encoding: [0xff,0xff,0xd1,0xca,0x02,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v2, v255 :: v_dual_mov_b32 v6, v3
// GFX11: encoding: [0x02,0xff,0xd1,0xca,0x03,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v3, v255 :: v_dual_mov_b32 v6, v4
// GFX11: encoding: [0x03,0xff,0xd1,0xca,0x04,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s105, v255 :: v_dual_mov_b32 v6, s1
// GFX11: encoding: [0x69,0xfe,0xd1,0xca,0x01,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s1, v255 :: v_dual_mov_b32 v6, s105
// GFX11: encoding: [0x01,0xfe,0xd1,0xca,0x69,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, ttmp15, v255 :: v_dual_mov_b32 v6, vcc_lo
// GFX11: encoding: [0x7b,0xfe,0xd1,0xca,0x6a,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_hi, v255 :: v_dual_mov_b32 v6, vcc_hi
// GFX11: encoding: [0x7f,0xfe,0xd1,0xca,0x6b,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_lo, v255 :: v_dual_mov_b32 v6, ttmp15
// GFX11: encoding: [0x7e,0xfe,0xd1,0xca,0x7b,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, m0, v255 :: v_dual_mov_b32 v6, m0
// GFX11: encoding: [0x7d,0xfe,0xd1,0xca,0x7d,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_hi, v255 :: v_dual_mov_b32 v6, exec_lo
// GFX11: encoding: [0x6b,0xfe,0xd1,0xca,0x7e,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_lo, v255 :: v_dual_mov_b32 v6, exec_hi
// GFX11: encoding: [0x6a,0xfe,0xd1,0xca,0x7f,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0xaf123456, v255 :: v_dual_mov_b32 v6, null
// GFX11: encoding: [0xff,0xfe,0xd1,0xca,0x7c,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, src_scc, v255 :: v_dual_mov_b32 v6, -1
// GFX11: encoding: [0xfd,0xfe,0xd1,0xca,0xc1,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0.5, v3 :: v_dual_mov_b32 v6, 0.5
// GFX11: encoding: [0xf0,0x06,0xd0,0xca,0xf0,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, -1, v4 :: v_dual_mov_b32 v6, src_scc
// GFX11: encoding: [0xc1,0x08,0xd0,0xca,0xfd,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v6, null, v5 :: v_dual_mov_b32 v255, 0xaf123456
// GFX11: encoding: [0x7c,0x0a,0xd0,0xca,0xff,0x00,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v4, v2 :: v_dual_mul_dx9_zero_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xce,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v1, v2 :: v_dual_mul_dx9_zero_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xce,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v255, v2 :: v_dual_mul_dx9_zero_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xce,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v2, v2 :: v_dual_mul_dx9_zero_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xce,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v3, v2 :: v_dual_mul_dx9_zero_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xce,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s105, v2 :: v_dual_mul_dx9_zero_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xce,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s1, v2 :: v_dual_mul_dx9_zero_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xce,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, ttmp15, v2 :: v_dual_mul_dx9_zero_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xce,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_hi, v2 :: v_dual_mul_dx9_zero_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xce,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_lo, v2 :: v_dual_mul_dx9_zero_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xce,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, m0, v2 :: v_dual_mul_dx9_zero_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xce,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_hi, v2 :: v_dual_mul_dx9_zero_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xce,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_lo, v2 :: v_dual_mul_dx9_zero_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xce,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0xaf123456, v2 :: v_dual_mul_dx9_zero_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xce,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, src_scc, v2 :: v_dual_mul_dx9_zero_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xce,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0.5, v3 :: v_dual_mul_dx9_zero_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xce,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, -1, v4 :: v_dual_mul_dx9_zero_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xce,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v6, null, v5 :: v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xce,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v4, v2 :: v_dual_mul_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xc6,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v1, v2 :: v_dual_mul_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xc6,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v255, v2 :: v_dual_mul_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xc6,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v2, v2 :: v_dual_mul_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xc6,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v3, v2 :: v_dual_mul_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xc6,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s105, v2 :: v_dual_mul_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xc6,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s1, v2 :: v_dual_mul_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xc6,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, ttmp15, v2 :: v_dual_mul_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xc6,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_hi, v2 :: v_dual_mul_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xc6,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_lo, v2 :: v_dual_mul_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xc6,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, m0, v2 :: v_dual_mul_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xc6,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_hi, v2 :: v_dual_mul_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xc6,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_lo, v2 :: v_dual_mul_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xc6,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0xaf123456, v2 :: v_dual_mul_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xc6,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, src_scc, v2 :: v_dual_mul_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xc6,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0.5, v3 :: v_dual_mul_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xc6,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, -1, v4 :: v_dual_mul_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xc6,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v6, null, v5 :: v_dual_mul_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xc6,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v4, v2 :: v_dual_sub_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xca,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v1, v2 :: v_dual_sub_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xca,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v255, v2 :: v_dual_sub_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xca,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v2, v2 :: v_dual_sub_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xca,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v3, v2 :: v_dual_sub_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xca,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s105, v2 :: v_dual_sub_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xca,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s1, v2 :: v_dual_sub_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xca,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, ttmp15, v2 :: v_dual_sub_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xca,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_hi, v2 :: v_dual_sub_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xca,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_lo, v2 :: v_dual_sub_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xca,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, m0, v2 :: v_dual_sub_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xca,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_hi, v2 :: v_dual_sub_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xca,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_lo, v2 :: v_dual_sub_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xca,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0xaf123456, v2 :: v_dual_sub_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xca,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, src_scc, v2 :: v_dual_sub_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xca,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0.5, v3 :: v_dual_sub_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xca,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, -1, v4 :: v_dual_sub_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xca,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v6, null, v5 :: v_dual_sub_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xca,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v4, v2 :: v_dual_subrev_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xcc,0xca,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v1, v2 :: v_dual_subrev_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xcc,0xca,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v255, v2 :: v_dual_subrev_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xcc,0xca,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v2, v2 :: v_dual_subrev_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xcc,0xca,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, v3, v2 :: v_dual_subrev_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xcc,0xca,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s105, v2 :: v_dual_subrev_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xcc,0xca,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, s1, v2 :: v_dual_subrev_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xcc,0xca,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, ttmp15, v2 :: v_dual_subrev_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xcc,0xca,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_hi, v2 :: v_dual_subrev_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xcc,0xca,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, exec_lo, v2 :: v_dual_subrev_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xcc,0xca,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, m0, v2 :: v_dual_subrev_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xcc,0xca,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_hi, v2 :: v_dual_subrev_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xcc,0xca,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, vcc_lo, v2 :: v_dual_subrev_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xcc,0xca,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0xaf123456, v2 :: v_dual_subrev_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xcc,0xca,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, src_scc, v2 :: v_dual_subrev_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xcc,0xca,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, 0.5, v3 :: v_dual_subrev_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xcc,0xca,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v255, -1, v4 :: v_dual_subrev_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xcc,0xca,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_min_f32 v6, null, v5 :: v_dual_subrev_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xcc,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v4 :: v_dual_add_f32 v6, v1, v255
// GFX11: encoding: [0x04,0x01,0x08,0xca,0x01,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v1 :: v_dual_add_f32 v6, v255, v255
// GFX11: encoding: [0x01,0x01,0x08,0xca,0xff,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v255 :: v_dual_add_f32 v6, v2, v255
// GFX11: encoding: [0xff,0x01,0x08,0xca,0x02,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v2 :: v_dual_add_f32 v6, v3, v255
// GFX11: encoding: [0x02,0x01,0x08,0xca,0x03,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v3 :: v_dual_add_f32 v6, v4, v255
// GFX11: encoding: [0x03,0x01,0x08,0xca,0x04,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s105 :: v_dual_add_f32 v6, s1, v255
// GFX11: encoding: [0x69,0x00,0x08,0xca,0x01,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s1 :: v_dual_add_f32 v6, s105, v255
// GFX11: encoding: [0x01,0x00,0x08,0xca,0x69,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, ttmp15 :: v_dual_add_f32 v6, vcc_lo, v255
// GFX11: encoding: [0x7b,0x00,0x08,0xca,0x6a,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_hi :: v_dual_add_f32 v6, vcc_hi, v255
// GFX11: encoding: [0x7f,0x00,0x08,0xca,0x6b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_lo :: v_dual_add_f32 v6, ttmp15, v255
// GFX11: encoding: [0x7e,0x00,0x08,0xca,0x7b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, m0 :: v_dual_add_f32 v6, m0, v255
// GFX11: encoding: [0x7d,0x00,0x08,0xca,0x7d,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_hi :: v_dual_add_f32 v6, exec_lo, v255
// GFX11: encoding: [0x6b,0x00,0x08,0xca,0x7e,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_lo :: v_dual_add_f32 v6, exec_hi, v255
// GFX11: encoding: [0x6a,0x00,0x08,0xca,0x7f,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0xaf123456 :: v_dual_add_f32 v6, null, v255
// GFX11: encoding: [0xff,0x00,0x08,0xca,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, src_scc :: v_dual_add_f32 v6, -1, v255
// GFX11: encoding: [0xfd,0x00,0x08,0xca,0xc1,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0.5 :: v_dual_add_f32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0x00,0x08,0xca,0xf0,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, -1 :: v_dual_add_f32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0x00,0x08,0xca,0xfd,0x08,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v6, null :: v_dual_add_f32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x00,0x08,0xca,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v4 :: v_dual_add_nc_u32 v6, v1, v255
// GFX11: encoding: [0x04,0x01,0x20,0xca,0x01,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v1 :: v_dual_add_nc_u32 v6, v255, v255
// GFX11: encoding: [0x01,0x01,0x20,0xca,0xff,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v255 :: v_dual_add_nc_u32 v6, v2, v255
// GFX11: encoding: [0xff,0x01,0x20,0xca,0x02,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v2 :: v_dual_add_nc_u32 v6, v3, v255
// GFX11: encoding: [0x02,0x01,0x20,0xca,0x03,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v3 :: v_dual_add_nc_u32 v6, v4, v255
// GFX11: encoding: [0x03,0x01,0x20,0xca,0x04,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s105 :: v_dual_add_nc_u32 v6, s1, v255
// GFX11: encoding: [0x69,0x00,0x20,0xca,0x01,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s1 :: v_dual_add_nc_u32 v6, s105, v255
// GFX11: encoding: [0x01,0x00,0x20,0xca,0x69,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, ttmp15 :: v_dual_add_nc_u32 v6, vcc_lo, v255
// GFX11: encoding: [0x7b,0x00,0x20,0xca,0x6a,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_hi :: v_dual_add_nc_u32 v6, vcc_hi, v255
// GFX11: encoding: [0x7f,0x00,0x20,0xca,0x6b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_lo :: v_dual_add_nc_u32 v6, ttmp15, v255
// GFX11: encoding: [0x7e,0x00,0x20,0xca,0x7b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, m0 :: v_dual_add_nc_u32 v6, m0, v255
// GFX11: encoding: [0x7d,0x00,0x20,0xca,0x7d,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_hi :: v_dual_add_nc_u32 v6, exec_lo, v255
// GFX11: encoding: [0x6b,0x00,0x20,0xca,0x7e,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_lo :: v_dual_add_nc_u32 v6, exec_hi, v255
// GFX11: encoding: [0x6a,0x00,0x20,0xca,0x7f,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0xaf123456 :: v_dual_add_nc_u32 v6, null, v255
// GFX11: encoding: [0xff,0x00,0x20,0xca,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, src_scc :: v_dual_add_nc_u32 v6, -1, v255
// GFX11: encoding: [0xfd,0x00,0x20,0xca,0xc1,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0.5 :: v_dual_add_nc_u32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0x00,0x20,0xca,0xf0,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, -1 :: v_dual_add_nc_u32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0x00,0x20,0xca,0xfd,0x08,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v6, null :: v_dual_add_nc_u32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x00,0x20,0xca,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v4 :: v_dual_and_b32 v6, v1, v255
// GFX11: encoding: [0x04,0x01,0x24,0xca,0x01,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v1 :: v_dual_and_b32 v6, v255, v255
// GFX11: encoding: [0x01,0x01,0x24,0xca,0xff,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v255 :: v_dual_and_b32 v6, v2, v255
// GFX11: encoding: [0xff,0x01,0x24,0xca,0x02,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v2 :: v_dual_and_b32 v6, v3, v255
// GFX11: encoding: [0x02,0x01,0x24,0xca,0x03,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v3 :: v_dual_and_b32 v6, v4, v255
// GFX11: encoding: [0x03,0x01,0x24,0xca,0x04,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s105 :: v_dual_and_b32 v6, s1, v255
// GFX11: encoding: [0x69,0x00,0x24,0xca,0x01,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s1 :: v_dual_and_b32 v6, s105, v255
// GFX11: encoding: [0x01,0x00,0x24,0xca,0x69,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, ttmp15 :: v_dual_and_b32 v6, vcc_lo, v255
// GFX11: encoding: [0x7b,0x00,0x24,0xca,0x6a,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_hi :: v_dual_and_b32 v6, vcc_hi, v255
// GFX11: encoding: [0x7f,0x00,0x24,0xca,0x6b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_lo :: v_dual_and_b32 v6, ttmp15, v255
// GFX11: encoding: [0x7e,0x00,0x24,0xca,0x7b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, m0 :: v_dual_and_b32 v6, m0, v255
// GFX11: encoding: [0x7d,0x00,0x24,0xca,0x7d,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_hi :: v_dual_and_b32 v6, exec_lo, v255
// GFX11: encoding: [0x6b,0x00,0x24,0xca,0x7e,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_lo :: v_dual_and_b32 v6, exec_hi, v255
// GFX11: encoding: [0x6a,0x00,0x24,0xca,0x7f,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0xaf123456 :: v_dual_and_b32 v6, null, v255
// GFX11: encoding: [0xff,0x00,0x24,0xca,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, src_scc :: v_dual_and_b32 v6, -1, v255
// GFX11: encoding: [0xfd,0x00,0x24,0xca,0xc1,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0.5 :: v_dual_and_b32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0x00,0x24,0xca,0xf0,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, -1 :: v_dual_and_b32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0x00,0x24,0xca,0xfd,0x08,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v6, null :: v_dual_and_b32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x00,0x24,0xca,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v4 :: v_dual_cndmask_b32 v6, v1, v255
// GFX11: encoding: [0x04,0x01,0x12,0xca,0x01,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v1 :: v_dual_cndmask_b32 v6, v255, v255
// GFX11: encoding: [0x01,0x01,0x12,0xca,0xff,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v255 :: v_dual_cndmask_b32 v6, v2, v255
// GFX11: encoding: [0xff,0x01,0x12,0xca,0x02,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v2 :: v_dual_cndmask_b32 v6, v3, v255
// GFX11: encoding: [0x02,0x01,0x12,0xca,0x03,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v3 :: v_dual_cndmask_b32 v6, v4, v255
// GFX11: encoding: [0x03,0x01,0x12,0xca,0x04,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s105 :: v_dual_cndmask_b32 v6, s105, v255
// GFX11: encoding: [0x69,0x00,0x12,0xca,0x69,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s1 :: v_dual_cndmask_b32 v6, s1, v255
// GFX11: encoding: [0x01,0x00,0x12,0xca,0x01,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, ttmp15 :: v_dual_cndmask_b32 v6, ttmp15, v255
// GFX11: encoding: [0x7b,0x00,0x12,0xca,0x7b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_hi :: v_dual_cndmask_b32 v6, exec_hi, v255
// GFX11: encoding: [0x7f,0x00,0x12,0xca,0x7f,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_lo :: v_dual_cndmask_b32 v6, exec_lo, v255
// GFX11: encoding: [0x7e,0x00,0x12,0xca,0x7e,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, m0 :: v_dual_cndmask_b32 v6, m0, v255
// GFX11: encoding: [0x7d,0x00,0x12,0xca,0x7d,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_hi :: v_dual_cndmask_b32 v6, vcc_hi, v255
// GFX11: encoding: [0x6b,0x00,0x12,0xca,0x6b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_lo :: v_dual_cndmask_b32 v6, vcc_lo, v255
// GFX11: encoding: [0x6a,0x00,0x12,0xca,0x6a,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0xaf123456 :: v_dual_cndmask_b32 v6, null, v255
// GFX11: encoding: [0xff,0x00,0x12,0xca,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, src_scc :: v_dual_cndmask_b32 v6, -1, v255
// GFX11: encoding: [0xfd,0x00,0x12,0xca,0xc1,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0.5 :: v_dual_cndmask_b32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0x00,0x12,0xca,0xf0,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, -1 :: v_dual_cndmask_b32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0x00,0x12,0xca,0xfd,0x08,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v6, null :: v_dual_cndmask_b32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x00,0x12,0xca,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v4 :: v_dual_dot2acc_f32_f16 v6, v1, v255
// GFX11: encoding: [0x04,0x01,0x18,0xca,0x01,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v1 :: v_dual_dot2acc_f32_f16 v6, v255, v255
// GFX11: encoding: [0x01,0x01,0x18,0xca,0xff,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v255 :: v_dual_dot2acc_f32_f16 v6, v2, v255
// GFX11: encoding: [0xff,0x01,0x18,0xca,0x02,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v2 :: v_dual_dot2acc_f32_f16 v6, v3, v255
// GFX11: encoding: [0x02,0x01,0x18,0xca,0x03,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v3 :: v_dual_dot2acc_f32_f16 v6, v4, v255
// GFX11: encoding: [0x03,0x01,0x18,0xca,0x04,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s105 :: v_dual_dot2acc_f32_f16 v6, s1, v255
// GFX11: encoding: [0x69,0x00,0x18,0xca,0x01,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s1 :: v_dual_dot2acc_f32_f16 v6, s105, v255
// GFX11: encoding: [0x01,0x00,0x18,0xca,0x69,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, ttmp15 :: v_dual_dot2acc_f32_f16 v6, vcc_lo, v255
// GFX11: encoding: [0x7b,0x00,0x18,0xca,0x6a,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_hi :: v_dual_dot2acc_f32_f16 v6, vcc_hi, v255
// GFX11: encoding: [0x7f,0x00,0x18,0xca,0x6b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_lo :: v_dual_dot2acc_f32_f16 v6, ttmp15, v255
// GFX11: encoding: [0x7e,0x00,0x18,0xca,0x7b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, m0 :: v_dual_dot2acc_f32_f16 v6, m0, v255
// GFX11: encoding: [0x7d,0x00,0x18,0xca,0x7d,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_hi :: v_dual_dot2acc_f32_f16 v6, exec_lo, v255
// GFX11: encoding: [0x6b,0x00,0x18,0xca,0x7e,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_lo :: v_dual_dot2acc_f32_f16 v6, exec_hi, v255
// GFX11: encoding: [0x6a,0x00,0x18,0xca,0x7f,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0xaf123456 :: v_dual_dot2acc_f32_f16 v6, null, v255
// GFX11: encoding: [0xff,0x00,0x18,0xca,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, src_scc :: v_dual_dot2acc_f32_f16 v6, -1, v255
// GFX11: encoding: [0xfd,0x00,0x18,0xca,0xc1,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0.5 :: v_dual_dot2acc_f32_f16 v6, 0.5, v3
// GFX11: encoding: [0xf0,0x00,0x18,0xca,0xf0,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, -1 :: v_dual_dot2acc_f32_f16 v6, src_scc, v4
// GFX11: encoding: [0xc1,0x00,0x18,0xca,0xfd,0x08,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v6, null :: v_dual_dot2acc_f32_f16 v255, 0xfe0b, v5
// GFX11: encoding: [0x7c,0x00,0x18,0xca,0xff,0x0a,0xfe,0x06,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v4 :: v_dual_fmaak_f32 v6, v1, v255, 0xaf123456
// GFX11: encoding: [0x04,0x01,0x02,0xca,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v1 :: v_dual_fmaak_f32 v6, v255, v255, 0xaf123456
// GFX11: encoding: [0x01,0x01,0x02,0xca,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v255 :: v_dual_fmaak_f32 v6, v2, v255, 0xaf123456
// GFX11: encoding: [0xff,0x01,0x02,0xca,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v2 :: v_dual_fmaak_f32 v6, v3, v255, 0xaf123456
// GFX11: encoding: [0x02,0x01,0x02,0xca,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v3 :: v_dual_fmaak_f32 v6, v4, v255, 0xaf123456
// GFX11: encoding: [0x03,0x01,0x02,0xca,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s105 :: v_dual_fmaak_f32 v6, s105, v255, 0xaf123456
// GFX11: encoding: [0x69,0x00,0x02,0xca,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s1 :: v_dual_fmaak_f32 v6, s1, v255, 0xaf123456
// GFX11: encoding: [0x01,0x00,0x02,0xca,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, ttmp15 :: v_dual_fmaak_f32 v6, ttmp15, v255, 0xaf123456
// GFX11: encoding: [0x7b,0x00,0x02,0xca,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_hi :: v_dual_fmaak_f32 v6, exec_hi, v255, 0xaf123456
// GFX11: encoding: [0x7f,0x00,0x02,0xca,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_lo :: v_dual_fmaak_f32 v6, exec_lo, v255, 0xaf123456
// GFX11: encoding: [0x7e,0x00,0x02,0xca,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, m0 :: v_dual_fmaak_f32 v6, m0, v255, 0xaf123456
// GFX11: encoding: [0x7d,0x00,0x02,0xca,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_hi :: v_dual_fmaak_f32 v6, vcc_hi, v255, 0xaf123456
// GFX11: encoding: [0x6b,0x00,0x02,0xca,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_lo :: v_dual_fmaak_f32 v6, vcc_lo, v255, 0xaf123456
// GFX11: encoding: [0x6a,0x00,0x02,0xca,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0xaf123456 :: v_dual_fmaak_f32 v6, null, v255, 0xaf123456
// GFX11: encoding: [0xff,0x00,0x02,0xca,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, src_scc :: v_dual_fmaak_f32 v6, -1, v255, 0xaf123456
// GFX11: encoding: [0xfd,0x00,0x02,0xca,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0.5 :: v_dual_fmaak_f32 v6, 0.5, v3, 0xaf123456
// GFX11: encoding: [0xf0,0x00,0x02,0xca,0xf0,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, -1 :: v_dual_fmaak_f32 v6, src_scc, v4, 0xaf123456
// GFX11: encoding: [0xc1,0x00,0x02,0xca,0xfd,0x08,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v6, null :: v_dual_fmaak_f32 v255, 0xaf123456, v5, 0xaf123456
// GFX11: encoding: [0x7c,0x00,0x02,0xca,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v4 :: v_dual_fmac_f32 v6, v1, v255
// GFX11: encoding: [0x04,0x01,0x00,0xca,0x01,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v1 :: v_dual_fmac_f32 v6, v255, v255
// GFX11: encoding: [0x01,0x01,0x00,0xca,0xff,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v255 :: v_dual_fmac_f32 v6, v2, v255
// GFX11: encoding: [0xff,0x01,0x00,0xca,0x02,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v2 :: v_dual_fmac_f32 v6, v3, v255
// GFX11: encoding: [0x02,0x01,0x00,0xca,0x03,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v3 :: v_dual_fmac_f32 v6, v4, v255
// GFX11: encoding: [0x03,0x01,0x00,0xca,0x04,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s105 :: v_dual_fmac_f32 v6, s1, v255
// GFX11: encoding: [0x69,0x00,0x00,0xca,0x01,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s1 :: v_dual_fmac_f32 v6, s105, v255
// GFX11: encoding: [0x01,0x00,0x00,0xca,0x69,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, ttmp15 :: v_dual_fmac_f32 v6, vcc_lo, v255
// GFX11: encoding: [0x7b,0x00,0x00,0xca,0x6a,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_hi :: v_dual_fmac_f32 v6, vcc_hi, v255
// GFX11: encoding: [0x7f,0x00,0x00,0xca,0x6b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_lo :: v_dual_fmac_f32 v6, ttmp15, v255
// GFX11: encoding: [0x7e,0x00,0x00,0xca,0x7b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, m0 :: v_dual_fmac_f32 v6, m0, v255
// GFX11: encoding: [0x7d,0x00,0x00,0xca,0x7d,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_hi :: v_dual_fmac_f32 v6, exec_lo, v255
// GFX11: encoding: [0x6b,0x00,0x00,0xca,0x7e,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_lo :: v_dual_fmac_f32 v6, exec_hi, v255
// GFX11: encoding: [0x6a,0x00,0x00,0xca,0x7f,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0xaf123456 :: v_dual_fmac_f32 v6, null, v255
// GFX11: encoding: [0xff,0x00,0x00,0xca,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, src_scc :: v_dual_fmac_f32 v6, -1, v255
// GFX11: encoding: [0xfd,0x00,0x00,0xca,0xc1,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0.5 :: v_dual_fmac_f32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0x00,0x00,0xca,0xf0,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, -1 :: v_dual_fmac_f32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0x00,0x00,0xca,0xfd,0x08,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v6, null :: v_dual_fmac_f32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x00,0x00,0xca,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v4 :: v_dual_fmamk_f32 v6, v1, 0xaf123456, v255
// GFX11: encoding: [0x04,0x01,0x04,0xca,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v1 :: v_dual_fmamk_f32 v6, v255, 0xaf123456, v255
// GFX11: encoding: [0x01,0x01,0x04,0xca,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v255 :: v_dual_fmamk_f32 v6, v2, 0xaf123456, v255
// GFX11: encoding: [0xff,0x01,0x04,0xca,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v2 :: v_dual_fmamk_f32 v6, v3, 0xaf123456, v255
// GFX11: encoding: [0x02,0x01,0x04,0xca,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v3 :: v_dual_fmamk_f32 v6, v4, 0xaf123456, v255
// GFX11: encoding: [0x03,0x01,0x04,0xca,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s105 :: v_dual_fmamk_f32 v6, s105, 0xaf123456, v255
// GFX11: encoding: [0x69,0x00,0x04,0xca,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s1 :: v_dual_fmamk_f32 v6, s1, 0xaf123456, v255
// GFX11: encoding: [0x01,0x00,0x04,0xca,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, ttmp15 :: v_dual_fmamk_f32 v6, ttmp15, 0xaf123456, v255
// GFX11: encoding: [0x7b,0x00,0x04,0xca,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_hi :: v_dual_fmamk_f32 v6, exec_hi, 0xaf123456, v255
// GFX11: encoding: [0x7f,0x00,0x04,0xca,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_lo :: v_dual_fmamk_f32 v6, exec_lo, 0xaf123456, v255
// GFX11: encoding: [0x7e,0x00,0x04,0xca,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, m0 :: v_dual_fmamk_f32 v6, m0, 0xaf123456, v255
// GFX11: encoding: [0x7d,0x00,0x04,0xca,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_hi :: v_dual_fmamk_f32 v6, vcc_hi, 0xaf123456, v255
// GFX11: encoding: [0x6b,0x00,0x04,0xca,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_lo :: v_dual_fmamk_f32 v6, vcc_lo, 0xaf123456, v255
// GFX11: encoding: [0x6a,0x00,0x04,0xca,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0xaf123456 :: v_dual_fmamk_f32 v6, null, 0xaf123456, v255
// GFX11: encoding: [0xff,0x00,0x04,0xca,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, src_scc :: v_dual_fmamk_f32 v6, -1, 0xaf123456, v255
// GFX11: encoding: [0xfd,0x00,0x04,0xca,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0.5 :: v_dual_fmamk_f32 v6, 0.5, 0xaf123456, v255
// GFX11: encoding: [0xf0,0x00,0x04,0xca,0xf0,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, -1 :: v_dual_fmamk_f32 v6, src_scc, 0xaf123456, v255
// GFX11: encoding: [0xc1,0x00,0x04,0xca,0xfd,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v6, null :: v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x00,0x04,0xca,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v4 :: v_dual_lshlrev_b32 v6, v1, v255
// GFX11: encoding: [0x04,0x01,0x22,0xca,0x01,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v1 :: v_dual_lshlrev_b32 v6, v255, v255
// GFX11: encoding: [0x01,0x01,0x22,0xca,0xff,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v255 :: v_dual_lshlrev_b32 v6, v2, v255
// GFX11: encoding: [0xff,0x01,0x22,0xca,0x02,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v2 :: v_dual_lshlrev_b32 v6, v3, v255
// GFX11: encoding: [0x02,0x01,0x22,0xca,0x03,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v3 :: v_dual_lshlrev_b32 v6, v4, v255
// GFX11: encoding: [0x03,0x01,0x22,0xca,0x04,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s105 :: v_dual_lshlrev_b32 v6, s1, v255
// GFX11: encoding: [0x69,0x00,0x22,0xca,0x01,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s1 :: v_dual_lshlrev_b32 v6, s105, v255
// GFX11: encoding: [0x01,0x00,0x22,0xca,0x69,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, ttmp15 :: v_dual_lshlrev_b32 v6, vcc_lo, v255
// GFX11: encoding: [0x7b,0x00,0x22,0xca,0x6a,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_hi :: v_dual_lshlrev_b32 v6, vcc_hi, v255
// GFX11: encoding: [0x7f,0x00,0x22,0xca,0x6b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_lo :: v_dual_lshlrev_b32 v6, ttmp15, v255
// GFX11: encoding: [0x7e,0x00,0x22,0xca,0x7b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, m0 :: v_dual_lshlrev_b32 v6, m0, v255
// GFX11: encoding: [0x7d,0x00,0x22,0xca,0x7d,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_hi :: v_dual_lshlrev_b32 v6, exec_lo, v255
// GFX11: encoding: [0x6b,0x00,0x22,0xca,0x7e,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_lo :: v_dual_lshlrev_b32 v6, exec_hi, v255
// GFX11: encoding: [0x6a,0x00,0x22,0xca,0x7f,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0xaf123456 :: v_dual_lshlrev_b32 v6, null, v255
// GFX11: encoding: [0xff,0x00,0x22,0xca,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, src_scc :: v_dual_lshlrev_b32 v6, -1, v255
// GFX11: encoding: [0xfd,0x00,0x22,0xca,0xc1,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0.5 :: v_dual_lshlrev_b32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0x00,0x22,0xca,0xf0,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, -1 :: v_dual_lshlrev_b32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0x00,0x22,0xca,0xfd,0x08,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v6, null :: v_dual_lshlrev_b32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x00,0x22,0xca,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v4 :: v_dual_max_f32 v6, v1, v255
// GFX11: encoding: [0x04,0x01,0x14,0xca,0x01,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v1 :: v_dual_max_f32 v6, v255, v255
// GFX11: encoding: [0x01,0x01,0x14,0xca,0xff,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v255 :: v_dual_max_f32 v6, v2, v255
// GFX11: encoding: [0xff,0x01,0x14,0xca,0x02,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v2 :: v_dual_max_f32 v6, v3, v255
// GFX11: encoding: [0x02,0x01,0x14,0xca,0x03,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v3 :: v_dual_max_f32 v6, v4, v255
// GFX11: encoding: [0x03,0x01,0x14,0xca,0x04,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s105 :: v_dual_max_f32 v6, s1, v255
// GFX11: encoding: [0x69,0x00,0x14,0xca,0x01,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s1 :: v_dual_max_f32 v6, s105, v255
// GFX11: encoding: [0x01,0x00,0x14,0xca,0x69,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, ttmp15 :: v_dual_max_f32 v6, vcc_lo, v255
// GFX11: encoding: [0x7b,0x00,0x14,0xca,0x6a,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_hi :: v_dual_max_f32 v6, vcc_hi, v255
// GFX11: encoding: [0x7f,0x00,0x14,0xca,0x6b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_lo :: v_dual_max_f32 v6, ttmp15, v255
// GFX11: encoding: [0x7e,0x00,0x14,0xca,0x7b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, m0 :: v_dual_max_f32 v6, m0, v255
// GFX11: encoding: [0x7d,0x00,0x14,0xca,0x7d,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_hi :: v_dual_max_f32 v6, exec_lo, v255
// GFX11: encoding: [0x6b,0x00,0x14,0xca,0x7e,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_lo :: v_dual_max_f32 v6, exec_hi, v255
// GFX11: encoding: [0x6a,0x00,0x14,0xca,0x7f,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0xaf123456 :: v_dual_max_f32 v6, null, v255
// GFX11: encoding: [0xff,0x00,0x14,0xca,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, src_scc :: v_dual_max_f32 v6, -1, v255
// GFX11: encoding: [0xfd,0x00,0x14,0xca,0xc1,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0.5 :: v_dual_max_f32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0x00,0x14,0xca,0xf0,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, -1 :: v_dual_max_f32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0x00,0x14,0xca,0xfd,0x08,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v6, null :: v_dual_max_f32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x00,0x14,0xca,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v4 :: v_dual_min_f32 v6, v1, v255
// GFX11: encoding: [0x04,0x01,0x16,0xca,0x01,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v1 :: v_dual_min_f32 v6, v255, v255
// GFX11: encoding: [0x01,0x01,0x16,0xca,0xff,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v255 :: v_dual_min_f32 v6, v2, v255
// GFX11: encoding: [0xff,0x01,0x16,0xca,0x02,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v2 :: v_dual_min_f32 v6, v3, v255
// GFX11: encoding: [0x02,0x01,0x16,0xca,0x03,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v3 :: v_dual_min_f32 v6, v4, v255
// GFX11: encoding: [0x03,0x01,0x16,0xca,0x04,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s105 :: v_dual_min_f32 v6, s1, v255
// GFX11: encoding: [0x69,0x00,0x16,0xca,0x01,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s1 :: v_dual_min_f32 v6, s105, v255
// GFX11: encoding: [0x01,0x00,0x16,0xca,0x69,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, ttmp15 :: v_dual_min_f32 v6, vcc_lo, v255
// GFX11: encoding: [0x7b,0x00,0x16,0xca,0x6a,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_hi :: v_dual_min_f32 v6, vcc_hi, v255
// GFX11: encoding: [0x7f,0x00,0x16,0xca,0x6b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_lo :: v_dual_min_f32 v6, ttmp15, v255
// GFX11: encoding: [0x7e,0x00,0x16,0xca,0x7b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, m0 :: v_dual_min_f32 v6, m0, v255
// GFX11: encoding: [0x7d,0x00,0x16,0xca,0x7d,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_hi :: v_dual_min_f32 v6, exec_lo, v255
// GFX11: encoding: [0x6b,0x00,0x16,0xca,0x7e,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_lo :: v_dual_min_f32 v6, exec_hi, v255
// GFX11: encoding: [0x6a,0x00,0x16,0xca,0x7f,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0xaf123456 :: v_dual_min_f32 v6, null, v255
// GFX11: encoding: [0xff,0x00,0x16,0xca,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, src_scc :: v_dual_min_f32 v6, -1, v255
// GFX11: encoding: [0xfd,0x00,0x16,0xca,0xc1,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0.5 :: v_dual_min_f32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0x00,0x16,0xca,0xf0,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, -1 :: v_dual_min_f32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0x00,0x16,0xca,0xfd,0x08,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v6, null :: v_dual_min_f32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x00,0x16,0xca,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v4 :: v_dual_mov_b32 v6, v1
// GFX11: encoding: [0x04,0x01,0x10,0xca,0x01,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v1 :: v_dual_mov_b32 v6, v255
// GFX11: encoding: [0x01,0x01,0x10,0xca,0xff,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v255 :: v_dual_mov_b32 v6, v2
// GFX11: encoding: [0xff,0x01,0x10,0xca,0x02,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v2 :: v_dual_mov_b32 v6, v3
// GFX11: encoding: [0x02,0x01,0x10,0xca,0x03,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v3 :: v_dual_mov_b32 v6, v4
// GFX11: encoding: [0x03,0x01,0x10,0xca,0x04,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s105 :: v_dual_mov_b32 v6, s1
// GFX11: encoding: [0x69,0x00,0x10,0xca,0x01,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s1 :: v_dual_mov_b32 v6, s105
// GFX11: encoding: [0x01,0x00,0x10,0xca,0x69,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, ttmp15 :: v_dual_mov_b32 v6, vcc_lo
// GFX11: encoding: [0x7b,0x00,0x10,0xca,0x6a,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_hi :: v_dual_mov_b32 v6, vcc_hi
// GFX11: encoding: [0x7f,0x00,0x10,0xca,0x6b,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_lo :: v_dual_mov_b32 v6, ttmp15
// GFX11: encoding: [0x7e,0x00,0x10,0xca,0x7b,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, m0 :: v_dual_mov_b32 v6, m0
// GFX11: encoding: [0x7d,0x00,0x10,0xca,0x7d,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_hi :: v_dual_mov_b32 v6, exec_lo
// GFX11: encoding: [0x6b,0x00,0x10,0xca,0x7e,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_lo :: v_dual_mov_b32 v6, exec_hi
// GFX11: encoding: [0x6a,0x00,0x10,0xca,0x7f,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0xaf123456 :: v_dual_mov_b32 v6, null
// GFX11: encoding: [0xff,0x00,0x10,0xca,0x7c,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, src_scc :: v_dual_mov_b32 v6, -1
// GFX11: encoding: [0xfd,0x00,0x10,0xca,0xc1,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0.5 :: v_dual_mov_b32 v6, 0.5
// GFX11: encoding: [0xf0,0x00,0x10,0xca,0xf0,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, -1 :: v_dual_mov_b32 v6, src_scc
// GFX11: encoding: [0xc1,0x00,0x10,0xca,0xfd,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v6, null :: v_dual_mov_b32 v255, 0xaf123456
// GFX11: encoding: [0x7c,0x00,0x10,0xca,0xff,0x00,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v4 :: v_dual_mul_dx9_zero_f32 v6, v1, v255
// GFX11: encoding: [0x04,0x01,0x0e,0xca,0x01,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v1 :: v_dual_mul_dx9_zero_f32 v6, v255, v255
// GFX11: encoding: [0x01,0x01,0x0e,0xca,0xff,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v255 :: v_dual_mul_dx9_zero_f32 v6, v2, v255
// GFX11: encoding: [0xff,0x01,0x0e,0xca,0x02,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v2 :: v_dual_mul_dx9_zero_f32 v6, v3, v255
// GFX11: encoding: [0x02,0x01,0x0e,0xca,0x03,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v3 :: v_dual_mul_dx9_zero_f32 v6, v4, v255
// GFX11: encoding: [0x03,0x01,0x0e,0xca,0x04,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s105 :: v_dual_mul_dx9_zero_f32 v6, s1, v255
// GFX11: encoding: [0x69,0x00,0x0e,0xca,0x01,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s1 :: v_dual_mul_dx9_zero_f32 v6, s105, v255
// GFX11: encoding: [0x01,0x00,0x0e,0xca,0x69,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, ttmp15 :: v_dual_mul_dx9_zero_f32 v6, vcc_lo, v255
// GFX11: encoding: [0x7b,0x00,0x0e,0xca,0x6a,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_hi :: v_dual_mul_dx9_zero_f32 v6, vcc_hi, v255
// GFX11: encoding: [0x7f,0x00,0x0e,0xca,0x6b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_lo :: v_dual_mul_dx9_zero_f32 v6, ttmp15, v255
// GFX11: encoding: [0x7e,0x00,0x0e,0xca,0x7b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, m0 :: v_dual_mul_dx9_zero_f32 v6, m0, v255
// GFX11: encoding: [0x7d,0x00,0x0e,0xca,0x7d,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_hi :: v_dual_mul_dx9_zero_f32 v6, exec_lo, v255
// GFX11: encoding: [0x6b,0x00,0x0e,0xca,0x7e,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_lo :: v_dual_mul_dx9_zero_f32 v6, exec_hi, v255
// GFX11: encoding: [0x6a,0x00,0x0e,0xca,0x7f,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0xaf123456 :: v_dual_mul_dx9_zero_f32 v6, null, v255
// GFX11: encoding: [0xff,0x00,0x0e,0xca,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, src_scc :: v_dual_mul_dx9_zero_f32 v6, -1, v255
// GFX11: encoding: [0xfd,0x00,0x0e,0xca,0xc1,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0.5 :: v_dual_mul_dx9_zero_f32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0x00,0x0e,0xca,0xf0,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, -1 :: v_dual_mul_dx9_zero_f32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0x00,0x0e,0xca,0xfd,0x08,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v6, null :: v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x00,0x0e,0xca,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v4 :: v_dual_mul_f32 v6, v1, v255
// GFX11: encoding: [0x04,0x01,0x06,0xca,0x01,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v1 :: v_dual_mul_f32 v6, v255, v255
// GFX11: encoding: [0x01,0x01,0x06,0xca,0xff,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v255 :: v_dual_mul_f32 v6, v2, v255
// GFX11: encoding: [0xff,0x01,0x06,0xca,0x02,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v2 :: v_dual_mul_f32 v6, v3, v255
// GFX11: encoding: [0x02,0x01,0x06,0xca,0x03,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v3 :: v_dual_mul_f32 v6, v4, v255
// GFX11: encoding: [0x03,0x01,0x06,0xca,0x04,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s105 :: v_dual_mul_f32 v6, s1, v255
// GFX11: encoding: [0x69,0x00,0x06,0xca,0x01,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s1 :: v_dual_mul_f32 v6, s105, v255
// GFX11: encoding: [0x01,0x00,0x06,0xca,0x69,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, ttmp15 :: v_dual_mul_f32 v6, vcc_lo, v255
// GFX11: encoding: [0x7b,0x00,0x06,0xca,0x6a,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_hi :: v_dual_mul_f32 v6, vcc_hi, v255
// GFX11: encoding: [0x7f,0x00,0x06,0xca,0x6b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_lo :: v_dual_mul_f32 v6, ttmp15, v255
// GFX11: encoding: [0x7e,0x00,0x06,0xca,0x7b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, m0 :: v_dual_mul_f32 v6, m0, v255
// GFX11: encoding: [0x7d,0x00,0x06,0xca,0x7d,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_hi :: v_dual_mul_f32 v6, exec_lo, v255
// GFX11: encoding: [0x6b,0x00,0x06,0xca,0x7e,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_lo :: v_dual_mul_f32 v6, exec_hi, v255
// GFX11: encoding: [0x6a,0x00,0x06,0xca,0x7f,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0xaf123456 :: v_dual_mul_f32 v6, null, v255
// GFX11: encoding: [0xff,0x00,0x06,0xca,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, src_scc :: v_dual_mul_f32 v6, -1, v255
// GFX11: encoding: [0xfd,0x00,0x06,0xca,0xc1,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0.5 :: v_dual_mul_f32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0x00,0x06,0xca,0xf0,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, -1 :: v_dual_mul_f32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0x00,0x06,0xca,0xfd,0x08,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v6, null :: v_dual_mul_f32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x00,0x06,0xca,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v4 :: v_dual_sub_f32 v6, v1, v255
// GFX11: encoding: [0x04,0x01,0x0a,0xca,0x01,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v1 :: v_dual_sub_f32 v6, v255, v255
// GFX11: encoding: [0x01,0x01,0x0a,0xca,0xff,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v255 :: v_dual_sub_f32 v6, v2, v255
// GFX11: encoding: [0xff,0x01,0x0a,0xca,0x02,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v2 :: v_dual_sub_f32 v6, v3, v255
// GFX11: encoding: [0x02,0x01,0x0a,0xca,0x03,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v3 :: v_dual_sub_f32 v6, v4, v255
// GFX11: encoding: [0x03,0x01,0x0a,0xca,0x04,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s105 :: v_dual_sub_f32 v6, s1, v255
// GFX11: encoding: [0x69,0x00,0x0a,0xca,0x01,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s1 :: v_dual_sub_f32 v6, s105, v255
// GFX11: encoding: [0x01,0x00,0x0a,0xca,0x69,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, ttmp15 :: v_dual_sub_f32 v6, vcc_lo, v255
// GFX11: encoding: [0x7b,0x00,0x0a,0xca,0x6a,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_hi :: v_dual_sub_f32 v6, vcc_hi, v255
// GFX11: encoding: [0x7f,0x00,0x0a,0xca,0x6b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_lo :: v_dual_sub_f32 v6, ttmp15, v255
// GFX11: encoding: [0x7e,0x00,0x0a,0xca,0x7b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, m0 :: v_dual_sub_f32 v6, m0, v255
// GFX11: encoding: [0x7d,0x00,0x0a,0xca,0x7d,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_hi :: v_dual_sub_f32 v6, exec_lo, v255
// GFX11: encoding: [0x6b,0x00,0x0a,0xca,0x7e,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_lo :: v_dual_sub_f32 v6, exec_hi, v255
// GFX11: encoding: [0x6a,0x00,0x0a,0xca,0x7f,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0xaf123456 :: v_dual_sub_f32 v6, null, v255
// GFX11: encoding: [0xff,0x00,0x0a,0xca,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, src_scc :: v_dual_sub_f32 v6, -1, v255
// GFX11: encoding: [0xfd,0x00,0x0a,0xca,0xc1,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0.5 :: v_dual_sub_f32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0x00,0x0a,0xca,0xf0,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, -1 :: v_dual_sub_f32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0x00,0x0a,0xca,0xfd,0x08,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v6, null :: v_dual_sub_f32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x00,0x0a,0xca,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v4 :: v_dual_subrev_f32 v6, v1, v255
// GFX11: encoding: [0x04,0x01,0x0c,0xca,0x01,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v1 :: v_dual_subrev_f32 v6, v255, v255
// GFX11: encoding: [0x01,0x01,0x0c,0xca,0xff,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v255 :: v_dual_subrev_f32 v6, v2, v255
// GFX11: encoding: [0xff,0x01,0x0c,0xca,0x02,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v2 :: v_dual_subrev_f32 v6, v3, v255
// GFX11: encoding: [0x02,0x01,0x0c,0xca,0x03,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, v3 :: v_dual_subrev_f32 v6, v4, v255
// GFX11: encoding: [0x03,0x01,0x0c,0xca,0x04,0xff,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s105 :: v_dual_subrev_f32 v6, s1, v255
// GFX11: encoding: [0x69,0x00,0x0c,0xca,0x01,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, s1 :: v_dual_subrev_f32 v6, s105, v255
// GFX11: encoding: [0x01,0x00,0x0c,0xca,0x69,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, ttmp15 :: v_dual_subrev_f32 v6, vcc_lo, v255
// GFX11: encoding: [0x7b,0x00,0x0c,0xca,0x6a,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_hi :: v_dual_subrev_f32 v6, vcc_hi, v255
// GFX11: encoding: [0x7f,0x00,0x0c,0xca,0x6b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, exec_lo :: v_dual_subrev_f32 v6, ttmp15, v255
// GFX11: encoding: [0x7e,0x00,0x0c,0xca,0x7b,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, m0 :: v_dual_subrev_f32 v6, m0, v255
// GFX11: encoding: [0x7d,0x00,0x0c,0xca,0x7d,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_hi :: v_dual_subrev_f32 v6, exec_lo, v255
// GFX11: encoding: [0x6b,0x00,0x0c,0xca,0x7e,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, vcc_lo :: v_dual_subrev_f32 v6, exec_hi, v255
// GFX11: encoding: [0x6a,0x00,0x0c,0xca,0x7f,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0xaf123456 :: v_dual_subrev_f32 v6, null, v255
// GFX11: encoding: [0xff,0x00,0x0c,0xca,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, src_scc :: v_dual_subrev_f32 v6, -1, v255
// GFX11: encoding: [0xfd,0x00,0x0c,0xca,0xc1,0xfe,0x07,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, 0.5 :: v_dual_subrev_f32 v6, 0.5, v3
// GFX11: encoding: [0xf0,0x00,0x0c,0xca,0xf0,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v255, -1 :: v_dual_subrev_f32 v6, src_scc, v4
// GFX11: encoding: [0xc1,0x00,0x0c,0xca,0xfd,0x08,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mov_b32 v6, null :: v_dual_subrev_f32 v255, 0xaf123456, v5
// GFX11: encoding: [0x7c,0x00,0x0c,0xca,0xff,0x0a,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v4, v2 :: v_dual_add_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xc8,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v1, v2 :: v_dual_add_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xc8,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v255, v2 :: v_dual_add_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xc8,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v2, v2 :: v_dual_add_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xc8,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v3, v2 :: v_dual_add_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xc8,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s105, v2 :: v_dual_add_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xc8,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s1, v2 :: v_dual_add_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xc8,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, ttmp15, v2 :: v_dual_add_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xc8,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_hi, v2 :: v_dual_add_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xc8,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_lo, v2 :: v_dual_add_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xc8,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, m0, v2 :: v_dual_add_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xc8,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_hi, v2 :: v_dual_add_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xc8,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_lo, v2 :: v_dual_add_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xc8,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v2 :: v_dual_add_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xc8,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, src_scc, v2 :: v_dual_add_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xc8,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0.5, v3 :: v_dual_add_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xc8,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, -1, v4 :: v_dual_add_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xc8,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v6, null, v5 :: v_dual_add_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xc8,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v4, v2 :: v_dual_add_nc_u32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xe0,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v1, v2 :: v_dual_add_nc_u32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xe0,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v255, v2 :: v_dual_add_nc_u32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xe0,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v2, v2 :: v_dual_add_nc_u32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xe0,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v3, v2 :: v_dual_add_nc_u32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xe0,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s105, v2 :: v_dual_add_nc_u32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xe0,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s1, v2 :: v_dual_add_nc_u32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xe0,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, ttmp15, v2 :: v_dual_add_nc_u32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xe0,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_hi, v2 :: v_dual_add_nc_u32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xe0,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_lo, v2 :: v_dual_add_nc_u32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xe0,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, m0, v2 :: v_dual_add_nc_u32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xe0,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_hi, v2 :: v_dual_add_nc_u32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xe0,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_lo, v2 :: v_dual_add_nc_u32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xe0,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v2 :: v_dual_add_nc_u32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xe0,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, src_scc, v2 :: v_dual_add_nc_u32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xe0,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0.5, v3 :: v_dual_add_nc_u32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xe0,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, -1, v4 :: v_dual_add_nc_u32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xe0,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v6, null, v5 :: v_dual_add_nc_u32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xe0,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v4, v2 :: v_dual_and_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xe4,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v1, v2 :: v_dual_and_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xe4,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v255, v2 :: v_dual_and_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xe4,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v2, v2 :: v_dual_and_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xe4,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v3, v2 :: v_dual_and_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xe4,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s105, v2 :: v_dual_and_b32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xe4,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s1, v2 :: v_dual_and_b32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xe4,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, ttmp15, v2 :: v_dual_and_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xe4,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_hi, v2 :: v_dual_and_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xe4,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_lo, v2 :: v_dual_and_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xe4,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, m0, v2 :: v_dual_and_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xe4,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_hi, v2 :: v_dual_and_b32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xe4,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_lo, v2 :: v_dual_and_b32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xe4,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v2 :: v_dual_and_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xe4,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, src_scc, v2 :: v_dual_and_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xe4,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0.5, v3 :: v_dual_and_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xe4,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, -1, v4 :: v_dual_and_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xe4,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v6, null, v5 :: v_dual_and_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xe4,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v4, v2 :: v_dual_cndmask_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xd2,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v1, v2 :: v_dual_cndmask_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xd2,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v255, v2 :: v_dual_cndmask_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xd2,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v2, v2 :: v_dual_cndmask_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xd2,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v3, v2 :: v_dual_cndmask_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xd2,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s105, v2 :: v_dual_cndmask_b32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0xd2,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s1, v2 :: v_dual_cndmask_b32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0xd2,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, ttmp15, v2 :: v_dual_cndmask_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0xd2,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_hi, v2 :: v_dual_cndmask_b32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0xd2,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_lo, v2 :: v_dual_cndmask_b32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0xd2,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, m0, v2 :: v_dual_cndmask_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xd2,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_hi, v2 :: v_dual_cndmask_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0xd2,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_lo, v2 :: v_dual_cndmask_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0xd2,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v2 :: v_dual_cndmask_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xd2,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, src_scc, v2 :: v_dual_cndmask_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xd2,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0.5, v3 :: v_dual_cndmask_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xd2,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, -1, v4 :: v_dual_cndmask_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xd2,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v6, null, v5 :: v_dual_cndmask_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xd2,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v4, v2 :: v_dual_dot2acc_f32_f16 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xd8,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v1, v2 :: v_dual_dot2acc_f32_f16 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xd8,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v255, v2 :: v_dual_dot2acc_f32_f16 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xd8,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v2, v2 :: v_dual_dot2acc_f32_f16 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xd8,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v3, v2 :: v_dual_dot2acc_f32_f16 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xd8,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s105, v2 :: v_dual_dot2acc_f32_f16 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xd8,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s1, v2 :: v_dual_dot2acc_f32_f16 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xd8,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, ttmp15, v2 :: v_dual_dot2acc_f32_f16 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xd8,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_hi, v2 :: v_dual_dot2acc_f32_f16 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xd8,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_lo, v2 :: v_dual_dot2acc_f32_f16 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xd8,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, m0, v2 :: v_dual_dot2acc_f32_f16 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xd8,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_hi, v2 :: v_dual_dot2acc_f32_f16 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xd8,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_lo, v2 :: v_dual_dot2acc_f32_f16 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xd8,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v2 :: v_dual_dot2acc_f32_f16 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xd8,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, src_scc, v2 :: v_dual_dot2acc_f32_f16 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xd8,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0.5, v3 :: v_dual_dot2acc_f32_f16 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xd8,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, -1, v4 :: v_dual_dot2acc_f32_f16 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xd8,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v6, null, v5 :: v_dual_dot2acc_f32_f16 v255, 0xfe0b, v4
// GFX11: encoding: [0x7c,0x0a,0xd8,0xc9,0xff,0x08,0xfe,0x06,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v4, v2 :: v_dual_fmaak_f32 v6, v1, v3, 0xaf123456
// GFX11: encoding: [0x04,0x05,0xc2,0xc9,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v1, v2 :: v_dual_fmaak_f32 v6, v255, v3, 0xaf123456
// GFX11: encoding: [0x01,0x05,0xc2,0xc9,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v255, v2 :: v_dual_fmaak_f32 v6, v2, v3, 0xaf123456
// GFX11: encoding: [0xff,0x05,0xc2,0xc9,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v2, v2 :: v_dual_fmaak_f32 v6, v3, v3, 0xaf123456
// GFX11: encoding: [0x02,0x05,0xc2,0xc9,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v3, v2 :: v_dual_fmaak_f32 v6, v4, v3, 0xaf123456
// GFX11: encoding: [0x03,0x05,0xc2,0xc9,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s105, v2 :: v_dual_fmaak_f32 v6, s105, v3, 0xaf123456
// GFX11: encoding: [0x69,0x04,0xc2,0xc9,0x69,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s1, v2 :: v_dual_fmaak_f32 v6, s1, v3, 0xaf123456
// GFX11: encoding: [0x01,0x04,0xc2,0xc9,0x01,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, ttmp15, v2 :: v_dual_fmaak_f32 v6, ttmp15, v3, 0xaf123456
// GFX11: encoding: [0x7b,0x04,0xc2,0xc9,0x7b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_hi, v2 :: v_dual_fmaak_f32 v6, exec_hi, v3, 0xaf123456
// GFX11: encoding: [0x7f,0x04,0xc2,0xc9,0x7f,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_lo, v2 :: v_dual_fmaak_f32 v6, exec_lo, v3, 0xaf123456
// GFX11: encoding: [0x7e,0x04,0xc2,0xc9,0x7e,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, m0, v2 :: v_dual_fmaak_f32 v6, m0, v3, 0xaf123456
// GFX11: encoding: [0x7d,0x04,0xc2,0xc9,0x7d,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_hi, v2 :: v_dual_fmaak_f32 v6, vcc_hi, v3, 0xaf123456
// GFX11: encoding: [0x6b,0x04,0xc2,0xc9,0x6b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_lo, v2 :: v_dual_fmaak_f32 v6, vcc_lo, v3, 0xaf123456
// GFX11: encoding: [0x6a,0x04,0xc2,0xc9,0x6a,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v2 :: v_dual_fmaak_f32 v6, null, v3, 0xaf123456
// GFX11: encoding: [0xff,0x04,0xc2,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, src_scc, v2 :: v_dual_fmaak_f32 v6, -1, v3, 0xaf123456
// GFX11: encoding: [0xfd,0x04,0xc2,0xc9,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0.5, v3 :: v_dual_fmaak_f32 v6, 0.5, v2, 0xaf123456
// GFX11: encoding: [0xf0,0x06,0xc2,0xc9,0xf0,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, -1, v4 :: v_dual_fmaak_f32 v6, src_scc, v5, 0xaf123456
// GFX11: encoding: [0xc1,0x08,0xc2,0xc9,0xfd,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v6, null, v5 :: v_dual_fmaak_f32 v255, 0xaf123456, v4, 0xaf123456
// GFX11: encoding: [0x7c,0x0a,0xc2,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v4, v2 :: v_dual_fmac_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xc0,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v1, v2 :: v_dual_fmac_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xc0,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v255, v2 :: v_dual_fmac_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xc0,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v2, v2 :: v_dual_fmac_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xc0,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v3, v2 :: v_dual_fmac_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xc0,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s105, v2 :: v_dual_fmac_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xc0,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s1, v2 :: v_dual_fmac_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xc0,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, ttmp15, v2 :: v_dual_fmac_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xc0,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_hi, v2 :: v_dual_fmac_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xc0,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_lo, v2 :: v_dual_fmac_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xc0,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, m0, v2 :: v_dual_fmac_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xc0,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_hi, v2 :: v_dual_fmac_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xc0,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_lo, v2 :: v_dual_fmac_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xc0,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v2 :: v_dual_fmac_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xc0,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, src_scc, v2 :: v_dual_fmac_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xc0,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0.5, v3 :: v_dual_fmac_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xc0,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, -1, v4 :: v_dual_fmac_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xc0,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v6, null, v5 :: v_dual_fmac_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xc0,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v4, v255 :: v_dual_fmamk_f32 v6, v1, 0xaf123456, v255
// GFX11: encoding: [0x04,0xff,0xc5,0xc9,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v1, v255 :: v_dual_fmamk_f32 v6, v255, 0xaf123456, v255
// GFX11: encoding: [0x01,0xff,0xc5,0xc9,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v255, v255 :: v_dual_fmamk_f32 v6, v2, 0xaf123456, v255
// GFX11: encoding: [0xff,0xff,0xc5,0xc9,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v2, v255 :: v_dual_fmamk_f32 v6, v3, 0xaf123456, v255
// GFX11: encoding: [0x02,0xff,0xc5,0xc9,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v3, v255 :: v_dual_fmamk_f32 v6, v4, 0xaf123456, v255
// GFX11: encoding: [0x03,0xff,0xc5,0xc9,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s105, v255 :: v_dual_fmamk_f32 v6, s105, 0xaf123456, v255
// GFX11: encoding: [0x69,0xfe,0xc5,0xc9,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s1, v255 :: v_dual_fmamk_f32 v6, s1, 0xaf123456, v255
// GFX11: encoding: [0x01,0xfe,0xc5,0xc9,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, ttmp15, v255 :: v_dual_fmamk_f32 v6, ttmp15, 0xaf123456, v255
// GFX11: encoding: [0x7b,0xfe,0xc5,0xc9,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_hi, v255 :: v_dual_fmamk_f32 v6, exec_hi, 0xaf123456, v255
// GFX11: encoding: [0x7f,0xfe,0xc5,0xc9,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_lo, v255 :: v_dual_fmamk_f32 v6, exec_lo, 0xaf123456, v255
// GFX11: encoding: [0x7e,0xfe,0xc5,0xc9,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, m0, v255 :: v_dual_fmamk_f32 v6, m0, 0xaf123456, v255
// GFX11: encoding: [0x7d,0xfe,0xc5,0xc9,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_hi, v255 :: v_dual_fmamk_f32 v6, vcc_hi, 0xaf123456, v255
// GFX11: encoding: [0x6b,0xfe,0xc5,0xc9,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_lo, v255 :: v_dual_fmamk_f32 v6, vcc_lo, 0xaf123456, v255
// GFX11: encoding: [0x6a,0xfe,0xc5,0xc9,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, null, 0xaf123456, v255
// GFX11: encoding: [0xff,0xfe,0xc5,0xc9,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, src_scc, v255 :: v_dual_fmamk_f32 v6, -1, 0xaf123456, v255
// GFX11: encoding: [0xfd,0xfe,0xc5,0xc9,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0.5, v3 :: v_dual_fmamk_f32 v6, 0.5, 0xaf123456, v255
// GFX11: encoding: [0xf0,0x06,0xc4,0xc9,0xf0,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, -1, v4 :: v_dual_fmamk_f32 v6, src_scc, 0xaf123456, v255
// GFX11: encoding: [0xc1,0x08,0xc4,0xc9,0xfd,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v6, null, v5 :: v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xc4,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v4, v2 :: v_dual_lshlrev_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xe2,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v1, v2 :: v_dual_lshlrev_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xe2,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v255, v2 :: v_dual_lshlrev_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xe2,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v2, v2 :: v_dual_lshlrev_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xe2,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v3, v2 :: v_dual_lshlrev_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xe2,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s105, v2 :: v_dual_lshlrev_b32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xe2,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s1, v2 :: v_dual_lshlrev_b32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xe2,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, ttmp15, v2 :: v_dual_lshlrev_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xe2,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_hi, v2 :: v_dual_lshlrev_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xe2,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_lo, v2 :: v_dual_lshlrev_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xe2,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, m0, v2 :: v_dual_lshlrev_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xe2,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_hi, v2 :: v_dual_lshlrev_b32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xe2,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_lo, v2 :: v_dual_lshlrev_b32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xe2,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v2 :: v_dual_lshlrev_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xe2,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, src_scc, v2 :: v_dual_lshlrev_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xe2,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0.5, v3 :: v_dual_lshlrev_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xe2,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, -1, v4 :: v_dual_lshlrev_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xe2,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v6, null, v5 :: v_dual_lshlrev_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xe2,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v4, v2 :: v_dual_max_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xd4,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v1, v2 :: v_dual_max_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xd4,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v255, v2 :: v_dual_max_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xd4,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v2, v2 :: v_dual_max_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xd4,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v3, v2 :: v_dual_max_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xd4,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s105, v2 :: v_dual_max_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xd4,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s1, v2 :: v_dual_max_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xd4,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, ttmp15, v2 :: v_dual_max_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xd4,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_hi, v2 :: v_dual_max_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xd4,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_lo, v2 :: v_dual_max_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xd4,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, m0, v2 :: v_dual_max_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xd4,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_hi, v2 :: v_dual_max_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xd4,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_lo, v2 :: v_dual_max_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xd4,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v2 :: v_dual_max_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xd4,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, src_scc, v2 :: v_dual_max_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xd4,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0.5, v3 :: v_dual_max_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xd4,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, -1, v4 :: v_dual_max_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xd4,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v6, null, v5 :: v_dual_max_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xd4,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v4, v2 :: v_dual_min_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xd6,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v1, v2 :: v_dual_min_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xd6,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v255, v2 :: v_dual_min_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xd6,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v2, v2 :: v_dual_min_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xd6,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v3, v2 :: v_dual_min_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xd6,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s105, v2 :: v_dual_min_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xd6,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s1, v2 :: v_dual_min_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xd6,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, ttmp15, v2 :: v_dual_min_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xd6,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_hi, v2 :: v_dual_min_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xd6,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_lo, v2 :: v_dual_min_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xd6,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, m0, v2 :: v_dual_min_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xd6,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_hi, v2 :: v_dual_min_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xd6,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_lo, v2 :: v_dual_min_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xd6,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v2 :: v_dual_min_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xd6,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, src_scc, v2 :: v_dual_min_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xd6,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0.5, v3 :: v_dual_min_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xd6,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, -1, v4 :: v_dual_min_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xd6,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v6, null, v5 :: v_dual_min_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xd6,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v4, v255 :: v_dual_mov_b32 v6, v1
// GFX11: encoding: [0x04,0xff,0xd1,0xc9,0x01,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v1, v255 :: v_dual_mov_b32 v6, v255
// GFX11: encoding: [0x01,0xff,0xd1,0xc9,0xff,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v255, v255 :: v_dual_mov_b32 v6, v2
// GFX11: encoding: [0xff,0xff,0xd1,0xc9,0x02,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v2, v255 :: v_dual_mov_b32 v6, v3
// GFX11: encoding: [0x02,0xff,0xd1,0xc9,0x03,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v3, v255 :: v_dual_mov_b32 v6, v4
// GFX11: encoding: [0x03,0xff,0xd1,0xc9,0x04,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s105, v255 :: v_dual_mov_b32 v6, s1
// GFX11: encoding: [0x69,0xfe,0xd1,0xc9,0x01,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s1, v255 :: v_dual_mov_b32 v6, s105
// GFX11: encoding: [0x01,0xfe,0xd1,0xc9,0x69,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, ttmp15, v255 :: v_dual_mov_b32 v6, vcc_lo
// GFX11: encoding: [0x7b,0xfe,0xd1,0xc9,0x6a,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_hi, v255 :: v_dual_mov_b32 v6, vcc_hi
// GFX11: encoding: [0x7f,0xfe,0xd1,0xc9,0x6b,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_lo, v255 :: v_dual_mov_b32 v6, ttmp15
// GFX11: encoding: [0x7e,0xfe,0xd1,0xc9,0x7b,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, m0, v255 :: v_dual_mov_b32 v6, m0
// GFX11: encoding: [0x7d,0xfe,0xd1,0xc9,0x7d,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_hi, v255 :: v_dual_mov_b32 v6, exec_lo
// GFX11: encoding: [0x6b,0xfe,0xd1,0xc9,0x7e,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_lo, v255 :: v_dual_mov_b32 v6, exec_hi
// GFX11: encoding: [0x6a,0xfe,0xd1,0xc9,0x7f,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v255 :: v_dual_mov_b32 v6, null
// GFX11: encoding: [0xff,0xfe,0xd1,0xc9,0x7c,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, src_scc, v255 :: v_dual_mov_b32 v6, -1
// GFX11: encoding: [0xfd,0xfe,0xd1,0xc9,0xc1,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0.5, v3 :: v_dual_mov_b32 v6, 0.5
// GFX11: encoding: [0xf0,0x06,0xd0,0xc9,0xf0,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, -1, v4 :: v_dual_mov_b32 v6, src_scc
// GFX11: encoding: [0xc1,0x08,0xd0,0xc9,0xfd,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v6, null, v5 :: v_dual_mov_b32 v255, 0xaf123456
// GFX11: encoding: [0x7c,0x0a,0xd0,0xc9,0xff,0x00,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v4, v2 :: v_dual_mul_dx9_zero_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xce,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v1, v2 :: v_dual_mul_dx9_zero_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xce,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v255, v2 :: v_dual_mul_dx9_zero_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xce,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v2, v2 :: v_dual_mul_dx9_zero_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xce,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v3, v2 :: v_dual_mul_dx9_zero_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xce,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s105, v2 :: v_dual_mul_dx9_zero_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xce,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s1, v2 :: v_dual_mul_dx9_zero_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xce,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, ttmp15, v2 :: v_dual_mul_dx9_zero_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xce,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_hi, v2 :: v_dual_mul_dx9_zero_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xce,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_lo, v2 :: v_dual_mul_dx9_zero_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xce,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, m0, v2 :: v_dual_mul_dx9_zero_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xce,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_hi, v2 :: v_dual_mul_dx9_zero_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xce,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_lo, v2 :: v_dual_mul_dx9_zero_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xce,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v2 :: v_dual_mul_dx9_zero_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xce,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, src_scc, v2 :: v_dual_mul_dx9_zero_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xce,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0.5, v3 :: v_dual_mul_dx9_zero_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xce,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, -1, v4 :: v_dual_mul_dx9_zero_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xce,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v6, null, v5 :: v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xce,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v4, v2 :: v_dual_mul_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xc6,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v1, v2 :: v_dual_mul_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xc6,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v255, v2 :: v_dual_mul_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xc6,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v2, v2 :: v_dual_mul_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xc6,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v3, v2 :: v_dual_mul_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xc6,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s105, v2 :: v_dual_mul_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xc6,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s1, v2 :: v_dual_mul_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xc6,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, ttmp15, v2 :: v_dual_mul_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xc6,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_hi, v2 :: v_dual_mul_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xc6,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_lo, v2 :: v_dual_mul_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xc6,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, m0, v2 :: v_dual_mul_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xc6,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_hi, v2 :: v_dual_mul_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xc6,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_lo, v2 :: v_dual_mul_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xc6,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v2 :: v_dual_mul_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xc6,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, src_scc, v2 :: v_dual_mul_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xc6,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0.5, v3 :: v_dual_mul_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xc6,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, -1, v4 :: v_dual_mul_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xc6,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v6, null, v5 :: v_dual_mul_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xc6,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v4, v2 :: v_dual_sub_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xca,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v1, v2 :: v_dual_sub_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xca,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v255, v2 :: v_dual_sub_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xca,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v2, v2 :: v_dual_sub_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xca,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v3, v2 :: v_dual_sub_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xca,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s105, v2 :: v_dual_sub_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xca,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s1, v2 :: v_dual_sub_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xca,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, ttmp15, v2 :: v_dual_sub_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xca,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_hi, v2 :: v_dual_sub_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xca,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_lo, v2 :: v_dual_sub_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xca,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, m0, v2 :: v_dual_sub_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xca,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_hi, v2 :: v_dual_sub_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xca,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_lo, v2 :: v_dual_sub_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xca,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v2 :: v_dual_sub_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xca,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, src_scc, v2 :: v_dual_sub_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xca,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0.5, v3 :: v_dual_sub_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xca,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, -1, v4 :: v_dual_sub_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xca,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v6, null, v5 :: v_dual_sub_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xca,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v4, v2 :: v_dual_subrev_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xcc,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v1, v2 :: v_dual_subrev_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xcc,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v255, v2 :: v_dual_subrev_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xcc,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v2, v2 :: v_dual_subrev_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xcc,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, v3, v2 :: v_dual_subrev_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xcc,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s105, v2 :: v_dual_subrev_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xcc,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, s1, v2 :: v_dual_subrev_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xcc,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, ttmp15, v2 :: v_dual_subrev_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xcc,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_hi, v2 :: v_dual_subrev_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xcc,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, exec_lo, v2 :: v_dual_subrev_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xcc,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, m0, v2 :: v_dual_subrev_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xcc,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_hi, v2 :: v_dual_subrev_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xcc,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, vcc_lo, v2 :: v_dual_subrev_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xcc,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v2 :: v_dual_subrev_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xcc,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, src_scc, v2 :: v_dual_subrev_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xcc,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, 0.5, v3 :: v_dual_subrev_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xcc,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v255, -1, v4 :: v_dual_subrev_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xcc,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_dx9_zero_f32 v6, null, v5 :: v_dual_subrev_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xcc,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v4, v2 :: v_dual_add_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xc8,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v1, v2 :: v_dual_add_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xc8,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v255, v2 :: v_dual_add_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xc8,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v2, v2 :: v_dual_add_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xc8,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v3, v2 :: v_dual_add_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xc8,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s105, v2 :: v_dual_add_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xc8,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s1, v2 :: v_dual_add_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xc8,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, ttmp15, v2 :: v_dual_add_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xc8,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_hi, v2 :: v_dual_add_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xc8,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_lo, v2 :: v_dual_add_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xc8,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, m0, v2 :: v_dual_add_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xc8,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_hi, v2 :: v_dual_add_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xc8,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_lo, v2 :: v_dual_add_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xc8,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0xaf123456, v2 :: v_dual_add_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xc8,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, src_scc, v2 :: v_dual_add_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xc8,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0.5, v3 :: v_dual_add_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xc8,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, -1, v4 :: v_dual_add_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xc8,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v6, null, v5 :: v_dual_add_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xc8,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v4, v2 :: v_dual_add_nc_u32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xe0,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v1, v2 :: v_dual_add_nc_u32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xe0,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v255, v2 :: v_dual_add_nc_u32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xe0,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v2, v2 :: v_dual_add_nc_u32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xe0,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v3, v2 :: v_dual_add_nc_u32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xe0,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s105, v2 :: v_dual_add_nc_u32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xe0,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s1, v2 :: v_dual_add_nc_u32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xe0,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, ttmp15, v2 :: v_dual_add_nc_u32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xe0,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_hi, v2 :: v_dual_add_nc_u32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xe0,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_lo, v2 :: v_dual_add_nc_u32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xe0,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, m0, v2 :: v_dual_add_nc_u32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xe0,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_hi, v2 :: v_dual_add_nc_u32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xe0,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_lo, v2 :: v_dual_add_nc_u32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xe0,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0xaf123456, v2 :: v_dual_add_nc_u32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xe0,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, src_scc, v2 :: v_dual_add_nc_u32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xe0,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0.5, v3 :: v_dual_add_nc_u32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xe0,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, -1, v4 :: v_dual_add_nc_u32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xe0,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v6, null, v5 :: v_dual_add_nc_u32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xe0,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v4, v2 :: v_dual_and_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xe4,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v1, v2 :: v_dual_and_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xe4,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v255, v2 :: v_dual_and_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xe4,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v2, v2 :: v_dual_and_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xe4,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v3, v2 :: v_dual_and_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xe4,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s105, v2 :: v_dual_and_b32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xe4,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s1, v2 :: v_dual_and_b32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xe4,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, ttmp15, v2 :: v_dual_and_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xe4,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_hi, v2 :: v_dual_and_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xe4,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_lo, v2 :: v_dual_and_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xe4,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, m0, v2 :: v_dual_and_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xe4,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_hi, v2 :: v_dual_and_b32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xe4,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_lo, v2 :: v_dual_and_b32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xe4,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0xaf123456, v2 :: v_dual_and_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xe4,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, src_scc, v2 :: v_dual_and_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xe4,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0.5, v3 :: v_dual_and_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xe4,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, -1, v4 :: v_dual_and_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xe4,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v6, null, v5 :: v_dual_and_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xe4,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v4, v2 :: v_dual_cndmask_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xd2,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v1, v2 :: v_dual_cndmask_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xd2,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v255, v2 :: v_dual_cndmask_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xd2,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v2, v2 :: v_dual_cndmask_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xd2,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v3, v2 :: v_dual_cndmask_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xd2,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s105, v2 :: v_dual_cndmask_b32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0xd2,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s1, v2 :: v_dual_cndmask_b32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0xd2,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, ttmp15, v2 :: v_dual_cndmask_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0xd2,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_hi, v2 :: v_dual_cndmask_b32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0xd2,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_lo, v2 :: v_dual_cndmask_b32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0xd2,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, m0, v2 :: v_dual_cndmask_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xd2,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_hi, v2 :: v_dual_cndmask_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0xd2,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_lo, v2 :: v_dual_cndmask_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0xd2,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0xaf123456, v2 :: v_dual_cndmask_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xd2,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, src_scc, v2 :: v_dual_cndmask_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xd2,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0.5, v3 :: v_dual_cndmask_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xd2,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, -1, v4 :: v_dual_cndmask_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xd2,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v6, null, v5 :: v_dual_cndmask_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xd2,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v4, v2 :: v_dual_dot2acc_f32_f16 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xd8,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v1, v2 :: v_dual_dot2acc_f32_f16 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xd8,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v255, v2 :: v_dual_dot2acc_f32_f16 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xd8,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v2, v2 :: v_dual_dot2acc_f32_f16 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xd8,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v3, v2 :: v_dual_dot2acc_f32_f16 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xd8,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s105, v2 :: v_dual_dot2acc_f32_f16 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xd8,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s1, v2 :: v_dual_dot2acc_f32_f16 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xd8,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, ttmp15, v2 :: v_dual_dot2acc_f32_f16 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xd8,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_hi, v2 :: v_dual_dot2acc_f32_f16 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xd8,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_lo, v2 :: v_dual_dot2acc_f32_f16 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xd8,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, m0, v2 :: v_dual_dot2acc_f32_f16 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xd8,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_hi, v2 :: v_dual_dot2acc_f32_f16 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xd8,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_lo, v2 :: v_dual_dot2acc_f32_f16 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xd8,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0xaf123456, v2 :: v_dual_dot2acc_f32_f16 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xd8,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, src_scc, v2 :: v_dual_dot2acc_f32_f16 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xd8,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0.5, v3 :: v_dual_dot2acc_f32_f16 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xd8,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, -1, v4 :: v_dual_dot2acc_f32_f16 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xd8,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v6, null, v5 :: v_dual_dot2acc_f32_f16 v255, 0xfe0b, v4
// GFX11: encoding: [0x7c,0x0a,0xd8,0xc8,0xff,0x08,0xfe,0x06,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v4, v2 :: v_dual_fmaak_f32 v6, v1, v3, 0xaf123456
// GFX11: encoding: [0x04,0x05,0xc2,0xc8,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v1, v2 :: v_dual_fmaak_f32 v6, v255, v3, 0xaf123456
// GFX11: encoding: [0x01,0x05,0xc2,0xc8,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v255, v2 :: v_dual_fmaak_f32 v6, v2, v3, 0xaf123456
// GFX11: encoding: [0xff,0x05,0xc2,0xc8,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v2, v2 :: v_dual_fmaak_f32 v6, v3, v3, 0xaf123456
// GFX11: encoding: [0x02,0x05,0xc2,0xc8,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v3, v2 :: v_dual_fmaak_f32 v6, v4, v3, 0xaf123456
// GFX11: encoding: [0x03,0x05,0xc2,0xc8,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s105, v2 :: v_dual_fmaak_f32 v6, s105, v3, 0xaf123456
// GFX11: encoding: [0x69,0x04,0xc2,0xc8,0x69,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s1, v2 :: v_dual_fmaak_f32 v6, s1, v3, 0xaf123456
// GFX11: encoding: [0x01,0x04,0xc2,0xc8,0x01,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, ttmp15, v2 :: v_dual_fmaak_f32 v6, ttmp15, v3, 0xaf123456
// GFX11: encoding: [0x7b,0x04,0xc2,0xc8,0x7b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_hi, v2 :: v_dual_fmaak_f32 v6, exec_hi, v3, 0xaf123456
// GFX11: encoding: [0x7f,0x04,0xc2,0xc8,0x7f,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_lo, v2 :: v_dual_fmaak_f32 v6, exec_lo, v3, 0xaf123456
// GFX11: encoding: [0x7e,0x04,0xc2,0xc8,0x7e,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, m0, v2 :: v_dual_fmaak_f32 v6, m0, v3, 0xaf123456
// GFX11: encoding: [0x7d,0x04,0xc2,0xc8,0x7d,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_hi, v2 :: v_dual_fmaak_f32 v6, vcc_hi, v3, 0xaf123456
// GFX11: encoding: [0x6b,0x04,0xc2,0xc8,0x6b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_lo, v2 :: v_dual_fmaak_f32 v6, vcc_lo, v3, 0xaf123456
// GFX11: encoding: [0x6a,0x04,0xc2,0xc8,0x6a,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0xaf123456, v2 :: v_dual_fmaak_f32 v6, null, v3, 0xaf123456
// GFX11: encoding: [0xff,0x04,0xc2,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, src_scc, v2 :: v_dual_fmaak_f32 v6, -1, v3, 0xaf123456
// GFX11: encoding: [0xfd,0x04,0xc2,0xc8,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0.5, v3 :: v_dual_fmaak_f32 v6, 0.5, v2, 0xaf123456
// GFX11: encoding: [0xf0,0x06,0xc2,0xc8,0xf0,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, -1, v4 :: v_dual_fmaak_f32 v6, src_scc, v5, 0xaf123456
// GFX11: encoding: [0xc1,0x08,0xc2,0xc8,0xfd,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v6, null, v5 :: v_dual_fmaak_f32 v255, 0xaf123456, v4, 0xaf123456
// GFX11: encoding: [0x7c,0x0a,0xc2,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v4, v2 :: v_dual_fmac_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xc0,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v1, v2 :: v_dual_fmac_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xc0,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v255, v2 :: v_dual_fmac_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xc0,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v2, v2 :: v_dual_fmac_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xc0,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v3, v2 :: v_dual_fmac_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xc0,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s105, v2 :: v_dual_fmac_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xc0,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s1, v2 :: v_dual_fmac_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xc0,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, ttmp15, v2 :: v_dual_fmac_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xc0,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_hi, v2 :: v_dual_fmac_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xc0,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_lo, v2 :: v_dual_fmac_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xc0,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, m0, v2 :: v_dual_fmac_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xc0,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_hi, v2 :: v_dual_fmac_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xc0,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_lo, v2 :: v_dual_fmac_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xc0,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0xaf123456, v2 :: v_dual_fmac_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xc0,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, src_scc, v2 :: v_dual_fmac_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xc0,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0.5, v3 :: v_dual_fmac_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xc0,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, -1, v4 :: v_dual_fmac_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xc0,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v6, null, v5 :: v_dual_fmac_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xc0,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v4, v255 :: v_dual_fmamk_f32 v6, v1, 0xaf123456, v255
// GFX11: encoding: [0x04,0xff,0xc5,0xc8,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v1, v255 :: v_dual_fmamk_f32 v6, v255, 0xaf123456, v255
// GFX11: encoding: [0x01,0xff,0xc5,0xc8,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v255, v255 :: v_dual_fmamk_f32 v6, v2, 0xaf123456, v255
// GFX11: encoding: [0xff,0xff,0xc5,0xc8,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v2, v255 :: v_dual_fmamk_f32 v6, v3, 0xaf123456, v255
// GFX11: encoding: [0x02,0xff,0xc5,0xc8,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v3, v255 :: v_dual_fmamk_f32 v6, v4, 0xaf123456, v255
// GFX11: encoding: [0x03,0xff,0xc5,0xc8,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s105, v255 :: v_dual_fmamk_f32 v6, s105, 0xaf123456, v255
// GFX11: encoding: [0x69,0xfe,0xc5,0xc8,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s1, v255 :: v_dual_fmamk_f32 v6, s1, 0xaf123456, v255
// GFX11: encoding: [0x01,0xfe,0xc5,0xc8,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, ttmp15, v255 :: v_dual_fmamk_f32 v6, ttmp15, 0xaf123456, v255
// GFX11: encoding: [0x7b,0xfe,0xc5,0xc8,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_hi, v255 :: v_dual_fmamk_f32 v6, exec_hi, 0xaf123456, v255
// GFX11: encoding: [0x7f,0xfe,0xc5,0xc8,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_lo, v255 :: v_dual_fmamk_f32 v6, exec_lo, 0xaf123456, v255
// GFX11: encoding: [0x7e,0xfe,0xc5,0xc8,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, m0, v255 :: v_dual_fmamk_f32 v6, m0, 0xaf123456, v255
// GFX11: encoding: [0x7d,0xfe,0xc5,0xc8,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_hi, v255 :: v_dual_fmamk_f32 v6, vcc_hi, 0xaf123456, v255
// GFX11: encoding: [0x6b,0xfe,0xc5,0xc8,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_lo, v255 :: v_dual_fmamk_f32 v6, vcc_lo, 0xaf123456, v255
// GFX11: encoding: [0x6a,0xfe,0xc5,0xc8,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, null, 0xaf123456, v255
// GFX11: encoding: [0xff,0xfe,0xc5,0xc8,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, src_scc, v255 :: v_dual_fmamk_f32 v6, -1, 0xaf123456, v255
// GFX11: encoding: [0xfd,0xfe,0xc5,0xc8,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0.5, v3 :: v_dual_fmamk_f32 v6, 0.5, 0xaf123456, v255
// GFX11: encoding: [0xf0,0x06,0xc4,0xc8,0xf0,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, -1, v4 :: v_dual_fmamk_f32 v6, src_scc, 0xaf123456, v255
// GFX11: encoding: [0xc1,0x08,0xc4,0xc8,0xfd,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v6, null, v5 :: v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xc4,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v4, v2 :: v_dual_lshlrev_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xe2,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v1, v2 :: v_dual_lshlrev_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xe2,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v255, v2 :: v_dual_lshlrev_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xe2,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v2, v2 :: v_dual_lshlrev_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xe2,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v3, v2 :: v_dual_lshlrev_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xe2,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s105, v2 :: v_dual_lshlrev_b32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xe2,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s1, v2 :: v_dual_lshlrev_b32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xe2,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, ttmp15, v2 :: v_dual_lshlrev_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xe2,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_hi, v2 :: v_dual_lshlrev_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xe2,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_lo, v2 :: v_dual_lshlrev_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xe2,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, m0, v2 :: v_dual_lshlrev_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xe2,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_hi, v2 :: v_dual_lshlrev_b32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xe2,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_lo, v2 :: v_dual_lshlrev_b32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xe2,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0xaf123456, v2 :: v_dual_lshlrev_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xe2,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, src_scc, v2 :: v_dual_lshlrev_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xe2,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0.5, v3 :: v_dual_lshlrev_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xe2,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, -1, v4 :: v_dual_lshlrev_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xe2,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v6, null, v5 :: v_dual_lshlrev_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xe2,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v4, v2 :: v_dual_max_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xd4,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v1, v2 :: v_dual_max_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xd4,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v255, v2 :: v_dual_max_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xd4,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v2, v2 :: v_dual_max_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xd4,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v3, v2 :: v_dual_max_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xd4,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s105, v2 :: v_dual_max_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xd4,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s1, v2 :: v_dual_max_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xd4,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, ttmp15, v2 :: v_dual_max_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xd4,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_hi, v2 :: v_dual_max_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xd4,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_lo, v2 :: v_dual_max_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xd4,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, m0, v2 :: v_dual_max_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xd4,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_hi, v2 :: v_dual_max_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xd4,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_lo, v2 :: v_dual_max_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xd4,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0xaf123456, v2 :: v_dual_max_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xd4,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, src_scc, v2 :: v_dual_max_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xd4,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0.5, v3 :: v_dual_max_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xd4,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, -1, v4 :: v_dual_max_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xd4,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v6, null, v5 :: v_dual_max_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xd4,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v4, v2 :: v_dual_min_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xd6,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v1, v2 :: v_dual_min_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xd6,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v255, v2 :: v_dual_min_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xd6,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v2, v2 :: v_dual_min_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xd6,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v3, v2 :: v_dual_min_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xd6,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s105, v2 :: v_dual_min_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xd6,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s1, v2 :: v_dual_min_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xd6,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, ttmp15, v2 :: v_dual_min_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xd6,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_hi, v2 :: v_dual_min_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xd6,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_lo, v2 :: v_dual_min_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xd6,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, m0, v2 :: v_dual_min_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xd6,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_hi, v2 :: v_dual_min_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xd6,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_lo, v2 :: v_dual_min_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xd6,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0xaf123456, v2 :: v_dual_min_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xd6,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, src_scc, v2 :: v_dual_min_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xd6,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0.5, v3 :: v_dual_min_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xd6,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, -1, v4 :: v_dual_min_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xd6,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v6, null, v5 :: v_dual_min_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xd6,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v4, v255 :: v_dual_mov_b32 v6, v1
// GFX11: encoding: [0x04,0xff,0xd1,0xc8,0x01,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v1, v255 :: v_dual_mov_b32 v6, v255
// GFX11: encoding: [0x01,0xff,0xd1,0xc8,0xff,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v255, v255 :: v_dual_mov_b32 v6, v2
// GFX11: encoding: [0xff,0xff,0xd1,0xc8,0x02,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v2, v255 :: v_dual_mov_b32 v6, v3
// GFX11: encoding: [0x02,0xff,0xd1,0xc8,0x03,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v3, v255 :: v_dual_mov_b32 v6, v4
// GFX11: encoding: [0x03,0xff,0xd1,0xc8,0x04,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s105, v255 :: v_dual_mov_b32 v6, s1
// GFX11: encoding: [0x69,0xfe,0xd1,0xc8,0x01,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s1, v255 :: v_dual_mov_b32 v6, s105
// GFX11: encoding: [0x01,0xfe,0xd1,0xc8,0x69,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, ttmp15, v255 :: v_dual_mov_b32 v6, vcc_lo
// GFX11: encoding: [0x7b,0xfe,0xd1,0xc8,0x6a,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_hi, v255 :: v_dual_mov_b32 v6, vcc_hi
// GFX11: encoding: [0x7f,0xfe,0xd1,0xc8,0x6b,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_lo, v255 :: v_dual_mov_b32 v6, ttmp15
// GFX11: encoding: [0x7e,0xfe,0xd1,0xc8,0x7b,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, m0, v255 :: v_dual_mov_b32 v6, m0
// GFX11: encoding: [0x7d,0xfe,0xd1,0xc8,0x7d,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_hi, v255 :: v_dual_mov_b32 v6, exec_lo
// GFX11: encoding: [0x6b,0xfe,0xd1,0xc8,0x7e,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_lo, v255 :: v_dual_mov_b32 v6, exec_hi
// GFX11: encoding: [0x6a,0xfe,0xd1,0xc8,0x7f,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0xaf123456, v255 :: v_dual_mov_b32 v6, null
// GFX11: encoding: [0xff,0xfe,0xd1,0xc8,0x7c,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, src_scc, v255 :: v_dual_mov_b32 v6, -1
// GFX11: encoding: [0xfd,0xfe,0xd1,0xc8,0xc1,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0.5, v3 :: v_dual_mov_b32 v6, 0.5
// GFX11: encoding: [0xf0,0x06,0xd0,0xc8,0xf0,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, -1, v4 :: v_dual_mov_b32 v6, src_scc
// GFX11: encoding: [0xc1,0x08,0xd0,0xc8,0xfd,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v6, null, v5 :: v_dual_mov_b32 v255, 0xaf123456
// GFX11: encoding: [0x7c,0x0a,0xd0,0xc8,0xff,0x00,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v4, v2 :: v_dual_mul_dx9_zero_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xce,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v1, v2 :: v_dual_mul_dx9_zero_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xce,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v255, v2 :: v_dual_mul_dx9_zero_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xce,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v2, v2 :: v_dual_mul_dx9_zero_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xce,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v3, v2 :: v_dual_mul_dx9_zero_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xce,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s105, v2 :: v_dual_mul_dx9_zero_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xce,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s1, v2 :: v_dual_mul_dx9_zero_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xce,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, ttmp15, v2 :: v_dual_mul_dx9_zero_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xce,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_hi, v2 :: v_dual_mul_dx9_zero_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xce,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_lo, v2 :: v_dual_mul_dx9_zero_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xce,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, m0, v2 :: v_dual_mul_dx9_zero_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xce,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_hi, v2 :: v_dual_mul_dx9_zero_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xce,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_lo, v2 :: v_dual_mul_dx9_zero_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xce,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0xaf123456, v2 :: v_dual_mul_dx9_zero_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xce,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, src_scc, v2 :: v_dual_mul_dx9_zero_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xce,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0.5, v3 :: v_dual_mul_dx9_zero_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xce,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, -1, v4 :: v_dual_mul_dx9_zero_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xce,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v6, null, v5 :: v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xce,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v4, v2 :: v_dual_mul_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xc6,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v1, v2 :: v_dual_mul_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xc6,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v255, v2 :: v_dual_mul_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xc6,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v2, v2 :: v_dual_mul_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xc6,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v3, v2 :: v_dual_mul_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xc6,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s105, v2 :: v_dual_mul_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xc6,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s1, v2 :: v_dual_mul_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xc6,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, ttmp15, v2 :: v_dual_mul_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xc6,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_hi, v2 :: v_dual_mul_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xc6,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_lo, v2 :: v_dual_mul_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xc6,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, m0, v2 :: v_dual_mul_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xc6,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_hi, v2 :: v_dual_mul_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xc6,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_lo, v2 :: v_dual_mul_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xc6,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0xaf123456, v2 :: v_dual_mul_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xc6,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, src_scc, v2 :: v_dual_mul_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xc6,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0.5, v3 :: v_dual_mul_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xc6,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, -1, v4 :: v_dual_mul_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xc6,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v6, null, v5 :: v_dual_mul_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xc6,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v4, v2 :: v_dual_sub_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xca,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v1, v2 :: v_dual_sub_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xca,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v255, v2 :: v_dual_sub_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xca,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v2, v2 :: v_dual_sub_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xca,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v3, v2 :: v_dual_sub_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xca,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s105, v2 :: v_dual_sub_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xca,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s1, v2 :: v_dual_sub_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xca,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, ttmp15, v2 :: v_dual_sub_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xca,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_hi, v2 :: v_dual_sub_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xca,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_lo, v2 :: v_dual_sub_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xca,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, m0, v2 :: v_dual_sub_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xca,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_hi, v2 :: v_dual_sub_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xca,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_lo, v2 :: v_dual_sub_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xca,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0xaf123456, v2 :: v_dual_sub_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xca,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, src_scc, v2 :: v_dual_sub_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xca,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0.5, v3 :: v_dual_sub_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xca,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, -1, v4 :: v_dual_sub_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xca,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v6, null, v5 :: v_dual_sub_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xca,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v4, v2 :: v_dual_subrev_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xcc,0xc8,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v1, v2 :: v_dual_subrev_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xcc,0xc8,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v255, v2 :: v_dual_subrev_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xcc,0xc8,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v2, v2 :: v_dual_subrev_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xcc,0xc8,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, v3, v2 :: v_dual_subrev_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xcc,0xc8,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s105, v2 :: v_dual_subrev_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xcc,0xc8,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, s1, v2 :: v_dual_subrev_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xcc,0xc8,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, ttmp15, v2 :: v_dual_subrev_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xcc,0xc8,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_hi, v2 :: v_dual_subrev_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xcc,0xc8,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, exec_lo, v2 :: v_dual_subrev_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xcc,0xc8,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, m0, v2 :: v_dual_subrev_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xcc,0xc8,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_hi, v2 :: v_dual_subrev_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xcc,0xc8,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, vcc_lo, v2 :: v_dual_subrev_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xcc,0xc8,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0xaf123456, v2 :: v_dual_subrev_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xcc,0xc8,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, src_scc, v2 :: v_dual_subrev_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xcc,0xc8,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, 0.5, v3 :: v_dual_subrev_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xcc,0xc8,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v255, -1, v4 :: v_dual_subrev_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xcc,0xc8,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_mul_f32 v6, null, v5 :: v_dual_subrev_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xcc,0xc8,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v4, v2 :: v_dual_add_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x48,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v1, v2 :: v_dual_add_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x48,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v255, v2 :: v_dual_add_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x48,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v2, v2 :: v_dual_add_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x48,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v3, v2 :: v_dual_add_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x48,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s105, v2 :: v_dual_add_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x48,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s1, v2 :: v_dual_add_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x48,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, ttmp15, v2 :: v_dual_add_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x48,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_hi, v2 :: v_dual_add_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x48,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_lo, v2 :: v_dual_add_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x48,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, m0, v2 :: v_dual_add_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x48,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_hi, v2 :: v_dual_add_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x48,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_lo, v2 :: v_dual_add_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x48,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0xaf123456, v2 :: v_dual_add_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x48,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, src_scc, v2 :: v_dual_add_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x48,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0.5, v3 :: v_dual_add_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x48,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, -1, v4 :: v_dual_add_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x48,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v6, null, v5 :: v_dual_add_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x48,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v4, v2 :: v_dual_add_nc_u32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x60,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v1, v2 :: v_dual_add_nc_u32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x60,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v255, v2 :: v_dual_add_nc_u32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x60,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v2, v2 :: v_dual_add_nc_u32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x60,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v3, v2 :: v_dual_add_nc_u32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x60,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s105, v2 :: v_dual_add_nc_u32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x60,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s1, v2 :: v_dual_add_nc_u32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x60,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, ttmp15, v2 :: v_dual_add_nc_u32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x60,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_hi, v2 :: v_dual_add_nc_u32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x60,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_lo, v2 :: v_dual_add_nc_u32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x60,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, m0, v2 :: v_dual_add_nc_u32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x60,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_hi, v2 :: v_dual_add_nc_u32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x60,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_lo, v2 :: v_dual_add_nc_u32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x60,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0xaf123456, v2 :: v_dual_add_nc_u32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x60,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, src_scc, v2 :: v_dual_add_nc_u32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x60,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0.5, v3 :: v_dual_add_nc_u32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x60,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, -1, v4 :: v_dual_add_nc_u32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x60,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v6, null, v5 :: v_dual_add_nc_u32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x60,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v4, v2 :: v_dual_and_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x64,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v1, v2 :: v_dual_and_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x64,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v255, v2 :: v_dual_and_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x64,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v2, v2 :: v_dual_and_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x64,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v3, v2 :: v_dual_and_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x64,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s105, v2 :: v_dual_and_b32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x64,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s1, v2 :: v_dual_and_b32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x64,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, ttmp15, v2 :: v_dual_and_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x64,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_hi, v2 :: v_dual_and_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x64,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_lo, v2 :: v_dual_and_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x64,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, m0, v2 :: v_dual_and_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x64,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_hi, v2 :: v_dual_and_b32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x64,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_lo, v2 :: v_dual_and_b32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x64,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0xaf123456, v2 :: v_dual_and_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x64,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, src_scc, v2 :: v_dual_and_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x64,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0.5, v3 :: v_dual_and_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x64,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, -1, v4 :: v_dual_and_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x64,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v6, null, v5 :: v_dual_and_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x64,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v4, v2 :: v_dual_cndmask_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x52,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v1, v2 :: v_dual_cndmask_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x52,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v255, v2 :: v_dual_cndmask_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x52,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v2, v2 :: v_dual_cndmask_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x52,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v3, v2 :: v_dual_cndmask_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x52,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s105, v2 :: v_dual_cndmask_b32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x52,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s1, v2 :: v_dual_cndmask_b32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x52,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, ttmp15, v2 :: v_dual_cndmask_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x52,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_hi, v2 :: v_dual_cndmask_b32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x52,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_lo, v2 :: v_dual_cndmask_b32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x52,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, m0, v2 :: v_dual_cndmask_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x52,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_hi, v2 :: v_dual_cndmask_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x52,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_lo, v2 :: v_dual_cndmask_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x52,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0xaf123456, v2 :: v_dual_cndmask_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x52,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, src_scc, v2 :: v_dual_cndmask_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x52,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0.5, v3 :: v_dual_cndmask_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x52,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, -1, v4 :: v_dual_cndmask_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x52,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v6, null, v5 :: v_dual_cndmask_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x52,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v4, v2 :: v_dual_dot2acc_f32_f16 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x58,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v1, v2 :: v_dual_dot2acc_f32_f16 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x58,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v255, v2 :: v_dual_dot2acc_f32_f16 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x58,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v2, v2 :: v_dual_dot2acc_f32_f16 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x58,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v3, v2 :: v_dual_dot2acc_f32_f16 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x58,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s105, v2 :: v_dual_dot2acc_f32_f16 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x58,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s1, v2 :: v_dual_dot2acc_f32_f16 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x58,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, ttmp15, v2 :: v_dual_dot2acc_f32_f16 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x58,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_hi, v2 :: v_dual_dot2acc_f32_f16 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x58,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_lo, v2 :: v_dual_dot2acc_f32_f16 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x58,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, m0, v2 :: v_dual_dot2acc_f32_f16 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x58,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_hi, v2 :: v_dual_dot2acc_f32_f16 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x58,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_lo, v2 :: v_dual_dot2acc_f32_f16 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x58,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0xaf123456, v2 :: v_dual_dot2acc_f32_f16 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x58,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, src_scc, v2 :: v_dual_dot2acc_f32_f16 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x58,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0.5, v3 :: v_dual_dot2acc_f32_f16 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x58,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, -1, v4 :: v_dual_dot2acc_f32_f16 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x58,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v6, null, v5 :: v_dual_dot2acc_f32_f16 v255, 0xfe0b, v4
// GFX11: encoding: [0x7c,0x0a,0x58,0xc9,0xff,0x08,0xfe,0x06,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v4, v2 :: v_dual_fmaak_f32 v6, v1, v3, 0xaf123456
// GFX11: encoding: [0x04,0x05,0x42,0xc9,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v1, v2 :: v_dual_fmaak_f32 v6, v255, v3, 0xaf123456
// GFX11: encoding: [0x01,0x05,0x42,0xc9,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v255, v2 :: v_dual_fmaak_f32 v6, v2, v3, 0xaf123456
// GFX11: encoding: [0xff,0x05,0x42,0xc9,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v2, v2 :: v_dual_fmaak_f32 v6, v3, v3, 0xaf123456
// GFX11: encoding: [0x02,0x05,0x42,0xc9,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v3, v2 :: v_dual_fmaak_f32 v6, v4, v3, 0xaf123456
// GFX11: encoding: [0x03,0x05,0x42,0xc9,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s105, v2 :: v_dual_fmaak_f32 v6, s105, v3, 0xaf123456
// GFX11: encoding: [0x69,0x04,0x42,0xc9,0x69,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s1, v2 :: v_dual_fmaak_f32 v6, s1, v3, 0xaf123456
// GFX11: encoding: [0x01,0x04,0x42,0xc9,0x01,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, ttmp15, v2 :: v_dual_fmaak_f32 v6, ttmp15, v3, 0xaf123456
// GFX11: encoding: [0x7b,0x04,0x42,0xc9,0x7b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_hi, v2 :: v_dual_fmaak_f32 v6, exec_hi, v3, 0xaf123456
// GFX11: encoding: [0x7f,0x04,0x42,0xc9,0x7f,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_lo, v2 :: v_dual_fmaak_f32 v6, exec_lo, v3, 0xaf123456
// GFX11: encoding: [0x7e,0x04,0x42,0xc9,0x7e,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, m0, v2 :: v_dual_fmaak_f32 v6, m0, v3, 0xaf123456
// GFX11: encoding: [0x7d,0x04,0x42,0xc9,0x7d,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_hi, v2 :: v_dual_fmaak_f32 v6, vcc_hi, v3, 0xaf123456
// GFX11: encoding: [0x6b,0x04,0x42,0xc9,0x6b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_lo, v2 :: v_dual_fmaak_f32 v6, vcc_lo, v3, 0xaf123456
// GFX11: encoding: [0x6a,0x04,0x42,0xc9,0x6a,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0xaf123456, v2 :: v_dual_fmaak_f32 v6, null, v3, 0xaf123456
// GFX11: encoding: [0xff,0x04,0x42,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, src_scc, v2 :: v_dual_fmaak_f32 v6, -1, v3, 0xaf123456
// GFX11: encoding: [0xfd,0x04,0x42,0xc9,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0.5, v3 :: v_dual_fmaak_f32 v6, 0.5, v2, 0xaf123456
// GFX11: encoding: [0xf0,0x06,0x42,0xc9,0xf0,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, -1, v4 :: v_dual_fmaak_f32 v6, src_scc, v5, 0xaf123456
// GFX11: encoding: [0xc1,0x08,0x42,0xc9,0xfd,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v6, null, v5 :: v_dual_fmaak_f32 v255, 0xaf123456, v4, 0xaf123456
// GFX11: encoding: [0x7c,0x0a,0x42,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v4, v2 :: v_dual_fmac_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x40,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v1, v2 :: v_dual_fmac_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x40,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v255, v2 :: v_dual_fmac_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x40,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v2, v2 :: v_dual_fmac_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x40,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v3, v2 :: v_dual_fmac_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x40,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s105, v2 :: v_dual_fmac_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x40,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s1, v2 :: v_dual_fmac_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x40,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, ttmp15, v2 :: v_dual_fmac_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x40,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_hi, v2 :: v_dual_fmac_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x40,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_lo, v2 :: v_dual_fmac_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x40,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, m0, v2 :: v_dual_fmac_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x40,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_hi, v2 :: v_dual_fmac_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x40,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_lo, v2 :: v_dual_fmac_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x40,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0xaf123456, v2 :: v_dual_fmac_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x40,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, src_scc, v2 :: v_dual_fmac_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x40,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0.5, v3 :: v_dual_fmac_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x40,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, -1, v4 :: v_dual_fmac_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x40,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v6, null, v5 :: v_dual_fmac_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x40,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v4, v255 :: v_dual_fmamk_f32 v6, v1, 0xaf123456, v255
// GFX11: encoding: [0x04,0xff,0x45,0xc9,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v1, v255 :: v_dual_fmamk_f32 v6, v255, 0xaf123456, v255
// GFX11: encoding: [0x01,0xff,0x45,0xc9,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v255, v255 :: v_dual_fmamk_f32 v6, v2, 0xaf123456, v255
// GFX11: encoding: [0xff,0xff,0x45,0xc9,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v2, v255 :: v_dual_fmamk_f32 v6, v3, 0xaf123456, v255
// GFX11: encoding: [0x02,0xff,0x45,0xc9,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v3, v255 :: v_dual_fmamk_f32 v6, v4, 0xaf123456, v255
// GFX11: encoding: [0x03,0xff,0x45,0xc9,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s105, v255 :: v_dual_fmamk_f32 v6, s105, 0xaf123456, v255
// GFX11: encoding: [0x69,0xfe,0x45,0xc9,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s1, v255 :: v_dual_fmamk_f32 v6, s1, 0xaf123456, v255
// GFX11: encoding: [0x01,0xfe,0x45,0xc9,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, ttmp15, v255 :: v_dual_fmamk_f32 v6, ttmp15, 0xaf123456, v255
// GFX11: encoding: [0x7b,0xfe,0x45,0xc9,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_hi, v255 :: v_dual_fmamk_f32 v6, exec_hi, 0xaf123456, v255
// GFX11: encoding: [0x7f,0xfe,0x45,0xc9,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_lo, v255 :: v_dual_fmamk_f32 v6, exec_lo, 0xaf123456, v255
// GFX11: encoding: [0x7e,0xfe,0x45,0xc9,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, m0, v255 :: v_dual_fmamk_f32 v6, m0, 0xaf123456, v255
// GFX11: encoding: [0x7d,0xfe,0x45,0xc9,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_hi, v255 :: v_dual_fmamk_f32 v6, vcc_hi, 0xaf123456, v255
// GFX11: encoding: [0x6b,0xfe,0x45,0xc9,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_lo, v255 :: v_dual_fmamk_f32 v6, vcc_lo, 0xaf123456, v255
// GFX11: encoding: [0x6a,0xfe,0x45,0xc9,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, null, 0xaf123456, v255
// GFX11: encoding: [0xff,0xfe,0x45,0xc9,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, src_scc, v255 :: v_dual_fmamk_f32 v6, -1, 0xaf123456, v255
// GFX11: encoding: [0xfd,0xfe,0x45,0xc9,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0.5, v3 :: v_dual_fmamk_f32 v6, 0.5, 0xaf123456, v255
// GFX11: encoding: [0xf0,0x06,0x44,0xc9,0xf0,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, -1, v4 :: v_dual_fmamk_f32 v6, src_scc, 0xaf123456, v255
// GFX11: encoding: [0xc1,0x08,0x44,0xc9,0xfd,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v6, null, v5 :: v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x44,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v4, v2 :: v_dual_lshlrev_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x62,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v1, v2 :: v_dual_lshlrev_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x62,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v255, v2 :: v_dual_lshlrev_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x62,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v2, v2 :: v_dual_lshlrev_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x62,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v3, v2 :: v_dual_lshlrev_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x62,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s105, v2 :: v_dual_lshlrev_b32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x62,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s1, v2 :: v_dual_lshlrev_b32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x62,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, ttmp15, v2 :: v_dual_lshlrev_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x62,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_hi, v2 :: v_dual_lshlrev_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x62,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_lo, v2 :: v_dual_lshlrev_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x62,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, m0, v2 :: v_dual_lshlrev_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x62,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_hi, v2 :: v_dual_lshlrev_b32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x62,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_lo, v2 :: v_dual_lshlrev_b32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x62,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0xaf123456, v2 :: v_dual_lshlrev_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x62,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, src_scc, v2 :: v_dual_lshlrev_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x62,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0.5, v3 :: v_dual_lshlrev_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x62,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, -1, v4 :: v_dual_lshlrev_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x62,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v6, null, v5 :: v_dual_lshlrev_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x62,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v4, v2 :: v_dual_max_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x54,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v1, v2 :: v_dual_max_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x54,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v255, v2 :: v_dual_max_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x54,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v2, v2 :: v_dual_max_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x54,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v3, v2 :: v_dual_max_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x54,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s105, v2 :: v_dual_max_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x54,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s1, v2 :: v_dual_max_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x54,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, ttmp15, v2 :: v_dual_max_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x54,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_hi, v2 :: v_dual_max_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x54,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_lo, v2 :: v_dual_max_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x54,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, m0, v2 :: v_dual_max_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x54,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_hi, v2 :: v_dual_max_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x54,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_lo, v2 :: v_dual_max_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x54,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0xaf123456, v2 :: v_dual_max_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x54,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, src_scc, v2 :: v_dual_max_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x54,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0.5, v3 :: v_dual_max_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x54,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, -1, v4 :: v_dual_max_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x54,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v6, null, v5 :: v_dual_max_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x54,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v4, v2 :: v_dual_min_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x56,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v1, v2 :: v_dual_min_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x56,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v255, v2 :: v_dual_min_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x56,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v2, v2 :: v_dual_min_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x56,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v3, v2 :: v_dual_min_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x56,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s105, v2 :: v_dual_min_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x56,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s1, v2 :: v_dual_min_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x56,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, ttmp15, v2 :: v_dual_min_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x56,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_hi, v2 :: v_dual_min_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x56,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_lo, v2 :: v_dual_min_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x56,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, m0, v2 :: v_dual_min_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x56,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_hi, v2 :: v_dual_min_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x56,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_lo, v2 :: v_dual_min_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x56,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0xaf123456, v2 :: v_dual_min_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x56,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, src_scc, v2 :: v_dual_min_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x56,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0.5, v3 :: v_dual_min_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x56,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, -1, v4 :: v_dual_min_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x56,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v6, null, v5 :: v_dual_min_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x56,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v4, v255 :: v_dual_mov_b32 v6, v1
// GFX11: encoding: [0x04,0xff,0x51,0xc9,0x01,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v1, v255 :: v_dual_mov_b32 v6, v255
// GFX11: encoding: [0x01,0xff,0x51,0xc9,0xff,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v255, v255 :: v_dual_mov_b32 v6, v2
// GFX11: encoding: [0xff,0xff,0x51,0xc9,0x02,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v2, v255 :: v_dual_mov_b32 v6, v3
// GFX11: encoding: [0x02,0xff,0x51,0xc9,0x03,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v3, v255 :: v_dual_mov_b32 v6, v4
// GFX11: encoding: [0x03,0xff,0x51,0xc9,0x04,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s105, v255 :: v_dual_mov_b32 v6, s1
// GFX11: encoding: [0x69,0xfe,0x51,0xc9,0x01,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s1, v255 :: v_dual_mov_b32 v6, s105
// GFX11: encoding: [0x01,0xfe,0x51,0xc9,0x69,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, ttmp15, v255 :: v_dual_mov_b32 v6, vcc_lo
// GFX11: encoding: [0x7b,0xfe,0x51,0xc9,0x6a,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_hi, v255 :: v_dual_mov_b32 v6, vcc_hi
// GFX11: encoding: [0x7f,0xfe,0x51,0xc9,0x6b,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_lo, v255 :: v_dual_mov_b32 v6, ttmp15
// GFX11: encoding: [0x7e,0xfe,0x51,0xc9,0x7b,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, m0, v255 :: v_dual_mov_b32 v6, m0
// GFX11: encoding: [0x7d,0xfe,0x51,0xc9,0x7d,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_hi, v255 :: v_dual_mov_b32 v6, exec_lo
// GFX11: encoding: [0x6b,0xfe,0x51,0xc9,0x7e,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_lo, v255 :: v_dual_mov_b32 v6, exec_hi
// GFX11: encoding: [0x6a,0xfe,0x51,0xc9,0x7f,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0xaf123456, v255 :: v_dual_mov_b32 v6, null
// GFX11: encoding: [0xff,0xfe,0x51,0xc9,0x7c,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, src_scc, v255 :: v_dual_mov_b32 v6, -1
// GFX11: encoding: [0xfd,0xfe,0x51,0xc9,0xc1,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0.5, v3 :: v_dual_mov_b32 v6, 0.5
// GFX11: encoding: [0xf0,0x06,0x50,0xc9,0xf0,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, -1, v4 :: v_dual_mov_b32 v6, src_scc
// GFX11: encoding: [0xc1,0x08,0x50,0xc9,0xfd,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v6, null, v5 :: v_dual_mov_b32 v255, 0xaf123456
// GFX11: encoding: [0x7c,0x0a,0x50,0xc9,0xff,0x00,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v4, v2 :: v_dual_mul_dx9_zero_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x4e,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v1, v2 :: v_dual_mul_dx9_zero_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x4e,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v255, v2 :: v_dual_mul_dx9_zero_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x4e,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v2, v2 :: v_dual_mul_dx9_zero_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x4e,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v3, v2 :: v_dual_mul_dx9_zero_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x4e,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s105, v2 :: v_dual_mul_dx9_zero_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x4e,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s1, v2 :: v_dual_mul_dx9_zero_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x4e,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, ttmp15, v2 :: v_dual_mul_dx9_zero_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x4e,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_hi, v2 :: v_dual_mul_dx9_zero_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x4e,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_lo, v2 :: v_dual_mul_dx9_zero_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x4e,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, m0, v2 :: v_dual_mul_dx9_zero_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x4e,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_hi, v2 :: v_dual_mul_dx9_zero_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x4e,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_lo, v2 :: v_dual_mul_dx9_zero_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x4e,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0xaf123456, v2 :: v_dual_mul_dx9_zero_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x4e,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, src_scc, v2 :: v_dual_mul_dx9_zero_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x4e,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0.5, v3 :: v_dual_mul_dx9_zero_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x4e,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, -1, v4 :: v_dual_mul_dx9_zero_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x4e,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v6, null, v5 :: v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x4e,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v4, v2 :: v_dual_mul_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x46,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v1, v2 :: v_dual_mul_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x46,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v255, v2 :: v_dual_mul_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x46,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v2, v2 :: v_dual_mul_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x46,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v3, v2 :: v_dual_mul_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x46,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s105, v2 :: v_dual_mul_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x46,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s1, v2 :: v_dual_mul_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x46,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, ttmp15, v2 :: v_dual_mul_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x46,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_hi, v2 :: v_dual_mul_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x46,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_lo, v2 :: v_dual_mul_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x46,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, m0, v2 :: v_dual_mul_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x46,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_hi, v2 :: v_dual_mul_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x46,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_lo, v2 :: v_dual_mul_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x46,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0xaf123456, v2 :: v_dual_mul_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x46,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, src_scc, v2 :: v_dual_mul_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x46,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0.5, v3 :: v_dual_mul_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x46,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, -1, v4 :: v_dual_mul_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x46,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v6, null, v5 :: v_dual_mul_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x46,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v4, v2 :: v_dual_sub_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x4a,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v1, v2 :: v_dual_sub_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x4a,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v255, v2 :: v_dual_sub_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x4a,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v2, v2 :: v_dual_sub_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x4a,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v3, v2 :: v_dual_sub_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x4a,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s105, v2 :: v_dual_sub_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x4a,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s1, v2 :: v_dual_sub_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x4a,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, ttmp15, v2 :: v_dual_sub_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x4a,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_hi, v2 :: v_dual_sub_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x4a,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_lo, v2 :: v_dual_sub_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x4a,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, m0, v2 :: v_dual_sub_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x4a,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_hi, v2 :: v_dual_sub_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x4a,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_lo, v2 :: v_dual_sub_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x4a,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0xaf123456, v2 :: v_dual_sub_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x4a,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, src_scc, v2 :: v_dual_sub_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x4a,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0.5, v3 :: v_dual_sub_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x4a,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, -1, v4 :: v_dual_sub_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x4a,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v6, null, v5 :: v_dual_sub_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x4a,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v4, v2 :: v_dual_subrev_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x4c,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v1, v2 :: v_dual_subrev_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x4c,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v255, v2 :: v_dual_subrev_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x4c,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v2, v2 :: v_dual_subrev_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x4c,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, v3, v2 :: v_dual_subrev_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x4c,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s105, v2 :: v_dual_subrev_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x4c,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, s1, v2 :: v_dual_subrev_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x4c,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, ttmp15, v2 :: v_dual_subrev_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x4c,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_hi, v2 :: v_dual_subrev_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x4c,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, exec_lo, v2 :: v_dual_subrev_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x4c,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, m0, v2 :: v_dual_subrev_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x4c,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_hi, v2 :: v_dual_subrev_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x4c,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, vcc_lo, v2 :: v_dual_subrev_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x4c,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0xaf123456, v2 :: v_dual_subrev_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x4c,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, src_scc, v2 :: v_dual_subrev_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x4c,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, 0.5, v3 :: v_dual_subrev_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x4c,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v255, -1, v4 :: v_dual_subrev_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x4c,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_sub_f32 v6, null, v5 :: v_dual_subrev_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x4c,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v4, v2 :: v_dual_add_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x88,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v1, v2 :: v_dual_add_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x88,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v255, v2 :: v_dual_add_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x88,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v2, v2 :: v_dual_add_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x88,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v3, v2 :: v_dual_add_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x88,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s105, v2 :: v_dual_add_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x88,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s1, v2 :: v_dual_add_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x88,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, ttmp15, v2 :: v_dual_add_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x88,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_hi, v2 :: v_dual_add_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x88,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_lo, v2 :: v_dual_add_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x88,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, m0, v2 :: v_dual_add_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x88,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_hi, v2 :: v_dual_add_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x88,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_lo, v2 :: v_dual_add_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x88,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0xaf123456, v2 :: v_dual_add_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x88,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, src_scc, v2 :: v_dual_add_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x88,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0.5, v3 :: v_dual_add_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x88,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, -1, v4 :: v_dual_add_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x88,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v6, null, v5 :: v_dual_add_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x88,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v4, v2 :: v_dual_add_nc_u32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xa0,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v1, v2 :: v_dual_add_nc_u32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xa0,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v255, v2 :: v_dual_add_nc_u32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xa0,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v2, v2 :: v_dual_add_nc_u32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xa0,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v3, v2 :: v_dual_add_nc_u32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xa0,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s105, v2 :: v_dual_add_nc_u32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xa0,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s1, v2 :: v_dual_add_nc_u32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xa0,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, ttmp15, v2 :: v_dual_add_nc_u32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xa0,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_hi, v2 :: v_dual_add_nc_u32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xa0,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_lo, v2 :: v_dual_add_nc_u32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xa0,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, m0, v2 :: v_dual_add_nc_u32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xa0,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_hi, v2 :: v_dual_add_nc_u32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xa0,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_lo, v2 :: v_dual_add_nc_u32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xa0,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0xaf123456, v2 :: v_dual_add_nc_u32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xa0,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, src_scc, v2 :: v_dual_add_nc_u32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xa0,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0.5, v3 :: v_dual_add_nc_u32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xa0,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, -1, v4 :: v_dual_add_nc_u32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xa0,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v6, null, v5 :: v_dual_add_nc_u32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xa0,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v4, v2 :: v_dual_and_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xa4,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v1, v2 :: v_dual_and_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xa4,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v255, v2 :: v_dual_and_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xa4,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v2, v2 :: v_dual_and_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xa4,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v3, v2 :: v_dual_and_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xa4,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s105, v2 :: v_dual_and_b32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xa4,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s1, v2 :: v_dual_and_b32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xa4,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, ttmp15, v2 :: v_dual_and_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xa4,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_hi, v2 :: v_dual_and_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xa4,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_lo, v2 :: v_dual_and_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xa4,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, m0, v2 :: v_dual_and_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xa4,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_hi, v2 :: v_dual_and_b32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xa4,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_lo, v2 :: v_dual_and_b32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xa4,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0xaf123456, v2 :: v_dual_and_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xa4,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, src_scc, v2 :: v_dual_and_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xa4,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0.5, v3 :: v_dual_and_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xa4,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, -1, v4 :: v_dual_and_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xa4,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v6, null, v5 :: v_dual_and_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xa4,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v4, v2 :: v_dual_cndmask_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x92,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v1, v2 :: v_dual_cndmask_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x92,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v255, v2 :: v_dual_cndmask_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x92,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v2, v2 :: v_dual_cndmask_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x92,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v3, v2 :: v_dual_cndmask_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x92,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s105, v2 :: v_dual_cndmask_b32 v6, s105, v3
// GFX11: encoding: [0x69,0x04,0x92,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s1, v2 :: v_dual_cndmask_b32 v6, s1, v3
// GFX11: encoding: [0x01,0x04,0x92,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, ttmp15, v2 :: v_dual_cndmask_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7b,0x04,0x92,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_hi, v2 :: v_dual_cndmask_b32 v6, exec_hi, v3
// GFX11: encoding: [0x7f,0x04,0x92,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_lo, v2 :: v_dual_cndmask_b32 v6, exec_lo, v3
// GFX11: encoding: [0x7e,0x04,0x92,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, m0, v2 :: v_dual_cndmask_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x92,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_hi, v2 :: v_dual_cndmask_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x6b,0x04,0x92,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_lo, v2 :: v_dual_cndmask_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x6a,0x04,0x92,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0xaf123456, v2 :: v_dual_cndmask_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x92,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, src_scc, v2 :: v_dual_cndmask_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x92,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0.5, v3 :: v_dual_cndmask_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x92,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, -1, v4 :: v_dual_cndmask_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x92,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v6, null, v5 :: v_dual_cndmask_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x92,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v4, v2 :: v_dual_dot2acc_f32_f16 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x98,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v1, v2 :: v_dual_dot2acc_f32_f16 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x98,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v255, v2 :: v_dual_dot2acc_f32_f16 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x98,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v2, v2 :: v_dual_dot2acc_f32_f16 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x98,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v3, v2 :: v_dual_dot2acc_f32_f16 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x98,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s105, v2 :: v_dual_dot2acc_f32_f16 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x98,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s1, v2 :: v_dual_dot2acc_f32_f16 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x98,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, ttmp15, v2 :: v_dual_dot2acc_f32_f16 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x98,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_hi, v2 :: v_dual_dot2acc_f32_f16 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x98,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_lo, v2 :: v_dual_dot2acc_f32_f16 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x98,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, m0, v2 :: v_dual_dot2acc_f32_f16 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x98,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_hi, v2 :: v_dual_dot2acc_f32_f16 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x98,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_lo, v2 :: v_dual_dot2acc_f32_f16 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x98,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0xaf123456, v2 :: v_dual_dot2acc_f32_f16 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x98,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, src_scc, v2 :: v_dual_dot2acc_f32_f16 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x98,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0.5, v3 :: v_dual_dot2acc_f32_f16 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x98,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, -1, v4 :: v_dual_dot2acc_f32_f16 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x98,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v6, null, v5 :: v_dual_dot2acc_f32_f16 v255, 0xfe0b, v4
// GFX11: encoding: [0x7c,0x0a,0x98,0xc9,0xff,0x08,0xfe,0x06,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v4, v2 :: v_dual_fmaak_f32 v6, v1, v3, 0xaf123456
// GFX11: encoding: [0x04,0x05,0x82,0xc9,0x01,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v1, v2 :: v_dual_fmaak_f32 v6, v255, v3, 0xaf123456
// GFX11: encoding: [0x01,0x05,0x82,0xc9,0xff,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v255, v2 :: v_dual_fmaak_f32 v6, v2, v3, 0xaf123456
// GFX11: encoding: [0xff,0x05,0x82,0xc9,0x02,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v2, v2 :: v_dual_fmaak_f32 v6, v3, v3, 0xaf123456
// GFX11: encoding: [0x02,0x05,0x82,0xc9,0x03,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v3, v2 :: v_dual_fmaak_f32 v6, v4, v3, 0xaf123456
// GFX11: encoding: [0x03,0x05,0x82,0xc9,0x04,0x07,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s105, v2 :: v_dual_fmaak_f32 v6, s105, v3, 0xaf123456
// GFX11: encoding: [0x69,0x04,0x82,0xc9,0x69,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s1, v2 :: v_dual_fmaak_f32 v6, s1, v3, 0xaf123456
// GFX11: encoding: [0x01,0x04,0x82,0xc9,0x01,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, ttmp15, v2 :: v_dual_fmaak_f32 v6, ttmp15, v3, 0xaf123456
// GFX11: encoding: [0x7b,0x04,0x82,0xc9,0x7b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_hi, v2 :: v_dual_fmaak_f32 v6, exec_hi, v3, 0xaf123456
// GFX11: encoding: [0x7f,0x04,0x82,0xc9,0x7f,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_lo, v2 :: v_dual_fmaak_f32 v6, exec_lo, v3, 0xaf123456
// GFX11: encoding: [0x7e,0x04,0x82,0xc9,0x7e,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, m0, v2 :: v_dual_fmaak_f32 v6, m0, v3, 0xaf123456
// GFX11: encoding: [0x7d,0x04,0x82,0xc9,0x7d,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_hi, v2 :: v_dual_fmaak_f32 v6, vcc_hi, v3, 0xaf123456
// GFX11: encoding: [0x6b,0x04,0x82,0xc9,0x6b,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_lo, v2 :: v_dual_fmaak_f32 v6, vcc_lo, v3, 0xaf123456
// GFX11: encoding: [0x6a,0x04,0x82,0xc9,0x6a,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0xaf123456, v2 :: v_dual_fmaak_f32 v6, null, v3, 0xaf123456
// GFX11: encoding: [0xff,0x04,0x82,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, src_scc, v2 :: v_dual_fmaak_f32 v6, -1, v3, 0xaf123456
// GFX11: encoding: [0xfd,0x04,0x82,0xc9,0xc1,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0.5, v3 :: v_dual_fmaak_f32 v6, 0.5, v2, 0xaf123456
// GFX11: encoding: [0xf0,0x06,0x82,0xc9,0xf0,0x04,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, -1, v4 :: v_dual_fmaak_f32 v6, src_scc, v5, 0xaf123456
// GFX11: encoding: [0xc1,0x08,0x82,0xc9,0xfd,0x0a,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v6, null, v5 :: v_dual_fmaak_f32 v255, 0xaf123456, v4, 0xaf123456
// GFX11: encoding: [0x7c,0x0a,0x82,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v4, v2 :: v_dual_fmac_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x80,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v1, v2 :: v_dual_fmac_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x80,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v255, v2 :: v_dual_fmac_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x80,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v2, v2 :: v_dual_fmac_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x80,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v3, v2 :: v_dual_fmac_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x80,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s105, v2 :: v_dual_fmac_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x80,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s1, v2 :: v_dual_fmac_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x80,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, ttmp15, v2 :: v_dual_fmac_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x80,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_hi, v2 :: v_dual_fmac_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x80,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_lo, v2 :: v_dual_fmac_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x80,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, m0, v2 :: v_dual_fmac_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x80,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_hi, v2 :: v_dual_fmac_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x80,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_lo, v2 :: v_dual_fmac_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x80,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0xaf123456, v2 :: v_dual_fmac_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x80,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, src_scc, v2 :: v_dual_fmac_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x80,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0.5, v3 :: v_dual_fmac_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x80,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, -1, v4 :: v_dual_fmac_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x80,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v6, null, v5 :: v_dual_fmac_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x80,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v4, v255 :: v_dual_fmamk_f32 v6, v1, 0xaf123456, v255
// GFX11: encoding: [0x04,0xff,0x85,0xc9,0x01,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v1, v255 :: v_dual_fmamk_f32 v6, v255, 0xaf123456, v255
// GFX11: encoding: [0x01,0xff,0x85,0xc9,0xff,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v255, v255 :: v_dual_fmamk_f32 v6, v2, 0xaf123456, v255
// GFX11: encoding: [0xff,0xff,0x85,0xc9,0x02,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v2, v255 :: v_dual_fmamk_f32 v6, v3, 0xaf123456, v255
// GFX11: encoding: [0x02,0xff,0x85,0xc9,0x03,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v3, v255 :: v_dual_fmamk_f32 v6, v4, 0xaf123456, v255
// GFX11: encoding: [0x03,0xff,0x85,0xc9,0x04,0xff,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s105, v255 :: v_dual_fmamk_f32 v6, s105, 0xaf123456, v255
// GFX11: encoding: [0x69,0xfe,0x85,0xc9,0x69,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s1, v255 :: v_dual_fmamk_f32 v6, s1, 0xaf123456, v255
// GFX11: encoding: [0x01,0xfe,0x85,0xc9,0x01,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, ttmp15, v255 :: v_dual_fmamk_f32 v6, ttmp15, 0xaf123456, v255
// GFX11: encoding: [0x7b,0xfe,0x85,0xc9,0x7b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_hi, v255 :: v_dual_fmamk_f32 v6, exec_hi, 0xaf123456, v255
// GFX11: encoding: [0x7f,0xfe,0x85,0xc9,0x7f,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_lo, v255 :: v_dual_fmamk_f32 v6, exec_lo, 0xaf123456, v255
// GFX11: encoding: [0x7e,0xfe,0x85,0xc9,0x7e,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, m0, v255 :: v_dual_fmamk_f32 v6, m0, 0xaf123456, v255
// GFX11: encoding: [0x7d,0xfe,0x85,0xc9,0x7d,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_hi, v255 :: v_dual_fmamk_f32 v6, vcc_hi, 0xaf123456, v255
// GFX11: encoding: [0x6b,0xfe,0x85,0xc9,0x6b,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_lo, v255 :: v_dual_fmamk_f32 v6, vcc_lo, 0xaf123456, v255
// GFX11: encoding: [0x6a,0xfe,0x85,0xc9,0x6a,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0xaf123456, v255 :: v_dual_fmamk_f32 v6, null, 0xaf123456, v255
// GFX11: encoding: [0xff,0xfe,0x85,0xc9,0x7c,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, src_scc, v255 :: v_dual_fmamk_f32 v6, -1, 0xaf123456, v255
// GFX11: encoding: [0xfd,0xfe,0x85,0xc9,0xc1,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0.5, v3 :: v_dual_fmamk_f32 v6, 0.5, 0xaf123456, v255
// GFX11: encoding: [0xf0,0x06,0x84,0xc9,0xf0,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, -1, v4 :: v_dual_fmamk_f32 v6, src_scc, 0xaf123456, v255
// GFX11: encoding: [0xc1,0x08,0x84,0xc9,0xfd,0xfe,0x07,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v6, null, v5 :: v_dual_fmamk_f32 v255, 0xaf123456, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x84,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v4, v2 :: v_dual_lshlrev_b32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0xa2,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v1, v2 :: v_dual_lshlrev_b32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0xa2,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v255, v2 :: v_dual_lshlrev_b32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0xa2,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v2, v2 :: v_dual_lshlrev_b32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0xa2,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v3, v2 :: v_dual_lshlrev_b32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0xa2,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s105, v2 :: v_dual_lshlrev_b32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0xa2,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s1, v2 :: v_dual_lshlrev_b32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0xa2,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, ttmp15, v2 :: v_dual_lshlrev_b32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0xa2,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_hi, v2 :: v_dual_lshlrev_b32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0xa2,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_lo, v2 :: v_dual_lshlrev_b32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0xa2,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, m0, v2 :: v_dual_lshlrev_b32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0xa2,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_hi, v2 :: v_dual_lshlrev_b32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0xa2,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_lo, v2 :: v_dual_lshlrev_b32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0xa2,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0xaf123456, v2 :: v_dual_lshlrev_b32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0xa2,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, src_scc, v2 :: v_dual_lshlrev_b32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0xa2,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0.5, v3 :: v_dual_lshlrev_b32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0xa2,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, -1, v4 :: v_dual_lshlrev_b32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0xa2,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v6, null, v5 :: v_dual_lshlrev_b32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0xa2,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v4, v2 :: v_dual_max_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x94,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v1, v2 :: v_dual_max_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x94,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v255, v2 :: v_dual_max_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x94,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v2, v2 :: v_dual_max_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x94,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v3, v2 :: v_dual_max_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x94,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s105, v2 :: v_dual_max_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x94,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s1, v2 :: v_dual_max_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x94,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, ttmp15, v2 :: v_dual_max_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x94,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_hi, v2 :: v_dual_max_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x94,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_lo, v2 :: v_dual_max_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x94,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, m0, v2 :: v_dual_max_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x94,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_hi, v2 :: v_dual_max_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x94,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_lo, v2 :: v_dual_max_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x94,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0xaf123456, v2 :: v_dual_max_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x94,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, src_scc, v2 :: v_dual_max_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x94,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0.5, v3 :: v_dual_max_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x94,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, -1, v4 :: v_dual_max_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x94,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v6, null, v5 :: v_dual_max_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x94,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v4, v2 :: v_dual_min_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x96,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v1, v2 :: v_dual_min_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x96,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v255, v2 :: v_dual_min_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x96,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v2, v2 :: v_dual_min_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x96,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v3, v2 :: v_dual_min_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x96,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s105, v2 :: v_dual_min_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x96,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s1, v2 :: v_dual_min_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x96,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, ttmp15, v2 :: v_dual_min_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x96,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_hi, v2 :: v_dual_min_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x96,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_lo, v2 :: v_dual_min_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x96,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, m0, v2 :: v_dual_min_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x96,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_hi, v2 :: v_dual_min_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x96,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_lo, v2 :: v_dual_min_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x96,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0xaf123456, v2 :: v_dual_min_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x96,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, src_scc, v2 :: v_dual_min_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x96,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0.5, v3 :: v_dual_min_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x96,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, -1, v4 :: v_dual_min_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x96,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v6, null, v5 :: v_dual_min_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x96,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v4, v255 :: v_dual_mov_b32 v6, v1
// GFX11: encoding: [0x04,0xff,0x91,0xc9,0x01,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v1, v255 :: v_dual_mov_b32 v6, v255
// GFX11: encoding: [0x01,0xff,0x91,0xc9,0xff,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v255, v255 :: v_dual_mov_b32 v6, v2
// GFX11: encoding: [0xff,0xff,0x91,0xc9,0x02,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v2, v255 :: v_dual_mov_b32 v6, v3
// GFX11: encoding: [0x02,0xff,0x91,0xc9,0x03,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v3, v255 :: v_dual_mov_b32 v6, v4
// GFX11: encoding: [0x03,0xff,0x91,0xc9,0x04,0x01,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s105, v255 :: v_dual_mov_b32 v6, s1
// GFX11: encoding: [0x69,0xfe,0x91,0xc9,0x01,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s1, v255 :: v_dual_mov_b32 v6, s105
// GFX11: encoding: [0x01,0xfe,0x91,0xc9,0x69,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, ttmp15, v255 :: v_dual_mov_b32 v6, vcc_lo
// GFX11: encoding: [0x7b,0xfe,0x91,0xc9,0x6a,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_hi, v255 :: v_dual_mov_b32 v6, vcc_hi
// GFX11: encoding: [0x7f,0xfe,0x91,0xc9,0x6b,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_lo, v255 :: v_dual_mov_b32 v6, ttmp15
// GFX11: encoding: [0x7e,0xfe,0x91,0xc9,0x7b,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, m0, v255 :: v_dual_mov_b32 v6, m0
// GFX11: encoding: [0x7d,0xfe,0x91,0xc9,0x7d,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_hi, v255 :: v_dual_mov_b32 v6, exec_lo
// GFX11: encoding: [0x6b,0xfe,0x91,0xc9,0x7e,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_lo, v255 :: v_dual_mov_b32 v6, exec_hi
// GFX11: encoding: [0x6a,0xfe,0x91,0xc9,0x7f,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0xaf123456, v255 :: v_dual_mov_b32 v6, null
// GFX11: encoding: [0xff,0xfe,0x91,0xc9,0x7c,0x00,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, src_scc, v255 :: v_dual_mov_b32 v6, -1
// GFX11: encoding: [0xfd,0xfe,0x91,0xc9,0xc1,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0.5, v3 :: v_dual_mov_b32 v6, 0.5
// GFX11: encoding: [0xf0,0x06,0x90,0xc9,0xf0,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, -1, v4 :: v_dual_mov_b32 v6, src_scc
// GFX11: encoding: [0xc1,0x08,0x90,0xc9,0xfd,0x00,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v6, null, v5 :: v_dual_mov_b32 v255, 0xaf123456
// GFX11: encoding: [0x7c,0x0a,0x90,0xc9,0xff,0x00,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v4, v2 :: v_dual_mul_dx9_zero_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x8e,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v1, v2 :: v_dual_mul_dx9_zero_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x8e,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v255, v2 :: v_dual_mul_dx9_zero_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x8e,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v2, v2 :: v_dual_mul_dx9_zero_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x8e,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v3, v2 :: v_dual_mul_dx9_zero_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x8e,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s105, v2 :: v_dual_mul_dx9_zero_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x8e,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s1, v2 :: v_dual_mul_dx9_zero_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x8e,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, ttmp15, v2 :: v_dual_mul_dx9_zero_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x8e,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_hi, v2 :: v_dual_mul_dx9_zero_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x8e,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_lo, v2 :: v_dual_mul_dx9_zero_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x8e,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, m0, v2 :: v_dual_mul_dx9_zero_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x8e,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_hi, v2 :: v_dual_mul_dx9_zero_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x8e,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_lo, v2 :: v_dual_mul_dx9_zero_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x8e,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0xaf123456, v2 :: v_dual_mul_dx9_zero_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x8e,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, src_scc, v2 :: v_dual_mul_dx9_zero_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x8e,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0.5, v3 :: v_dual_mul_dx9_zero_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x8e,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, -1, v4 :: v_dual_mul_dx9_zero_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x8e,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v6, null, v5 :: v_dual_mul_dx9_zero_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x8e,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v4, v2 :: v_dual_mul_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x86,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v1, v2 :: v_dual_mul_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x86,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v255, v2 :: v_dual_mul_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x86,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v2, v2 :: v_dual_mul_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x86,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v3, v2 :: v_dual_mul_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x86,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s105, v2 :: v_dual_mul_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x86,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s1, v2 :: v_dual_mul_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x86,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, ttmp15, v2 :: v_dual_mul_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x86,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_hi, v2 :: v_dual_mul_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x86,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_lo, v2 :: v_dual_mul_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x86,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, m0, v2 :: v_dual_mul_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x86,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_hi, v2 :: v_dual_mul_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x86,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_lo, v2 :: v_dual_mul_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x86,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0xaf123456, v2 :: v_dual_mul_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x86,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, src_scc, v2 :: v_dual_mul_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x86,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0.5, v3 :: v_dual_mul_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x86,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, -1, v4 :: v_dual_mul_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x86,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v6, null, v5 :: v_dual_mul_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x86,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v4, v2 :: v_dual_sub_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x8a,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v1, v2 :: v_dual_sub_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x8a,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v255, v2 :: v_dual_sub_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x8a,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v2, v2 :: v_dual_sub_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x8a,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v3, v2 :: v_dual_sub_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x8a,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s105, v2 :: v_dual_sub_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x8a,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s1, v2 :: v_dual_sub_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x8a,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, ttmp15, v2 :: v_dual_sub_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x8a,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_hi, v2 :: v_dual_sub_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x8a,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_lo, v2 :: v_dual_sub_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x8a,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, m0, v2 :: v_dual_sub_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x8a,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_hi, v2 :: v_dual_sub_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x8a,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_lo, v2 :: v_dual_sub_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x8a,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0xaf123456, v2 :: v_dual_sub_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x8a,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, src_scc, v2 :: v_dual_sub_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x8a,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0.5, v3 :: v_dual_sub_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x8a,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, -1, v4 :: v_dual_sub_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x8a,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v6, null, v5 :: v_dual_sub_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x8a,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v4, v2 :: v_dual_subrev_f32 v6, v1, v3
// GFX11: encoding: [0x04,0x05,0x8c,0xc9,0x01,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v1, v2 :: v_dual_subrev_f32 v6, v255, v3
// GFX11: encoding: [0x01,0x05,0x8c,0xc9,0xff,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v255, v2 :: v_dual_subrev_f32 v6, v2, v3
// GFX11: encoding: [0xff,0x05,0x8c,0xc9,0x02,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v2, v2 :: v_dual_subrev_f32 v6, v3, v3
// GFX11: encoding: [0x02,0x05,0x8c,0xc9,0x03,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, v3, v2 :: v_dual_subrev_f32 v6, v4, v3
// GFX11: encoding: [0x03,0x05,0x8c,0xc9,0x04,0x07,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s105, v2 :: v_dual_subrev_f32 v6, s1, v3
// GFX11: encoding: [0x69,0x04,0x8c,0xc9,0x01,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, s1, v2 :: v_dual_subrev_f32 v6, s105, v3
// GFX11: encoding: [0x01,0x04,0x8c,0xc9,0x69,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, ttmp15, v2 :: v_dual_subrev_f32 v6, vcc_lo, v3
// GFX11: encoding: [0x7b,0x04,0x8c,0xc9,0x6a,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_hi, v2 :: v_dual_subrev_f32 v6, vcc_hi, v3
// GFX11: encoding: [0x7f,0x04,0x8c,0xc9,0x6b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, exec_lo, v2 :: v_dual_subrev_f32 v6, ttmp15, v3
// GFX11: encoding: [0x7e,0x04,0x8c,0xc9,0x7b,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, m0, v2 :: v_dual_subrev_f32 v6, m0, v3
// GFX11: encoding: [0x7d,0x04,0x8c,0xc9,0x7d,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_hi, v2 :: v_dual_subrev_f32 v6, exec_lo, v3
// GFX11: encoding: [0x6b,0x04,0x8c,0xc9,0x7e,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, vcc_lo, v2 :: v_dual_subrev_f32 v6, exec_hi, v3
// GFX11: encoding: [0x6a,0x04,0x8c,0xc9,0x7f,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0xaf123456, v2 :: v_dual_subrev_f32 v6, null, v3
// GFX11: encoding: [0xff,0x04,0x8c,0xc9,0x7c,0x06,0x06,0xff,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, src_scc, v2 :: v_dual_subrev_f32 v6, -1, v3
// GFX11: encoding: [0xfd,0x04,0x8c,0xc9,0xc1,0x06,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, 0.5, v3 :: v_dual_subrev_f32 v6, 0.5, v2
// GFX11: encoding: [0xf0,0x06,0x8c,0xc9,0xf0,0x04,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v255, -1, v4 :: v_dual_subrev_f32 v6, src_scc, v5
// GFX11: encoding: [0xc1,0x08,0x8c,0xc9,0xfd,0x0a,0x06,0xff]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32

v_dual_subrev_f32 v6, null, v5 :: v_dual_subrev_f32 v255, 0xaf123456, v4
// GFX11: encoding: [0x7c,0x0a,0x8c,0xc9,0xff,0x08,0xfe,0x06,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction requires wavesize=32
