.section .data
msg:    .asciz "thoriq\n"

.section .text
.global _start

_start:
    // write(int fd, const void *buf, size_t count)
    mov     x0, 1          // file descriptor 1 = stdout
    ldr     x1, =msg       // pointer ke string "thoriq\n"
    mov     x2, 7          // panjang string (termasuk newline)
    mov     x8, 64         // syscall number untuk write (64 di AArch64)
    svc     0              // panggil kernel

    // exit(int status)
    mov     x0, 0          // status 0
    mov     x8, 93         // syscall number untuk exit (93 di AArch64)
    svc     0              // keluar
