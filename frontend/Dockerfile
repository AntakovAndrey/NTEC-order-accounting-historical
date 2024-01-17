# Этап сборки
FROM node:14 as build
WORKDIR /app

# Копирование зависимостей и установка
COPY package*.json ./
RUN npm install

# Копирование остальных файлов проекта и сборка
COPY . .
RUN npm run build

# Этап создания приложения
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]