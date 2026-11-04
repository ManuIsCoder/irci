# Uso de `SUBV1.cv`

`SUBV1.cv` es un circuito de 16 bits para restar dos entradas. Se abre en CircuitVerse, no con el ensamblador ni con el simulador RTM32.

## Abrir el circuito

1. Abre CircuitVerse en el navegador.
2. Usa la opción de importar o abrir un proyecto y selecciona `SUBV1.cv`.
3. Entra al circuito principal, llamado `Main`.

## Entradas y salidas

- `A`: primer operando de 16 bits.
- `B`: segundo operando de 16 bits.
- `RESULTADO`: resultado de 16 bits.
- `OVERFLOW`: salida de acarreo del sumador.

El circuito invierte `B` y suma un acarreo inicial de 1. Así calcula `A + ~B + 1`, que equivale a `A - B` en complemento a dos. El resultado se limita a 16 bits.

Para probarlo, cambia el valor de `A` y `B` en las entradas del circuito y observa las salidas. Por ejemplo:

| A | B | RESULTADO |
|---:|---:|---:|
| 9 | 4 | 5 |
| 4 | 9 | 65531 (`0xFFFB`, equivalente a -5 con signo de 16 bits) |
| 7 | 7 | 0 |

`OVERFLOW` está conectado directamente al acarreo de salida del sumador. No es una bandera de desbordamiento aritmético con signo; interpreta esa salida según la convención de acarreo de la resta en complemento a dos.
