FROM mcr.microsoft.com/mssql/server

# Set the SA password
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=<your_password>

# Create a database
ENV MSSQL_DB=OrderManagementDB

# Set the default database to the one created
ENV MSSQL_PID=Express

# Expose SQL Server port
EXPOSE 1433

# Copy SQL script and execute it
COPY init-script.sql /docker-entrypoint-initdb.d/