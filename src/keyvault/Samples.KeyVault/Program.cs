namespace Samples.KeyVault
{
    using System;
    using Microsoft.Azure.KeyVault;
    using Microsoft.Azure.KeyVault.Models;
    using Microsoft.Azure.Services.AppAuthentication;
    using Microsoft.Extensions.Configuration;
    using Microsoft.Extensions.Configuration.AzureKeyVault;
    using Microsoft.Extensions.DependencyInjection;
    using Microsoft.Extensions.Logging;

    class Program
    {
        static void Main()
        {
            var services = new ServiceCollection()
                .AddLogging(loggingBuilder => loggingBuilder.AddConsole(options => options.IncludeScopes = true));
            
            var logger = services.BuildServiceProvider().GetRequiredService<ILogger<Program>>();
            
            logger.LogInformation("Starting key vault sample...");

            var builder = new ConfigurationBuilder()
                .AddJsonFile("appsettings.json");

            IConfiguration configuration = builder.Build();

            try
            {
                var myKeyVaultUri = configuration["MyKeyVault"];

                if (!string.IsNullOrEmpty(myKeyVaultUri))
                {
                    var azureServiceTokenProvider = new AzureServiceTokenProvider();

                    var keyVaultClient = new KeyVaultClient(
                        new KeyVaultClient.AuthenticationCallback(
                            azureServiceTokenProvider.KeyVaultTokenCallback));

                    builder
                        .AddAzureKeyVault(myKeyVaultUri,
                            keyVaultClient, new DefaultKeyVaultSecretManager());

                    configuration = builder.Build();
                }
            }
            catch (KeyVaultErrorException kve)
            {
                logger.LogWarning(kve.Message);
            }
            catch (Exception e)
            {
                logger.LogError(e.Message);
            }

            var result = configuration["sqlserver-connectionstring"];
            var testvalue = configuration["TestSection:value"];
            var testname = configuration["TestSection:name"];
            
            logger.LogInformation($"result => {result}");
            logger.LogInformation($"result => {testvalue}");
            logger.LogInformation($"result => {testname}");
        }
    }
}