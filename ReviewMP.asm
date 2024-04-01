section .data
    input_alert db "Enter password: ", 0
    weak_msg_alert db "Weak password", 0
    strong_msg_alert db "Strong password", 0
    newline db 10

section .bss
    input resb 100
    length resb 1

section .text
    global _start

_start:
    mov eax, 4             
    mov ebx, 1             
    mov ecx, input_alert        
    mov edx, 15          
    int 0x80

    mov eax, 3             
    mov ebx, 0             
    mov ecx, input      
    mov edx, 100           
    int 0x80

    mov ecx, input
    mov eax, 0
        
count_loop:
    cmp byte [input + eax], 0  
    je count_finish
    inc eax                  
    jmp count_loop

count_finish:
    mov [length], al         

    cmp byte [length], 8     
    jl weak_password
    jge strong_password         

strong_password:
    mov eax, 4              
    mov ebx, 1              
    mov ecx, strong_msg_alert    
    mov edx, 16             
    int 0x80
    jmp end_prog        

weak_password:
    mov eax, 4              
    mov ebx, 1              
    mov ecx, weak_msg_alert     
    mov edx, 13            
    int 0x80
    jmp end_prog

end_prog:
    mov eax, 4              
    mov ebx, 1              
    mov ecx, newline        
    mov edx, 1              
    int 0x80

    mov eax, 1              
    xor ebx, ebx            
    int 0x80
