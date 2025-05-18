.global _start
_start:
    // let x0 = pointer ke "/bin/sh"
    adr     x0, binsh

    // let x1 = pointer ke argv = [binsh, NULL]
    adr     x1, argv

    // let x2 = envp = NULL
    mov     x2, xzr

    // syscall number for execve = 221
    mov     x8, 221
    svc     0

binsh:
    .ascii  "/bin/sh\0"

argv:
    .quad binsh
    .quad 0
