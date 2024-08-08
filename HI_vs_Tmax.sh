#!/usr/bin/env bash

# Autores: Agostina Giunta y Federico Esteban

#	Variables del Mapa
#	-----------------------------------------------------------------------------------------------------------
#	Titulo de la figura
	title=HI_vs_Tmax
	title=$(basename $0 .sh)
	echo $title

#	Dominio de datos (eje X e Y)
	REGION=400/525/0/1000

#	Proyeccion Lineal (X). Ancho y alto (en cm)
	PROJ=X10c/12c

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
gmt begin $title png
	
#	Setear la region y proyeccion
	gmt basemap -R$REGION -J$PROJ -B+n

#	Tìtulo de la figura (-B+t)
#	gmt basemap -B+t"Titulo"

#	Color de fondo del grafico (-B+g"color")
	gmt basemap -B+g200

#	Titulo de los ejes (X Y) por separado: (a)notacion), (f)rame y (l)abel. @- Inicio/Fin Subindice. 
	gmt basemap -Bxaf+l"Tmax (°C)" -Bya100f+l"Hydrogen Index (mg-CO@-2@-/g-TOC)" -BWeSn
 
#	Graficar Lineas del Grafico
	gmt plot -Wthin+s <<- END 
	425,900
	450,700
	470,200
	500,50
	520,45
	
	425,650
	465,190
	476,75
	500,50
	520,45
	
	425,350
	442,250
	460,95
	500,50
	520,45
	
	425,190
	445,100
	465,60
	500,50
	520,45

	425,40
	520,40
	END

#	Graficar limite verticales 
	gmt plot -Wthinner,- <<- END
	435,1000
	435,0

	455,1000
	455,0

	475,1000
	475,0
	END

#	Poner Nombre de los Campos
	gmt text -F+f8 <<-END
	415,900, TYPE I
	415,650, TYPE II
	415,350, TYPE III
	415,190, TYPE II-III
	415,40, TYPE IV
	END

#	Nombre de las zonas de madurez
	gmt text -F+f7 --FONT_ANNOT_PRIMARY=Helvetica,Red <<-END 
	415,950,Inmature
	445,950,Mature
	490,950,Overmature
	END

#	Zonas de generacion de hidrocarburos 
	gmt text -F+f7 --FONT_ANNOT_PRIMARY=Helvetica,Blue <<-END 
	445,900,Oil window
	465,700,Condensate-
	465,680,Wet gas 
	465,660,window
	500,150,Dry gas window
	END

#	Graficar los datos como símbolos. Color (-G), Borde (-W) y forma (-S)
#	**************************************************************
#	gmt plot "geoquimica.txt" -: -Wthinnest -S0.2 -Ccategorical

#	Dibujar Leyenda
#	gmt legend -DjTR+w3/0+o-2/1+jTC -F+gwhite+pdefault+i <<- END
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
