DSEG SEGMENT
   MSG1 DB 10, 13, "NHAP VAO CHUOI SO (VD -12 23 34): $"
   MSG2 DB 10, 13, "SO LUONG SO CHIA HET CHO SO 5 LA: $"
   STR DB 60 DUP ("$") 
   N DW 10 DUP("$")
   DEM DW ?
DSEG ENDS

CSEG SEGMENT
    ASSUME CS:CSEG, DS:DSEG
    START:
       MOV AX, DSEG
       MOV DS, AX
       
       ;IN TB NHAP CHUOI
       MOV AH, 09H
       LEA DX, MSG1
       INT 21H
       
       ;NHAP CHUOI
       MOV AH, 0AH
       LEA DX, STR
       INT 21H
       
       ;XU LY:
       MOV CX, 0
       MOV CL, [STR+1]
       LEA SI, [STR+2]
       
       MOV BX, 10
       MOV AX, 0
       MOV DEM, AX
      
       LOOP1:
            MOV DX, [SI]
            CMP DL, '-'
            JE SOAM
            
            CMP DL, '9'
            JA NEXTD
            
            MOV DX, [SI]
            CMP DL, 20H
            JE NEXT1
           
            MUL BX
            MOV DX, [SI]
            MOV DH, 0
            SUB DL, 30H
            ADD AX, DX
            JMP NEXT2
            
            NEXTD:
                INC SI
                SUB CX, 1
                CMP [SI], 20H
                JE NEXT2
                
                CMP [SI], 0DH
                JE TINH
                JMP NEXTD
            
            TINH:
                MOV AX, 1
                JMP NEXT4
            
            SOAM:
                JMP NEXT2
                
            NEXT1:
                MOV DX, 0
                MOV BX, 5
                DIV BX
                CMP DX, 0
                JE TANGDEM
                
                MOV AX, 0
                MOV BX, 10
                JMP NEXT2
            
            TANGDEM:
                INC DEM
            
            NEXT2:
                INC SI
                LOOP LOOP1 
                
            NEXT4:
            MOV DX, 0
            MOV BX, 5
            DIV BX
            CMP DX, 0
            JE TANGDEM2
            JMP NEXT3
            
            TANGDEM2:
                INC DEM
            
            NEXT3:
                ;IN TB KQ
                MOV AH, 09H
                LEA DX, MSG2
                INT 21H
            
            CALL PRINT
            
            MOV AH, 08H
            INT 21H
            
            MOV AH, 4CH
            INT 21H
            
CSEG ENDS
   PRINT PROC
        MOV CX, 0
        MOV BX, 10
        MOV AX, DEM
        
        CHIA10:
            MOV DX, 0
            DIV BX
            PUSH DX
            INC CX
            CMP AX, 0
            JNE CHIA10
            JMP HIENTHI
            
                HIENTHI:
                    POP DX
                    ADD DL, 30H
                    MOV AH, 02H
                    INT 21H
                    DEC CX
                    CMP CX, 0
                    JNE HIENTHI
                    RET
    
   PRINT ENDP 
END START