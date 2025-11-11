# EduLink
Group Project for Software Engineering II course.
-> Will update l8r

![Demostración de clonado](./Resources/Demo-1.gif)

## Cómo solucionar las dependencias
Recuerden que estamos trabajando con .NET, ASP y Razor Pages, el
encargado de manejar paquetes en .NET es nugget.

Corran en la consola desde /EduLink:

`dotnet restore`

**ESTO DESCARGA LAS DEPENDENCIAS EN .csproj**
Funciona similar a npm i en node.js, aunque sé que no han tocado esa herramienta, básicamente las dependencias declaradas en algúna archivo (package.json en el caso de node.js) son chequeadas y si alguna falta, se instala.

## Compilar
Si usan VS Community 2022, usen el boton verde de compilado.

Si usan otro IDE o la consola de comando, corran `dotnet run` en /EduLink.Web, esto compila el proyecto.

![Demostración del compilado](./Resources/Demo-2.gif)

## Despliegue
No es el titulo que corresponde a esta parte por ahora.

Si desean ver la página web, accedan a `http://localhost:XXXX` desde un navegador luego de compilar y correr el programa.

Por ahora deberían ver:
- Home, la página de inicio por ahora.
- Privacy, autogenerado por ASP.NET, sólo es una plantilla.

## Estructura del proyecto
Los nombres de las capas del proyecto fueron autogeneradas por ASP.NET, pero a continuación se explica sus equivalentes:
- Application == Business Logic (BL) -> Aquí debe trabajar Xavs
- Domain == Persistencia de objetos (DBO)
- Infrastructure == Database Access Layer (DAL)
- Web == Interfaz de usuario / Páginas Web (UI) -> Aquí debe trabajar Sebas

En el caso de Gabito, paséate donde quieras. La capa de base de datos la configuramos juntos después.

### Nota adicional
NUNCA hagan stage ni commit durante la ejecución de una build o compilado, se va a dañar la rama y el flujo de trabajo, obligandolos a borrar cosas e incluso prohibiendo borrarlas.