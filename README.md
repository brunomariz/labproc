# labproc

## Utilizando arm-utils com Docker

Para utilizar as ferramentas imediatamente basta rodar o script `run-container.sh` da seguinte forma:

```shell
~/projects/labproc$ sh ./run_container.sh
```

Isso buscará uma imagem com o pacote arm-utils já instalado e rodará o container.

A saída será algo como:

```
Unable to find image 'brunomariz/labproc:latest' locally
latest: Pulling from brunomariz/labproc
Status: Downloaded newer image for brunomariz/labproc:latest
root@bdab2dc0469e:~/src#
```

## Utilizando arm-utils

O pacote arm-utils foi desenvolvido pelo professor do lab para ajudar nas experiências. Para instalá-lo, siga as instruções em https://edisciplinas.usp.br/mod/page/view.php?id=4584513

## Utilizando Docker (forma antiga)

Utilizar pasta src para realização das experiências. **Não modificar arquivos dentro da pasta gcc-arm.**

## Setup

##### Buscar arquivos do submodulo

```shell
~/projects/labproc$ git submodule init
~/projects/labproc$ git submodule update
```

##### Criar imagem utilizando script do submodulo

```shell
~/projects/labproc$ cd gcc-arm/
~/projects/labproc/gcc-arm$ sh ./build_docker.sh
~/projects/labproc/gcc-arm$ cd ..
~/projects/labproc$
```

##### Rodar container

Tenho preferência por utilizar meu proprio comando para o docker run, pois inclui volumes compartilhados entre a pasta `src/` do repositório, não a do submodulo.

```shell
~/projects/labproc$ docker run --rm -ti -v $PWD/src:/home/student/src epiceric/gcc-arm
student:~/src$
```

Para sair do container, basta usar o comando `Ctrl+D`.
