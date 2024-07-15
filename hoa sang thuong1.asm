DSEG SEGMENT 
    STR DB 50 DUP('$')
    TB1 DB "NHAP CHUOI KY TU: $"
    TB2 DB 10, 13, "CHUOI KY TU THUONG: $"
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
        
        LEA SI, STR+2
        MOV CL, [STR+1]
        
        THUONGTOHOA:
            CMP [SI], 'Z'
            JA BOQUA
            
            ADD [SI], 32
            
            BOQUA:
            INC SI
            LOOP THUONGTOHOA
            
        MOV AH, 09H
        LEA DX, TB2
        INT 21H
        
        MOV AH, 09H
        LEA DX, STR+2
        INT 21H
        
        MOV AH, 08H
        INT 21H
        
        MOV AH, 4CH
        INT 21H
CSEG ENDS
END START