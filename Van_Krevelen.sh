#!/usr/bin/env bash

# Temas a ver:
# 1. Usar archivo con distintos simbolos y colores

#	Variables del Mapa
#	-----------------------------------------------------------------------------------------------------------
#	Titulo de la figura
	title=Van_Krevelen
	title=$(basename $0 .sh)
	echo $title

#	Dominio de datos (eje X e Y)
	REGION=0/100/0/1000

#	Proyeccion Lineal (X). Ancho y alto (en cm)
	PROJ=X7c/10c

#	Parametros GMT
#	-----------------------------------------------------------------------------------------------------------
#	Parametros de Fuentes: Titulo del grafico, del eje (label) y unidades del eje (ANNOT_PRIMARY)
	gmt set	FONT_TITLE 16,4,Black
	gmt set	FONT_LABEL 10p,19,Red
	gmt set	FONT_ANNOT_PRIMARY 8p,Helvetica,Blue

	gmt set PS_CHAR_ENCODING ISOLatin1+
	gmt set IO_SEGMENT_MARKER B

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Iniciar sesion y tipo de figura
gmt begin $title png
	
#	Setear la region y proyeccion
	gmt basemap -R$REGION -J$PROJ -B+n

#	Tìtulo de la figura (-B+t)
	gmt basemap -B+t"Pseudo Van Krevelen"

#	Color de fondo del grafico (-B+g"color")
	gmt basemap -B+g200

#	Titulo de los ejes (X Y) por separado: (a)notacion), (f)rame y (l)abel. @- Inicio/Fin Subindice. 
	gmt basemap -Bxaf+l"Hydrogen Index (mg-HC/g-TOC)" -Bya100f+l"Oxygen Index (mg-CO@-2@-/g-TOC)" -BWeSn
 
#	Graficar Lineas del Grafico
	gmt plot -Wthin+s <<- END 
	20,900
	10,700
	3,75
	
	35,675
	30,665
	15,600
	8,500
	6,400
	
	86,195
	60,205
	20,150
	10,75
	
	86,75
	60,78
	17,50
	END


#	Poner Nombre de los Campos
	gmt text -F+f10 <<-END
	25,900, I
	42,675, II
	93,200, III
	93,72, IV

	40,800,TYPE I
	50,500,TYPE II
	85,135,TYPE III
	85,30,TYPE IV
	END

#	Graficar Datos como símbolos. Color (-G), Borde (-W) y forma (-S)
#	**************************************************************
#	gmt plot "geoquimica.txt" -: -Wthinnest -S0.2 -Ccategorical
		
#	---------------------------------------------------------------------------
#	Cerrar la sesion y mostrar archivo
gmt end

	rm gmt.*
