# Use the official .NET 8 SDK image for the build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the project file(s) into the container
COPY FilmFinderApi.csproj ./

# Restore dependencies
RUN dotnet restore

# Copy the rest of the application code into the container
COPY . ./

# Build and publish the application
RUN dotnet publish -c Release -o out

# Use the official .NET runtime image for the runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

# Set the working directory in the container
WORKDIR /app

# Copy the published application from the build stage
COPY --from=build /app/out .

# Specify the entry point of the application
ENTRYPOINT ["dotnet", "FilmFinderApi.dll"]
