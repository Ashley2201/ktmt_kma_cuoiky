DSEG SEGMENT
   MSG1 DB "NHAP VAO CHUOI SO(VD -2 3 10): $"
   MSG2 DB 10,13,"SO CAC SO NGUYEN TO TRONG CHUOI LA: $"
   STR DB 100 DUP('$')
   DEM DW ?
   AM DW ?
   TMP DW ?
DSEG ENDS

CSEG SEGMENT
    ASSUME CS:CSEG, DS:DSEG
    START:

        MOV AX, DSEG
        MOV DS, AX
        
        MOV AH, 09H
        LEA DX, MSG1
        INT 21H
        
        MOV AH, 0AH
        LEA DX, STR
        INT 21H
        
        MOV CX, 0
        MOV CL, [STR+1]
        LEA SI, [STR+2]
        
        MOV BX, 10
        MOV AX, 0
        
        CALC:
            MOV DX, [SI]
            CMP DL, '-'
            JE NEXT1
            
            MOV DX, [SI]
            CMP DL, 20H
            JE NEXT2
            
            MOV DX, [SI]
            CMP DL, '9'
            JA NEXTD
            
            MUL BX
            MOV DX, [SI]
            MOV DH, 0
            SUB DL, 30H
            ADD AX, DX
            MOV TMP, AX
            JMP NEXTLOOP
            
            NEXTD:
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
                INC AM
                JMP NEXTLOOP
                
            NEXT2:
                CMP AM, 0
                JNE RESET
                
                CMP TMP, 1
                JE RESET
                MOV BX, 1
                
                CHIA:
                    MOV DX, 0
                    MOV AX, TMP
                    INC BX
                    DIV BX
                    CMP DL, 0
                    JNE CHIA 
                    
                    CMP BX, TMP
                    MOV AX ,0
                    JE TANGDEM
                    JMP NEXTLOOP
                
                RESET:
                    MOV AM, 0
                    MOV TMP, 0 
                    MOV AX, 0
                    JMP NEXTLOOP
                    
                TANGDEM:
                    INC DEM
                    JMP NEXTLOOP
             
            NEXTLOOP:
                MOV BX, 10
                INC SI
                LOOP CALC
                
                CMP AM, 0
                JNE DONE
                MOV BX, 1
                
                CHIA2:
                    MOV DX, 0
                    MOV AX, TMP
                    INC BX
                    DIV BX
                    CMP DL, 0
                    JNE CHIA2
                    
                    CMP BX, TMP
                    MOV AX, 0
                    JE TANGDEM2
                    JMP DONE
                
                TANGDEM2:
                    INC DEM
                    JMP DONE
            
            DONE: 
                 
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
            MOV BX, 10
            MOV CX, 0
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
                        MOV AH, 2
                        INT 21H
                        LOOP HIENTHI
                        
           RET  
      PRINT ENDP 
END START