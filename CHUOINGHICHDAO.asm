DSEG SEGMENT
    STR DB 50 DUP('$')
    TB1 DB "NHAP CHUOI: $"
    TB2 DB 10, 13, "CHUOI NGHICH DAO: $"
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
        LEA DX, STR
        INT 21H
        
        MOV AH, 09H
        LEA DX, TB2
        INT 21H
        
        LEA SI, STR+2
        MOV CL, [STR+1]
        
        STACK:
            PUSH [SI]
            INC SI
            LOOP STACK
        
        MOV CL, [STR+1]
            
        NGHICHDAO:
            POP DX
            MOV AH, 02H
            INT 21H
            
            LOOP NGHICHDAO
        MOV AH, 08H
        INT 21H
        
        MOV AH, 4CH
        INT 21H
CSEG ENDS
END START