DSEG SEGMENT 
    TB1 DB "NHAP TEN FILE: $"
    TB2 DB 10, 13, "NHAP TEN MOI CHO FILE: $"
    TENFILE DB 100 DUP('$')
    THEFILE DW ?
    TENMOI DB 100 DUP('$')
DSEG ENDS

CSEG SEGMENT
    ASSUME CS:CSEG, DS:DSEG, ES:DSEG
    START:
        MOV AX, DSEG
        MOV DS, AX
        MOV ES, AX
        
        MOV AH, 09H
        LEA DX, TB1
        INT 21H
        
        MOV AH, 0AH
        LEA DX, TENFILE
        INT 21H
        
        XOR CX, CX
        LEA SI, TENFILE+2
        MOV CL, [TENFILE+1]
        ADD SI, CX
        MOV [SI], CH
        
        MOV AH, 09H
        LEA DX, TB2
        INT 21H
        
        MOV AH, 0AH
        LEA DX, TENMOI
        INT 21H
        
        XOR CX, CX
        LEA SI, TENMOI+2
        MOV CL, [TENMOI+1]
        ADD SI, CX
        MOV [SI], CH
        
        MOV AH, 56H
        LEA DX, TENFILE+2
        LEA DI, TENMOI+2
        INT 21H
        
        MOV AH, 4CH
        INT 21H
CSEG ENDS
END START
        