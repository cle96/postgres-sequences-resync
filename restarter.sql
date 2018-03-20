  CREATE OR REPLACE FUNCTION sync_sequences(max_id integer default 0) RETURNS VOID AS
  $$
  DECLARE
    t_s record;
    last_id integer;
    tab_name VARCHAR(255);
  BEGIN
   FOR t_s IN
     (SELECT s.sequence_name from information_schema.sequences s)
   LOOP
   
     tab_name := replace(t_s.sequence_name, '_id_seq\', '\');
     last_id := max_id;
     IF last_id = 0 THEN
     EXECUTE format('SELECT MAX(t_n.id)+1 as id \' ||
                     'from %I as t_n\', tab_name)
      INTO last_id;
     END IF;

    EXECUTE 'SELECT setval($1, $2)\'
        USING  t_s.sequence_name, last_id;
   END LOOP;
  END
  $$ language plpgsql
