# Stage 1: Build the .NET Core application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /app

# Copy the .csproj file and restore any dependencies
COPY FilmFinderApi/FilmFinderApi.csproj FilmFinderApi/
RUN dotnet restore FilmFinderApi/FilmFinderApi.csproj

# Copy the rest of the application files
COPY . .

# Publish the application
RUN dotnet publish FilmFinderApi/FilmFinderApi.csproj -c Release -o out

ENV ASPNETCORE_ENVIRONMENT=Production
ENV ASPNETCORE_URLS=http://+:8080;https://+:8443

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

COPY --from=build /app/out .

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["dotnet", "FilmFinderApi.dll"]
