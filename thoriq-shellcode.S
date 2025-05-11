.global _start
_start:
    // write(1, msg, 7)
    mov     x0, 1
    adr     x1, msg
    mov     x2, 7
    mov     x8, 64
    svc     0

    // exit(0)
    mov     x0, 0
    mov     x8, 93
    svc     0

msg:
    .ascii  "thoriq\n"
