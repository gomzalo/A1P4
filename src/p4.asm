;Practica 4 - Dinosaurio de Chrome alv
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::        
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        ; °°°°°°°°°°°°°°°°°°°           MACROS          °°°°°°°°°°°°°°°°°°°°°
;|||||||||||||||||||||||||||||||||||||||   TOOLS    |||||||||||||||||||||||||||||||||||||||
;||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
; ||------------------------------------------------------------------------------------||
; ||                                   Copiar                                           ||
; ||------------------------------------------------------------------------------------||
copiar MACRO cadena, destino
local copiarLoop
    xor di,di
    xor bl,bl

    mov di,0

    copiarLoop:
        mov bl,cadena[di]
        mov destino[di], bl
        inc di
        cmp cadena[di],"$"
        jne copiarLoop
ENDM
; ||------------------------------------------------------------------------------------||
; ||                                   Tamano cadena                                    ||
; ||------------------------------------------------------------------------------------||
tamanoCadena MACRO cadena, tamCadena
local tamanoLoop, finCadena

    imprimir strTamanoCadena

    lea si, cadena
    mov si,0
    tamanoLoop:
        cmp cadena[si],"$"
        je finCadena
        inc si
        jmp tamanoLoop
    finCadena:
        ret
    imprimir tamCadena
ENDM
tamanoCadena1 MACRO cadena, tamCadena
local l2, l1

    xor ax, ax
    xor bx, bx
    xor dx, dx

    imprimir strTamanoCadena
    copiar cadena, tamCadena

    lea si, tamCadena

    add si, 2
    mov ax, 00

    l2:
        cmp byte ptr[si], "$"
        je l1
        inc si
        add al, 1
        jmp l2
    l1:
        sub al, 1
        add al, 30h

        mov ah, 02H
        mov dl, al
        int 21h

ENDM
; ||------------------------------------------------------------------------------------||
; ||                                   Ingresa desde el teclado                         ||
; ||------------------------------------------------------------------------------------||
ingresar MACRO nombre
local entradaTeclado, zeroTerm
    lea si, nombre
    mov ah, 01h         ; Entrada de caracter

    entradaTeclado:
        int 21h

        cmp al,0dh      ; Enter
        je zeroTerm

        mov [si],al
        inc si

        jmp entradaTeclado

    zeroTerm:
        mov byte ptr [si],0
ENDM
; ||------------------------------------------------------------------------------------||
; ||                                   Leer tecla                                       ||
; ||------------------------------------------------------------------------------------||
leerTecla MACRO teclaLeida
    ; local teclaLeida
    ; xor ax,ax
    ; xor bx, bx
    ; xor cx, cx
    ; xor dx,dx

    mov ah,3fh
    mov bx,00
    mov cx, 54      ;Tamaño cadena
    lea dx, teclaLeida      ;Donde almacenaras el valor
    int 21h
ENDM
; ||------------------------------------------------------------------------------------||
; ||                                   Imprimir                                         ||
; ||------------------------------------------------------------------------------------||
imprimir MACRO cadena
    xor dx,dx
    xor ax,ax
    mov ah,09
    lea dx,cadena
    int 21h
    xor dx,dx
    xor ax,ax
ENDM
; ||------------------------------------------------------------------------------------||
; ||                                   Limpia pantalla                                  ||
; ||------------------------------------------------------------------------------------||
limpiarPantalla MACRO
    xor ax,ax
    mov ah, 03h
    int 10h
    xor ax,ax
    ; ret
ENDM
; ||------------------------------------------------------------------------------------||
; ||                                   Salir                                            ||
; ||------------------------------------------------------------------------------------||
salir MACRO
    mov ah, 4ch	;Function (Quit with exit code (EXIT))
    int 21h			;Interruption DOS Functions
ENDM
;||||||||||||||||||||||||||||||||   IMPRESION DE MENUS    ||||||||||||||||||||||||||||||||
;||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
; ||------------------------------------------------------------------------------------||
; ||                                  Mostrar encabezado                                ||
; ||------------------------------------------------------------------------------------||
mostrarEncabezado MACRO
    imprimir strEncabezado
    imprimir strEncabezado1
    imprimir strEncabezado2
ENDM
; ||------------------------------------------------------------------------------------||
; ||                                   Mostrar menu principal                           ||
; ||------------------------------------------------------------------------------------||
mostrarMenuPrincipal MACRO
    imprimir strEncebazadoMenuPrincipal
    imprimir strEncebazadoMenuPrincipal1
    imprimir strMenuPrincipal
    imprimir strMenuPrincipal1
ENDM
; ||------------------------------------------------------------------------------------||
; ||                                   Mostrar menu admin                               ||
; ||------------------------------------------------------------------------------------||
mostrarMenuAdmin MACRO
    imprimir strEncabezadoMenuAdministrador
    imprimir strMenuAdministrador
