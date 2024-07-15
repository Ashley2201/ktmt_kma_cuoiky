INCHUOI MACRO CHUOI
    MOV AH, 09H
    LEA DX, CHUOI
    INT 21H
ENDM

DSEG SEGMENT
    TB1 DB 10, 13, "NHAP N <= 8: $"
    TB2 DB 10, 13, "KET QUA: N! = $"
    TB3 DB 10, 13, "NHAP LAI N! (0 =< N < 9)$"
    MUOI DW 10
DSEG ENDS

CSEG SEGMENT
    ASSUME CS:CSEG, DS: DSEG
    START:
        MOV AX, DSEG
        MOV DS, AX
        
        NHAP:
            INCHUOI TB1
            MOV AH, 01H
            INT 21H
            
            CMP AL, 39H
            JAE INTB3
            
            CMP AL, 30H
            JB INTB3
            
            JMP CONTINUE
        
        INTB3:
            INCHUOI TB3
            JMP NHAP
        
        CONTINUE:
            SUB AL, 30H
            XOR CX, CX
            MOV CL, AL
        
        INCHUOI TB2
        
        MOV AX, 1
        MOV BX, 1 
        
        GIAITHUA:
            MUL BX
            INC BX
            CMP BX, CX
            JLE GIAITHUA
        
        XOR CX, CX
        
        CHUYENDOI:
            XOR DX, DX
            DIV MUOI
            ADD DX, 30H
            PUSH DX
            INC CX
            CMP AX, 0
            JNE CHUYENDOI
            
        HIENTHI:
            POP DX
            MOV AH, 02H
            INT 21H 
            LOOP HIENTHI
        
        THOAT:
            MOV AH, 08H
            INT 21H
            
            MOV AH, 4CH
            INT 21H
CSEG ENDS
END START