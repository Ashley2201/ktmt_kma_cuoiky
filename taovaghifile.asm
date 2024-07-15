INCHUOI MACRO CHUOI
    MOV AH, 09H
    LEA DX, CHUOI
    INT 21H
ENDM

DSEG SEGMENT
    TB1 DB 10, 13, "NHAP TEN FILE: $"
    TB2 DB "NHAP CHUOI CAN GHI: $"
    STR DB 50 DUP('$')
    THEFILE DW ?
    TENFILE DB 200
DSEG ENDS

CSEG SEGMENT
    ASSUME CS:CSEG, DS:DSEG
    START:
        MOV AX, DSEG
        MOV DS, AX
        
        INCHUOI TB2
        
        MOV AH, 0AH
        LEA DX, STR
        INT 21H
        
        INCHUOI TB1

        MOV AH, 0AH
        LEA DX, TENFILE
        INT 21H
        
        XOR CX, CX
        MOV CL, [TENFILE+1]
        LEA SI, TENFILE+2
        ADD SI, CX
        MOV [SI], CH
        
        MOV AH, 3CH
        MOV CX, 0       ; Thuoc tinh file binh thuong
        LEA DX, TENFILE+2
        INT 21H
        MOV THEFILE, AX ; Luu handle cua file
        
        MOV AH, 3DH
        MOV BX, THEFILE
        MOV AL, 2       ; Che do ghi
        INT 21H
        
        MOV AH, 40H
        MOV CL, [STR+1] ; Lay do dai chuoi can ghi
        LEA DX, STR + 2
        INT 21H

        MOV AH, 3EH
        MOV BX, THEFILE
        INT 21H
        
        MOV AH, 4CH
        INT 21H

        MOV AH, 4CH
        INT 21H
CSEG ENDS
END START
