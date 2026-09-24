# Dockerfile del repositorio base.
# Contiene cinco malas practicas deliberadas. Cada una lleva su numero en la
# linea anterior. Corregirlas es el bloque A1 de la guia del laboratorio.

# Etapa 1: build, instala dependencias y empaqueta el handler
FROM public.ecr.aws/lambda/nodejs:20 AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY src ./src
RUN npm run build

# Etapa 2: final, solo el artefacto empaquetado
FROM public.ecr.aws/lambda/nodejs:20
COPY --from=build /app/dist/handler.js ${LAMBDA_TASK_ROOT}/handler.js
CMD ["handler.handler"]
