Certamente! Aqui está o conteúdo para o seu README.md com base nas informações fornecidas:

```markdown
# Procedimento de Importação de Imagem para Colaborador

Este procedimento PL/SQL é responsável por excluir registros existentes na tabela IMG_COLABORADOR para um determinado COLABORADOR_ID e inserir novos registros com base nos dados da tabela temporária APEX_APPLICATION_TEMP_FILES.

## Procedimento PL/SQL

```sql
DECLARE
   lp NUMBER := 0;
BEGIN
   -- Exclui registros existentes na tabela IMG_COLABORADOR para o COLABORADOR_ID fornecido
   DELETE FROM IMG_COLABORADOR WHERE COLABORADOR_ID = :P64_COLABORADOR_ID;

   -- Itera sobre os registros da tabela temporária APEX_APPLICATION_TEMP_FILES
   FOR lp IN (SELECT * FROM APEX_APPLICATION_TEMP_FILES)
   LOOP
      -- Insere novos registros na tabela IMG_COLABORADOR
      INSERT INTO IMG_COLABORADOR (
         FILENAME,
         CONTENT,
         MIMETYPE,
         LAST_UPDATE,
         COLABORADOR_ID
      ) VALUES (
         lp.FILENAME,
         lp.BLOB_CONTENT,
         lp.MIME_TYPE,
         lp.CREATED_ON,
         :P64_COLABORADOR_ID
      );
   END LOOP;
END;
```

## Uso

Este procedimento é utilizado para atualizar ou adicionar imagens associadas a um determinado colaborador. Certifique-se de fornecer o valor apropriado para o item de página `P64_COLABORADOR_ID` antes de executar este bloco PL/SQL.

## Exemplo de Teste

Para testar o procedimento, você pode seguir estas etapas:

1. **Preparação**: Certifique-se de ter uma tabela temporária APEX_APPLICATION_TEMP_FILES populada com dados de imagem válidos.
2. **Configuração**: Substitua o valor de `:P64_COLABORADOR_ID` por um ID de colaborador existente.
3. **Execução**: Execute o bloco PL/SQL no Oracle APEX.
4. **Verificação**: Confirme se os registros associados ao COLABORADOR_ID foram corretamente excluídos e os novos registros foram inseridos na tabela IMG_COLABORADOR.

## Observações

- Antes de executar este bloco PL/SQL, certifique-se de que os dados na tabela temporária APEX_APPLICATION_TEMP_FILES estão corretos e contêm as informações necessárias para a inserção na tabela IMG_COLABORADOR.
- O bloco DELETE garante que registros antigos associados ao mesmo COLABORADOR_ID sejam removidos antes da inserção de novos dados.

```

Certifique-se de substituir `:P64_COLABORADOR_ID` com os valores reais necessários para o seu ambiente. Este README.md fornece informações sobre o procedimento, como usá-lo e um exemplo de teste para verificar sua funcionalidade.
