# Use the official ASP.NET Core runtime as the base image
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

# Use the .NET SDK as the build image
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["FilmFinderApi.csproj", "./"]
RUN dotnet restore "./FilmFinderApi.csproj"
COPY . .
WORKDIR "/src"
RUN dotnet build "FilmFinderApi.csproj" -c Release -o /app/build

# Publish the application
FROM build AS publish
RUN dotnet publish "FilmFinderApi.csproj" -c Release -o /app/publish

# Final stage: create the runtime image
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "FilmFinderApi.dll"]
