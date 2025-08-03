# Desafio Full Cycle 3.0 - Docker e Go

Este repositório contém a solução para o desafio do módulo de Docker do curso Full Cycle 3.0.

## O Desafio

O objetivo deste desafio é criar uma imagem Docker que, ao ser executada, imprima a mensagem "Full Cycle Rocks!!". A imagem final deve ter menos de 2MB.

## Solução

Para resolver este desafio, foi utilizada a linguagem Go para criar um programa simples que imprime a mensagem solicitada. O Dockerfile foi construído utilizando uma abordagem de multi-stage build para garantir que a imagem final seja a menor possível.

### O código Go (`hello.go`)

```go
package main

import "fmt"

func main() {
    fmt.Println("Full Cycle Rocks!!")
}
```

### O Dockerfile

```dockerfile
FROM golang:1.24.4-alpine AS builder

WORKDIR /app

COPY go.mod ./
COPY go.sum ./

COPY hello.go .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags="-s -w" -o hello .

FROM scratch

WORKDIR /app

COPY --from=builder /app/hello .

CMD ["./hello"]
```

## Como executar

1.  **Construa a imagem Docker:**

    ```bash
    docker build -t seu-user/fullcycle .
    ```

2.  **Execute a imagem:**

    ```bash
    docker run seu-user/fullcycle
    ```

    A saída esperada é:

    ```
    Full Cycle Rocks!!
    ```

## Imagem no Docker Hub

A imagem Docker resultante deste projeto está disponível no Docker Hub. Para executá-la diretamente, utilize o seguinte comando:

```bash
docker run rubenfabiodev/fullcycle:latest
```

**Link do repositório no Docker Hub:** [https://hub.docker.com/r/rubenfabiodev/fullcycle](https://hub.docker.com/r/rubenfabiodev/fullcycle)
