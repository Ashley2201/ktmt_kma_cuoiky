DSEG SEGMENT
    MSG1 DB "NHAP SO THAP PHAN: $" 
    OUTPUT1 DB 10, 13, "SO DO O DANG HEXA LA: $"
    OUTPUT2 DB 10, 13, "SO DO O DANG BIN (16 BIT) LA: $"
    STR DW 100 DUP('$')
    CHIA16 DW 16 
DSEG ENDS    

CSEG SEGMENT
   ASSUME CS:CSEG, DS:DSEG 
   START:
        MOV AX, DSEG
        MOV DS, AX
        
        MOV AH, 09
        LEA DX, MSG1
        INT 21H
        
        MOV AH, 10
        LEA DX, STR
        INT 21H 
        
        ; CHUYEN CHUOI THANH SO TRONG ASSEMBLY
        MOV CX, [STR + 1] ; DO DAI CHUOI SO VUA NHAP 
        MOV CH, 0
        LEA SI, STR + 2   ; TRO DEN CHU SO DAU TIEN
        MOV AX, 0
        MOV BX, 10
        
        STRTONUM:
            MUL BX
            MOV DL, [SI]
            SUB DL, '0'
            ADD AX, DX
            INC SI
            LOOP STRTONUM
            MOV STR, AX
            
            
        ; CHUYEN THANH SO THAP LUC PHAN 
        MOV AH, 09H
        LEA DX, OUTPUT1
        INT 21H
               
        XOR AX, AX
        MOV AX, STR
        XOR CX, CX
        LAP1:
            XOR DX, DX
            DIV CHIA16
            
            CMP DL, 09H
            JA CHUCAI
            
            ADD DL, 30H
            JMP SO
            
            CHUCAI:
                ADD DL, 37H
            
            SO: 
                PUSH DX
                INC CX
                CMP AX, 0
                JNE LAP1
         HIENTHI:
            POP DX
            MOV AH, 02H
            INT 21H
            LOOP HIENTHI
         MOV DX, 'H'
         INT 21H
            
        ; CHUYEN THANH SO NHI PHAN
            
            MOV BX, STR 
            MOV AH, 09H
            LEA DX, OUTPUT2
            INT 21H
    
        MOV CX, 16
        BINOUT:
            MOV DL, 0
            SHL BX, 1
            RCL DL, 1
            ADD DL, 30H
            MOV AH, 02H
            INT 21H
            LOOP BINOUT
        
        MOV AH, 08H
        INT 21H 
               
        MOV AH, 4CH
        INT 21H
        
CSEG ENDS
END START