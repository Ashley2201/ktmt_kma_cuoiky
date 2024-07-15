WRITE MACRO BIEN1
    MOV AH, 09H
    LEA DX, BIEN1
    INT 21H
ENDM 

DSEG SEGMENT
    STRING DB 50
    TB1 DB 10, 13, "   CO KY TU TRONG CHUOI $"
    TB2 DB 10, 13, "KHONG CO KY TU TRONG CHUOI $" 
    TB3 DB 10, 13, "NHAP VAO KY TU CAN TIM: $"
    TB4 DB "NHAP VAO CHUOI: $" 
    TB5 DB 10, 13, "$"
    WORD DB ?
DSEG ENDS 

CSEG SEGMENT
    ASSUME CS:CSEG, DS:DSEG
    BEGIN: 
        MOV AX, DSEG
        MOV DS, AX
        
        WRITE TB4
        
        MOV AH, 0AH
        LEA DX, STRING
        INT 21H
        
        WRITE TB3
        
        MOV AH, 01H
        INT 21H
        
        MOV WORD, AL
        
        LEA SI, STRING + 2
        MOV CL, [STRING + 1]
        
        TIMKIEM:
            MOV BL, WORD
            CMP BL, [SI]
            JE INTB1
            INC SI
            LOOP TIMKIEM
        
        JMP INTB2
        
        INTB1:
            WRITE TB5 
            WRITE TB1
        JMP THOAT
        
        INTB2: WRITE TB2
        
        THOAT: 
            MOV AH,08H ; DUNG MAN HINH DE XEM KET QUA
            INT 21H
            MOV AH, 4CH ; THOAT VE DOS
            INT 21H
CSEG ENDS
END BEGIN