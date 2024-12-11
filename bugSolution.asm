section .data

valid_memory_range: dq 0x0000000000000000, 0xFFFFFFFFFFFFFFFF ; Define the valid memory range (64-bit)

section .text

global _start

_start:
    ; ... other code ...

    ; Check for potential overflow before memory access
    mov rbx, ebx ; Load ebx into a 64-bit register for comparison
    mov rsi, esi ; Load esi into a 64-bit register for comparison
    mov rax, rbx
    add rax, rsi
    add rax, 0x10

    mov rdi, valid_memory_range
    cmp rax, [rdi] ; Compare with lower limit of the address range
    jl overflow_error
    cmp rax, [rdi + 8] ; Compare with upper limit of the address range
    jg overflow_error

    mov eax, [rbx + rsi * 4 + 0x10] ; Safe memory access if no overflow
    ; ... rest of the code

    mov rax, 60  ; sys_exit
    xor rdi, rdi ; exit code 0
    syscall

overflow_error:
    ; Handle overflow error (e.g., exit with error code)
    mov rax, 60
    mov rdi, 1
    syscall
    ; ...end