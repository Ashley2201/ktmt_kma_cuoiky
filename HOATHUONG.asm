DSEG SEGMENT
    MANG DB 50 DUP('$')
    TBAO1 DB "NHAP CHUOI:$"
    TBAO2 DB 10, 13, "CHUOI THUONG:$"
    TBAO3 DB 10, 13, "CHUOI HOA:$"
DSEG ENDS
CSEG SEGMENT
    ASSUME CS:CSEG, DS:DSEG
    START:
        MOV AX, DSEG
        MOV DS, AX
        
        MOV AH, 09H
        LEA DX, TBAO1
        INT 21H
        
        MOV AH, 0AH
        LEA DX, MANG
        INT 21H
    
        LEA SI, MANG+2
        MOV CL, [MANG+1]
        
        KTT:
            CMP [SI], 'Z'
            JA BOQUA
            
            ADD [SI], 32
            BOQUA: INC SI
            LOOP KTT
        
        MOV AH, 09H
        LEA DX, TBAO2
        INT 21H
        
        MOV AH, 09H
        LEA DX, MANG+2
        INT 21H
            
        LEA SI, MANG+2
        XOR CX, CX
        MOV CL, [MANG + 1]
            
        KTH:
            CMP [SI], 'a'
            JB BOQUA1
            
            SUB [SI], 32
            BOQUA1: INC SI
            LOOP KTH
        
        MOV AH, 09H
        LEA DX, TBAO3
        INT 21H

        MOV AH, 09H
        LEA DX, MANG+2
        INT 21H
        
        MOV AH, 08H
        INT 21H    
             
        MOV AH, 4CH
        INT 21H
CSEG ENDS
END START