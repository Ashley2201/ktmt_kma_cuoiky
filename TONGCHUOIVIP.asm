DSEG SEGMENT
    MSG1 DB 10,13, "NHAP CHUOI SO(VD: '-12 23 44'): $"
    MSG2 DB 10,13, "TONG CAC PHAN TU TRONG CHUOI SO: $"
    STR DB 100 DUP("$")
    TMP DW ?
    SUM1 DW ?  ;TONG DUONG
    SUM2 DW ?  ;TONG AM
CSEG SEGMENT
    ASSUME CS:CSEG, DS:DSEG
    START:
        MOV AX, DSEG
        MOV DS, AX       
        
        ; IN THONG BAO NHAP CHUOI SO
        MOV AH,09H
        LEA DX, MSG1
        INT 21H
        ; NHAP CHUOI SO 
        MOV AH, 0AH
        LEA DX, STR
        INT 21H
        ;IN THONG BAO TONG CHUOI SO
        MOV AH, 09H
        LEA DX, MSG2
        INT 21H
        
        ;TINH TONG CHUOI SO
        MOV CX, 0
        MOV CL, [STR + 1]  ; CHUYEN DO DAI CUA CHUOI VAO CL
        LEA SI, [STR + 2]  ; LAY DIA CHI KY TU DAU TIEN LUU VAO SI
        MOV BX, 10
        MOV AX, 0
        MOV SUM1, AX 
        MOV SUM2, AX
        
        CALC:
            MOV DX,[SI]
            CMP DL,'-'
            JE NEXT1
            
            MOV DX,[SI]
            CMP DL, 20H
            JE NEXT2
            
            MOV DL, [SI]
            CMP DL, '9'
            JA NEXTD
            
            MUL BX
            MOV DX,[SI]
            MOV DH,0
            SUB DL,30H
            ADD AX,DX
            JMP NEXTLOOP
        
        NEXTD:
            INC SI
            SUB CX, 1
            MOV DL, [SI]
            CMP DL, 0DH
            JE TINH
            
            MOV DL, [SI]
            CMP DL, 20H
            JE NEXTLOOP
            JMP NEXTD
        
        NEXT1:
            INC TMP
            JMP NEXTLOOP
            
        NEXT2:
            CMP TMP,0
            JNE TRU
            JMP CONG
            
            TRU:
                MOV TMP, 0 
                ADD SUM2, AX
                MOV AX, 0
                JMP NEXTLOOP  
           
            CONG:
                ADD SUM1, AX
                MOV AX, 0
                JMP NEXTLOOP    
                

        NEXTLOOP:     
            INC SI
            LOOP CALC
            
            TINH: CMP TMP, 0
            JNE TRU2
            JMP CONG2
            
            TRU2:
                ADD SUM2, AX
                JMP DONE  
           
            CONG2:
                ADD SUM1, AX
                JMP DONE  
        
        DONE: 
        
        MOV AX, SUM1
        MOV BX, SUM2
        
        CMP AX, BX
        JAE TONGDUONG
        
        MOV DX, SUM2
        SUB DX, AX
        MOV TMP, DX
        
        MOV AH, 02H
        MOV DL, '-'
        INT 21H
        
        MOV AX, TMP
        
        CALL PRINT
        JMP THOAT  
           
        TONGDUONG:
            MOV DX, AX
            SUB DX, BX
            MOV AX, DX
            CALL PRINT 
            
        THOAT:
            MOV AH, 08H
            INT 21H
            MOV AH, 4CH
            INT 21H
CSEG ENDS 
   PRINT PROC
        MOV BX, 10
        MOV CX, 0
        
        CHIA10:
            MOV DX, 0
            DIV BX    ; AX = AX / BX, DX = DX % BX
            PUSH DX   ; DAY DX VAO STACK
            INC CX
            CMP AX, 0
            JE HIENTHI
            JMP CHIA10
            
            HIENTHI:
                POP DX     ; LAY DX TU STACK
                ADD DL, 30H
                MOV AH, 2
                INT 21H
                DEC CX
                CMP CX,0
                JNE HIENTHI
                RET
    PRINT ENDP
END START