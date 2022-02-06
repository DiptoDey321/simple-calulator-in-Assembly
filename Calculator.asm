INCLUDE "EMU8086.INC"
.MODEL SMALL
.STACK 100H
.DATA

VAR DB ?
PLUS DB "+" 
MINUS DB "-"  
MULTI DB "*"
DIVIDED DB "/"
POWER DB "^"
MODULUS DB "%" 

YES DB "Y"
NO DB "N"


VAR1 DW ?
VAR2 DW ? 

NUM1 DB ?
NUM2 DB ? 
MULTIRES DB ?
 

.CODE
MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX
    
    YESNO:
    PRINTN " "
    PRINT "ENTER WHAT OPERATION YOU WANT TO DO : "  
    MOV AH,1
    INT 21H
    MOV BL,AL
    
    CMP BL,PLUS
    JE ADDITION
     
    CMP BL,MINUS
    JE SUBTRUCTION 
    
    CMP BL,MULTI
    JE MULTIP
    
    CMP BL,DIVIDED
    JE DIVI
    
    CMP BL,POWER
    JE POW  
    
    CMP BL,MODULUS
    JE MODU 
    
    JNE BAD
    
    
    ;FOR MODULAS OPERATION
    MODU:
    PRINTN " " 
    PRINT "ENTER THE FIRST NUMBER: "
    MOV AH,1
    INT 21H
    MOV NUM1,AL
    SUB NUM1,48
    
    PRINTN " "
    PRINT "ENTER THE SECOND NUMBER: " 
    INT 21H
    MOV NUM2,AL
    SUB NUM2,48
    
    MOV AH,00H 
    
    MOV AL, NUM1 
    MOV BH,NUM2
    DIV BH
    MOV BL,AH
    ADD BL,30H
    
    
    PRINTN " "
    PRINT "RESULT : "
    MOV AH,2
    MOV DL,BL 
    INT 21H
    JMP AGAINORCLOSE 
    
    
    
    
    
    POW:
    PRINTN " "
    PRINT "ENTER NUMBER: " 
    MOV AH,1
    INT 21H
    SUB AL,30H
    MOV NUM1,AL     
    
    MUL NUM1
    MOV MULTIRES,AL
    AAM 
    
    ADD AH,30H
    ADD AL,30H
    MOV BX,AX 
    
    PRINTN " "
    PRINT "RESULT :"
    MOV AH,2
    MOV DL,BH
    INT 21H
    
    MOV AH,2
    MOV DL,BL
    INT 21H

    JMP AGAINORCLOSE 
    
    
    
    
    
    
     
    ;FOR DIVISION OPERATION  
    DIVI:
     
    PRINTN " "
    PRINT "ENTER THE FIRST NUMBER: "  
    MOV AH,1
    INT 21H
    SUB AL,30H
    MOV NUM1,AL
     
    PRINTN " "
    PRINT "ENTER THE SECOND NUMBER: "
    MOV AH,1
    INT 21H
    SUB AL,30H
    MOV NUM2,AL
    
    MOV CL,NUM1
    MOV CH,00 ; TO PREVENT THE OVERFLOW
    MOV AX,CX  
    
    DIV NUM2 ;DIVIDED BY AX
    MOV MULTIRES,AL
    MOV AH, 00
    AAD  
     
    ADD AH,30H
    ADD AL,30H
    
    MOV BX,AX 
    
    PRINTN " "
    PRINT "RESULT :" 
    
    MOV AH,2
    MOV DL,BH
    INT 21H
    
    MOV AH,2
    MOV DL,BL
    INT 21H
    JMP AGAINORCLOSE
        
       
    
    
        
        
        
    ;FOR MULIPLICATION OPERATION
    MULTIP:
    PRINTN " "
    PRINT "ENTER THE FIRST NUMBER: " 
    MOV AH,1
    INT 21H
    SUB AL,30H
    MOV NUM1,AL 
    
    PRINTN " "
    PRINT "ENTER THE SECOND NUMBER: " 
    MOV AH,1
    INT 21H
    SUB AL,30H 
    
    MUL NUM1
    MOV MULTIRES,AL
    AAM 
    
    ADD AH,30H
    ADD AL,30H
    MOV BX,AX 
    
    PRINTN " "
    PRINT "RESULT :"
    MOV AH,2
    MOV DL,BH
    INT 21H
    
    MOV AH,2
    MOV DL,BL
    INT 21H
    JMP AGAINORCLOSE
    
     
     
     
    
 
    
    ;FOR SUBTRACTION OPERATION
    SUBTRUCTION: 
    PRINTN " "
    PRINT "ENTER THE FIRST NUMBER: "
    MOV AH,1
    INT 21H
    MOV VAR1,AX
    SUB VAR1,48
    
    PRINTN " "
    PRINT "ENTER THE SECOND NUMBER: " 
    INT 21H
    MOV VAR2,AX
    SUB VAR2,48
    
    MOV DX,VAR1
                     
    SUB DX,VAR2
    ADD DX,48
    
    PRINTN " "
    PRINT "RESULT :"
    MOV AH,2
    INT 21H
    JMP AGAINORCLOSE 
    
    
    
     
     
     
    
    ;FOR ADDITION OPERATION
    ADDITION:
    PRINTN " "
    PRINT "ENTER THE FIRST NUMBER: "
    
    MOV AH,1
    INT 21H
    MOV BL,AL 
    
    PRINTN " "
    PRINT "ENTER THE SECOND NUMBER: " 
    
    MOV AH,1
    INT 21H
    
    ADD AL,BL
    MOV AH,0
    AAA
    
    MOV BX,AX 
    ADD BH,48
    ADD BL,48 
    PRINTN " "
    PRINT "RESULT :"
    MOV AH,2
    MOV DL,BH
    INT 21H
    
    MOV AH,2
    MOV DL,BL
    INT 21H
    JMP AGAINORCLOSE  
    
    
    
    
    
    ;FOR WORNG OPERATION
    BAD: 
    PRINTN " "
    PRINT "WRONG OPERATION"
    JMP EXIT 
    
     
    
    AGAINORCLOSE:
    PRINTN " "
    PRINT "ARE YOU WANT TO USE IT AGAIN ? Y/N  "
    MOV AH,1
    INT 21H
    MOV BL,AL
    CMP BL,YES
    JE YESNO
    JNE EXIT 
    
    
    
    EXIT:
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN