%include 'in_out.asm'

section .data
    msg1 db 'Введите A: ',0h
	msg2 db 'Введите x: ',0h
	msg_res db 'Результат: ',0h

section .bss
	res resb 10
	A resb 10
	x resb 10
section .text
global _start
_start:

; ---------- Вывод сообщения 'Введите A: '
mov eax,msg1
call sprint
; ---------- Ввод 'A'
mov ecx,A
mov edx,10
call sread
; ---------- Преобразование 'A' из символа в число
mov eax,A
call atoi ; Вызов подпрограммы перевода символа в число
mov [A],eax ; запись преобразованного числа в 'A'

; ---------- Вывод сообщения 'Введите B: '
mov eax,msg2
call sprint
; ---------- Ввод 'x'
mov ecx,x
mov edx,10
call sread
; ---------- Преобразование 'x' из символа в число
mov eax,x
call atoi ; Вызов подпрограммы перевода символа в число
mov [x],eax ; запись преобразованного числа в 'x'

; ---------- Сравниваем 'A' и 2

mov ecx, 2
cmp ecx,[x] ; Сравниваем 'X' и 2
jg check_B ; если 'A>2', то переход на метку 'check_B',
mov eax,[A] ; иначе 'f = ax'
mov ecx, 3
mul ecx
mov [res], eax
jmp fin

; ---------- Вычитание '2 из X' 
check_B:
mov eax, [A]
sub eax, 2
mov [res], eax
jmp fin

; ---------- Вывод результата
fin:
mov eax, msg_res
call sprint ; Вывод сообщения 'Результат: '
mov eax,[res]
call iprintLF ; Вывод 'f(x)='
call quit ; Выход
