.MODEL small
.STACK
.DATA
    message db 'The value in AX is: $'
.CODE
main PROC
    mov ax,0F00h
    int 10h
    call print_word         ; call the print_word procedure
    mov ah, 4Ch             ; return control to DOS
    int 21h
main ENDP

print_word PROC
    push ax                 ; save the value of AX on the stack
    mov ah, 0               ; set AH to 0 to print the lower byte
    mov al, byte ptr [bp+2] ; load the lower byte of AX from the stack
    call print_hex          ; call the print_hex procedure to print the lower byte
    mov ah, 0               ; set AH to 0 to print the upper byte
    mov al, byte ptr [bp+4] ; load the upper byte of AX from the stack
    call print_hex          ; call the print_hex procedure to print the upper byte
    pop ax                  ; restore the original value of AX from the stack
    ret
print_word ENDP

print_hex PROC
    push ax                 ; save the value of AX on the stack
    mov bh, 0               ; set page number to 0
    mov bl, 10h             ; set attribute to bright green on black
    mov cx, 1               ; set count to 1
    mov ah, 0eh             ; set teletype function to print character
    mov al, '0'             ; print '0' character
    cmp al, 0               ; check if the value is zero
    jz skip_print           ; if it's zero, skip printing the character
print_loop:
    xor dx, dx              ; clear DX for division
    div cx                  ; divide by 16 to get the next digit
    add dl, '0'             ; convert the remainder to a character
    cmp dl, '9'             ; check if it's between '9' and 'A'
    jbe print_digit         ; if it's a digit, print it
    add dl, 7h              ; otherwise, convert to 'A'-'F'
print_digit:
    int 10h                 ; print the character on the screen
    cmp ax, 0               ; check if the value is zero
    jnz print_loop          ; if it's not zero, repeat the loop
skip_print:
    pop ax                  ; restore the original value of AX from the stack
    ret
print_hex ENDP

END main