ENDM
; ||------------------------------------------------------------------------------------||
; ||                                   Mostrar Menu reporte                             ||
; ||------------------------------------------------------------------------------------||
mostrarMenuReporte MACRO
    imprimir strEncabezadoMenuReporte
    imprimir strMenuReporte
ENDM
;|||||||||||||||||||||||||||||||||||    MENUS    ||||||||||||||||||||||||||||||||||||||||||
;||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
; ||------------------------------------------------------------------------------------||
; ||                                   Menu principal                                   ||
; ||------------------------------------------------------------------------------------||
menuPrincipal MACRO
local esIgual1, esIgual2, esIgual3, noEsIgual, menuPrincipalP
    
    menuPrincipalP:
        leerTecla menuPrincipalOpcion
        mov si,0
    ; __________________________________ Opciones de menu __________________________________
        cmp menuPrincipalOpcion[si], "1"
        jz esIgual1                     ; Ingresar
        cmp menuPrincipalOpcion[si], "2"
        jz esIgual2                     ; Registrar
        cmp menuPrincipalOpcion[si], "3"
        jz esIgual3
        jnz noEsIgual                     ; Salir
    ; __________________________________ IFs de menu __________________________________
        esIgual1:
            ; Mostrando info
            imprimir strEncabezadoMenuIngresar
            ; Login usuario
            imprimir strMenuIngresarUsuario
            ingresar usuarioIngresar
            imprimir usuarioIngresar
            ; Login contrasena
            imprimir strMenuIngresarContrasena
            ingresar contrasenaIngresar
            imprimir contrasenaIngresar
            ; Juego
            jmp main
        esIgual2:
            ; Mostrando info
            imprimir strEncabezadoMenuRegistrar
            ; Registro usuario
            imprimir strMenuRegistrarUsuario
            ingresar usuarioRegistrar
            imprimir usuarioRegistrar
            escribirArchivoUsuarios usuarioRegistrar
            ; Registro contrasena
            imprimir strMenuRegistrarContrasena
            ingresar contrasenaRegistrar
            imprimir contrasenaRegistrar
            ; Escribir archivo
            ; Juego
            jmp main
        esIgual3:
            ; Mostrando info
            imprimir strEncabezadoMenuSalir
            imprimir strMenuSalir
            salir
        noEsIgual:
            imprimir strMenuOpcionIncorrecta
            jmp main

ENDM
;||||||||||||||||||||||||||||||||||  TOOLS ARCHIVOS  ||||||||||||||||||||||||||||||||||||||
;||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
; ||------------------------------------------------------------------------------------||
; ||                                   Leer archivo                                     ||
; ||------------------------------------------------------------------------------------||
leerArchivo MACRO handler, contenido, tamano
; local handler, contenido, tamano
    ; xor ax, ax
    ; xor bx, bx
    ; xor cx, cx
    ; xor dx, dx

    imprimir strLeyendoArchivo

    mov ah, 3fh         ; Lee contenido del archivo
    mov bx, handler     ; Handler
    lea dx, contenido   ; (Buffer) Contenido del archivo
    mov cx, tamano      ; Numero de bytes a leer
    int 21h             ; DOS Int
ENDM
; ||------------------------------------------------------------------------------------||
; ||                                   Abrir archivo                                    ||
; ||------------------------------------------------------------------------------------||
abrirArchivo MACRO ruta, tipo, handler
; local ruta, tipo, handler
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx

    imprimir strAbriendoArchivo

    lea dx, ruta        ; Ruta donde esta el archivo (nombre, si esta en root)
    mov al, tipo        ; Tipos: 000b solo lectura, 001b solo escritura, 010b lectura/escritura
    mov ah, 3dh          ; Abre el archivo
    int 21h             ; DOS Int

    mov handler, ax     ; Handler

    ; lea si, contenidoArchivo
ENDM
; ||------------------------------------------------------------------------------------||
; ||                                   Crear archivo                                    ||
; ||------------------------------------------------------------------------------------||
crearArchivo MACRO nombre, handler
; local nombre, handler
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx

    imprimir strCreandoArchivo

    mov ah, 3ch          ; Crea el archivo
    mov cx, 00h         ; Tipos: 00H normal, 01H solo lectura, 02H oculto, 03H sistema
    lea dx, nombre      ; Nombre del archivo a crear
    int 21h             ; DOS Int

    mov handler, ax     ; Handler
ENDM
; ||------------------------------------------------------------------------------------||
; ||                                   Escribir archivo                                 ||
; ||------------------------------------------------------------------------------------||
escribirArchivo MACRO handler, tamano, contenido
; local handler, tamano, contenido
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx

    imprimir strEscribiendoArchivo

    mov ah, 40h         ; Escribe el archivo
    mov bx, handler     ; Handler
    mov cx, tamano      ; Tamano del contenido
    lea dx, contenido   ; Contenido a escribir
    int 21h
