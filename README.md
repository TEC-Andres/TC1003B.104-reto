# Modelación de la ingeniería con matemática computacional | Reto de solido de revolución
## Miembros del equipo:
- Alexa Martínez Escobedo
- Andrés Rodríguez Cantú
- Viviana González Cervantes

## Objetivo del proyecto:
Modelar e imprimir un prototipo un producto inovador utilizando sólidos de revolución utilizando tecnologías como MATLAB, Geogebra y la impresión 3D.

## Liga de descarga del proyecto:
Última versión del proyecto:
[Release de Semana III](https://github.com/TEC-Andres/TC1003B.104-reto/releases/tag/Avance)

## Requerimientos para compilar
- [Python](https://www.python.org/downloads/) 3.8 o superior
- [TexWorks](https://tug.org/texworks/) o cualquier editor de $\LaTeX$
- [Biber](https://www.ctan.org/pkg/biber)

## Compilación del documento (LaTeX)
Para compilar el documento, se puede usar el siguiente comando:
`python texCompiler.py -F documento main.tex -o main.pdf`

Ignorar bibliografía (más rápido; omite correr `biber` aunque exista `.bcf`):
`python texCompiler.py -I bib -F documento main.tex -o main.pdf`