![alt text](<Arquitetura lakehouse.drawio.png>)


# Documentação da Arquitetura

## Descrição da Arquitetura

Este projeto tem como objetivo criar uma arquitetura de processamento de dados usando serviços da AWS e ferramentas de processamento de dados. A arquitetura foi configurada para estudo e demonstração dos seguintes serviços e processos:

1. **Terraform**: Utilizado para provisionar a infraestrutura.
2. **AWS Lambda**: Função para popular dados no Amazon RDS MySQL.
3. **Amazon RDS MySQL**: Banco de dados relacional para armazenamento de dados.
4. **EC2**: Instância para execução do Airbyte.
5. **Airbyte**: Ferramenta de integração de dados para ingerir dados do MySQL para o Amazon S3 no formato Parquet.
6. **Amazon S3**: Armazenamento de dados em buckets com dados organizados nas camadas Bronze, Silver e Gold.
7. **PySpark**: Processamento de dados no formato Parquet e criação das camadas Bronze, Silver e Gold com o Delta Lake.
8. **AWS Glue**: Catalogação dos dados no Glue Data Catalog.
9. **AWS Athena**: Consulta e exploração dos dados catalogados.
10. **IAM Roles**: Gerenciamento de permissões e segurança de acesso aos serviços.
11. **CloudWatch e Slack**: Monitoramento de erros e atividades na arquitetura.

## Detalhes da Arquitetura

### Provisionamento da Infraestrutura

Utilizei o Terraform para criar e configurar os seguintes recursos:

- **VPC**: Rede Virtual Privada para isolar a infraestrutura.
- **Subnets**: Sub-redes para segmentar o tráfego e melhorar a segurança.
- **Amazon RDS MySQL**: Instância de banco de dados relacional para armazenar os dados iniciais.

### Processamento de Dados

1. **AWS Lambda**:
   - Função Lambda criada para popular o Amazon RDS MySQL com dados.
   - Desencadeada automaticamente para processar e carregar dados novos.

2. **EC2 e Airbyte**:
   - Instância EC2 provisionada e configurada com o Airbyte.
   - Airbyte realiza a ingestão dos dados do MySQL para o Amazon S3, transformando-os para o formato Parquet.

3. **PySpark e Delta Lake**:
   - Código PySpark desenvolvido para processar dados no formato Parquet.
   - Dados são carregados em três camadas no Amazon S3:
     - **Camada Bronze**: Dados brutos.
     - **Camada Silver**: Dados refinados.
     - **Camada Gold**: Dados agregados e otimizados.

4. **AWS Glue**:
   - Glue Crawler utilizado para catalogar os dados e criar tabelas no Glue Data Catalog.
   - Cada camada (Bronze, Silver, Gold) é representada por uma tabela correspondente.

5. **AWS Athena**:
   - Utilizado para explorar e consultar os dados catalogados no Glue Data Catalog.

### Monitoramento e Segurança

- **IAM Roles**: Configurados para gerenciar permissões e garantir segurança de acesso.
- **CloudWatch**: Monitoramento e logging das atividades na arquitetura.
- **Slack**: Notificações de erros e alertas de falhas utilizando integração com o CloudWatch.

### Eventos e Notificações

- **S3 Event Notifications**: Configuradas para acionar funções Lambda quando novos dados são carregados na Landing Zone.

## Instruções para Execução

1. **Provisionar Infraestrutura**:
   - Execute `terraform apply` para criar os recursos necessários.

2. **Configurar Airbyte**:
   - Inicie a instância EC2 e configure o Airbyte para realizar a ingestão dos dados.

3. **Executar Processamento de Dados**:
   - Utilize o PySpark para processar dados e carregá-los nas camadas Bronze, Silver e Gold.

4. **Catalogar e Explorar Dados**:
   - Configure o Glue Crawler e utilize o AWS Athena para explorar os dados.

5. **Monitoramento e Notificações**:
   - Verifique logs e configure notificações no CloudWatch e Slack.

## Conclusão

Esta arquitetura demonstra o uso integrado de várias ferramentas e serviços da AWS para criar uma solução robusta para processamento e análise de dados. A configuração e o fluxo de dados foram projetados para proporcionar um entendimento prático dos serviços e suas interações.