ENDM
; ||------------------------------------------------------------------------------------||
; ||                                   Editar archivo                                   ||
; ||------------------------------------------------------------------------------------||
editarArchivo MACRO tipo, handler, ms, ls

    imprimir strEditandoArchivo

    mov ah, 42h         ; Establece puntero en fichero
    mov al, tipo        ; Tipos de desplazamiento: 00h incio, 01h posicion actual, 02h final
    mov bx, handler     ; Handler
    mov cx, ms          ; Mitad mas significativa
    mov dx, ls          ; Mitad menos significativa

ENDM
; ||------------------------------------------------------------------------------------||
; ||                                   Cerrar archivo                                   ||
; ||------------------------------------------------------------------------------------||
cerrarArchivo MACRO handler
; local handler
    ; xor ax, ax
    ; xor bx, bx
    ; xor cx, cx
    ; xor dx, dx

    imprimir strCerrandoArchivo

    mov ah, 3eh          ; Cerrar archivo
    mov bx, handler      ; Handler
    int 21h
ENDM
;|||||||||||||||||||||||||||||||||||||  ARCHIVOS  |||||||||||||||||||||||||||||||||||||||||
;||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
; ||------------------------------------------------------------------------------------||
; ||                                   Archivo usuarios                                 ||
; ||------------------------------------------------------------------------------------||
escribirArchivoUsuarios MACRO usuario
local yaExiste, noExiste, continuar
    
    abrirArchivo nombreArchivoUsuarios, leerArchivoTipoEscritura, handlerArchivoUsuarios
    jc noExiste
    jnc yaExiste
    
    yaExiste:
        imprimir strArchivoYaExiste
        jmp continuar
    noExiste:
        imprimir strArchivoNoExiste
        crearArchivo nombreArchivoUsuarios, handlerArchivoUsuarios
        jmp continuar
    continuar:
        tamanoCadena1 usuario, tamanoUsuario
        escribirArchivo handlerArchivoUsuarios, tamanoUsuario, usuario
        cerrarArchivo handlerArchivoUsuarios

ENDM
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::        
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;||||||||||||||||||||||||||||||||   INICIO DEL PROGRAMA    ||||||||||||||||||||||||||||||||
;||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
.model large
.stack 4096
.data
;|||||||||||||||||||||||||||||||| CONSTANTES ||||||||||||||||||||||||||||||||||||||||||||||||||||
; ________________________________________________ CARACTERES ________________________________________________
comaCH          EQU    2ch      ; ,
puntoComaCH     EQU     3bh     ; ;
; ________________________________________________ MODOS LECTURA ________________________________________________
leerArchivoTipoLectura EQU 000b
leerArchivoTipoEscritura EQU 001b
leerArchivoTipoLecturaEscritura EQU 010b
; ________________________________________________ DESPLAZAMIENTO FICHERO ________________________________________________
despInicioFichero       EQU     00h
despPosActualFichero    EQU     01h
despFinFichero          EQU     02h
; ________________________________________________ ARCHIVO USUARIOS ________________________________________________
tamanoArchivoUsuariosConst EQU 4
nombreArchivoUsuariosConst EQU "USUARIOS.JSON"
;|||||||||||||||||||||||||||||||| VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||||||||
saltoret            db 13,10,"$"
; ________________________________________________ ENCABEZADO ________________________________________________
strEncabezado    	    db                  "|___________________________________________________|",13,10,
                                            "| Universidad de San Carlos de Guatemala            |",13,10,
                                            "| Facultad de Ingenieria                            |",13,10,"$"
strEncabezado1          db                  "| Escuela de ciencias y sistemas                    |",13,10,
                                            "| Arquitectura de Computadores y Ensambladores 1 A  |",13,10,
                                            "| Segundo semestre 2018                             |",13,10,"$"
strEncabezado2          db                  "| Gonzalo Antonio Garcia Solares                    |",13,10,
                                            "| 201318652                                         |",13,10,
                                            "| Cuarta practica                                   |",13,10,
                                            "|___________________________________________________|",13,10,"$"
; ________________________________________________ MENU PRINCIPAL ________________________________________________
strEncebazadoMenuPrincipal      db    13,10,"||=================================================||",13,10,
                                            "||-------------------------------------------------||",13,10,
                                            "||                 Menu principal                  ||",13,10,
                                            "||-------------------------------------------------||",13,10,"$"
strEncebazadoMenuPrincipal1     db          "||=================================================||",13,10,"$"
strMenuPrincipal        db                  "1. Ingresar                                        ",13,10,
                                            "2. Registrar                                       ",13,10,                            
                                            "3. Salir                                           ",13,10,
                                            "___________________________________________________",13,10,"$"
