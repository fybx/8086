.MODEL SMALL    ; use the small memory model
.STACK 100H     ; set aside 256 bytes for the stack
.DATA           ; start the data segment

; define two strings: STR1 and STR2
STR1 DB ' Bursa Uludag University' , '$'  ; the original string
STR2 db 50 dup ('$')                    ; the destination string

.CODE           ; start the code segment
MAIN PROC FAR   ; define the main procedure

; set up the data segment register (DS) and load the source address into SI
MOV BL,00H      ; clear BL to use it as a counter
MOV AX, @DATA   ; get the address of the data segment
MOV DS, AX      ; set DS to the data segment
MOV SI, OFFSET STR1  ; load the address of STR1 into SI

; load the destination address into DI and copy the string
MOV DI, OFFSET STR2  ; load the address of STR2 into DI
L2: MOV DL, [SI]      ; load the byte at the source address into DL
CMP Dl, '$'          ; compare DL to '$'
JE L1                ; jump to L1 if DL is '$'
INC SI               ; increment the source address
INC BL               ; increment the counter
JMP L2               ; jump back to L2
L1: MOV CL, BL        ; move the counter into CL
MOV CH, 00H          ; clear CH
DEC SI               ; decrement SI to point to the last character in STR1
L3: MOV AL, [SI]      ; load the byte at the source address into AL
MOV [DI], AL         ; store the byte at the destination address
DEC SI               ; decrement the source address
INC DI               ; increment the destination address
LOOP L3             ; loop back to L3 until CX (CL and CH) is zero

; display the copied string on the screen
MOV AH,09H          ; set AH to 09H to display a string
MOV DX, OFFSET STR2 ; load the offset of STR2 into DX
INT 21H             ; call interrupt 21H to display the string

; exit the program
MOV AX, 4C00H       ; set AX to 4C00H to indicate the program should exit
INT 21H             ; call interrupt 21H to exit the program

MAIN ENDP         ; end the main procedure
END MAIN          ; end the program