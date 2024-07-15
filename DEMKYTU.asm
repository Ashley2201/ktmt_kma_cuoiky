DSEG SEGMENT
    STR DB 50 DUP('$')
    TB1 DB "NHAP CHUOI: $"
    TB2 DB 10, 13, "SO KY TU TRONG CHUOI: $"
    MUOI DW 10
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
        
        XOR CX, CX
        
        LEA SI, STR+2
        
        DEM:
            CMP [SI], 0DH
            JE THOAT
            
            INC CX
            INC SI
            JMP DEM
        
        THOAT:
            MOV AX, CX
            XOR CX, CX
            
            CHIA:
                XOR DX, DX
                DIV MUOI
                
                PUSH DX
                INC CX
                
                CMP AX, 0
                JNZ CHIA
                
                JMP HIENTHI
            HIENTHI:
                POP DX
                ADD DL, 30H
                MOV AH, 02H
                INT 21H
                LOOP HIENTHI
            MOV AH, 08H
            INT 21H
            
            MOV AH, 4CH
            INT 21H
CSEG ENDS
END START