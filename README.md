
# Procedimento de Importação de Imagem

Este procedimento PL/SQL é responsável por excluir registros existentes na tabela IMG para um determinado ID e inserir novos registros com base nos dados da tabela temporária APEX_APPLICATION_TEMP_FILES.

## Procedimento PL/SQL

```sql
DECLARE
   lp NUMBER := 0;
BEGIN
   -- Exclui registros existentes na tabela IMG_COLABORADOR para o ID fornecido
   DELETE FROM IMG WHERE ID = :P64_ID;

   -- Itera sobre os registros da tabela temporária APEX_APPLICATION_TEMP_FILES
   FOR lp IN (SELECT * FROM APEX_APPLICATION_TEMP_FILES)
   LOOP
      -- Insere novos registros na tabela IMG
      INSERT INTO IMG (
         FILENAME,
         CONTENT,
         MIMETYPE,
         LAST_UPDATE,
         ID
      ) VALUES (
         lp.FILENAME,
         lp.BLOB_CONTENT,
         lp.MIME_TYPE,
         lp.CREATED_ON,
         :P64_ID
      );
   END LOOP;
END;
```

## Uso

Este procedimento é utilizado para atualizar ou adicionar imagens associadas a um determinado ID. Certifique-se de fornecer o valor apropriado para o item de página `P64_ID` antes de executar este bloco PL/SQL.

## Exemplo de Teste

Para testar o procedimento, você pode seguir estas etapas:

1. **Preparação**: Certifique-se de ter uma tabela temporária APEX_APPLICATION_TEMP_FILES populada com dados de imagem válidos.
2. **Configuração**: Substitua o valor de `:P64_ID` por um ID de colaborador existente.
3. **Execução**: Execute o bloco PL/SQL no Oracle APEX.
4. **Verificação**: Confirme se os registros associados ao ID foram corretamente excluídos e os novos registros foram inseridos na tabela IMG.

## Observações

- Antes de executar este bloco PL/SQL, certifique-se de que os dados na tabela temporária APEX_APPLICATION_TEMP_FILES estão corretos e contêm as informações necessárias para a inserção na tabela IMG.
- O bloco DELETE garante que registros antigos associados ao mesmo ID sejam removidos antes da inserção de novos dados.



# Atualização de Dados na Tabela EMPRESA

Este bloco SQL é responsável por atualizar os dados na tabela `EMPRESA` com informações provenientes da tabela temporária `APEX_APPLICATION_TEMP_FILES`.

## Instrução SQL

```sql
UPDATE EMPRESA
SET 
   FILENAME = (SELECT FILENAME FROM APEX_APPLICATION_TEMP_FILES),
   CONTENT = (SELECT BLOB_CONTENT FROM APEX_APPLICATION_TEMP_FILES),
   MIMETYPE = (SELECT MIME_TYPE FROM APEX_APPLICATION_TEMP_FILES),
   LAST_UPDATE = (SELECT CREATED_ON FROM APEX_APPLICATION_TEMP_FILES)
WHERE ID_EMPRESA = :GLOBAL_FK_EMPRESA;
```

## Uso

Esta instrução SQL é utilizada para atualizar os campos `FILENAME`, `CONTENT`, `MIMETYPE` e `LAST_UPDATE` na tabela `EMPRESA` com os dados correspondentes da tabela temporária `APEX_APPLICATION_TEMP_FILES`. Certifique-se de fornecer o valor apropriado para o parâmetro `:GLOBAL_EMPRESA` antes de executar esta instrução SQL.

## Observações

- Antes de executar esta instrução SQL, certifique-se de que os dados na tabela temporária `APEX_APPLICATION_TEMP_FILES` estão corretos e contêm as informações necessárias para a atualização na tabela `EMPRESA`.

