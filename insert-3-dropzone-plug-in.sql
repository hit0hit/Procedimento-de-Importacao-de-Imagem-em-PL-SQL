DECLARE
  CURSOR l_cur_files IS
    SELECT c001    AS filename,
           c002    AS mime_type,
           d001    AS date_created,
           n001    AS file_id,
           blob001 AS file_content
      FROM apex_collections
     WHERE collection_name = 'DROPZONE_UPLOAD';
BEGIN
  FOR l_rec_files IN l_cur_files LOOP
    INSERT INTO IMG_COLABORADOR (
        FILENAME,
        MIMETYPE,
        LAST_UPDATE,
        CONTENT,
        COLABORADOR_ID
    ) VALUES (
        l_rec_files.filename,
        l_rec_files.mime_type,
        l_rec_files.date_created,
        l_rec_files.file_content,
        :P64_COLABORADOR_ID
    );
  END LOOP;
  -- clear original apex collection (only if exist)
  IF apex_collection.collection_exists(p_collection_name => 'DROPZONE_UPLOAD') THEN
    apex_collection.delete_collection(p_collection_name => 'DROPZONE_UPLOAD');
  END IF;
END;
