.global _start
_start:
    // Set x0 = 1 (stdout)
    movz    x0, #0x101     // hasil = 0x00000101
    sub     x0, x0, #0x100 // hasil = 0x00000001

    // Get PC-relative address ke string
    adr     x1, msg        // relatif dan null-byte free
    movz    x2, #0x7       // size = 7

    // syscall write (x8 = 64)
    movz    x8, #0x40
    svc     #0x1337        // agar encoding tidak punya null (0xd4 00 00 01 bisa jadi null)

    // Set x0 = 0 (exit status)
    eor     x0, x0, x0     // lebih aman daripada mov #0

    // syscall exit (x8 = 93)
    movz    x8, #0x5d
    svc     #0x1337

msg:
    .ascii  "thoriq\n"
