.MODEL SMALL
.STACK 100H
.DATA   
   MSG1 DB 10,13, "NHAP VAO CHUOI SO (VD -12 23 34): $"
   MSG2 DB 10,13, "SO LUONG PHAN TU AM TRONG CHUOI LA: $"
   MSG3 DB 10,13, "SO LUONG PHAN TU DUONG TRONG CHUOI LA: $"
   STR DB 100 DUP('$')
   DEMAM DW ? 
   DEMDUONG DW ? 
   SO0 DW ?
   TMP DW ?
.CODE
   MAIN PROC
    MOV AX,DATA
    MOV DS,AX

    MOV AH,9
    LEA DX,MSG1
    INT 21H
    
    MOV AH,0AH
    LEA DX,STR
    INT 21H
    
    MOV AH,9
    LEA DX,MSG2
    INT 21H
    
    MOV CX,0
    MOV CL,[STR+1]
    LEA SI,[STR+2]
    
    MOV BX,10
    MOV AX,0
    
    LOOP1:
        MOV DX,[SI]
        CMP DL, '-'
        JE NEXT1     
        
        MOV DX,[SI]
        CMP DL, 20H
        JE NEXT2
        
        MOV DX, [SI]
        CMP DL, '9'
        JA NEXTD
        
        MUL BX
        MOV DX,[SI]
        MOV DH,0
        SUB DL,30H
        ADD AX,DX 
        JMP NEXTLOOP
        
        NEXTD:
            MOV TMP, 0
            INC SI 
            SUB CX, 1
            MOV DX, [SI]
            CMP DL, 20H
            JE NEXTLOOP
            
            MOV DX, [SI]
            CMP DL, 0DH
            JE DONE
            JMP NEXTD
        
        NEXT1:
            MOV TMP,1
            JMP NEXTLOOP
    
        NEXT2:    
            CMP TMP,1 
            JE TANGAM
            CMP AX,0
            JNE TANGDUONG
            JMP NEXTLOOP
            
            TANGAM:
                INC DEMAM
                MOV TMP,0
                JMP NEXTLOOP
                
            TANGDUONG:
                INC DEMDUONG
                MOV AX,0 
                JMP NEXTLOOP
                   
        NEXTLOOP:
            INC SI
            LOOP LOOP1    

            CMP TMP,1
            JE TANGAM2
            CMP AX,0 
            JNE TANGDUONG2 
            JMP DONE
             
            TANGAM2:
                INC DEMAM
                JMP DONE  
            
            TANGDUONG2:
                INC DEMDUONG 
                JMP DONE
            DONE:
            
         MOV AX,DEMAM
         CALL PRINT
         
         MOV AH,9
         LEA DX,MSG3
         INT 21H
         
         MOV AX,DEMDUONG
         CALL PRINT
       
       MOV AH, 08H
       INT 21H
            
       MOV AH,4CH
       INT 21H     
                   
   MAIN ENDP   
   
   PRINT PROC 
        MOV BX,10
        MOV CX,0
  
        CHIA:
            MOV DX,0
            DIV BX
            PUSH DX
            INC CX
            CMP AX,0
            JNE CHIA
            JMP HIENTHI
            
            HIENTHI:
                POP DX
                ADD DL,30H
                MOV AH,02
                INT 21H
                LOOP HIENTHI 
                
            RET
   PRINT ENDP
END