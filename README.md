# EduLink
Group Project for Software Engineering II course.
-> Will update l8r

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

## Despliegue
No es el titulo que corresponde a esta parte por ahora.

Si desean ver la página web, accedan a `http://localhost:5114` desde un navegador luego de compilar y correr el programa.

Por ahora deberían ver:
- Home, la página de inicio por ahora.
- Privacy, autogenerado por ASP.NET, sólo es una plantilla.

### Nota adicional
NUNCA hagan stage ni commit durante la ejecución de una build o compilado, se va a dañar la rama y el flujo de trabajo, obligandolos a borrar cosas e incluso prohibiendo borrarlas.