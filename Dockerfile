# Use the official .NET 8 SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the .csproj file and restore any dependencies
COPY FilmFinderApi.csproj ./
RUN dotnet restore FilmFinderApi.csproj

# Copy the rest of the application code
COPY . ./

# Build the application
RUN dotnet build FilmFinderApi.csproj -c Release -o /app/build

# Publish the application
RUN dotnet publish FilmFinderApi.csproj -c Release -o /app/publish

# Use the official .NET 8 ASP.NET runtime image to run the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

# Set the working directory inside the container
WORKDIR /app

# Copy the published output from the build stage
COPY --from=build /app/publish .

# Expose the port the app runs on
EXPOSE 80

# Set the entry point for the container
ENTRYPOINT ["dotnet", "FilmFinderApi.dll"]
