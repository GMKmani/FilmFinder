
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build


WORKDIR /app


COPY FilmFinderApi/FilmFinderApi.csproj  


RUN dotnet restore


COPY FilmFinderApi/. ./


RUN dotnet publish -c Release -o out


FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

WORKDIR /app


COPY --from=build /app/out .


ENTRYPOINT ["dotnet", "FilmFinderApi.dll"]
