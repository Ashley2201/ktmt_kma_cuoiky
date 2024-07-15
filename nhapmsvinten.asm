INCHUOI MACRO CHUOI
    MOV AH, 09H
    LEA DX, CHUOI
    INT 21H
ENDM

DSEG SEGMENT
    MSV DB "AT180603"
    TB1 DB 10, 13, "NHAP MA SINH VIEN: $"
    TB2 DB 10, 13, "MA SINH VIEN SAI, NHAP LAI$"
    TB3 DB 10, 13, "TUOI CUA SINH VIEN: 21$"
DSEG ENDS

CSEG SEGMENT
    ASSUME CS:CSEG, DS:DSEG
    START:
        MOV AX, DSEG
        MOV DS, AX
        
        NHAP: INCHUOI TB1
        
        XOR CX, CX
        MOV CX, 8
        LEA SI, MSV 
        
        SOSANH:
            MOV AH, 01H
            INT 21H 
            
            CMP [SI], AL
            JNE INTB2
            INC SI
            
            LOOP SOSANH
            
        INCHUOI TB3
        JMP THOAT
        
        INTB2: 
            INCHUOI TB2
            JMP NHAP
            
        THOAT: 
            MOV AH, 08H
            INT 21H
            
            MOV AH, 4CH
            INT 21H
CSEG ENDS
END START
    