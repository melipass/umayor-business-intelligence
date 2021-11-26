# Tarea 2: Sistema de recomendación

El contenido de esta carpeta corresponde a la tarea 2 de la asignatura Inteligencia de Negocios de la Universidad Mayor, en donde se solicita la creación de un sistema de recomendación de películas. Este sistema fue desarrollado con Python dentro de cuadernos Jupyter, teniendo el archivo ``testing.ipynb`` como el cuaderno donde se fue creando de a poco el modelo mediante prueba y error, y el archivo final ``sistema-recomendacion.ipynb`` que es aquel donde se explica todo lo que fue aprendido a medida que se ejecuta el código.

Se sugiere abrir directamente el archivo ``sistema-recomendacion.ipynb``, ya que el archivo ``testing.ipynb`` se mantiene en el repositorio solo en caso de necesitar hacer más pruebas.


## Visualización

Si bien es posible ver el cuaderno Jupyter desde GitHub, se recomienda utilizar NBViewer para apreciar correctamente todas las tablas y el código en LaTeX, en [este enlace](https://nbviewer.org/github/melipass/umayor-business-intelligence/blob/main/tarea-2/sistema-recomendacion.ipynb).

## Ejecución

Para echar a andar el cuaderno Jupyter con el código del sistema de recomendación, existen muchas maneras de hacerlo. Se sugieren las siguientes, pero existen más:

- Local o remotamente:
  - Tras clonar el repositorio, usar el comando ``jupyter notebook`` en esta carpeta (/tarea-2).
    - *Si no está instalado, primero usar el comando ``pip install notebook`` o, como alternativa,  ``conda install -c conda-forge notebook``.*
  - Tras clonar el repositorio, usar el comando ``jupyter-lab`` en esta carpeta  (/tarea-2).
    - *Si no está instalado, primero usar el comando ``pip install jupyterlab`` o, como alternativa,  ``conda install -c conda-forge jupyterlab``.*
- Remotamente:
  - Importando el cuaderno en Google Colab en [este enlace](https://colab.research.google.com/github/melipass/umayor-business-intelligence/blob/main/tarea-2/sistema-recomendacion.ipynb).
  - Subiendo el cuaderno a [IBM Watson Studio](https://www.ibm.com/cloud/watson-studio) en IBM Cloud.

La manera en la que se ejecutará el cuaderno dependerá del usuario. Es importante indicar que se requerirá cargar los archivos ``movie_titles.csv`` y los documentos que están dentro del archivo ``training_set.tar`` para que el código funcione, y es posible tener que modificar un par de líneas de código para indicar la carpeta donde estos están almacenados. Además, para usar la API de The Movie Database, se requiere de una llave que debe ser generada creando una cuenta en el sitio y generándola, almacenándola en un archivo ``.env`` bajo la variable de entorno ``API_KEY``.

Todo el código fue realizado y probado con Python 3.9 y, en el probable caso de no tener instaladas todas las bibliotecas, se sugiere crear una celda de código dentro del cuaderno e instalarlas con ``!pip install <nombre-biblioteca>``.