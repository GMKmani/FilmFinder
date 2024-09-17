# Stage 1: Build the .NET Core application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /app
COPY FilmFinderApi/FilmFinderApi.csproj ./FilmFinderApi/
RUN dotnet restore FilmFinderApi/FilmFinderApi.csproj
COPY . .
RUN dotnet publish -c Release -o out

# Stage 2: Run the .NET Core application
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

WORKDIR /app
COPY --from=build /app/out .

EXPOSE 80

ENTRYPOINT ["dotnet", "FilmFinderApi.dll"]
