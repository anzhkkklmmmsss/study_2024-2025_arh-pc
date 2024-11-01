%include  'in_out.asm'
SECTION .data
msg: DB 'Вычисление f(x) =  5(x + 18) − 28. Введите x: ',0
rem: DB 'Результат: ',0

SECTION .bss
x:  RESB 80

SECTION .text
GLOBAL _start
 _start:
 mov eax, msg
 call sprintLF
 mov ecx, x
 mov edx, 80
 call sread

 mov eax,x  ; вызов подпрограммы преобразования
 call atoi  ; ASCII кода в число, `eax=x`

 add eax,18  ; eax += 18

 mov ebx,5
 mul ebx     ; eax = eax * ebx

 sub eax,28  ; eax -= 28

 mov edi,eax ; запись результата вычисления в edi

 mov eax,rem   ; вызов подпрограммы печати
 call sprint   ; сообщения 'Результат: '
 mov eax,edi   ; вызов подпрограммы печати значения
 call iprintLF ; из 'edi' в виде символов
 call quit
