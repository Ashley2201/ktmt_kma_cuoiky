DSEG SEGMENT              
    TB1 DB "NHAP TEN FILE: $"
    TENFILE DB 50 DUP('$')
    THEFILE DW ?
DSEG ENDS

CSEG SEGMENT
    ASSUME CS:CSEG, DS:DSEG
    START:
        MOV AX, DSEG
        MOV DS, AX
        
        MOV AH, 09H
        LEA DX, TB1
        INT 21H
        
        MOV AH, 0AH
        LEA DX, TENFILE  ;nhap ten file
        INT 21H
        
        XOR CX, CX
        LEA SI, TENFILE+2    ;cho si tro den ky tu dau tien
        MOV CL, [TENFILE+1]  ; cl = so luong ky tu trong tenfile
        ADD SI, CX           ;si tro vao ky tu cuoi cung
        MOV [SI], CH         ;cho ky tu cuoi cung = 0
        
        MOV AH, 3DH  ; mo file
        LEA DX, TENFILE+2
        MOV AL, 2
        INT 21H
        MOV THEFILE, AX ; lay the file
        
        MOV AH, 3EH  ; dong file
        MOV BX, THEFILE
        INT 21H
        
        MOV AH, 41H   ; xoa file
        MOV BX, THEFILE
        INT 21H
        
        MOV AH, 4CH
        INT 21H
CSEG ENDS
END START