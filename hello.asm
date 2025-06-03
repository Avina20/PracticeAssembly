section .data
    hello db 'Hello, World!', 13, 10, 0    ; Our string with carriage return, line feed, and null terminator
    hello_len equ $ - hello - 1             ; Length of string (excluding null terminator)

section .text
    global _start
    extern ExitProcess
    extern GetStdHandle
    extern WriteConsoleA

_start:
    ; Get handle to stdout
    mov rcx, -11        ; STD_OUTPUT_HANDLE
    call GetStdHandle
    mov r12, rax        ; Save stdout handle in r12

    ; Write "Hello, World!" to console
    mov rcx, r12        ; Console handle
    mov rdx, hello      ; Pointer to string
    mov r8, hello_len   ; Number of characters to write
    mov r9, 0           ; Reserved (must be 0)
    push 0              ; Reserved parameter (lpReserved)
    sub rsp, 32         ; Shadow space for function call
    call WriteConsoleA
    add rsp, 40         ; Clean up stack (32 + 8 for pushed parameter)

    ; Exit program
    mov rcx, 0          ; Exit code
    call ExitProcess