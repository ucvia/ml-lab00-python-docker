# Laboratorio 1: Pipeline de trabajo para Aprendizaje automático

Setup mínimo para correr Docker y docker compose con un API en Flask

# Docker

Docker es una plataforma de contenedores que permite empaquetar aplicaciones y sus dependencias en contenedores, lo que facilita la implementación y la gestión de aplicaciones en diferentes entornos. Este tutorial te guiará a través de los conceptos básicos de Docker y te mostrará cómo empezar a trabajar con contenedores.

## 1. Instalación de Docker

Para comenzar a usar Docker, primero debes instalarlo en tu sistema. Sigue estos pasos según tu sistema operativo:

### Windows y macOS

1. Descarga Docker Desktop desde [el sitio web oficial de Docker](https://www.docker.com/products/docker-desktop).
2. Instala Docker Desktop siguiendo las instrucciones de instalación.

### Linux

En Linux, puedes instalar Docker a través de la línea de comandos. Los pasos varían según la distribución, así que consulta la documentación oficial para tu distribución específica.

### UCV AI

Para nuestro curso, recomendamos trabajar en un ambiente Unix, preferiblemente Ubuntu o Debian. En cualquier caso, escribimos un archivo de instalación que instala todo lo que necesitan y configura todo para su usuario actual. Recomiendo leer cada paso en el caso de que estén interesados pero no es necesario.

Para instalar, basta con ejecutar los siguientes comandos:

```shell
cd instalacion/docker
sh install.sh
```

## 2. Verificar la instalación

Una vez que hayas instalado Docker, verifica que se haya instalado correctamente ejecutando el siguiente comando en la terminal:

```shell
docker --version
```

Deberías ver la versión de Docker instalada.

## 3. Ejecutar tu primer contenedor

Ahora que Docker está instalado y funcionando, puedes ejecutar tu primer contenedor. Aquí hay un ejemplo simple para ejecutar un contenedor de Ubuntu:

```shell
docker run -it ubuntu
```

Este comando descargará la imagen de Ubuntu desde el registro de Docker (si aún no está descargada) y ejecutará un contenedor interactivo. Puedes ejecutar comandos dentro del contenedor como lo harías en una máquina virtual.

## 4. Gestión de contenedores

- Listar contenedores en ejecución:
  ```shell
  docker ps
  ```

- Listar todos los contenedores (incluyendo los detenidos):
  ```shell
  docker ps -a
  ```

- Detener un contenedor en ejecución:
  ```shell
  docker stop <container_id>
  ```

- Eliminar un contenedor:
  ```shell
  docker rm <container_id>
  ```

## 5. Crear tu propia imagen

Crearemos un contenedor que ejecuta un script de Python que imprime "Hola, Mundo!".

1. Crea una carpeta para tu proyecto y coloca tu script Python en ella. Asegúrate de que el script se llame `hello.py` y contenga el siguiente código:

    ```python
    print("Hola, Mundo!")
    ```

1. Crea un archivo llamado `Dockerfile` (sin extensión) en la misma carpeta donde se encuentra tu script. El `Dockerfile` contendrá las instrucciones para construir la imagen de Docker. Aquí está el contenido del `Dockerfile`:

    ```Dockerfile
    # Usa una imagen base de Python
    FROM python:3.11

    # Establece el directorio de trabajo en el contenedor
    WORKDIR /app

    # Copia el script Python al contenedor
    COPY hello.py .

    # Ejecuta el script cuando el contenedor se inicie
    CMD ["python", "hello.py"]
    ```

    Este `Dockerfile` utiliza la imagen oficial de Python 3.8 como base y establece el directorio de trabajo en `/app`. Luego, copia el script `hello.py` al contenedor y especifica que debe ejecutarse cuando se inicie el contenedor.

1. Abre una terminal en la misma carpeta donde se encuentran el `Dockerfile` y `hello.py` y construye la imagen con el siguiente comando:

    ```shell
    docker build -t mi-imagen-python .
    ```

    Esto construirá una imagen llamada `mi-imagen-python` a partir del `Dockerfile` y los archivos en el directorio actual (`.`).

1.  Una vez que la imagen se haya construido, puedes ejecutar un contenedor basado en esta imagen con el siguiente comando:

    ```shell
    docker run mi-imagen-python
    ```

    El contenedor se iniciará y ejecutará el script Python, lo que imprimirá "Hola, Mundo!" en la salida.

    ¡Eso es todo! Has creado una imagen de Docker para una aplicación simple de Python y ejecutado un contenedor a partir de esa imagen. Puedes personalizar el script y el `Dockerfile` según tus necesidades para crear contenedores con aplicaciones de Python más complejas.

## 6. Publicar y compartir imágenes

Puedes publicar tus imágenes de Docker en Docker Hub u otros registros de contenedores para compartir con otros. Primero, debes etiquetar tu imagen con tu nombre de usuario en Docker Hub:

```shell
docker tag mi-imagen-python nombre_de_usuario/mi-imagen-python
```

Luego, puedes subir tu imagen:

```shell
docker push nombre_de_usuario/mi-imagen-python
```

Otros usuarios pueden descargar tu imagen desde el registro y ejecutarla en sus sistemas.

## 7. Docker-compose

Docker Compose es una herramienta que facilita la gestión de aplicaciones multi-contenedor. Te permite definir la configuración de tus servicios, redes y volúmenes en un archivo YAML llamado `docker-compose.yml` y luego iniciar todos los contenedores y recursos relacionados con un solo comando.

### Instalación de Docker Compose

Docker Compose generalmente se instala automáticamente junto con Docker Desktop en sistemas Windows y macOS. Sin embargo, en sistemas Linux, es posible que debas instalarlo por separado. Puedes descargar la última versión de Docker Compose desde el [sitio web oficial de Docker Compose](https://docs.docker.com/compose/install/).

### Creación de un archivo `docker-compose.yml`

Para comenzar a usar Docker Compose, crea un archivo llamado `docker-compose.yml` en el directorio de tu proyecto. En este archivo, puedes definir la configuración de tus servicios, redes y volúmenes. Aquí hay un ejemplo de un `docker-compose.yml` simple para ejecutar una aplicación web de Python con una base de datos:

```yaml
version: '3'
services:
  web:
    image: mi-imagen-python  # Utiliza la imagen que creaste anteriormente
    ports:
      - "8000:8000"
  db:
    image: postgres:12
    environment:
      POSTGRES_PASSWORD: mi-contraseña
```

En este ejemplo, hemos definido dos servicios: uno llamado "web" que utiliza la imagen de Python que creamos previamente, y otro llamado "db" que utiliza una imagen oficial de PostgreSQL. También hemos mapeado el puerto 8000 del contenedor "web" al puerto 8000 del host.

### Iniciar contenedores con Docker Compose

Una vez que hayas definido tu archivo `docker-compose.yml`, puedes iniciar todos los contenedores y servicios relacionados con el siguiente comando en el directorio de tu proyecto:

```shell
docker-compose up
```

Docker Compose descargará las imágenes necesarias, creará las redes y volúmenes si es necesario, y ejecutará los contenedores según la configuración especificada en el archivo `docker-compose.yml`.

### Detener y eliminar contenedores

Puedes detener y eliminar los contenedores y recursos relacionados con Docker Compose utilizando el siguiente comando:

```shell
docker-compose down
```

Este comando detendrá y eliminará todos los contenedores, redes y volúmenes creados por el proyecto de Docker Compose.

Docker Compose simplifica la gestión de aplicaciones Docker con múltiples contenedores, lo que facilita la definición y ejecución de aplicaciones complejas. Puedes personalizar tu archivo `docker-compose.yml` para satisfacer las necesidades específicas de tu proyecto.


# Referencias

1. Basado en A simple Python app for [Docker's Python Language Guide](https://docs.docker.com/language/python).


