DSEG SEGMENT
    TB1 DB "NHAP TEN TEP TIN: $"
    TB2 DB 10, 13, "NOI DUNG TEP TIN: $"
    TENFILE DB 200 DUP('$')
    THEFILE DW ?
    READER DB 251 DUP('$')
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
        LEA DX, TENFILE
        INT 21H
        
        MOV AH, 09H
        LEA DX, TB2
        INT 21H
        
        XOR CX, CX
        LEA SI, TENFILE+2
        MOV CL, [TENFILE+1]
        ADD SI, CX
        MOV [SI], CH

        MOV AH, 3DH
        LEA DX, TENFILE+2
        MOV AL, 2
        INT 21H
        MOV THEFILE, AX 
        
        XOR CX, CX
        XOR SI, SI
        MOV CL, [TENFILE+1]
        CLEAN_LOOP:
            MOV BYTE PTR [READER + SI], '$'
            INC SI
            LOOP CLEAN_LOOP
        
        MOV AH, 3FH
        MOV BX, THEFILE
        LEA DX, READER
        MOV CX, 250
        INT 21H
        
        MOV AH, 09H
        LEA DX, READER
        INT 21H
        
        MOV AH, 3EH
        MOV BX, THEFILE
        INT 21H
        
        MOV AH, 08H
        INT 21H
        
        MOV AH, 4CH
        INT 21H
CSEG ENDS
END START