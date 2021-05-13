FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY publish/web .

ENV ASPNETCORE_ENVIRONMENT="Vagrant"

HEALTHCHECK CMD curl --fail http://localhost:8999/healthcheck || exit 1
ENTRYPOINT ["dotnet", "API.Boilerplate.AspNetCore.dll"]