strMenuPrincipal1       db                  "Bienvenido, elige una opcion...                    ",13,10,13,10,"$"
menuPrincipalOpcion    db       54,?,54 dup (?),"$"
; ________________________________________________ MENU INGRESAR ________________________________________________
strEncabezadoMenuIngresar   db  13,10,13,10,"-------------------- Ingresar ---------------------",13,10,13,10,"$"
strMenuIngresarUsuario      db        13,10,"Ingresa el nombre del usuario:                     ",13,10,"$"
strMenuIngresarContrasena   db        13,10,"Ingresa la contrasena del usuario:                 ",13,10,"$"
strMenuIngresando           db        13,10,"Bienvenido, ingresando al juego...                 ",13,10,13,10,"$"
;................................ Login usuario ................................................
usuarioIngresar       db      100 dup("$"),"$"
contrasenaIngresar     db     32 dup(0),"$"
; ________________________________________________ MENU REGISTRAR ________________________________________________
strEncabezadoMenuRegistrar  db  13,10,13,10,"--------------------- Registrar -------------------",13,10,13,10,"$"
strMenuRegistrarUsuario     db        13,10,"Ingresa el nombre del usuario a registrar:         ",13,10,"$"
strMenuRegistrarContrasena  db        13,10,"Ingresa la contrasena del usuario a registrar:     ",13,10,"$"
strMenuRegistrando          db        13,10,"Registrando el usuario...                          ",13,10,13,10,"$"
;................................ Signup usuario ................................................
usuarioRegistrar        db      100 dup("$"),"$"
contrasenaRegistrar     db      32 dup(0),"$"
; ________________________________________________ MENU ADMIN ____________________________________________________
strEncabezadoMenuAdministrador db 13,10,13,10,"----------------- Bienvenido Admin ----------------",13,10,13,10,"$"
strMenuAdministrador           db           "1. Reportes                                        ",13,10,
                                            "2. Jugar                                           ",13,10,
                                            "3. Salir                                           ",13,10,
                                            "___________________________________________________",13,10,"$"
                                            ; "Bienvenido, elige una opcion...                    ",13,10,13,10,"$"
menuAdminOpcion    db       ?,10,13,"$"
; _______________________________________________ MENU REPORTES____________________________________________________
strEncabezadoMenuReporte     db 13,10,13,10,"--------------------- Reportes --------------------",13,10,13,10,"$"
strMenuReporte                db            "1. Top 10                                          ",13,10,
                                            "2. Usuarios registrados                            ",13,10,
                                            "3. Salir                                           ",13,10,
                                            "___________________________________________________",13,10,"$"
                                            ; "Bienvenido, elige una opcion...                    ",13,10,13,10,"$"
menuReporteOpcion    db       ?,10,13,"$"
; _____________________________________________ SALIR _____________________________________________________________ 
strEncabezadoMenuSalir      db  13,10,13,10,"---------------------- Salir -----------------------",13,10,13,10,"$"
strMenuSalir                db              "Abandonando el programa, hasta pronto.              ",13,10,"$"
;...........................................................................................
strMenuOpcionIncorrecta     db        13,10,"Elige una opcion correcta.                          ",13,10,"$"
; _____________________________________________ ARCHIVOS _____________________________________________________________
;................................ Archivo usuarios .............................................
strArchivoYaExiste          db      13,10,"El archivo ya existe.",13,10,"$"
strArchivoNoExiste          db      13,10,"El archivo no existe.",13,10,"$"
strCreandoArchivo           db      13,10,"Creando archivo.",13,10,"$"
strAbriendoArchivo          db      13,10,"Abriendo archivo.",13,10,"$"
strLeyendoArchivo           db      13,10,"Leyendo archivo.",13,10,"$"
strEditandoArchivo          db      13,10,"Editando archivo.",13,10,"$"
strEscribiendoArchivo       db      13,10,"Escribiendo archivo.",13,10,"$"
strCerrandoArchivo          db      13,10,"Cerrando archivo.",13,10,"$"
strTamanoCadena             db      13,10,"Tamano cadena: ","$"

nombreArchivoUsuarios       db      "USUARIOS.JSON","$"
tamanoArchivoUsuarios       db      ?
tamanoUsuario               db      ?
tamanoContrasena            db      ?,"$"
handlerArchivoUsuarios      dw      ?,"$"
contenidoArchivoUsuarios    db      5000 dup("$"),"$"
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::        
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
.code

    ; Inicializa DS
    mov ax, @data
    mov ds, ax
    mostrarEncabezado

    main proc        
        mostrarMenuPrincipal
        menuPrincipal
    ;    .exit
    main endp

;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
end