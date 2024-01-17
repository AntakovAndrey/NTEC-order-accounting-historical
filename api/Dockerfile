# Этап установки зависимостей и сборки приложения
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

COPY *.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish -c Debug -o /app

# Этап создания приложения
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
EXPOSE 80

COPY --from=build /app .

ENTRYPOINT ["dotnet", "api.dll"]