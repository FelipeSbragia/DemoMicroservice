FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
EXPOSE 8090
COPY DemoMicroservice.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app .
ENV ASPNETCORE_URLS http://*:8090
ENTRYPOINT ["dotnet", "DemoMicroservice.dll"]