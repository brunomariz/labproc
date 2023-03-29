# labproc

Utilizar pasta src para realização das experiências. **Não modificar arquivos dentro da pasta gcc-arm.**

## Setup

##### Buscar arquivos do submodulo

```
~/projects/labproc$ git submodule init
~/projects/labproc$ git submodule update
```

##### Criar imagem utilizando script do submodulo

```
~/projects/labproc$ cd gcc-arm/
~/projects/labproc/gcc-arm$ sh ./build_docker.sh
~/projects/labproc/gcc-arm$ cd ..
~/projects/labproc$
```

##### Rodar container

Tenho preferência por utilizar meu proprio script para o docker run, pois inclui volumes compartilhados entre a pasta `src/` do repositório, não a do submodulo.

```
~/projects/labproc$ sh ./run_container.sh
student:~/src$
```

Para sair do container, basta usar o comando `Ctrl+D`.
