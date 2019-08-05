FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build
WORKDIR /src
COPY ["testGitApp.csproj", ""]
RUN dotnet restore "testGitApp.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "testGitApp.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "testGitApp.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "testGitApp.dll"]