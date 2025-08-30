#Requires AutoHotkey v2.0
#SingleInstance force
^Esc:: ExitApp()    ;ctrl + Esc = cierra script
!j::  ; alt + j abre un input box donde al indicarse el número se deletrea.
{
    global
    deletreador_de_numeros()
}


deletreador_de_numeros() {
    n := ""
    numeroInput := ""
    numeroParts2 := 00
    IB := InputBox("Ingresar Número", "De 10 en Diez"), numeroOriginal := IB.Value, ErrorLevel := IB.Result = "OK" ?
        0 : IB.Result = "CANCEL" ? 1 : IB.Result = "Timeout" ? 2 : "ERROR"
    if ErrorLevel
        return

    comasss := ","
    agregarcoma := ",00"
    if RegExMatch(numeroOriginal, comasss) = 0 {
        numeroOriginal := (numeroOriginal agregarcoma)

    } else {

    }

    numeroInput := numeroOriginal
    ; Eliminar puntos de la entrada

    numeroInput := StrReplace(numeroInput, ".")

    ; Obtener la parte entera y los centavos separando el valor por la ","
    numeroParts := StrSplit(numeroInput, ",")
    n := numeroParts[1]
    centavos := numeroParts[2]

    ;MsgBox 1, Number Names, % PrettyNumber(n) "`n`n" Spell(n) " con " numeroparts2 "/100 centavos"
    Send("PESOS{Space}")
    resultado1 := Spell(n) " con " Spell_c(centavos) " centavos ($" PrettyNumber(n) "," numeroParts[2] ".-)"
    resultado1 := StrUpper(resultado1) ;mayusculeador

    resultado1 := StrReplace(resultado1, "UNO MILLONES", "UN MILLÓN", , , 1)

    resultado1 := StrReplace(resultado1, "UNO MIL", "UN MIL", , , 1)

    resultado1 := StrReplace(resultado1, "Y UN MILLON", "Y UN MILLONES", , , 1)

    resultado1 := StrReplace(resultado1, "Y MIL", "MIL", , , 1)

    resultado1 := StrReplace(resultado1, "UNO TRILLONES", "UN TRILLÓN", , , 1)

    resultado1 := StrReplace(resultado1, "UNO BILLONES", "UN BILLÓN", , , 1)
    Send(resultado1)
} ; Added bracket before function

Spell(n) { ; función recursiva para deletrear el nombre de un número entero máximo de 36 dígitos, después de eliminar los ceros iniciales
    static p1 := " mil", p2 := " millones", p3 := " mil", p4 := " billones", p5 := " mil", p6 := " trillones", p7 :=
        " mil ", p8 := " cuatrillones ", p9 := " mil ", p10 := " quintillones ", p11 := " mil ", t2 := "veinte", t3 :=
        "treinta", t4 := "cuarenta", t5 := "cincuenta", t6 := "sesenta", t7 := "setenta", t8 := "ochenta", t9 :=
        "noventa", o0 := "cero", o1 := "uno", o2 := "dos", o3 := "tres", o4 := "cuatro", o5 := "cinco", o6 :=
        "seis", o7 := "siete", o8 := "ocho", o9 := "nueve", o10 := "diez", o11 := "once", o12 := "doce", o13 :=
        "trece", o14 := "catorce", o15 := "quince", o16 := "dieciséis", o17 := "diecisiete", o18 := "dieciocho",
        o19 := "diecinueve", o20 := "veinte", o21 := "veintiuno", o22 := "veintidos", o23 := "veintitres", o24 :=
        "veinticuatro", o25 := "veinticinco", o26 := "veintiseis", o27 := "veintisiete", o28 := "veintiocho", o29 :=
        "veintinueve", c1 := "ciento", c2 := "doscientos", c3 := "trescientos", c4 := "cuatrocientos", c5 :=
        "quinientos", c6 := "seiscientos", c7 := "setecientos", c8 := "ochocientos", c9 := "novecientos"

    n := RegExReplace(n, "^0+(\d)", "$1") ; elimina los 0s que preceden al numero

    if (11 < d := (StrLen(n) - 1) // 3) ; #d como digitos de 3 y si es mayor a 11 la cantidad de estos, entonces indica que el numero es demasiado grande
        return "NÚMERO MUY GRANDE"

    if (d) ; más de 3 digitos
        return Spell(SubStr(n, 1, -3 * d)) p%d% ((s := SubStr(n, (1 - 3 * d) < 1 ? (1 - 3 * d) - 1 : (1 - 3 * d))) ?
            " " Spell(s) : "")

    i := SubStr(n, 1, 1)
    if (n > 99) ; 3 digitos
        return c%i% ((s := SubStr(n, 2)) ? " " Spell(s) : "")

    if (n > 29) ; del 30 al 99
        return t%i% ((o := SubStr(n, 2)) ? " y " o%o% : "")

    return o%n% ; del 0 al 29
}


PrettyNumber(n) { ; "^0+(\d)", "$1") realiza una sustitución mediante una expresión regular para eliminar los ceros iniciales en el número , y RegExReplace(RegExReplace(n, "^0+(\d)", "$1"), "\G\d+?(?=(\d{3})+(?:\D|$))", "$0,") realiza otra sustitución mediante una expresión regular para agregar puntos a la representación del número.
    return RegExReplace(RegExReplace(n, "^0+(\d)", "$1"), "\G\d+?(?=(\d{3})+(?:\D|$))", "$0.")
}

