# 1. Use uma imagem oficial slim do Python como imagem base.
# Ela oferece um bom equilíbrio entre tamanho e compatibilidade.
FROM python:3.11-slim

# 2. Defina o diretório de trabalho no contêiner como /app
WORKDIR /app

# 3. Copie o arquivo de dependências primeiro para aproveitar o cache de build do Docker.
# Se o requirements.txt não mudar, esta camada não será reexecutada.
COPY requirements.txt .

# 4. Instale os pacotes necessários especificados no requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copie o restante do código da aplicação para o contêiner em /app
COPY . .

# 6. Exponha a porta 8000 para permitir a comunicação com a aplicação
EXPOSE 8000

# 7. Defina o comando para executar a aplicação quando o contêiner iniciar.
# Usamos --host 0.0.0.0 para tornar o servidor acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]