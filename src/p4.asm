;Practica 4 - Dinosaurio de Chrome alv
;||||||||||||||||||||||||||||||||   INICIO DE MACROS    ||||||||||||||||||||||||||||||||
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::        
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
; ||------------------------------------------------------------------------------------||
; ||                                   Copiar                                           ||
; ||------------------------------------------------------------------------------------||
copiar MACRO cadena, destino
    ; xor di,di
    ; xor bl,bl
    local copiarLoop
    mov di,0

    copiarLoop:
        mov bl,cadena[di]
        mov destino[di], bl
        inc di
        cmp cadena[di],"$"
        jne copiarLoop
ENDM
; ||------------------------------------------------------------------------------------||
; ||                                   Tamaño cadena                                    ||
; ||------------------------------------------------------------------------------------||
tamanoCadena MACRO cadena
    local tamanoLoop, finCadena
    mov si,0
    tamanoLoop:
        cmp cadena[si],"$"
        je finCadena
        inc si
        jmp tamanoLoop
    finCadena:
        ret
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
; ||------------------------------------------------------------------------------------||
; ||                                   Encabezado                                       ||
; ||------------------------------------------------------------------------------------||
mostrarEncabezado MACRO
    imprimir strEncabezado
    imprimir strEncabezado1
ENDM
; ||------------------------------------------------------------------------------------||
; ||                                   Menu principal                                   ||
; ||------------------------------------------------------------------------------------||
mostrarMenuPrincipal MACRO
    imprimir strEncebazadoMenuPrincipal
    imprimir strMenuPrincipal
ENDM
; ||------------------------------------------------------------------------------------||
; ||                                   Menu Admin                                       ||
; ||------------------------------------------------------------------------------------||
mostrarMenuAdmin MACRO
    imprimir strEncabezadoMenuAdministrador
    imprimir strMenuAdministrador
ENDM
; ||------------------------------------------------------------------------------------||
; ||                                   Menu reporte                                   ||
; ||------------------------------------------------------------------------------------||
mostrarMenuReporte MACRO
    imprimir strEncabezadoMenuReporte
    imprimir strMenuReporte
ENDM
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::        
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;||||||||||||||||||||||||||||||||   INICIO DEL PROGRAMA    ||||||||||||||||||||||||||||||||
.model large
.stack 4096
.data
;|||||||||||||||||||||||||||||||| VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||||||||
saltoret            db 13,10,"$"
; ________________________________________________ ENCABEZADO ________________________________________________
strEncabezado    	   db                   "|___________________________________________________|",13,10,
                                            "| Universidad de San Carlos de Guatemala            |",13,10,
                                            "| Facultad de Ingenieria                            |",13,10,
                                            "| Escuela de ciencias y sistemas                    |",13,10,
                                            "| Arquitectura de Computadores y Ensambladores 1 A  |",13,10,"$"
strEncabezado1         db                   "| Segundo semestre 2018                             |",13,10,
                                            "| Gonzalo Antonio Garcia Solares                    |",13,10,
                                            "| 201318652                                         |",13,10,
                                            "| Cuarta practica                                   |",13,10,
                                            "|___________________________________________________|",13,10,"$"
; ________________________________________________ MENU PRINCIPAL ________________________________________________
strEncebazadoMenuPrincipal      db    13,10,"||=================================================||",13,10,
                                            "||-------------------------------------------------||",13,10,
                                            "||                 Menu principal                  ||",13,10,
                                            "||-------------------------------------------------||",13,10,
                                            "||=================================================||",13,10,"$"
strMenuPrincipal        db                  "1. Ingresar                                        ",13,10,
                                            "2. Registrar                                       ",13,10,                            
                                            "3. Salir                                           ",13,10,
                                            "___________________________________________________",13,10,
                                            "Bienvenido, elige una opcion...                    ",13,10,13,10,"$"
menuPrincipalOpcion    db       ?,10,13,"$"
; ________________________________________________ MENU INGRESAR ________________________________________________
strEncabezadoMenuIngresar   db  13,10,13,10,"-------------------- Ingresar ---------------------",13,10,13,10,"$"
strMenuIngresarUsuario      db              "Ingresa el nombre del usuario:                     ",13,10,"$"
strMenuIngresarContraseña   db              "Ingresa la contraseña del usuario:                 ",13,10,"$"
strMenuIngresando           db        13,10,"Bienvenido, ingresando al juego...                 ",13,10,13,10,"$"
; ________________________________________________ MENU REGISTRAR ________________________________________________
strEncabezadoMenuRegistrar  db  13,10,13,10,"--------------------- Registrar -------------------",13,10,13,10,"$"
strMenuRegistrarUsuario     db              "Ingresa el nombre del usuario a registrar:         ",13,10,"$"
strMenuRegistrarContraseña  db              "Ingresa la contraseña del usuario a registrar:     ",13,10,"$"
strMenuRegistrando          db        13,10,"Registrando el usuario...                          ",13,10,13,10,"$"
; ________________________________________________ MENU ADMIN ____________________________________________________
strEncabezadoMenuAdministrador db 13,10,13,10,"----------------- Bienvenido Admin ----------------",13,10,13,10,"$"
strMenuAdministrador           db           "1. Reportes                                        ",13,10,
                                            "2. Jugar                                           ",13,10,
                                            "3. Salir                                           ",13,10,
                                            "___________________________________________________",13,10,
                                            "Bienvenido, elige una opcion...                    ",13,10,13,10,"$"
menuAdminOpcion    db       ?,10,13,"$"
; _______________________________________________ MENU REPORTES____________________________________________________
strEncabezadoMenuReporte     db 13,10,13,10,"--------------------- Reportes --------------------",13,10,13,10,"$"
strMenuReporte                db            "1. Top 10                                          ",13,10,
                                            "2. Usuarios registrados                            ",13,10,
                                            "3. Salir                                           ",13,10,
                                            "___________________________________________________",13,10,
                                            "Bienvenido, elige una opcion...                    ",13,10,13,10,"$"
menuReporteOpcion    db       ?,10,13,"$"

; _____________________________________________ SALIR _____________________________________________________________ 
strMenuSalir                db  13,10,13,10,"---------------------- Salir -----------------------",13,10,13,10,"$"
strMenuSalirAbandonando     db              "Abandonando el programa, hasta pronto.              ",13,10,"$"
;...........................................................................................
strMenuOpcionIncorrecta     db              "Elige una opcion correcta.                          ",13,10,"$"

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