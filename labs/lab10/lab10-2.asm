;--------------------------------
; Запись в файл строки введененой на запрос
;--------------------------------

%include 'in_out.asm'
SECTION .data
filename db 'name.txt', 0h ; Имя файла
msg db 'Как вас зовут: ', 0h ; Сообщение
prefix db 'Меня зовут ', 0h ; Сообщение

SECTION .bss
contents resb 255 ; переменная для вводимой строки

SECTION .text
    global _start
_start:

; --- Печать сообщения `msg`
    mov eax,msg
    call sprint

; ---- Запись введеной с клавиатуры строки в `contents`
    mov ecx, contents
    mov edx, 255
    call sread

; --- Создание и открытие файла (`sys_creat`)
    mov ecx, 0777o ; Создание файла.
    mov ebx, filename ; в случае успешного создания файла,
    mov eax, 8 ; в регистр eax запишется дескриптор файла
    int 80h

; --- Запись дескриптора файла в `esi`
    mov esi, eax

; --- Расчет длины префикса
    mov eax, prefix ; в `eax` запишется количество
    call slen ; введенных байтов

; --- Записываем в файл `prefix` (`sys_write`)
    mov edx, eax
    mov ecx, prefix
    mov ebx, esi
    mov eax, 4
    int 80h
   
; --- Расчет длины введенной строки
    mov eax, prefix ; в `eax` запишется количество
    call slen ; введенных байтов

; --- Записываем в файл `contents` (`sys_write`)
    mov edx, eax
    mov ecx, contents
    mov ebx, esi
    mov eax, 4
    int 80h

; --- Закрываем файл (`sys_close`)
    mov ebx, esi
    mov eax, 6
    int 80h
call quit
