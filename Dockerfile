# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

# Copy project file
COPY ["MyDotNetApp_new.csproj", "./"]

# Restore dependencies
RUN dotnet restore

# Copy source code
COPY . .

# Build and publish application
RUN dotnet publish -c Release -o /app/publish --no-restore

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final

WORKDIR /app

EXPOSE 8080

# Copy published application
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "MyDotNetApp_new.dll"]