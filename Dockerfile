FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY ["API.Boilerplate.AspNetCore/API.Boilerplate.AspNetCore.csproj", "API.Boilerplate.AspNetCore/"]
RUN dotnet restore "API.Boilerplate.AspNetCore/API.Boilerplate.AspNetCore.csproj"
COPY . .
WORKDIR "/src/API.Boilerplate.AspNetCore"
RUN dotnet build "API.Boilerplate.AspNetCore.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "API.Boilerplate.AspNetCore.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "API.Boilerplate.AspNetCore.dll"]