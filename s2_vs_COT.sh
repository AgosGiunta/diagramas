#!/usr/bin/env bash

# Autores: Agostina Giunta y Federico Esteban

#	Variables del Mapa
#	-----------------------------------------------------------------------------------------------------------
#	Titulo de la figura
	title=S2_vs_COT
	title=$(basename $0 .sh)
	echo $title

#	Dominio de datos (eje X e Y)
	REGION=0.1/100/0.01/100

#	Proyeccion Lineal (X). Ancho y alto (en cm)
	PROJ=X15cl/10cl

#	Parametros GMT
#	-----------------------------------------------------------------------------------------------------------
#	Parametros de Fuentes: Titulo del grafico, del eje (label) y unidades del eje (ANNOT_PRIMARY)
	gmt set	FONT_TITLE 16,4,Black
	gmt set	FONT_LABEL 10p,19,Red
	gmt set	FONT_ANNOT_PRIMARY 8p,Helvetica,Black

	gmt set PS_CHAR_ENCODING ISOLatin1+
	gmt set IO_SEGMENT_MARKER B

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Iniciar sesion y tipo de figura
gmt begin generated/$title png
	
#	Setear la region y proyeccion
	gmt basemap -R$REGION -J$PROJ -B+n

#	Tìtulo de la figura (-B+t)
#	gmt basemap -B+t"Titulo"

#	Color de fondo del grafico (-B+g"color")
	gmt basemap -B+g200

#	Titulo de los ejes (X Y) por separado: (a)notacion), (f)rame y (l)abel. @- Inicio/Fin Subindice. 
	gmt basemap -Bxaf+l"TOTAL ORGANIC CARBON (TOC, wt.%)" -Bya100f+l"S2 (mg/g)" -BWeSn
 
#	Graficar Lineas del Grafico
	gmt plot -Wthinner <<- END 
	0.5,0.01
	0.5,100
	
	1,0.01
	1,100
	
	2,0.01
	2,100

	0.1,3
	100,3
	
	0.1,6
	100,6
	END

#	Limites HI
	gmt plot -Wthinner,. <<- END 
	0.1,0.6
	100,600
	
	0.1,0.3
	100,300
	
	0.1,0.1
	100,100

	0.1,0.05
	100,50

	0.1,0.01
	100,10

	1,0.01
	100,1
	END

#	Poner Nombre de los Campos
	gmt text -F+f8 --FONT_ANNOT_PRIMARY=Helvetica-Bold,Black <<-END
	0.3,0.08, Pobre
	0.3,4, Regular
	0.3,10, Bueno
	10,0.02, Muy bueno
	0.7,0.02, Regular
	1.4,0.02, Bueno
	END

#	Nombre de las divisiones de HI
	gmt text -F+f8+a30 -Gwhite --FONT_ANNOT_PRIMARY=Helvetica,Black <<-END
	6,55, HI=600
	12,50, HI=300
	30,40, HI=100
	40,27, HI=50
	70,9, HI=10
	80,1.1, HI=1
	END

#	Graficar los datos como símbolos. Color (-G), Borde (-W) y forma (-S)
#	**************************************************************
#	gmt plot "geoquimica.txt" -: -Wthinnest -S0.2 -Ccategorical

#	Dibujar Leyenda
#	gmt legend -DjBR+w3/0+o-2/-2+jTC -F+gwhite+pdefault+i <<- END
#	N 1
#	S 0.25c c 0.25c green thinnest 0.5c Formacion 1
#	S 0.25c s 0.25c blue  thinnest 0.5c Formacion 2
#	S 0.25c t 0.25c red   thinnest 0.5c Formacion 3
#	S 0.25c d 0.25c cyan  thinnest 0.5c Formacion 4	
#	END
		
#	---------------------------------------------------------------------------
#	Cerrar la sesion y mostrar archivo
gmt end

	rm gmt.*
