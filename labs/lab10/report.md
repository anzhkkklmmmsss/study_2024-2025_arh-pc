---
## Front matter
title: "Лабораторная работа №10"
subtitle: "Работа с файлами
средствами Nasm"
author: "Тютрюмова Анжелина"

## Generic otions
lang: ru-RU
toc-title: "Содержание"

## Bibliography
bibliography: bib/cite.bib
csl: pandoc/csl/gost-r-7-0-5-2008-numeric.csl

## Pdf output format
toc: true # Table of contents
toc-depth: 2
fontsize: 12pt
linestretch: 1.5
papersize: a4
documentclass: scrreprt
## I18n polyglossia
polyglossia-lang:
  name: russian
  options:
	- spelling=modern
	- babelshorthands=true
polyglossia-otherlangs:
  name: english
## I18n babel
babel-lang: russian
babel-otherlangs: english
## Fonts
mainfont: IBM Plex Serif
romanfont: IBM Plex Serif
sansfont: IBM Plex Sans
monofont: IBM Plex Mono
mathfont: STIX Two Math
mainfontoptions: Ligatures=Common,Ligatures=TeX,Scale=0.94
romanfontoptions: Ligatures=Common,Ligatures=TeX,Scale=0.94
sansfontoptions: Ligatures=Common,Ligatures=TeX,Scale=MatchLowercase,Scale=0.94
monofontoptions: Scale=MatchLowercase,Scale=0.94,FakeStretch=0.9
mathfontoptions:
## Biblatex
biblatex: true
biblio-style: "gost-numeric"
biblatexoptions:
  - parentracker=true
  - backend=biber
  - hyperref=auto
  - language=auto
  - autolang=other*
  - citestyle=gost-numeric
## Pandoc-crossref LaTeX customization
figureTitle: "Рис."
tableTitle: "Таблица"
listingTitle: "Листинг"
## Misc options
indent: true
header-includes:
  - \usepackage{indentfirst}
  - \usepackage{float} # keep figures where there are in the text
  - \floatplacement{figure}{H} # keep figures where there are in the text
---

# Цель работы

Целью работы является приобретение навыков написания программ для работы с файлами.

# Выполнение лабораторной работы
Создала и перешла в директорию для лабораторной работы создала файл lab10-1.asm,
readme-1.txt и readme-2.txt (рис. [-@fig:001]).

![Папка для лабораторной работы](image/1.png){#fig:001 width=70%}

Переписала код с лабараторной работы. Создала исполняемый файл и запустила его.(рис. [-@fig:002]).

![Выполение программы](image/2.png){#fig:002 width=70%}

Листинг кода:

```
;--------------------------------
; Запись в файл строки введененой на запрос
;--------------------------------

%include 'in_out.asm'
SECTION .data
filename db 'readme-1.txt', 0h ; Имя файла
msg db 'Введите строку для записи в файл: ', 0h ; Сообщение

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

; --- Открытие существующего файла (`sys_open`)
    mov ecx, 2 ; открываем для записи (2)
    mov ebx, filename
    mov eax, 5
    int 80h

; --- Запись дескриптора файла в `esi`
    mov esi, eax

; --- Расчет длины введенной строки
    mov eax, contents ; в `eax` запишется количество
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
```

С помощью команды chmod изменила права доступа к исполняемому файлу lab10-1,
запретив его выполнение. Попыталась выполнить файл. Выдало ошибку отказано в доступе, т.к. я убрала
право на выполение для всех пользователей (рис. [-@fig:003]).

![Результат выполнения](image/3.png){#fig:003 width=70%}	

С помощью команды chmod изменила права доступа к файлу lab10-1.asm с исходным
текстом программы, добавив права на исполнение. Попыталась выполнить. 
Программа выдала ошибку синтаксиса. (рис. [-@fig:004]).

![Результат выполнения](image/4.png){#fig:004 width=70%}

В соответствии с 10 вариантом предоставила права доступа к файлу readme-
1.txt представленные в символьном виде.
Проверила правильность выполнения с помощью команды ls -l (рис. [-@fig:005]).

![Результат выполнения](image/5.png){#fig:005 width=70%}

Продеала тоже самое для файла readme-2.txt – в двочном виде.
Проверила правильность выполнения с помощью команды ls -l  (рис. [-@fig:006]).

![Результат выполнения](image/6.png){#fig:006 width=70%}

# Выполнение самостоятельной работы

Написала программу работающую по следующему алгоритму:
• Вывод приглашения “Как Вас зовут?”
• ввести с клавиатуры свои фамилию и имя
• создать файл с именем name.txt
• записать в файл сообщение “Меня зовут”
• дописать в файл строку введенную с клавиатуры
• закрыть файл

Листинг кода:

```
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
```

Создала исполняемый файл и проверила его работу. Проверила наличие файла и его
содержимое с помощью команд ls и cat (рис. [-@fig:007]).

![Результат выполнения](image/7.png){#fig:007 width=70%}

# Выводы
Выполнив данную лабараторную работу, я обрела навыки написания программ программ для работы с файлами.