Spell_c(centavos) { ; función recursiva para deletrear el nombre de un número entero máximo de 36 dígitos, después de eliminar los ceros iniciales
    static p1 := " mil", p2 := " millones", p3 := " mil", p4 := " billones", p5 := " mil", p6 := " trillones", p7 :=
        " mil ", p8 := " cuatrillones ", p9 := " mil ", p10 := " quintillones ", p11 := " mil ", t2 := "veinte", t3 :=
        "treinta", t4 := "cuarenta", t5 := "cincuenta", t6 := "sesenta", t7 := "setenta", t8 := "ochenta", t9 :=
        "noventa", o0 := "cero", o1 := "uno", o2 := "dos", o3 := "tres", o4 := "cuatro", o5 := "cinco", o6 :=
        "seis", o7 := "siete", o8 := "ocho", o9 := "nueve", o10 := "diez", o11 := "once", o12 := "doce", o13 :=
        "trece", o14 := "catorce", o15 := "quince", o16 := "dieciséis", o17 := "diecisiete", o18 := "dieciocho",
        o19 := "diecinueve", o20 := "veinte", o21 := "veintiuno", o22 := "veintidos", o23 := "veintitres", o24 :=
        "veinticuatro", o25 := "veinticinco", o26 := "veintiseis", o27 := "veintisiete", o28 := "veintiocho", o29 :=
        "veintinueve", c1 := "ciento", c2 := "doscientos", c3 := "trescientos", c4 := "cuatrocientos", c5 :=
        "quinientos", c6 := "seiscientos", c7 := "setecientos", c8 := "ochocientos", c9 := "novecientos"

    centavos := RegExReplace(centavos, "^0+(\d)", "$1") ; elimina los 0s que preceden al numero

    if (11 < d := (StrLen(centavos) - 1) // 3) ; #d como digitos de 3 y si es mayor a 11 la cantidad de estos, entonces indica que el numero es demasiado grande
        return "NÚMERO MUY GRANDE"

    if (d) ; más de 3 digitos
        return Spell(SubStr(centavos, 1, -3 * d)) p%d% ((s := SubStr(centavos, (1 - 3 * d) < 1 ? (1 - 3 * d) - 1 :
            (1 - 3 * d))) ? " " Spell(s) : "")

    i := SubStr(centavos, 1, 1)
    if (centavos > 99) ; 3 digitos
        return c%i% ((s := SubStr(centavos, 2)) ? " " Spell(s) : "")

    if (centavos > 29) ; del 30 al 99
        return t%i% ((o := SubStr(centavos, 2)) ? " y " o%o% : "")

    return o%centavos% ; del 0 al 29
}

PrettyNumber_c(centavos) { ; "^0+(\d)", "$1")
    return RegExReplace(RegExReplace(centavos, "^0+(\d)", "$1"), "\G\d+?(?=(\d{3})+(?:\D|$))", "$0.")
}