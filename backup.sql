--
-- PostgreSQL database cluster dump
--

\restrict q7aoFalAkbqqvlOMO3UACIn4H7AggERmBWaLCalndo3UcZTu19CIBeU77Whx9GC

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE anon;
ALTER ROLE anon WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE authenticated;
ALTER ROLE authenticated WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE authenticator;
ALTER ROLE authenticator WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE dashboard_user;
ALTER ROLE dashboard_user WITH NOSUPERUSER INHERIT CREATEROLE CREATEDB NOLOGIN REPLICATION NOBYPASSRLS;
CREATE ROLE pgbouncer;
ALTER ROLE pgbouncer WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE postgres;
ALTER ROLE postgres WITH NOSUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;
CREATE ROLE service_role;
ALTER ROLE service_role WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION BYPASSRLS;
CREATE ROLE supabase_admin;
ALTER ROLE supabase_admin WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;
CREATE ROLE supabase_auth_admin;
ALTER ROLE supabase_auth_admin WITH NOSUPERUSER NOINHERIT CREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE supabase_read_only_user;
ALTER ROLE supabase_read_only_user WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION BYPASSRLS;
CREATE ROLE supabase_realtime_admin;
ALTER ROLE supabase_realtime_admin WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE supabase_replication_admin;
ALTER ROLE supabase_replication_admin WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN REPLICATION NOBYPASSRLS;
CREATE ROLE supabase_storage_admin;
ALTER ROLE supabase_storage_admin WITH NOSUPERUSER NOINHERIT CREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;

--
-- User Configurations
--

--
-- User Config "anon"
--

ALTER ROLE anon SET statement_timeout TO '3s';

--
-- User Config "authenticated"
--

ALTER ROLE authenticated SET statement_timeout TO '8s';

--
-- User Config "authenticator"
--

ALTER ROLE authenticator SET session_preload_libraries TO 'safeupdate';
ALTER ROLE authenticator SET statement_timeout TO '8s';
ALTER ROLE authenticator SET lock_timeout TO '8s';

--
-- User Config "postgres"
--

ALTER ROLE postgres SET search_path TO E'\\$user', 'public', 'extensions';

--
-- User Config "supabase_admin"
--

ALTER ROLE supabase_admin SET search_path TO '$user', 'public', 'auth', 'extensions';
ALTER ROLE supabase_admin SET log_statement TO 'none';

--
-- User Config "supabase_auth_admin"
--

ALTER ROLE supabase_auth_admin SET search_path TO 'auth';
ALTER ROLE supabase_auth_admin SET idle_in_transaction_session_timeout TO '60000';
ALTER ROLE supabase_auth_admin SET log_statement TO 'none';

--
-- User Config "supabase_storage_admin"
--

ALTER ROLE supabase_storage_admin SET search_path TO 'storage';
ALTER ROLE supabase_storage_admin SET log_statement TO 'none';


--
-- Role memberships
--

GRANT anon TO authenticator GRANTED BY postgres;
GRANT anon TO postgres GRANTED BY supabase_admin;
GRANT authenticated TO authenticator GRANTED BY postgres;
GRANT authenticated TO postgres GRANTED BY supabase_admin;
GRANT authenticator TO supabase_storage_admin GRANTED BY supabase_admin;
GRANT pg_monitor TO postgres GRANTED BY supabase_admin;
GRANT pg_read_all_data TO postgres GRANTED BY supabase_admin;
GRANT pg_read_all_data TO supabase_read_only_user GRANTED BY postgres;
GRANT pg_signal_backend TO postgres GRANTED BY supabase_admin;
GRANT service_role TO authenticator GRANTED BY postgres;
GRANT service_role TO postgres GRANTED BY supabase_admin;
GRANT supabase_realtime_admin TO postgres GRANTED BY supabase_admin;






\unrestrict q7aoFalAkbqqvlOMO3UACIn4H7AggERmBWaLCalndo3UcZTu19CIBeU77Whx9GC

--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

\restrict OxiobfBTAt9kdi9kPgQoFn3nLR3DwZFlbygCdtOW5nXah7RD7CDsLCgrcw46q5h

-- Dumped from database version 15.8
-- Dumped by pg_dump version 15.14 (Debian 15.14-1.pgdg12+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

\unrestrict OxiobfBTAt9kdi9kPgQoFn3nLR3DwZFlbygCdtOW5nXah7RD7CDsLCgrcw46q5h

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

\restrict mX4Y7G2ZrvjMGbeDHn6DZK0T4Glk2IWfx7alKPbkYVNYOQ72zBn8GpdLv5u9B9Y

-- Dumped from database version 15.8
-- Dumped by pg_dump version 15.14 (Debian 15.14-1.pgdg12+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: pgjwt; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;


--
-- Name: EXTENSION pgjwt; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgjwt IS 'JSON Web Token API for Postgresql';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: carts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carts (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    buyer_id uuid,
    product_id uuid,
    farmer_id uuid,
    quantity integer NOT NULL,
    price numeric NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.carts OWNER TO postgres;

--
-- Name: favorites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favorites (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    buyer_id uuid,
    product_id uuid,
    farmer_id uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.favorites OWNER TO postgres;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    buyer_id uuid,
    farmer_id uuid,
    product_id uuid,
    quantity integer NOT NULL,
    status text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    billing_details jsonb DEFAULT '{"email": "", "fullName": "", "location": "", "townCity": "", "phoneNumber": "", "order_amount": 0.00}'::jsonb,
    CONSTRAINT orders_status_check CHECK ((status = ANY (ARRAY['Pending'::text, 'Confirmed'::text, 'Shipped'::text, 'Delivered'::text, 'Cancelled'::text])))
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    farmer_id uuid,
    name text NOT NULL,
    description text,
    price numeric NOT NULL,
    category text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    images jsonb DEFAULT '[]'::jsonb,
    stock integer DEFAULT 0 NOT NULL,
    status text DEFAULT 'active'::text NOT NULL,
    CONSTRAINT products_status_check CHECK ((status = ANY (ARRAY['active'::text, 'inactive'::text])))
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    product_id uuid,
    buyer_id uuid,
    rating integer NOT NULL,
    comment text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: farmer_analytics; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.farmer_analytics AS
 SELECT p.farmer_id,
    count(DISTINCT o.id) AS total_orders,
    sum(((o.quantity)::numeric * p.price)) AS total_sales,
    count(DISTINCT p.id) AS products_listed,
    avg(r.rating) AS average_rating,
    count(DISTINCT f.id) AS favorite_count
   FROM (((public.products p
     LEFT JOIN public.orders o ON ((p.id = o.product_id)))
     LEFT JOIN public.reviews r ON ((p.id = r.product_id)))
     LEFT JOIN public.favorites f ON (((p.id = f.product_id) OR (p.farmer_id = f.farmer_id))))
  GROUP BY p.farmer_id;


ALTER TABLE public.farmer_analytics OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    sender_id uuid,
    receiver_id uuid,
    content text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status text DEFAULT 'sent'::text,
    product_id uuid,
    CONSTRAINT messages_status_check CHECK ((status = ANY (ARRAY['sent'::text, 'delivered'::text, 'read'::text])))
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    email text NOT NULL,
    role text NOT NULL,
    name text NOT NULL,
    location text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    phone_number text,
    CONSTRAINT users_role_check CHECK ((role = ANY (ARRAY['Farmer'::text, 'Buyer'::text, 'Admin'::text])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: messages_2025_07_17; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_17 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_17 OWNER TO supabase_admin;

--
-- Name: messages_2025_07_18; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_18 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_18 OWNER TO supabase_admin;

--
-- Name: messages_2025_07_19; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_19 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_19 OWNER TO supabase_admin;

--
-- Name: messages_2025_07_20; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_20 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_20 OWNER TO supabase_admin;

--
-- Name: messages_2025_07_21; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_21 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_21 OWNER TO supabase_admin;

--
-- Name: messages_2025_07_22; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_22 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_22 OWNER TO supabase_admin;

--
-- Name: messages_2025_07_23; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_23 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_23 OWNER TO supabase_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: messages_2025_07_17; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_17 FOR VALUES FROM ('2025-07-17 00:00:00') TO ('2025-07-18 00:00:00');


--
-- Name: messages_2025_07_18; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_18 FOR VALUES FROM ('2025-07-18 00:00:00') TO ('2025-07-19 00:00:00');


--
-- Name: messages_2025_07_19; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_19 FOR VALUES FROM ('2025-07-19 00:00:00') TO ('2025-07-20 00:00:00');


--
-- Name: messages_2025_07_20; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_20 FOR VALUES FROM ('2025-07-20 00:00:00') TO ('2025-07-21 00:00:00');


--
-- Name: messages_2025_07_21; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_21 FOR VALUES FROM ('2025-07-21 00:00:00') TO ('2025-07-22 00:00:00');


--
-- Name: messages_2025_07_22; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_22 FOR VALUES FROM ('2025-07-22 00:00:00') TO ('2025-07-23 00:00:00');


--
-- Name: messages_2025_07_23; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_23 FOR VALUES FROM ('2025-07-23 00:00:00') TO ('2025-07-24 00:00:00');


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	41a35f5d-2c52-448d-81d5-4968274c021e	{"action":"user_signedup","actor_id":"21c696ec-860c-488d-9955-c4248ff7bd9f","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-03 23:37:45.885865+00	
00000000-0000-0000-0000-000000000000	7775f45f-c23f-4864-97e9-8ac88bc50a67	{"action":"login","actor_id":"21c696ec-860c-488d-9955-c4248ff7bd9f","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-03 23:37:45.891644+00	
00000000-0000-0000-0000-000000000000	b5ebe222-4adb-4a12-a9bf-e00185eada72	{"action":"user_signedup","actor_id":"b82905e5-8bb4-45fe-a9bd-b1239867cb1e","actor_username":"test@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-03 23:40:29.307133+00	
00000000-0000-0000-0000-000000000000	2ce71ccf-529b-4f04-ab11-a96da5fba0e2	{"action":"login","actor_id":"b82905e5-8bb4-45fe-a9bd-b1239867cb1e","actor_username":"test@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-03 23:40:29.310994+00	
00000000-0000-0000-0000-000000000000	3f4f78f2-010c-4e6e-8ab1-d9c4dc1f93c2	{"action":"user_repeated_signup","actor_id":"b82905e5-8bb4-45fe-a9bd-b1239867cb1e","actor_username":"test@example.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-04 11:26:14.45064+00	
00000000-0000-0000-0000-000000000000	9cfeb493-fd69-4ae6-bbd9-41ce26ae2fe5	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"admin1@example.com","user_id":"21c696ec-860c-488d-9955-c4248ff7bd9f","user_phone":""}}	2025-05-04 11:26:59.384673+00	
00000000-0000-0000-0000-000000000000	c3cb1ecd-a47f-405a-b28c-703d65d3220a	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"test@example.com","user_id":"b82905e5-8bb4-45fe-a9bd-b1239867cb1e","user_phone":""}}	2025-05-04 11:26:59.389195+00	
00000000-0000-0000-0000-000000000000	8bb91086-8cd0-4fe7-bcd9-bb5dc4c2aef8	{"action":"user_signedup","actor_id":"c529531b-876a-4c85-892f-a6fb850694f4","actor_username":"test@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-04 11:27:08.543174+00	
00000000-0000-0000-0000-000000000000	0d20edde-04d1-48eb-85de-e10f0fdaf4f4	{"action":"login","actor_id":"c529531b-876a-4c85-892f-a6fb850694f4","actor_username":"test@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 11:27:08.547222+00	
00000000-0000-0000-0000-000000000000	543eabd4-b92b-4ba5-9861-2b9b2a2b4262	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"test@example.com","user_id":"c529531b-876a-4c85-892f-a6fb850694f4","user_phone":""}}	2025-05-04 11:38:12.596824+00	
00000000-0000-0000-0000-000000000000	bf63169a-1cab-44c8-863a-ce94c7dfa6cf	{"action":"user_signedup","actor_id":"e6964f3a-9d65-4144-a056-a2041316e883","actor_username":"test@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-04 11:38:48.932437+00	
00000000-0000-0000-0000-000000000000	c0715b65-6423-472a-b4e4-f1452c758a5d	{"action":"login","actor_id":"e6964f3a-9d65-4144-a056-a2041316e883","actor_username":"test@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 11:38:48.936409+00	
00000000-0000-0000-0000-000000000000	ab66764b-a8fe-4a9b-befb-9676c925e067	{"action":"login","actor_id":"e6964f3a-9d65-4144-a056-a2041316e883","actor_username":"test@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 11:38:49.595622+00	
00000000-0000-0000-0000-000000000000	bf4afa18-e486-4767-ab80-547acf5e7e8f	{"action":"logout","actor_id":"e6964f3a-9d65-4144-a056-a2041316e883","actor_username":"test@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-04 11:38:50.42828+00	
00000000-0000-0000-0000-000000000000	ea15019c-658f-47f9-8604-e7d01ded2011	{"action":"user_signedup","actor_id":"03fc3c70-4d5a-495d-9741-ea8d21b59542","actor_username":"farmer@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-04 11:43:26.390993+00	
00000000-0000-0000-0000-000000000000	f042093a-7aa1-4cd3-963d-adfb898bbfe5	{"action":"login","actor_id":"03fc3c70-4d5a-495d-9741-ea8d21b59542","actor_username":"farmer@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 11:43:26.39496+00	
00000000-0000-0000-0000-000000000000	3cc0c23e-276a-40ad-87b7-a4539bf507ff	{"action":"login","actor_id":"03fc3c70-4d5a-495d-9741-ea8d21b59542","actor_username":"farmer@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 11:43:27.201285+00	
00000000-0000-0000-0000-000000000000	55df12a1-1b0f-4463-9493-5c483437b170	{"action":"user_signedup","actor_id":"6e632bcf-ec95-413b-b00a-f7d1e9527bbf","actor_username":"user1@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-04 11:46:59.83666+00	
00000000-0000-0000-0000-000000000000	f04acbae-af3c-4030-8d4a-ba5857158619	{"action":"login","actor_id":"6e632bcf-ec95-413b-b00a-f7d1e9527bbf","actor_username":"user1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 11:46:59.84233+00	
00000000-0000-0000-0000-000000000000	b97e34af-0d98-4668-80d6-1bf38adadee5	{"action":"user_signedup","actor_id":"40930511-5d56-4977-bfad-9304cd9b4257","actor_username":"user2@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-04 11:47:00.396616+00	
00000000-0000-0000-0000-000000000000	44d4b134-0b11-4e48-98c7-76579cf5a608	{"action":"login","actor_id":"40930511-5d56-4977-bfad-9304cd9b4257","actor_username":"user2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 11:47:00.399577+00	
00000000-0000-0000-0000-000000000000	d5064080-37b2-4161-9e12-8031bcb6ac97	{"action":"login","actor_id":"6e632bcf-ec95-413b-b00a-f7d1e9527bbf","actor_username":"user1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 11:47:00.91419+00	
00000000-0000-0000-0000-000000000000	e5ca8f8c-63fb-4536-9f72-8ef1eda58fc5	{"action":"user_repeated_signup","actor_id":"40930511-5d56-4977-bfad-9304cd9b4257","actor_username":"user2@example.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-04 11:47:01.542597+00	
00000000-0000-0000-0000-000000000000	3d018f25-ee55-4632-be7c-cdff88c884b1	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"user1@example.com","user_id":"6e632bcf-ec95-413b-b00a-f7d1e9527bbf","user_phone":""}}	2025-05-04 12:09:15.44366+00	
00000000-0000-0000-0000-000000000000	d2220259-541c-449b-9eb4-db0eed37e80b	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"user2@example.com","user_id":"40930511-5d56-4977-bfad-9304cd9b4257","user_phone":""}}	2025-05-04 12:09:15.454411+00	
00000000-0000-0000-0000-000000000000	c429c840-f2a8-449b-9ae5-524c1df169f6	{"action":"user_signedup","actor_id":"b79308a2-e783-4e3e-a726-0ba80dbe527b","actor_username":"user1_1746360583618@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-04 12:09:45.409158+00	
00000000-0000-0000-0000-000000000000	d4d36c49-b948-4922-ac03-d687c775e27e	{"action":"login","actor_id":"b79308a2-e783-4e3e-a726-0ba80dbe527b","actor_username":"user1_1746360583618@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 12:09:45.412697+00	
00000000-0000-0000-0000-000000000000	ea465474-0afe-4e8f-b251-13a63da86998	{"action":"login","actor_id":"b79308a2-e783-4e3e-a726-0ba80dbe527b","actor_username":"user1_1746360583618@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 12:09:46.199133+00	
00000000-0000-0000-0000-000000000000	6aac8339-18f0-4192-979a-7daae11cbaea	{"action":"user_signedup","actor_id":"5b7f9e26-c12b-42d0-97f0-232dd1615add","actor_username":"user2_1746360583618@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-04 12:09:48.080246+00	
00000000-0000-0000-0000-000000000000	c078dc0a-7cb9-400b-bc7b-4be37f97da8a	{"action":"login","actor_id":"5b7f9e26-c12b-42d0-97f0-232dd1615add","actor_username":"user2_1746360583618@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 12:09:48.083097+00	
00000000-0000-0000-0000-000000000000	753dc7cd-e23b-41e2-9bfe-31f4dee18353	{"action":"login","actor_id":"5b7f9e26-c12b-42d0-97f0-232dd1615add","actor_username":"user2_1746360583618@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 12:09:48.590112+00	
00000000-0000-0000-0000-000000000000	61675c04-83fe-48a2-80ed-9890e5cb99a5	{"action":"user_signedup","actor_id":"a2dca14c-8ce6-42d6-bc9d-f5cc969ca416","actor_username":"user1_1746363148413@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-04 12:52:30.300952+00	
00000000-0000-0000-0000-000000000000	ae119b5c-77b6-441d-83a1-2c7673f9f9f0	{"action":"login","actor_id":"a2dca14c-8ce6-42d6-bc9d-f5cc969ca416","actor_username":"user1_1746363148413@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 12:52:30.305945+00	
00000000-0000-0000-0000-000000000000	63316d58-a942-40dc-87d6-4ce305dafff6	{"action":"login","actor_id":"a2dca14c-8ce6-42d6-bc9d-f5cc969ca416","actor_username":"user1_1746363148413@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 12:52:31.141077+00	
00000000-0000-0000-0000-000000000000	a1519dd7-16d1-48c5-8c25-f5f9ecc00ce2	{"action":"user_signedup","actor_id":"00815a59-3a7b-4c68-be17-fff474e86a56","actor_username":"user2_1746363148413@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-04 12:52:32.203885+00	
00000000-0000-0000-0000-000000000000	1e23ed09-df63-4b68-bfac-819c9fa688ab	{"action":"login","actor_id":"00815a59-3a7b-4c68-be17-fff474e86a56","actor_username":"user2_1746363148413@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 12:52:32.206791+00	
00000000-0000-0000-0000-000000000000	9e4c6eee-49b0-4cad-989b-f39fbdc6c178	{"action":"login","actor_id":"00815a59-3a7b-4c68-be17-fff474e86a56","actor_username":"user2_1746363148413@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 12:52:33.384232+00	
00000000-0000-0000-0000-000000000000	7465db22-d8c6-47a9-8055-590d295abdb6	{"action":"user_signedup","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-04 13:59:51.2601+00	
00000000-0000-0000-0000-000000000000	04c1f892-2173-4c97-9206-5a3531ba2c65	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 13:59:51.264018+00	
00000000-0000-0000-0000-000000000000	0c8aa226-8b36-47df-b8e8-c21599265fa3	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-04 14:02:16.569795+00	
00000000-0000-0000-0000-000000000000	a2370f32-24e2-4f8d-b5c4-5fa6df466313	{"action":"user_signedup","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-04 14:03:13.415724+00	
00000000-0000-0000-0000-000000000000	3251ff30-4392-486f-936c-faeb95b17c88	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 14:03:13.420022+00	
00000000-0000-0000-0000-000000000000	8314e448-4927-43ef-b471-27f0bf134f26	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-04 14:04:25.632341+00	
00000000-0000-0000-0000-000000000000	1adb5933-ab75-4df4-b3c5-8b057fef5ea0	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 14:04:45.978554+00	
00000000-0000-0000-0000-000000000000	52d97cc9-de89-4afa-93bd-35a734a9e08c	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-04 14:05:04.214347+00	
00000000-0000-0000-0000-000000000000	0690140b-b33b-483a-84c1-54976f5b7a81	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 14:05:22.284539+00	
00000000-0000-0000-0000-000000000000	ad336856-57c6-43f4-99ff-39f88b6712be	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-04 14:05:50.679674+00	
00000000-0000-0000-0000-000000000000	06d0adf8-9098-4afc-aaac-37d68dd72a67	{"action":"user_signedup","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-04 14:06:28.307097+00	
00000000-0000-0000-0000-000000000000	3b265771-c07b-4a83-af38-286cac3d9f86	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 14:06:28.31026+00	
00000000-0000-0000-0000-000000000000	3273e24d-9aa2-40f7-a81d-4e947b5115bc	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"user2_1746363148413@example.com","user_id":"00815a59-3a7b-4c68-be17-fff474e86a56","user_phone":""}}	2025-05-04 14:14:38.909753+00	
00000000-0000-0000-0000-000000000000	1c36266a-c1ac-4ee4-9b8c-880541f67248	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"user1_1746363148413@example.com","user_id":"a2dca14c-8ce6-42d6-bc9d-f5cc969ca416","user_phone":""}}	2025-05-04 14:14:38.956133+00	
00000000-0000-0000-0000-000000000000	144e564f-8bac-4d71-a578-141aad66434e	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"farmer@example.com","user_id":"03fc3c70-4d5a-495d-9741-ea8d21b59542","user_phone":""}}	2025-05-04 14:14:39.016453+00	
00000000-0000-0000-0000-000000000000	1197cb24-d153-444b-a8d3-05962d203d2e	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"user2_1746360583618@example.com","user_id":"5b7f9e26-c12b-42d0-97f0-232dd1615add","user_phone":""}}	2025-05-04 14:14:39.030502+00	
00000000-0000-0000-0000-000000000000	43cff908-537b-463f-9d58-80fcd650fcfc	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"user1_1746360583618@example.com","user_id":"b79308a2-e783-4e3e-a726-0ba80dbe527b","user_phone":""}}	2025-05-04 14:14:41.074515+00	
00000000-0000-0000-0000-000000000000	a6cb4df7-db3b-4573-9e7e-e87840ed246f	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"test@example.com","user_id":"e6964f3a-9d65-4144-a056-a2041316e883","user_phone":""}}	2025-05-04 14:15:04.468553+00	
00000000-0000-0000-0000-000000000000	3822dbb9-d151-4eca-b6af-2f6d4522c85d	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-04 14:27:12.033641+00	
00000000-0000-0000-0000-000000000000	be30b4f0-38d7-4497-be54-410c9996fd59	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 14:27:56.877455+00	
00000000-0000-0000-0000-000000000000	b320648a-dc8a-4121-b405-7dc62a827608	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-04 14:28:38.456188+00	
00000000-0000-0000-0000-000000000000	447701b1-e00c-4414-a42e-76c8aa0dda90	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-04 14:28:58.713693+00	
00000000-0000-0000-0000-000000000000	4225ab9b-ea06-44e7-9ca9-1d40a189f877	{"action":"token_refreshed","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-06 13:11:26.776977+00	
00000000-0000-0000-0000-000000000000	e5204168-2475-48b8-ae48-0f802795184f	{"action":"token_revoked","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-06 13:11:26.791704+00	
00000000-0000-0000-0000-000000000000	34211852-3dce-4207-8a61-b6ebf25cd28a	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-06 13:12:36.798684+00	
00000000-0000-0000-0000-000000000000	23d90f98-5c56-4181-aa38-a236fc9ccb19	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-06 14:02:20.744997+00	
00000000-0000-0000-0000-000000000000	a86f5991-aa5f-41f8-88a8-1c08de9b149f	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-06 14:03:27.804532+00	
00000000-0000-0000-0000-000000000000	d886e870-082b-4054-895d-ed2ce9c8a96a	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-06 14:03:48.636527+00	
00000000-0000-0000-0000-000000000000	c3ff8dbe-93df-4f6e-8035-874a74ba84f7	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-06 14:05:18.867201+00	
00000000-0000-0000-0000-000000000000	2fe973e9-7676-4a92-a237-4f4c1392a03a	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-06 14:05:46.996056+00	
00000000-0000-0000-0000-000000000000	e9c9d323-678e-441c-a676-d875b9190278	{"action":"user_signedup","actor_id":"249290fd-351f-4161-9e75-6e040503df35","actor_username":"user1_1746540576227@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-06 14:09:36.882902+00	
00000000-0000-0000-0000-000000000000	2178d5ac-c1d5-489a-b51b-56dc90376600	{"action":"login","actor_id":"249290fd-351f-4161-9e75-6e040503df35","actor_username":"user1_1746540576227@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-06 14:09:36.890254+00	
00000000-0000-0000-0000-000000000000	28c3dda7-9b76-41cf-b0d4-e79e69d37963	{"action":"login","actor_id":"249290fd-351f-4161-9e75-6e040503df35","actor_username":"user1_1746540576227@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-06 14:09:37.675736+00	
00000000-0000-0000-0000-000000000000	88d791a8-89f2-44b8-a2c0-abe22ff5a374	{"action":"user_signedup","actor_id":"d3304fc8-9f80-4556-a8c8-2715de7acc19","actor_username":"user2_1746540576227@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-06 14:09:38.48276+00	
00000000-0000-0000-0000-000000000000	7aa03fee-2229-4d8d-99fd-c5fa8deb1bbc	{"action":"login","actor_id":"d3304fc8-9f80-4556-a8c8-2715de7acc19","actor_username":"user2_1746540576227@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-06 14:09:38.485899+00	
00000000-0000-0000-0000-000000000000	16fad1e5-326e-42ad-8ed1-23472d2d67a2	{"action":"login","actor_id":"d3304fc8-9f80-4556-a8c8-2715de7acc19","actor_username":"user2_1746540576227@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-06 14:09:39.105396+00	
00000000-0000-0000-0000-000000000000	240b6c5f-137b-4ab6-aced-962f3f035b2a	{"action":"token_refreshed","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-06 15:39:17.691622+00	
00000000-0000-0000-0000-000000000000	38734e26-68f3-40fd-a26b-15658ee5fd8d	{"action":"token_revoked","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-06 15:39:17.69316+00	
00000000-0000-0000-0000-000000000000	3e03b1dc-c73d-44ba-8adc-4d7190213bb2	{"action":"token_refreshed","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-08 14:08:47.148283+00	
00000000-0000-0000-0000-000000000000	f0f7632a-335a-4485-b8d8-f347c5b6ec84	{"action":"token_revoked","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-08 14:08:47.16856+00	
00000000-0000-0000-0000-000000000000	7825196e-966a-4fd3-98ab-58663ec2ea9b	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-08 14:38:03.330618+00	
00000000-0000-0000-0000-000000000000	9823a4e3-6c5f-4abd-ace1-e10bed925d60	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-08 14:38:29.541467+00	
00000000-0000-0000-0000-000000000000	8f13db19-ed10-4bd2-a13f-82054021b7ee	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-08 14:39:06.922808+00	
00000000-0000-0000-0000-000000000000	0f92baa8-a38b-4212-be0d-dc995c73eb46	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-08 14:39:23.794391+00	
00000000-0000-0000-0000-000000000000	6d53ac02-444e-4f82-86b4-50e9149927a6	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-08 14:52:36.730574+00	
00000000-0000-0000-0000-000000000000	e9dd16f0-ef8a-443f-9431-0d5df726a5a9	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-08 14:53:47.129594+00	
00000000-0000-0000-0000-000000000000	4a1df2f3-82e4-43b9-b255-b887e8ddc189	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-08 14:54:12.087817+00	
00000000-0000-0000-0000-000000000000	fa53054f-ca39-45fa-9619-ba146206e9cf	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-08 14:54:32.454372+00	
00000000-0000-0000-0000-000000000000	6c66d2b5-96b4-46b3-9acc-4da0bd527730	{"action":"token_refreshed","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-09 17:20:42.299533+00	
00000000-0000-0000-0000-000000000000	67b08c99-96d3-48e2-a946-2386864fc8df	{"action":"token_revoked","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-09 17:20:42.318695+00	
00000000-0000-0000-0000-000000000000	a7cdf1b0-f5f2-4d30-a59b-a881d7d8d26e	{"action":"user_signedup","actor_id":"9baceab2-edd2-4880-be72-19643bed1cd3","actor_username":"farmer@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-09 17:22:55.000795+00	
00000000-0000-0000-0000-000000000000	20cb9a74-4abd-43c8-9d86-d70dec733510	{"action":"login","actor_id":"9baceab2-edd2-4880-be72-19643bed1cd3","actor_username":"farmer@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-09 17:22:55.012005+00	
00000000-0000-0000-0000-000000000000	12b3ff6c-70f5-4be5-9e95-71b2ca65fb89	{"action":"login","actor_id":"9baceab2-edd2-4880-be72-19643bed1cd3","actor_username":"farmer@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-09 17:22:55.547347+00	
00000000-0000-0000-0000-000000000000	8c75b4ad-c679-495d-8773-202ebcce0255	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-09 17:23:59.504367+00	
00000000-0000-0000-0000-000000000000	f8e0ad15-af91-49d5-ac8e-0bdbc332a326	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-09 17:24:41.939447+00	
00000000-0000-0000-0000-000000000000	b9b568d3-669b-4ff7-a741-e2f7def250b3	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-09 17:25:02.35481+00	
00000000-0000-0000-0000-000000000000	29dd0deb-d88e-4acf-8ab3-61e1a485900d	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-09 17:25:20.147806+00	
00000000-0000-0000-0000-000000000000	71e30c03-70ba-427f-9259-ba00c41af6b3	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-09 17:25:36.865463+00	
00000000-0000-0000-0000-000000000000	0ef915d5-9ebb-4ca9-a20b-f1e2615da459	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-09 17:34:06.273942+00	
00000000-0000-0000-0000-000000000000	0724e24c-e372-4a1c-bbc9-926739df3cd9	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-09 17:35:32.748476+00	
00000000-0000-0000-0000-000000000000	50898ba1-1fd4-4729-a3f2-2021828efe4c	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-09 17:35:51.501038+00	
00000000-0000-0000-0000-000000000000	d6e3b5b9-8d42-49f1-912e-e9da536bdbe6	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-09 17:36:01.363439+00	
00000000-0000-0000-0000-000000000000	d9bfe3dc-3522-48db-ba78-d254e59c8fa7	{"action":"user_signedup","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-09 17:36:34.017335+00	
00000000-0000-0000-0000-000000000000	82404e69-5ce1-4a21-a43b-f9675f4b8682	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-09 17:36:34.021215+00	
00000000-0000-0000-0000-000000000000	0905a21f-e670-4576-af77-37dd7c037386	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-09 17:36:46.489089+00	
00000000-0000-0000-0000-000000000000	861c3657-2c74-44e0-94eb-bb3f57cdbe5b	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-09 17:37:06.27315+00	
00000000-0000-0000-0000-000000000000	54e23e47-27f0-449d-9a32-2d59a61d0adc	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-09 18:06:11.424053+00	
00000000-0000-0000-0000-000000000000	249f0621-2842-47db-9fb4-724b14d654cc	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-09 18:06:42.929606+00	
00000000-0000-0000-0000-000000000000	f6e8f4d0-ca4f-4919-b938-01e51f608995	{"action":"token_refreshed","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-09 19:48:48.574454+00	
00000000-0000-0000-0000-000000000000	eac92d2d-e3e9-40fa-ac51-3ec236cdf80a	{"action":"token_revoked","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-09 19:48:48.575964+00	
00000000-0000-0000-0000-000000000000	9ececb39-4c31-4622-8d99-5cef2eea4885	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-09 19:51:06.440221+00	
00000000-0000-0000-0000-000000000000	01a0bf05-4a9f-4ea4-8242-860e4091ce38	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-09 19:51:24.928067+00	
00000000-0000-0000-0000-000000000000	e0cbbebd-ce79-44e9-a9ad-ecc2be7ab153	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-09 19:51:38.764394+00	
00000000-0000-0000-0000-000000000000	e1baa190-51d9-4e0e-84be-cfa346d1c983	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-09 19:51:56.96028+00	
00000000-0000-0000-0000-000000000000	1b963ef3-3228-4a21-9711-66565a161432	{"action":"token_refreshed","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-11 11:40:32.608456+00	
00000000-0000-0000-0000-000000000000	0f5c4aa1-dd71-479b-a71a-0ff9284f4cbc	{"action":"token_revoked","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-11 11:40:32.618228+00	
00000000-0000-0000-0000-000000000000	d7425ffc-2bec-4a89-b85b-907b9b901c52	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-11 11:42:55.388765+00	
00000000-0000-0000-0000-000000000000	8c176b06-1fe1-4773-92e6-026689940d66	{"action":"login","actor_id":"9baceab2-edd2-4880-be72-19643bed1cd3","actor_username":"farmer@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-11 11:43:12.038108+00	
00000000-0000-0000-0000-000000000000	fc66431c-744a-4ccf-a0bc-7dd918a72b69	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"farmer@example.com","user_id":"9baceab2-edd2-4880-be72-19643bed1cd3","user_phone":""}}	2025-05-11 11:44:05.819014+00	
00000000-0000-0000-0000-000000000000	2d1ca6b9-ede5-4ef0-8efa-fb1e92b5d9e8	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"user1_1746540576227@example.com","user_id":"249290fd-351f-4161-9e75-6e040503df35","user_phone":""}}	2025-05-11 11:44:05.85945+00	
00000000-0000-0000-0000-000000000000	44e6ca20-f1fd-40b2-8801-f53455d734d6	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"user2_1746540576227@example.com","user_id":"d3304fc8-9f80-4556-a8c8-2715de7acc19","user_phone":""}}	2025-05-11 11:44:05.872893+00	
00000000-0000-0000-0000-000000000000	3f2e9fe8-c2ef-49ba-870a-be5fac2d2114	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-11 11:46:26.480793+00	
00000000-0000-0000-0000-000000000000	f015668a-8474-4bfa-87b1-a7beb232453e	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-11 11:52:30.610128+00	
00000000-0000-0000-0000-000000000000	d2a9d661-fd00-4c13-aaf0-2a0a0471e2de	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-11 11:53:37.956349+00	
00000000-0000-0000-0000-000000000000	c9563106-f2e7-4f32-9c60-abf48a788ebd	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-11 11:54:45.088021+00	
00000000-0000-0000-0000-000000000000	d0556eb1-168b-425a-bcb0-69ea2817aec5	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-11 11:55:00.805565+00	
00000000-0000-0000-0000-000000000000	1e87fc0f-8005-4e6c-b9b2-25331f01be6b	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-11 11:55:28.289392+00	
00000000-0000-0000-0000-000000000000	3d2e45c5-ac47-4a50-8999-cacca47e861d	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-11 12:22:24.336233+00	
00000000-0000-0000-0000-000000000000	fecf71b6-8673-4763-b5a0-206d9bbd5930	{"action":"token_refreshed","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-11 13:20:44.440326+00	
00000000-0000-0000-0000-000000000000	da9efd67-4500-4633-909b-add2dbc2d81a	{"action":"token_revoked","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-11 13:20:44.443797+00	
00000000-0000-0000-0000-000000000000	1420e66b-4e57-437a-8540-97673d12b76d	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-11 13:22:09.292881+00	
00000000-0000-0000-0000-000000000000	85030f15-2e55-4107-b3a8-02122ab87a0a	{"action":"user_signedup","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-11 13:23:05.706214+00	
00000000-0000-0000-0000-000000000000	cce372ea-327d-4230-9f53-f7420bece05e	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-11 13:23:05.711014+00	
00000000-0000-0000-0000-000000000000	ab5adf2e-acb5-4da8-914b-1f2d0daacc18	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-11 14:16:38.831864+00	
00000000-0000-0000-0000-000000000000	c097aa33-2494-4cde-b185-d2509eec06ef	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-11 14:16:58.184441+00	
00000000-0000-0000-0000-000000000000	86e70672-f240-4722-9e3e-e0d341fffb54	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-11 14:17:52.473801+00	
00000000-0000-0000-0000-000000000000	e15c5727-d976-4864-a781-0f1bc967dcb8	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-13 17:19:43.139636+00	
00000000-0000-0000-0000-000000000000	fb455a0a-e05a-441f-aa0e-240b3706918c	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-13 17:20:27.706173+00	
00000000-0000-0000-0000-000000000000	29a82c86-0797-4b1a-af0a-0fbbad8d22c5	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-13 17:20:46.030764+00	
00000000-0000-0000-0000-000000000000	abbb749f-c276-42c7-a096-39c486f1ca7c	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-13 17:21:22.774173+00	
00000000-0000-0000-0000-000000000000	0f137bee-1a5f-4460-9454-2bdf47e2865b	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-13 17:21:41.746367+00	
00000000-0000-0000-0000-000000000000	66615789-cc8e-4193-b170-4d4e270e2d78	{"action":"token_refreshed","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-13 18:34:23.747267+00	
00000000-0000-0000-0000-000000000000	b7d2546d-e280-405c-8a10-7505d0316cf4	{"action":"token_revoked","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-13 18:34:23.75097+00	
00000000-0000-0000-0000-000000000000	3ba44db4-7954-44bc-92d7-34afba8de22d	{"action":"token_refreshed","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-16 17:41:22.281046+00	
00000000-0000-0000-0000-000000000000	7908c0be-f733-4dde-8fb8-c0009d4ca256	{"action":"token_revoked","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-16 17:41:22.298653+00	
00000000-0000-0000-0000-000000000000	f1a49195-d5a4-46b3-80fc-98d587d2d8f0	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-16 17:43:42.619838+00	
00000000-0000-0000-0000-000000000000	61dabd61-ffe9-4a66-85ce-49e0a4520050	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-16 17:44:54.595956+00	
00000000-0000-0000-0000-000000000000	273166ec-8318-4c8e-aea1-1361d6b641f9	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-16 18:42:56.863228+00	
00000000-0000-0000-0000-000000000000	d5b2e0c8-cb33-4017-bc0e-095dfa8b6c52	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-16 18:42:56.866682+00	
00000000-0000-0000-0000-000000000000	ca25db65-e2ac-44d4-9462-2646ceeb82a7	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-16 19:43:43.317614+00	
00000000-0000-0000-0000-000000000000	47018a24-6f9d-4ee6-b746-e06060963282	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-16 19:43:43.319056+00	
00000000-0000-0000-0000-000000000000	92c1bb16-5899-40c2-94df-da598cb51ac5	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-16 19:45:16.067977+00	
00000000-0000-0000-0000-000000000000	efe1db06-284c-42fc-8728-8ce377ddf633	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-19 20:20:19.611374+00	
00000000-0000-0000-0000-000000000000	a4420c92-354c-4f99-a141-4486253982e8	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-20 16:10:27.247353+00	
00000000-0000-0000-0000-000000000000	e0e6b8c9-dacc-4ecf-8df4-e166b9d1a090	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-20 16:10:27.262376+00	
00000000-0000-0000-0000-000000000000	8bf337ec-5767-4399-a40f-e1ed3aa70f92	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-20 16:12:05.170958+00	
00000000-0000-0000-0000-000000000000	24a5af0b-9df2-4432-8ec3-8776bcc25ed2	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-20 16:15:15.394123+00	
00000000-0000-0000-0000-000000000000	642eae6a-389a-45cc-9a5b-2a54afbcdb15	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-20 16:36:03.253657+00	
00000000-0000-0000-0000-000000000000	a97368fe-e01a-458f-8726-60e0333f7ad4	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-20 16:36:19.998591+00	
00000000-0000-0000-0000-000000000000	2dd8b3ef-e904-411a-97f1-91906208ada1	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-20 16:39:51.888542+00	
00000000-0000-0000-0000-000000000000	99b63367-9f94-4592-897c-0fe1acd62b28	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-20 16:40:22.98589+00	
00000000-0000-0000-0000-000000000000	210e3029-3abc-4f50-a1c3-887f4b42414d	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-20 16:41:47.025749+00	
00000000-0000-0000-0000-000000000000	7fdbb77e-8295-43f7-bed6-614de35be822	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-20 16:42:04.298168+00	
00000000-0000-0000-0000-000000000000	d4bc74ba-e486-4a1b-9194-dcb205a8ec0f	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-20 18:49:32.478941+00	
00000000-0000-0000-0000-000000000000	17508034-8627-432c-9383-9eed215a956c	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-20 18:49:32.481113+00	
00000000-0000-0000-0000-000000000000	2b7b1448-c096-4312-9140-e0eb1cadcb85	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-20 19:29:09.748929+00	
00000000-0000-0000-0000-000000000000	f1083f90-6b6c-403f-931c-9ca34a40cd3d	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-20 19:30:47.497563+00	
00000000-0000-0000-0000-000000000000	20b0cfb0-936a-49dd-8ffa-77c0316dab19	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-20 19:31:30.446983+00	
00000000-0000-0000-0000-000000000000	780fb959-922f-4807-a893-af6b3a0de700	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-22 13:03:38.099613+00	
00000000-0000-0000-0000-000000000000	4d4a9626-3fc0-4a42-9bd4-d02fca8a736e	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-22 13:39:24.254036+00	
00000000-0000-0000-0000-000000000000	3f9e310c-7447-4645-82d8-fb51dddaa80b	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:15:15.71812+00	
00000000-0000-0000-0000-000000000000	8702a560-65f0-441e-9cec-a5c5cc29daef	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:15:53.761449+00	
00000000-0000-0000-0000-000000000000	e4784c57-72bd-4dae-89f0-aa8d81901e39	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:15:55.344031+00	
00000000-0000-0000-0000-000000000000	2b9ea5da-bbf7-4a51-bc03-1dd52b1e55f9	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:15:55.549701+00	
00000000-0000-0000-0000-000000000000	d0f21a71-aca7-4a08-bfa8-674dd26220a4	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:15:55.740127+00	
00000000-0000-0000-0000-000000000000	1b500314-e2f3-4e61-9f2f-9ae2bd2576b1	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:15:55.923695+00	
00000000-0000-0000-0000-000000000000	ee3cec0e-e999-4d92-ac58-885437436729	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:15:58.608895+00	
00000000-0000-0000-0000-000000000000	6f66ccce-1a51-431f-af0d-17c3924169e3	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:15:58.90833+00	
00000000-0000-0000-0000-000000000000	c6e64747-d748-47cc-b5aa-80fdc35b6fce	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:15:59.347007+00	
00000000-0000-0000-0000-000000000000	eef85490-b7b9-471d-a3fa-0b30f7e81136	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:15:59.409552+00	
00000000-0000-0000-0000-000000000000	d5390fd3-9fe5-4b46-bfdc-7d7eda576c79	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:16:00.325348+00	
00000000-0000-0000-0000-000000000000	d6699811-25bb-4560-8a03-e0ef7c1338cf	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:16:00.55286+00	
00000000-0000-0000-0000-000000000000	c6ab5137-0403-4478-946f-d919d86ac155	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:20:39.944827+00	
00000000-0000-0000-0000-000000000000	92f45f48-064b-4be5-be39-6428de013004	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:20:42.682099+00	
00000000-0000-0000-0000-000000000000	a60256b6-6444-484c-9573-9214e8a34d6f	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:20:43.221208+00	
00000000-0000-0000-0000-000000000000	2d6ce20f-a723-4c41-8c1c-e73db21930af	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:20:43.545375+00	
00000000-0000-0000-0000-000000000000	d81cf563-6165-4323-aaf6-4718ac31cbed	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:20:43.666159+00	
00000000-0000-0000-0000-000000000000	ae3e6bc2-d22c-442e-a0ed-ad322d3c8754	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:20:43.83772+00	
00000000-0000-0000-0000-000000000000	75d5d0e1-737f-45a6-a667-12bb8ffd8dfd	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:20:43.964336+00	
00000000-0000-0000-0000-000000000000	441e4058-05c9-4052-9ca1-4d946ff06da3	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:21:07.691556+00	
00000000-0000-0000-0000-000000000000	604cabc4-1a1a-4b57-a07d-38c0445e24ae	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:21:07.951166+00	
00000000-0000-0000-0000-000000000000	8f4fcb9f-e72e-4dd3-8f8b-c67f89c7d7b2	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:21:08.03306+00	
00000000-0000-0000-0000-000000000000	d2ec52cd-5f02-49d4-bde2-25257399eba7	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:21:08.319116+00	
00000000-0000-0000-0000-000000000000	9864ac3a-1ecc-42c4-8f53-c7c217e4c8e6	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:21:08.422609+00	
00000000-0000-0000-0000-000000000000	c75ae51a-65f8-4831-85f2-9117e45b1fcc	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:21:08.638628+00	
00000000-0000-0000-0000-000000000000	bc984212-c17a-46c2-b48f-bd21681e6fbf	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:21:08.815287+00	
00000000-0000-0000-0000-000000000000	730c3895-2a00-4d44-8a66-0e761b71f2a3	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:27:06.232532+00	
00000000-0000-0000-0000-000000000000	455e8499-fb50-4a9f-8d52-53775c722ab8	{"action":"user_signedup","actor_id":"e7857426-1a03-4701-82b2-e7babc7c195b","actor_username":"buyer3@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-23 16:29:12.910804+00	
00000000-0000-0000-0000-000000000000	c7cd019a-9f2b-41e2-aeee-cf1672dafcd4	{"action":"login","actor_id":"e7857426-1a03-4701-82b2-e7babc7c195b","actor_username":"buyer3@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:29:12.918812+00	
00000000-0000-0000-0000-000000000000	d4d70f9b-d773-43e3-ad58-c2f861ab59c4	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:32:38.84186+00	
00000000-0000-0000-0000-000000000000	acbfb912-40db-4f2a-92a1-367cf0ea8ef4	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-23 16:39:07.236932+00	
00000000-0000-0000-0000-000000000000	630f3684-e00e-4938-a3d8-e03ee6881346	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 16:41:49.93125+00	
00000000-0000-0000-0000-000000000000	071c5345-472e-4625-90a9-964d49257383	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"buyer3@example.com","user_id":"e7857426-1a03-4701-82b2-e7babc7c195b","user_phone":""}}	2025-05-23 19:44:35.6388+00	
00000000-0000-0000-0000-000000000000	99be4fc9-7670-4b77-8248-7dd83055d3ba	{"action":"token_refreshed","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-23 19:56:58.338988+00	
00000000-0000-0000-0000-000000000000	ca3f459a-d2f5-495d-916b-1ea7c7e160f7	{"action":"token_revoked","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-23 19:56:58.342838+00	
00000000-0000-0000-0000-000000000000	b60b4234-2f3a-46f0-bb7c-2c8e70be30ca	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-23 20:20:25.372516+00	
00000000-0000-0000-0000-000000000000	0e0ab111-450f-4e01-b0f3-3d79080a41da	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-23 20:20:41.366038+00	
00000000-0000-0000-0000-000000000000	ecca2db8-89af-4fcd-ab1d-33bf7f05bebd	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-24 19:02:47.90384+00	
00000000-0000-0000-0000-000000000000	8275ec29-514f-4d48-aa52-849712d17a40	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-24 19:02:47.924569+00	
00000000-0000-0000-0000-000000000000	0ef8944c-7fa7-402b-a35f-86956127eb72	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-24 19:03:01.849042+00	
00000000-0000-0000-0000-000000000000	e7e287bb-3cfe-4946-ac21-53ef17187598	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-24 19:03:25.168191+00	
00000000-0000-0000-0000-000000000000	1c548fac-6396-4a46-a04c-6e832976b075	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-24 20:00:57.626084+00	
00000000-0000-0000-0000-000000000000	654b47b7-fbc9-4fc9-94de-36fd970bcf6e	{"action":"user_signedup","actor_id":"36a5e2f2-d1e8-4fea-9b52-c90b5311d6b8","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-24 20:01:47.550249+00	
00000000-0000-0000-0000-000000000000	7730603c-8cd3-43ea-93b2-8b5880c7b1c7	{"action":"login","actor_id":"36a5e2f2-d1e8-4fea-9b52-c90b5311d6b8","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-24 20:01:47.556958+00	
00000000-0000-0000-0000-000000000000	c8ca8423-f5a1-4020-9475-5775ba62eee6	{"action":"logout","actor_id":"36a5e2f2-d1e8-4fea-9b52-c90b5311d6b8","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-24 20:02:33.454497+00	
00000000-0000-0000-0000-000000000000	a55cd632-8705-4f0b-bf0a-f08fd7e12223	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-24 20:02:58.743362+00	
00000000-0000-0000-0000-000000000000	a2018bcd-7baa-49df-8978-5bf8bcbb6125	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-24 20:30:26.094633+00	
00000000-0000-0000-0000-000000000000	b90ffdd2-3522-4355-949e-37f6adcf41c4	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-24 20:30:44.948652+00	
00000000-0000-0000-0000-000000000000	abc784d0-a6ac-490e-b680-c248049f136f	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-24 20:32:56.672519+00	
00000000-0000-0000-0000-000000000000	780db5ec-9172-4d4c-a634-ff3df1c52df9	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-25 09:10:10.619609+00	
00000000-0000-0000-0000-000000000000	de379213-0835-462a-8234-ac7f0e7b6f80	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-25 09:10:30.209782+00	
00000000-0000-0000-0000-000000000000	8b24c356-d2b7-4604-bcb5-4a5e1a5abdf6	{"action":"user_signedup","actor_id":"ace0ffd1-5ef3-4e37-b718-25fa62f301d7","actor_username":"buyer3@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-25 09:11:08.262596+00	
00000000-0000-0000-0000-000000000000	d1213e05-72e4-486f-820d-93f809ad70ec	{"action":"login","actor_id":"ace0ffd1-5ef3-4e37-b718-25fa62f301d7","actor_username":"buyer3@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-25 09:11:08.269338+00	
00000000-0000-0000-0000-000000000000	5bf0a6b2-eb17-4e66-8e77-821674665646	{"action":"logout","actor_id":"ace0ffd1-5ef3-4e37-b718-25fa62f301d7","actor_username":"buyer3@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-25 09:11:18.10915+00	
00000000-0000-0000-0000-000000000000	e4a1dacb-8b6e-4c24-b5be-0e5ee6a1d74e	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-25 09:12:04.169606+00	
00000000-0000-0000-0000-000000000000	f08ff11b-10fb-4146-bc74-bc94d28b3a8d	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"buyer3@example.com","user_id":"ace0ffd1-5ef3-4e37-b718-25fa62f301d7","user_phone":""}}	2025-05-25 09:12:19.308864+00	
00000000-0000-0000-0000-000000000000	3c3f20f3-6547-4551-ad77-bbfbc1b427ea	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"mkulima3@example.com","user_id":"36a5e2f2-d1e8-4fea-9b52-c90b5311d6b8","user_phone":""}}	2025-05-25 09:12:51.670326+00	
00000000-0000-0000-0000-000000000000	fd7a8ceb-556d-48c4-b9bc-084524ef9fb2	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-25 09:40:26.093976+00	
00000000-0000-0000-0000-000000000000	2f274c80-cc58-4a05-b409-3f781cd843ab	{"action":"user_signedup","actor_id":"bb3741bd-c80f-4bac-8953-aac1be70481e","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-25 09:41:03.275861+00	
00000000-0000-0000-0000-000000000000	11caddc7-08fb-4465-8111-85b5339f4f2d	{"action":"login","actor_id":"bb3741bd-c80f-4bac-8953-aac1be70481e","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-25 09:41:03.280588+00	
00000000-0000-0000-0000-000000000000	71808e42-306c-4b6c-b7ea-bf542e171e7f	{"action":"logout","actor_id":"bb3741bd-c80f-4bac-8953-aac1be70481e","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-25 09:41:29.980164+00	
00000000-0000-0000-0000-000000000000	1025c363-e2e2-4214-b25c-6f52797b768a	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-25 09:41:46.792826+00	
00000000-0000-0000-0000-000000000000	ff430329-591b-4ba4-8a0e-583804645d2a	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"mkulima3@example.com","user_id":"bb3741bd-c80f-4bac-8953-aac1be70481e","user_phone":""}}	2025-05-25 10:30:34.541158+00	
00000000-0000-0000-0000-000000000000	6edb2b7c-90ed-4c13-a1cf-3dc5e01de08e	{"action":"token_refreshed","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-25 10:40:59.686231+00	
00000000-0000-0000-0000-000000000000	a0813f7e-9ede-4bcb-b2a2-2095fa0f399a	{"action":"token_revoked","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-25 10:40:59.688986+00	
00000000-0000-0000-0000-000000000000	59e6fe1c-e2ee-4daa-9040-07f65cf3c0fa	{"action":"token_refreshed","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-25 11:39:33.888461+00	
00000000-0000-0000-0000-000000000000	f392037d-f904-481b-8558-95c4a64863f9	{"action":"token_revoked","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-25 11:39:33.891237+00	
00000000-0000-0000-0000-000000000000	0c66e241-3d93-4c8c-b4b7-9777016e198c	{"action":"token_refreshed","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-25 15:54:25.288601+00	
00000000-0000-0000-0000-000000000000	5736d216-3f5f-4016-8b25-71e51d6801d5	{"action":"token_revoked","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-25 15:54:25.294864+00	
00000000-0000-0000-0000-000000000000	c04adcea-a1b9-4c73-8d85-1938a7966d41	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-25 15:55:13.323674+00	
00000000-0000-0000-0000-000000000000	e4e778b8-4d7b-437d-ab5e-1e7cd841baba	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-25 15:55:31.961184+00	
00000000-0000-0000-0000-000000000000	b4190fa8-d34c-4288-84bf-e628c0e33f23	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-25 16:02:25.042815+00	
00000000-0000-0000-0000-000000000000	388d5871-3c05-431a-a517-92c33587ce44	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-25 16:02:45.569375+00	
00000000-0000-0000-0000-000000000000	1ebe0156-5e9a-47ce-b8bd-1bc130285de1	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-25 16:04:15.157244+00	
00000000-0000-0000-0000-000000000000	349c473c-35b2-42c7-9c18-93e9cca288ec	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-25 16:04:31.948734+00	
00000000-0000-0000-0000-000000000000	948eb24a-490f-4b2f-ae1d-ecc58cdf8fca	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-25 17:14:08.710547+00	
00000000-0000-0000-0000-000000000000	23933381-5872-4a64-a761-d8815d322fd9	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-25 17:14:08.713614+00	
00000000-0000-0000-0000-000000000000	f98efb0e-a3e0-4a85-ba4e-2978387430ab	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-25 18:46:16.743051+00	
00000000-0000-0000-0000-000000000000	76db6e71-4558-487a-84e4-b099ab5ff59c	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-25 18:46:16.74788+00	
00000000-0000-0000-0000-000000000000	7a865439-2744-4e44-958c-662be98b8474	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-25 21:42:38.81827+00	
00000000-0000-0000-0000-000000000000	b71ce888-e595-421a-931f-17b8c88712b4	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-25 21:42:38.824252+00	
00000000-0000-0000-0000-000000000000	3393aefd-4551-416a-8e6a-003ad25dd6de	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-27 11:27:39.372789+00	
00000000-0000-0000-0000-000000000000	4923daf3-0be3-4e41-8f30-f30458db3f77	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-27 11:27:39.38312+00	
00000000-0000-0000-0000-000000000000	d6dc13a7-a425-48d0-aa48-e4740a019ce1	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-27 12:26:46.046732+00	
00000000-0000-0000-0000-000000000000	e4d2b515-22a6-44d5-97d1-7ec7306780cc	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-27 12:26:46.052091+00	
00000000-0000-0000-0000-000000000000	c512d438-8a78-416f-aba5-6506d48ea607	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-27 13:25:30.131747+00	
00000000-0000-0000-0000-000000000000	77835c01-7467-4f8d-94f7-cb86ee0d272e	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-27 13:25:30.136961+00	
00000000-0000-0000-0000-000000000000	bebdbf2e-dd12-41c6-81c2-6ee37153c8c1	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-28 07:44:40.950608+00	
00000000-0000-0000-0000-000000000000	bd142a01-149f-4806-9ac5-3474c67c64a6	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-28 07:44:40.963248+00	
00000000-0000-0000-0000-000000000000	6dbfd5a8-681e-45f0-a5a7-44c686c5e7e7	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-28 08:09:04.103086+00	
00000000-0000-0000-0000-000000000000	405f68f7-4511-4311-8af5-24564aca1e38	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 08:09:29.744848+00	
00000000-0000-0000-0000-000000000000	37d288f1-0e39-4ecd-a0be-164165f8b332	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-28 08:10:58.88709+00	
00000000-0000-0000-0000-000000000000	7e1b4ab9-0817-4732-b9b9-1ddde786609c	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 08:11:17.692941+00	
00000000-0000-0000-0000-000000000000	b17bcb47-3008-4a1e-9c57-16a477a16169	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-28 08:11:45.826335+00	
00000000-0000-0000-0000-000000000000	a2902efa-6651-401f-bed5-2c37581ceb43	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 08:12:07.483138+00	
00000000-0000-0000-0000-000000000000	e7b17084-0f6a-4296-94f2-e0207d6b39c0	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-28 08:13:21.739698+00	
00000000-0000-0000-0000-000000000000	50fff592-ff9f-4713-b0ac-274aeaa52b7b	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 08:13:43.956917+00	
00000000-0000-0000-0000-000000000000	4a4033bb-ecb8-4936-8077-e75df84dc768	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-28 08:17:26.602857+00	
00000000-0000-0000-0000-000000000000	d6c6f556-aa67-4415-b887-f712e3b08218	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 08:17:46.762019+00	
00000000-0000-0000-0000-000000000000	f177f9fc-b83d-477d-bd1d-5967d8afb3d6	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-28 08:18:56.034068+00	
00000000-0000-0000-0000-000000000000	36e95413-a9c1-46eb-827f-8b58eb4d99a6	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 08:19:17.997706+00	
00000000-0000-0000-0000-000000000000	0c8c409e-68b8-4ee2-a1c1-e6a655b4f5b7	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-28 09:28:03.600341+00	
00000000-0000-0000-0000-000000000000	d16b66f6-bab0-4760-8caf-5a5db34a5e2c	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-28 09:28:03.610822+00	
00000000-0000-0000-0000-000000000000	7f6a1d7a-edd5-415c-adf5-062655e239b3	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-28 09:58:24.294358+00	
00000000-0000-0000-0000-000000000000	0fbd0e04-003a-4125-8ff9-468221b0e860	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 09:58:43.510966+00	
00000000-0000-0000-0000-000000000000	1740352c-6fd9-46b3-9618-98505bb3dda2	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-28 10:01:00.299519+00	
00000000-0000-0000-0000-000000000000	31dea679-20ab-4374-a9a6-55056cf7033d	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 10:01:42.042895+00	
00000000-0000-0000-0000-000000000000	9f4f5451-f966-401d-b0af-a2d8323c2f3f	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-28 10:05:30.149566+00	
00000000-0000-0000-0000-000000000000	6f2c91be-a5b0-413c-add6-5222b08ab02e	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 10:06:02.657155+00	
00000000-0000-0000-0000-000000000000	93c499d2-5043-4d92-b68c-b693b77c753a	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-28 10:07:16.459354+00	
00000000-0000-0000-0000-000000000000	93adb1a0-1e31-422b-a7f5-7de6004750c4	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 10:07:37.396043+00	
00000000-0000-0000-0000-000000000000	fd9937d7-c1fe-4ac3-959e-7c67c912d951	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-28 10:22:09.109751+00	
00000000-0000-0000-0000-000000000000	af7c463b-54a4-4abf-9fec-8a341f8b7c86	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 10:22:36.289192+00	
00000000-0000-0000-0000-000000000000	df5306dd-c76c-4eec-b145-61673bf1cd37	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-28 10:22:55.746+00	
00000000-0000-0000-0000-000000000000	9764a129-c47b-439f-8684-ebdd3bdce56f	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 10:23:19.764383+00	
00000000-0000-0000-0000-000000000000	6a9023a8-0d56-40bd-96c2-90bb0f2c9fdd	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-28 10:23:46.785324+00	
00000000-0000-0000-0000-000000000000	bd602a87-8723-4da0-be82-5c2702b1e3bc	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 10:24:28.42728+00	
00000000-0000-0000-0000-000000000000	23f7defe-12de-4194-b453-9b0455999a2f	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-28 11:23:34.873999+00	
00000000-0000-0000-0000-000000000000	42d3a639-da41-493d-bcdf-19ef6ab1c9ac	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-28 11:23:34.87555+00	
00000000-0000-0000-0000-000000000000	3b5aaa22-5a1c-4b59-b79f-099082677f4c	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-28 11:36:43.093639+00	
00000000-0000-0000-0000-000000000000	d9faa884-a3b1-4d38-8377-1790f765cbb8	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 11:37:05.508643+00	
00000000-0000-0000-0000-000000000000	bbca655a-310a-4585-8194-284015cd5d10	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-28 11:38:09.10834+00	
00000000-0000-0000-0000-000000000000	dae7d54d-d947-449c-a6a0-24741392dc27	{"action":"user_signedup","actor_id":"dd35b495-23a1-4cb6-918d-a2f2db1bf3d8","actor_username":"user1@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-05-28 11:38:51.585455+00	
00000000-0000-0000-0000-000000000000	6ab56593-854b-4ab1-875b-6cc269091690	{"action":"login","actor_id":"dd35b495-23a1-4cb6-918d-a2f2db1bf3d8","actor_username":"user1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 11:38:51.595456+00	
00000000-0000-0000-0000-000000000000	fb1f74be-c48c-45a4-b34e-844b3494acd3	{"action":"logout","actor_id":"dd35b495-23a1-4cb6-918d-a2f2db1bf3d8","actor_username":"user1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-28 11:39:08.599537+00	
00000000-0000-0000-0000-000000000000	20759577-6740-4ef7-ac6c-e68d81369a30	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 11:39:47.354001+00	
00000000-0000-0000-0000-000000000000	a67c0f0c-7d07-45b8-8bdc-d65b9c04e2c7	{"action":"token_refreshed","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-28 15:00:27.001164+00	
00000000-0000-0000-0000-000000000000	bea28597-db8c-477e-9968-e232539d625a	{"action":"token_revoked","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-28 15:00:27.010851+00	
00000000-0000-0000-0000-000000000000	7e6a0d97-d6a3-421f-8747-8d22dff00a9e	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"user1@example.com","user_id":"dd35b495-23a1-4cb6-918d-a2f2db1bf3d8","user_phone":""}}	2025-05-28 15:53:48.381512+00	
00000000-0000-0000-0000-000000000000	e348b929-9f0c-440c-b38f-d301b3e0827a	{"action":"token_refreshed","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-28 15:58:55.570215+00	
00000000-0000-0000-0000-000000000000	4220378a-5fff-4cc6-9f15-05f2d45d7051	{"action":"token_revoked","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-28 15:58:55.572947+00	
00000000-0000-0000-0000-000000000000	60ccf8c5-e811-4ad2-814f-52ec6b9a6b11	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-28 16:36:10.036542+00	
00000000-0000-0000-0000-000000000000	25bd751b-d25a-4f62-ac8a-99bdfc5fc652	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 16:36:27.969449+00	
00000000-0000-0000-0000-000000000000	cf31fa4a-18b3-48ef-b0b6-cb57fa3debab	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-28 16:37:27.329719+00	
00000000-0000-0000-0000-000000000000	a6f518f4-5b1c-4235-9ce2-8f87716e473f	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 20:14:43.898601+00	
00000000-0000-0000-0000-000000000000	0392c8f2-08e1-4ac1-b225-373778fcb0c7	{"action":"token_refreshed","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-29 08:23:45.199901+00	
00000000-0000-0000-0000-000000000000	3e42efd6-9af6-4e5f-9704-63c88ffd547a	{"action":"token_revoked","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-29 08:23:45.216375+00	
00000000-0000-0000-0000-000000000000	bc21f8ee-1ecb-4613-90dd-eca6dc7f7468	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-29 08:24:04.008836+00	
00000000-0000-0000-0000-000000000000	112cd58a-f52f-4e48-9127-264dcda2e555	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 08:24:31.489551+00	
00000000-0000-0000-0000-000000000000	c1ea4622-d701-40bb-bee7-ec30afabc4c6	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-29 08:33:51.626225+00	
00000000-0000-0000-0000-000000000000	d3eba7ab-adb0-4dc2-8428-91022950b207	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 08:34:10.707345+00	
00000000-0000-0000-0000-000000000000	903bbcc9-6021-41f2-abd0-0da56d77dab3	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-29 08:50:24.708177+00	
00000000-0000-0000-0000-000000000000	6e5bfb8a-7802-42b7-aefc-80f8c0fdf090	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 08:50:45.391308+00	
00000000-0000-0000-0000-000000000000	43f2d0fc-1e2c-48d6-ae8b-3833c2f01a37	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 09:47:32.732174+00	
00000000-0000-0000-0000-000000000000	393f111c-38d4-4758-a53e-753541c39438	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 09:49:43.661023+00	
00000000-0000-0000-0000-000000000000	2ec195bd-7792-47fe-a4c1-2a3d31e8e73a	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 09:50:05.000368+00	
00000000-0000-0000-0000-000000000000	74df6ec1-bb2c-4765-9e88-6416a6a46026	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 10:20:05.744783+00	
00000000-0000-0000-0000-000000000000	95d72ccd-b469-429c-bb41-c6d82da8e5ec	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-29 10:23:32.088943+00	
00000000-0000-0000-0000-000000000000	514274dd-bc72-48ae-b397-2599c0d73311	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 10:23:51.179818+00	
00000000-0000-0000-0000-000000000000	c6573fbd-6d6f-4ae8-a73d-bc42d219fedc	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-29 11:22:41.984074+00	
00000000-0000-0000-0000-000000000000	efe7fee9-515f-4954-8c33-219dc23bf246	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-29 11:22:41.988046+00	
00000000-0000-0000-0000-000000000000	76e9e674-06d8-4e9a-ab99-17bc9c263fea	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-29 11:33:25.949467+00	
00000000-0000-0000-0000-000000000000	c6f0c811-074d-46cd-aa94-fe28a9f11029	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 14:01:53.055153+00	
00000000-0000-0000-0000-000000000000	36ead9ca-f362-485d-8c7b-789116e2c2a4	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-29 14:04:13.838503+00	
00000000-0000-0000-0000-000000000000	7ff2158b-1e13-4ba6-b417-0611cc413d9a	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 14:04:30.886604+00	
00000000-0000-0000-0000-000000000000	801874b1-f28d-46aa-99a9-9d6261fbddae	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-29 14:04:47.016148+00	
00000000-0000-0000-0000-000000000000	2ab7f888-4a33-43a8-8286-283cc06ab227	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 14:05:09.229206+00	
00000000-0000-0000-0000-000000000000	981723ac-e19f-491a-995d-bb417f1ad887	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-29 14:12:58.481495+00	
00000000-0000-0000-0000-000000000000	30c39ebc-f993-4d47-b81e-b91541a83333	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 14:13:16.266159+00	
00000000-0000-0000-0000-000000000000	e38a33ab-b7cc-43fb-b940-0dd29e17d76c	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-29 14:27:35.62635+00	
00000000-0000-0000-0000-000000000000	e98280ca-6f38-4dad-af29-5d1344aee581	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 14:27:58.666353+00	
00000000-0000-0000-0000-000000000000	a696aed1-42ee-4650-8bb1-31bfd5b9f9fe	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-29 14:33:54.058307+00	
00000000-0000-0000-0000-000000000000	04d8e953-fc4f-4c6e-be20-61df8aac29a1	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 14:34:47.276986+00	
00000000-0000-0000-0000-000000000000	9bf91aa9-3507-4a6f-a297-5e05b57c34d2	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-29 15:19:50.799198+00	
00000000-0000-0000-0000-000000000000	c334fa53-eae7-428e-a7b5-8913c23a971a	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 15:20:47.769252+00	
00000000-0000-0000-0000-000000000000	88e664b0-5b67-4222-9cd3-0b9fa2fbddb3	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-29 16:24:53.3097+00	
00000000-0000-0000-0000-000000000000	7eac9659-294f-49bc-9f8a-adbc506cd95e	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-29 16:24:53.312023+00	
00000000-0000-0000-0000-000000000000	c9f5ce4a-f5de-4cf6-b683-bb7b277e7266	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-29 16:39:19.91154+00	
00000000-0000-0000-0000-000000000000	8da4373f-b479-4e14-8b26-27d980800911	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 16:40:13.022349+00	
00000000-0000-0000-0000-000000000000	4a993465-c09d-4e4e-97b4-8121aee4df46	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-29 16:44:23.609475+00	
00000000-0000-0000-0000-000000000000	7aa05c16-8955-4519-b0dc-e3cf40280572	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 16:46:02.862192+00	
00000000-0000-0000-0000-000000000000	85e64876-68ee-474c-a47d-1058fd46e9e3	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-29 16:53:49.793984+00	
00000000-0000-0000-0000-000000000000	d4466fe6-191f-4c78-8149-6c8eef6ce29c	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 16:54:06.413682+00	
00000000-0000-0000-0000-000000000000	2f64bdba-41cc-4145-aa01-bfa9aa870266	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-29 16:54:48.489746+00	
00000000-0000-0000-0000-000000000000	8841e544-1e10-4ab6-b347-6a92b1ed149e	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 20:25:15.372422+00	
00000000-0000-0000-0000-000000000000	e41691cb-326c-45ad-bd62-7a8695fd6474	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-29 20:28:33.310952+00	
00000000-0000-0000-0000-000000000000	a77cdf13-7b1d-4c80-8f75-8593646f7b74	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 20:28:53.994674+00	
00000000-0000-0000-0000-000000000000	d1d09ba7-2573-40ae-b3c3-e9a664c70b45	{"action":"token_refreshed","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-30 14:03:53.765006+00	
00000000-0000-0000-0000-000000000000	7bcb59e5-8aa4-4008-88d0-c19d20bf1436	{"action":"token_revoked","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-30 14:03:53.778845+00	
00000000-0000-0000-0000-000000000000	f7b3c88f-7235-4e94-8fca-f57fa1088e9b	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-30 14:06:37.298262+00	
00000000-0000-0000-0000-000000000000	2fa8d5cd-5e9e-4ac1-b7b7-253f3fd4ddcd	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 14:06:56.328817+00	
00000000-0000-0000-0000-000000000000	ab2e32d9-a6c3-4ef9-9760-a3348b2dfe65	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-30 14:17:41.955174+00	
00000000-0000-0000-0000-000000000000	491a763f-ac02-41bd-92c6-f6918f9b4aa2	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 14:18:02.310088+00	
00000000-0000-0000-0000-000000000000	4e375acc-3c68-46c5-8bcb-2bcdcbcf9efd	{"action":"token_refreshed","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-30 15:17:09.69892+00	
00000000-0000-0000-0000-000000000000	9019a815-b441-42a5-a4d5-dfa8c2aaf8a8	{"action":"token_revoked","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-30 15:17:09.704007+00	
00000000-0000-0000-0000-000000000000	f6ae9561-ff72-4438-af89-e87b01d18ccc	{"action":"token_refreshed","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-30 16:15:58.311318+00	
00000000-0000-0000-0000-000000000000	fbefe63d-a815-40cf-8aac-509705c0ce32	{"action":"token_revoked","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-30 16:15:58.313412+00	
00000000-0000-0000-0000-000000000000	0bb07d77-2e09-43d6-9e96-c1667ebdf147	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-30 16:33:47.785299+00	
00000000-0000-0000-0000-000000000000	8f2e260c-e6d5-4bbf-a793-d05db8ed5679	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 16:34:07.717947+00	
00000000-0000-0000-0000-000000000000	1556c288-ed6b-4124-b303-64f8c86a4bb1	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-30 16:37:23.333506+00	
00000000-0000-0000-0000-000000000000	682b81ab-dfaf-4b84-8b3b-c307213f6156	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 16:37:48.37789+00	
00000000-0000-0000-0000-000000000000	02e8cc7a-a56b-44c5-a2bd-3843a4a8660c	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-30 16:58:06.991331+00	
00000000-0000-0000-0000-000000000000	3fa9a3df-d9ed-4774-8d7d-7da888f83976	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 16:58:29.18834+00	
00000000-0000-0000-0000-000000000000	0fcc5378-2d88-407c-b84a-bab77c23d514	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-30 17:00:31.636506+00	
00000000-0000-0000-0000-000000000000	6b726dec-15e3-48af-8c9e-99b8ce15dcb6	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 17:01:02.432757+00	
00000000-0000-0000-0000-000000000000	1ac01832-e319-4e5d-9b3e-b93d16d61172	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-30 17:01:55.341813+00	
00000000-0000-0000-0000-000000000000	852d4307-c7b9-4a40-b6af-dc2198d79155	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 17:02:13.224749+00	
00000000-0000-0000-0000-000000000000	880c61da-e8b5-41ca-b8bd-677bb7f0b715	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-30 17:15:27.564733+00	
00000000-0000-0000-0000-000000000000	5486fb8a-2299-4ac9-b642-2cad92df50e4	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 17:15:48.755811+00	
00000000-0000-0000-0000-000000000000	d09bd3cd-cdbe-4ea8-9a3a-1d47556546ee	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-30 17:26:03.096865+00	
00000000-0000-0000-0000-000000000000	24b6e1ed-d1cd-4169-88ff-2bc04ba91fc3	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 17:26:24.829971+00	
00000000-0000-0000-0000-000000000000	09eb591a-f4b8-48f8-bfcb-cff9620739f1	{"action":"token_refreshed","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-30 18:26:00.393665+00	
00000000-0000-0000-0000-000000000000	4b4cb1c0-da76-4d72-a2ff-c375ae1ecc00	{"action":"token_revoked","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"token"}	2025-05-30 18:26:00.402444+00	
00000000-0000-0000-0000-000000000000	6a825a74-1cf0-471e-93ad-061ea5c7c97e	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-30 18:32:32.244915+00	
00000000-0000-0000-0000-000000000000	176a5046-2cbd-4858-9259-add3b8292a0c	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 18:33:05.842382+00	
00000000-0000-0000-0000-000000000000	c9f350dd-44a3-4509-b1ff-7faaf2d7620d	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-30 18:37:06.794349+00	
00000000-0000-0000-0000-000000000000	13dcaee7-dae3-4011-a182-0d0aea885410	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 18:37:27.639616+00	
00000000-0000-0000-0000-000000000000	aa4ffed0-31b2-4023-a2d2-fc815118387a	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-05-30 19:05:52.198854+00	
00000000-0000-0000-0000-000000000000	9d80deb6-f535-4f83-bc0e-b4ddbe348f47	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 19:06:08.806441+00	
00000000-0000-0000-0000-000000000000	f954fb6f-5706-4bca-9009-1337369d0bf5	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-01 16:14:43.06455+00	
00000000-0000-0000-0000-000000000000	c6303124-153f-41aa-a936-c29d67b5f822	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-01 16:14:43.075144+00	
00000000-0000-0000-0000-000000000000	1c438f84-7ca8-42e0-b447-5a559a2ef1d0	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-01 16:15:12.788111+00	
00000000-0000-0000-0000-000000000000	a7df7f1e-5971-4c6f-b445-a4ff63b8dcf7	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 16:15:31.71505+00	
00000000-0000-0000-0000-000000000000	ff717729-e3c1-444e-a7a4-e07a332406b7	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-01 16:16:54.289719+00	
00000000-0000-0000-0000-000000000000	2d162372-01f7-447f-94bc-71eb43702126	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 16:17:11.009266+00	
00000000-0000-0000-0000-000000000000	daa6387c-2e1b-4f43-9858-b411d5a28c5a	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-01 16:18:51.209765+00	
00000000-0000-0000-0000-000000000000	8bd98e17-809d-47d9-be5c-d4db9b994e12	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 16:19:14.701477+00	
00000000-0000-0000-0000-000000000000	8a1a8117-f3df-42c6-ab36-53eda95aca86	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-01 17:12:09.453397+00	
00000000-0000-0000-0000-000000000000	bbb848c3-76fb-4109-add5-aeefbb0b4d77	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 17:12:28.877583+00	
00000000-0000-0000-0000-000000000000	f06a554c-0e98-4f64-871f-902f91a53ce5	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-01 17:13:01.827266+00	
00000000-0000-0000-0000-000000000000	084f8e59-f808-44d3-94e5-fbcdeaaca1a8	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 17:13:20.2184+00	
00000000-0000-0000-0000-000000000000	1f4e0ac6-66fa-4471-86fe-e7986ba857dd	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 17:39:30.267943+00	
00000000-0000-0000-0000-000000000000	c9db2797-1444-4c08-9f6c-e2dc911cb1f3	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 17:40:30.286812+00	
00000000-0000-0000-0000-000000000000	974e25c0-dd96-4f89-9035-d730bc356dfe	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 17:40:37.236102+00	
00000000-0000-0000-0000-000000000000	6cf5d7e6-13d3-4560-9c1b-4ae1e7c8f5d1	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 17:40:37.6327+00	
00000000-0000-0000-0000-000000000000	e086ce4f-0c04-4154-8d49-b22af90dab1d	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 17:40:37.979266+00	
00000000-0000-0000-0000-000000000000	3d67a7af-f95e-4f86-97c6-b8c44b52d8e7	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 17:40:38.085691+00	
00000000-0000-0000-0000-000000000000	991cf391-ee81-4586-85d9-9d99f8794c78	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 17:40:38.136836+00	
00000000-0000-0000-0000-000000000000	093278a0-83ce-4870-aeb1-e7938dc2abb7	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 17:40:38.286766+00	
00000000-0000-0000-0000-000000000000	fb95ed10-8631-49e8-9542-200e5aaa6554	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 17:40:38.476588+00	
00000000-0000-0000-0000-000000000000	33a3049f-3caf-40db-a162-3f4a1969551b	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 17:41:06.619469+00	
00000000-0000-0000-0000-000000000000	aa6322bf-0be4-4732-a395-036004a4b17b	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 17:41:08.200722+00	
00000000-0000-0000-0000-000000000000	f42eb874-9a9c-4002-b116-2d204d7a95c1	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 17:41:08.435495+00	
00000000-0000-0000-0000-000000000000	4e93e802-95d7-4a90-a27e-f1911283010e	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 17:45:15.779179+00	
00000000-0000-0000-0000-000000000000	e5cdaef6-f639-47ec-8a18-c325a4dca014	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 17:58:25.863809+00	
00000000-0000-0000-0000-000000000000	39184f7e-25b0-45ef-a375-ecb4d45d6e92	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-01 18:00:44.891846+00	
00000000-0000-0000-0000-000000000000	94b8a095-0f7a-4b6c-9cb9-7b016b93cc86	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 18:01:01.038467+00	
00000000-0000-0000-0000-000000000000	41a6706a-ccc5-4732-b48c-864bfe7f0ec1	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-01 18:02:53.284424+00	
00000000-0000-0000-0000-000000000000	02a56b89-76f7-4825-b4f5-f81bca0d6e6a	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 18:03:10.744617+00	
00000000-0000-0000-0000-000000000000	4aae2e63-d6dc-4999-bf19-cf192e7f3bed	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-01 18:03:43.862237+00	
00000000-0000-0000-0000-000000000000	682edd6a-426c-4b7d-945f-35248e22ac46	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 09:12:01.088276+00	
00000000-0000-0000-0000-000000000000	79170a10-9636-4ece-8db1-5f97cfb8b96d	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-02 09:43:19.357824+00	
00000000-0000-0000-0000-000000000000	0f94870a-797d-4b88-8305-0ade2e0dfbaf	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 09:44:15.924116+00	
00000000-0000-0000-0000-000000000000	9e1160a8-d91b-4ce7-add5-4ebf898366bf	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-02 10:02:15.751398+00	
00000000-0000-0000-0000-000000000000	64e853d1-3e34-4777-a7ad-1767092657ab	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 10:02:52.382613+00	
00000000-0000-0000-0000-000000000000	e92fc791-9920-4d7a-ad29-d96c28eb08d6	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-02 10:16:11.231662+00	
00000000-0000-0000-0000-000000000000	c40300c6-be6a-4698-83f2-e83aae43b460	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 10:17:36.033784+00	
00000000-0000-0000-0000-000000000000	eac66152-818e-40bf-985d-3259442d18a8	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-02 10:22:24.949352+00	
00000000-0000-0000-0000-000000000000	a186b718-47b0-4c93-ac37-41b4744fd214	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 10:22:40.661828+00	
00000000-0000-0000-0000-000000000000	9bc64664-356a-452e-8fea-a7e45a1ef53c	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-02 11:11:08.196722+00	
00000000-0000-0000-0000-000000000000	5fc3e168-dfe9-42b4-9e57-b920de33eca1	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 11:11:30.328886+00	
00000000-0000-0000-0000-000000000000	2cc410a5-9bc0-4af8-a7f8-20be8b1b4d43	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-02 11:17:00.606029+00	
00000000-0000-0000-0000-000000000000	6a80b9a4-fa5c-48ab-b3ff-f433b71be0ac	{"action":"user_signedup","actor_id":"dac63cb7-6307-4ad8-8dfe-3b5bbba68347","actor_username":"user1@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-06-02 11:17:26.639795+00	
00000000-0000-0000-0000-000000000000	887ecd0b-ff31-4581-8692-b00fd7e952bf	{"action":"login","actor_id":"dac63cb7-6307-4ad8-8dfe-3b5bbba68347","actor_username":"user1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 11:17:26.645363+00	
00000000-0000-0000-0000-000000000000	373c8e0b-bcd0-4ab2-bd62-10c5d9bb7fbc	{"action":"logout","actor_id":"dac63cb7-6307-4ad8-8dfe-3b5bbba68347","actor_username":"user1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-02 11:17:48.450657+00	
00000000-0000-0000-0000-000000000000	e8abee8e-cf80-4f0c-aab9-9d06205ddab9	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 11:18:05.801105+00	
00000000-0000-0000-0000-000000000000	86f96377-3abb-43ed-a661-b30b936746d4	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"user1@example.com","user_id":"dac63cb7-6307-4ad8-8dfe-3b5bbba68347","user_phone":""}}	2025-06-02 11:18:20.244221+00	
00000000-0000-0000-0000-000000000000	daf3bb33-37f7-46dc-85af-b051cb8965ff	{"action":"token_refreshed","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-02 12:17:02.232657+00	
00000000-0000-0000-0000-000000000000	bb2e734c-0d74-4d02-9ac9-6db5b43076fa	{"action":"token_revoked","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-02 12:17:02.233616+00	
00000000-0000-0000-0000-000000000000	cd31eb43-b1a5-419d-8fdc-a0b22cfe7f1e	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-02 12:46:41.220738+00	
00000000-0000-0000-0000-000000000000	46cd8da1-15d8-4f05-84a0-29e7fecb9fac	{"action":"user_signedup","actor_id":"ec0f491d-7697-43e5-9e19-e564c32c8e50","actor_username":"user1@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-06-02 12:47:13.875423+00	
00000000-0000-0000-0000-000000000000	1f2a09af-6f5b-4049-a35c-6f8190b45e8b	{"action":"login","actor_id":"ec0f491d-7697-43e5-9e19-e564c32c8e50","actor_username":"user1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 12:47:13.883033+00	
00000000-0000-0000-0000-000000000000	fdf81fd0-7e3a-4ee1-a368-ea64590c3865	{"action":"logout","actor_id":"ec0f491d-7697-43e5-9e19-e564c32c8e50","actor_username":"user1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-02 12:47:49.649739+00	
00000000-0000-0000-0000-000000000000	46480ae6-f878-4136-a00d-9fb976e3a121	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 12:48:06.177634+00	
00000000-0000-0000-0000-000000000000	05f4e37e-2549-4a2a-a1a4-3f0b6c58cf23	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"user1@example.com","user_id":"ec0f491d-7697-43e5-9e19-e564c32c8e50","user_phone":""}}	2025-06-02 12:48:15.734576+00	
00000000-0000-0000-0000-000000000000	c71d0b6d-9077-4abe-b40e-20b34a13870f	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-02 12:48:39.68281+00	
00000000-0000-0000-0000-000000000000	48bd1029-c48a-44a5-b522-d5ea2283db4a	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 12:48:56.366875+00	
00000000-0000-0000-0000-000000000000	0cfb3d03-4cf0-4179-93ca-370f2bf497bd	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-02 12:51:10.944001+00	
00000000-0000-0000-0000-000000000000	e210358c-8690-45d2-a4f9-2cb2a688698f	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 12:51:29.057425+00	
00000000-0000-0000-0000-000000000000	5e6cc035-0401-4492-9f70-fb326b6fb0be	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-02 12:51:56.735897+00	
00000000-0000-0000-0000-000000000000	1dee96f1-f156-46bd-841f-8d1bb5ea0218	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-03 07:56:31.768106+00	
00000000-0000-0000-0000-000000000000	4b95aa45-0f28-4114-b8d5-749adb795987	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-03 08:02:12.282293+00	
00000000-0000-0000-0000-000000000000	3147ad0a-7aac-43f3-8170-8aaf7043384c	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-03 08:02:33.353526+00	
00000000-0000-0000-0000-000000000000	6f44f5fb-beb6-42ec-b63f-10479aa7ff19	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-03 08:06:03.070971+00	
00000000-0000-0000-0000-000000000000	4f38eb52-4f1c-4cf2-a841-2f11de30d4f3	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-03 08:06:21.365859+00	
00000000-0000-0000-0000-000000000000	d9af0a31-42ca-450e-98e6-85051be63b74	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-03 08:06:51.580128+00	
00000000-0000-0000-0000-000000000000	6667f49d-9b34-4e03-aa0c-6da895b1b8a8	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-03 08:07:11.24062+00	
00000000-0000-0000-0000-000000000000	b06302af-46ff-4fc0-8855-fb440c06f290	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-03 09:20:28.984519+00	
00000000-0000-0000-0000-000000000000	cb0f2756-4278-4f25-814e-cbdac4935f0a	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-03 09:20:28.989644+00	
00000000-0000-0000-0000-000000000000	4ec2cd49-0a1f-433b-ba97-8a5d262545fe	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-03 09:33:28.668693+00	
00000000-0000-0000-0000-000000000000	1c12200c-e395-445f-b4ab-2002724cdaa3	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-03 09:33:48.184219+00	
00000000-0000-0000-0000-000000000000	0fd37bc7-5a25-4533-b386-f1eb3b138a89	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-03 09:34:43.528334+00	
00000000-0000-0000-0000-000000000000	0b3f13ec-a949-4723-83d2-7f1d89982f18	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-03 10:07:40.457711+00	
00000000-0000-0000-0000-000000000000	7efaa442-8025-4bef-9506-1433a9fae309	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-04 06:43:44.225767+00	
00000000-0000-0000-0000-000000000000	ee78bd58-31fc-4530-96ac-3e2de7f4ed63	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-04 06:43:44.24205+00	
00000000-0000-0000-0000-000000000000	5168c37f-6d0f-4d23-8e7c-53f395ca1c22	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-04 07:42:12.552705+00	
00000000-0000-0000-0000-000000000000	b2eb0033-bff4-433e-8f13-313fedf0abcb	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-04 07:42:12.561908+00	
00000000-0000-0000-0000-000000000000	88abef8d-7cb9-4e27-9d4a-589acab986a0	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-05 10:54:27.006624+00	
00000000-0000-0000-0000-000000000000	3c3ccfe8-cd88-49d6-9838-ee27d3875c70	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-05 10:54:27.022963+00	
00000000-0000-0000-0000-000000000000	b01cc75d-3e25-4e9d-853d-9921b8313d3c	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-05 10:55:49.298551+00	
00000000-0000-0000-0000-000000000000	1d6af71a-a194-4017-ac1b-bf89600f7760	{"action":"user_signedup","actor_id":"2e1eace1-bcba-446c-acf8-23995208ea15","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-06-05 11:56:09.550389+00	
00000000-0000-0000-0000-000000000000	c96bd16a-0113-4d82-ba30-48a469966340	{"action":"login","actor_id":"2e1eace1-bcba-446c-acf8-23995208ea15","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-05 11:56:09.558765+00	
00000000-0000-0000-0000-000000000000	ddbba034-b2b3-4875-b3f3-a264a8009684	{"action":"logout","actor_id":"2e1eace1-bcba-446c-acf8-23995208ea15","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-05 11:57:57.616729+00	
00000000-0000-0000-0000-000000000000	b724a39c-7275-4852-b4b8-aee529dface2	{"action":"login","actor_id":"2e1eace1-bcba-446c-acf8-23995208ea15","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-05 12:24:28.933848+00	
00000000-0000-0000-0000-000000000000	77f72472-e3ab-4e9e-b562-9cb812863a00	{"action":"logout","actor_id":"2e1eace1-bcba-446c-acf8-23995208ea15","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-05 12:24:52.902477+00	
00000000-0000-0000-0000-000000000000	000f94b6-b59d-4909-a4cc-9a97b587a4e6	{"action":"user_signedup","actor_id":"52c97e64-5168-40ec-a691-4708dd4412a0","actor_username":"ftgthv@hfvhgcvh","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-06-05 12:27:35.115447+00	
00000000-0000-0000-0000-000000000000	2828f8e7-1362-4555-af4a-2c16d4657a81	{"action":"login","actor_id":"52c97e64-5168-40ec-a691-4708dd4412a0","actor_username":"ftgthv@hfvhgcvh","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-05 12:27:35.120192+00	
00000000-0000-0000-0000-000000000000	14322b2e-4099-4e3a-952f-1987192443ab	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"ftgthv@hfvhgcvh","user_id":"52c97e64-5168-40ec-a691-4708dd4412a0","user_phone":""}}	2025-06-05 12:27:55.460251+00	
00000000-0000-0000-0000-000000000000	f54e2435-7739-444d-ba3e-81a0638eb2c1	{"action":"user_signedup","actor_id":"a0cdc8cf-1491-4d96-a38f-4f7f1520d956","actor_username":"bryankinyua4@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-06-05 12:29:33.217723+00	
00000000-0000-0000-0000-000000000000	ab218688-7dfd-4ba3-901e-ca06a784ee29	{"action":"login","actor_id":"a0cdc8cf-1491-4d96-a38f-4f7f1520d956","actor_username":"bryankinyua4@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-05 12:29:33.223699+00	
00000000-0000-0000-0000-000000000000	06bb316d-03a8-48a7-b820-bb7cb7c0a2dd	{"action":"logout","actor_id":"a0cdc8cf-1491-4d96-a38f-4f7f1520d956","actor_username":"bryankinyua4@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-05 12:29:39.70808+00	
00000000-0000-0000-0000-000000000000	3155e9b0-e6df-4bec-95c6-b68e561f52f9	{"action":"user_updated_password","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-06-05 21:05:10.800654+00	
00000000-0000-0000-0000-000000000000	976ce539-7270-4d30-82b3-03c2bf4e5572	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"bryankinyua4@example.com","user_id":"a0cdc8cf-1491-4d96-a38f-4f7f1520d956","user_phone":""}}	2025-06-05 12:30:50.896916+00	
00000000-0000-0000-0000-000000000000	516b7831-0424-4bd8-af1e-09436867d99f	{"action":"user_signedup","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-06-05 12:32:11.647535+00	
00000000-0000-0000-0000-000000000000	892197ef-a0cc-41fb-8aac-87bbaabd7b36	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-05 12:32:11.651429+00	
00000000-0000-0000-0000-000000000000	689f0290-571e-4aaa-849f-fe0bbbe55ace	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-05 12:32:17.897495+00	
00000000-0000-0000-0000-000000000000	9c948ca6-b5ea-4e66-9fe3-5be2f3380632	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-05 12:32:48.539636+00	
00000000-0000-0000-0000-000000000000	b2dd86ec-3039-4352-a7e7-7d2701d104a6	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-05 12:32:53.790982+00	
00000000-0000-0000-0000-000000000000	5add5776-6494-495f-a8f0-411ea554d912	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-05 12:33:06.705435+00	
00000000-0000-0000-0000-000000000000	f77bccef-52ac-461a-9271-da636d03e7bc	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-05 12:33:09.474779+00	
00000000-0000-0000-0000-000000000000	47a45cb7-f2f8-4613-9d75-df880c0277ee	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-05 12:37:25.393232+00	
00000000-0000-0000-0000-000000000000	3643654b-a762-4901-a483-b5c52695f48a	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-05 12:37:48.608069+00	
00000000-0000-0000-0000-000000000000	9c63280d-a6fa-45f8-aa0f-cbdfbcaf77ef	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-05 13:07:52.90442+00	
00000000-0000-0000-0000-000000000000	dc2afb1b-6d8a-40e7-affb-28750bb69e15	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-05 13:08:03.999083+00	
00000000-0000-0000-0000-000000000000	3c074bda-e648-48c0-91a1-61033948877b	{"action":"user_recovery_requested","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-06-05 14:07:20.470598+00	
00000000-0000-0000-0000-000000000000	684ba190-0173-4eba-87a8-8912470e9189	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-05 14:08:35.151673+00	
00000000-0000-0000-0000-000000000000	0629027d-687e-4783-b4c5-f83fe4a1cdb9	{"action":"token_refreshed","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-06-05 20:30:19.377623+00	
00000000-0000-0000-0000-000000000000	9a487144-bc86-49cd-85b8-c5275bd88379	{"action":"token_revoked","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-06-05 20:30:19.392862+00	
00000000-0000-0000-0000-000000000000	ebbcda1a-31df-4acc-8ece-237799bdfc1b	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-05 20:31:50.935125+00	
00000000-0000-0000-0000-000000000000	4ad63590-82ca-4a5e-9d3d-91ab3b7a5fd1	{"action":"user_recovery_requested","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-06-05 20:44:59.596744+00	
00000000-0000-0000-0000-000000000000	2fb26dd2-3508-462c-b2bc-bc9289d81fb4	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-05 20:45:41.710106+00	
00000000-0000-0000-0000-000000000000	631e1a2e-c0f6-470d-be4b-81259a97627e	{"action":"user_recovery_requested","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-06-05 20:46:42.19746+00	
00000000-0000-0000-0000-000000000000	836e5ae4-8f30-4e40-97c4-40f698ba475f	{"action":"user_updated_password","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-06-05 20:51:56.496652+00	
00000000-0000-0000-0000-000000000000	f51eaf21-f308-4a5b-ac55-ff834da615e4	{"action":"user_modified","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-06-05 20:51:56.499851+00	
00000000-0000-0000-0000-000000000000	738fd128-af81-400e-967a-d0168e913c37	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-05 20:52:28.065776+00	
00000000-0000-0000-0000-000000000000	14aebfe6-5979-4665-8e40-cf719cad233e	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-05 20:55:09.558993+00	
00000000-0000-0000-0000-000000000000	19ba9d22-c8f6-4637-a5c8-1e2d77363667	{"action":"user_recovery_requested","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-06-05 20:55:31.525299+00	
00000000-0000-0000-0000-000000000000	687db6b6-7b0b-4696-8c25-44854bedef8c	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-05 20:56:00.553265+00	
00000000-0000-0000-0000-000000000000	4e88fc35-709c-4a64-adcc-e4d323c84090	{"action":"user_updated_password","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-06-05 20:56:25.399893+00	
00000000-0000-0000-0000-000000000000	6c05311f-53c6-4b8c-9e56-c4d9774cb522	{"action":"user_modified","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-06-05 20:56:25.402357+00	
00000000-0000-0000-0000-000000000000	6a1d9d10-90da-464f-a242-166cd984eafd	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-05 20:56:48.874905+00	
00000000-0000-0000-0000-000000000000	c6abf345-2442-4c16-b124-a1e91d4b84f6	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-05 21:03:18.559823+00	
00000000-0000-0000-0000-000000000000	324e0e1e-bef5-449d-a1a1-8e53787a22e8	{"action":"user_recovery_requested","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-06-05 21:03:39.071104+00	
00000000-0000-0000-0000-000000000000	89315565-2511-429a-896c-19fa1722d4e8	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-05 21:04:04.315675+00	
00000000-0000-0000-0000-000000000000	62ab81cf-ab9e-456b-90eb-2c90394442a4	{"action":"user_modified","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-06-05 21:05:10.803831+00	
00000000-0000-0000-0000-000000000000	29cb166b-3279-446c-a767-93931dbae36c	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-05 21:05:37.995652+00	
00000000-0000-0000-0000-000000000000	8baffc1e-ed3e-4091-9a98-f6fe37d56e2b	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-05 21:07:47.029151+00	
00000000-0000-0000-0000-000000000000	38ae7b1c-3f32-41c0-937d-8604cb43e5ab	{"action":"user_recovery_requested","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-06-05 21:08:03.704358+00	
00000000-0000-0000-0000-000000000000	3dc52313-1a2a-4e8c-b1e1-64de2131ea9f	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-05 21:08:46.099603+00	
00000000-0000-0000-0000-000000000000	ad2970e3-bf85-4c71-87f9-20b61766d089	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-05 21:09:12.05882+00	
00000000-0000-0000-0000-000000000000	22527f86-84fe-40ea-be41-a0e4124b222a	{"action":"user_recovery_requested","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-06-05 21:15:53.13155+00	
00000000-0000-0000-0000-000000000000	f3cc2010-9459-4b07-b026-8b870e40d4f8	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-05 21:16:19.943314+00	
00000000-0000-0000-0000-000000000000	980ad0c8-3bbb-4a5d-b837-80b7c24b95c9	{"action":"user_updated_password","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-06-05 21:17:16.747753+00	
00000000-0000-0000-0000-000000000000	3d5ef51d-be26-49d1-afcf-70a5058b007d	{"action":"user_modified","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-06-05 21:17:16.749686+00	
00000000-0000-0000-0000-000000000000	8b08816a-d8f4-4ccd-a86c-0107b4bf2d24	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-05 21:18:18.612495+00	
00000000-0000-0000-0000-000000000000	f7c7e3c1-f0cc-4426-b20d-e7ed41abc201	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-05 21:18:26.327711+00	
00000000-0000-0000-0000-000000000000	7b8bddb9-1141-4dde-9bc5-bc8559142e18	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-06 08:02:27.211768+00	
00000000-0000-0000-0000-000000000000	a8a9e7db-3cf2-4396-a993-e92bf0bbd239	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-06 08:08:43.284421+00	
00000000-0000-0000-0000-000000000000	b703cf2e-c8d4-4758-912c-e3ce3bd94d2c	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-06 08:09:04.820417+00	
00000000-0000-0000-0000-000000000000	648829c6-3420-46f2-8cc0-f4aea2b03050	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-06 08:10:46.623711+00	
00000000-0000-0000-0000-000000000000	c4d4676e-3065-4c48-95db-7fba654c4afd	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-06 08:11:09.237851+00	
00000000-0000-0000-0000-000000000000	67037582-ea9a-481a-b811-5f1910260642	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-06 08:12:26.232725+00	
00000000-0000-0000-0000-000000000000	c974e899-e2df-4e31-9fb6-30630cb4b254	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-06 08:13:05.894598+00	
00000000-0000-0000-0000-000000000000	509d4a7f-ce3e-484a-bf6b-1f40bcc661af	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-06 08:13:33.371995+00	
00000000-0000-0000-0000-000000000000	0dc51a09-7d14-412d-8c2b-79713dc2e8cf	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-06 08:13:54.27565+00	
00000000-0000-0000-0000-000000000000	7355af77-fcd4-450b-bf14-0cdc4380c01e	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-06 08:15:04.676761+00	
00000000-0000-0000-0000-000000000000	564826e6-1c53-4007-b78c-bd7556606108	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-06 08:15:28.312781+00	
00000000-0000-0000-0000-000000000000	aa90b45a-7f3a-48a8-961f-2a7085662d90	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-06 08:23:36.400138+00	
00000000-0000-0000-0000-000000000000	f254812b-e7a8-49cd-bf45-313e942bf336	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-06 08:24:01.782927+00	
00000000-0000-0000-0000-000000000000	1fff00fa-a8cc-4554-8310-41615e6b2e87	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-06 08:25:06.53427+00	
00000000-0000-0000-0000-000000000000	7f0bef5d-7ae0-4397-8fac-63fce8b195e0	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-06 08:25:23.369151+00	
00000000-0000-0000-0000-000000000000	699195db-3fd4-483c-9d2d-33102432b778	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-06 09:23:10.51231+00	
00000000-0000-0000-0000-000000000000	ebf0b5d0-ebb0-41e3-9a6b-99afc7874cc5	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-06 09:23:45.8301+00	
00000000-0000-0000-0000-000000000000	f969ef71-cd4f-4741-8b20-19fc139d414c	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-06 09:25:07.124582+00	
00000000-0000-0000-0000-000000000000	8506dde4-e177-41a1-927f-828444c28c4f	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-06 09:25:27.835796+00	
00000000-0000-0000-0000-000000000000	e7b290d8-5fc5-4f2f-ab72-4311badf4189	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-06 09:25:40.541139+00	
00000000-0000-0000-0000-000000000000	4353a842-f35b-4a25-bfc6-229079bd232d	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-06 09:26:03.467904+00	
00000000-0000-0000-0000-000000000000	3ebc642d-e3e4-4792-842c-a578321317c4	{"action":"token_refreshed","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-06-06 10:24:04.843098+00	
00000000-0000-0000-0000-000000000000	f4c828db-67cc-4b6b-b5ee-f6554568f6b8	{"action":"token_revoked","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-06-06 10:24:04.845828+00	
00000000-0000-0000-0000-000000000000	15b8b157-1dff-4ba0-8c31-a372de1d887a	{"action":"token_refreshed","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-06-09 17:20:21.583819+00	
00000000-0000-0000-0000-000000000000	d9b117b8-d793-4e7e-b91e-4e232e30f66d	{"action":"token_revoked","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-06-09 17:20:21.599808+00	
00000000-0000-0000-0000-000000000000	68720780-6a36-4cf0-9100-245750fd776e	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-09 17:20:34.514933+00	
00000000-0000-0000-0000-000000000000	58f0eabf-2717-440b-ab42-f1b067eca386	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-09 17:28:31.109365+00	
00000000-0000-0000-0000-000000000000	1d57c641-fdeb-454f-8950-662866583120	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-09 18:10:11.943728+00	
00000000-0000-0000-0000-000000000000	0c89eab9-6bb7-4184-bf7d-e40900ecdae3	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-09 18:10:32.326033+00	
00000000-0000-0000-0000-000000000000	b84c6671-b0dd-4efc-ba91-1d3824bc3d9c	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-09 18:11:13.201763+00	
00000000-0000-0000-0000-000000000000	ad4b4453-2bf0-44dd-abb9-e763879af0d5	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-09 18:11:32.874252+00	
00000000-0000-0000-0000-000000000000	fa5941c7-5253-4ebc-90eb-3beefcdbda73	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-09 18:12:05.140526+00	
00000000-0000-0000-0000-000000000000	072a2dfc-b2e8-461f-994b-6be73ba82aad	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-09 18:12:26.772007+00	
00000000-0000-0000-0000-000000000000	139ccecf-5bf1-4948-9699-9f87deeebdd0	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-09 18:13:49.040609+00	
00000000-0000-0000-0000-000000000000	cedf02f4-a663-4c8c-b693-10f639a9e07a	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-09 18:14:17.829289+00	
00000000-0000-0000-0000-000000000000	1d3fe7eb-b360-430d-a843-66ccb0e6ffa0	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-09 18:16:24.967931+00	
00000000-0000-0000-0000-000000000000	4f46af10-df30-493c-a438-2f9caa4041f5	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-09 18:16:44.63099+00	
00000000-0000-0000-0000-000000000000	b247f629-a9d7-4bc7-a37b-8699ded56259	{"action":"token_refreshed","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-11 11:09:16.027617+00	
00000000-0000-0000-0000-000000000000	d28edbfd-83f4-42ac-830e-2417c8cff74f	{"action":"token_revoked","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-11 11:09:16.044563+00	
00000000-0000-0000-0000-000000000000	031343c2-b61b-45be-8b14-76d4704afaa6	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 11:12:10.530191+00	
00000000-0000-0000-0000-000000000000	9f5016d9-91a1-4450-8ae6-a63a0bf65059	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 11:12:34.440989+00	
00000000-0000-0000-0000-000000000000	b8ea5270-1300-4daf-892e-12dd57e63d2b	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 11:15:52.82216+00	
00000000-0000-0000-0000-000000000000	d809a369-3fb6-40a5-93eb-e19c8e0123b2	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 11:16:14.850988+00	
00000000-0000-0000-0000-000000000000	0598c829-76b3-4d36-902e-dc03a06a4bf2	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 11:17:18.003299+00	
00000000-0000-0000-0000-000000000000	322a8e60-2e76-4686-826e-b92d32018c9b	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 11:17:37.401462+00	
00000000-0000-0000-0000-000000000000	d1117788-9685-491c-8191-7140c0fec7d2	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 11:21:35.196146+00	
00000000-0000-0000-0000-000000000000	c538fe7d-3cc1-45b7-95fb-89ca6b96ca37	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 11:21:54.570988+00	
00000000-0000-0000-0000-000000000000	41f74ebc-a3f4-45fd-bc60-5216148bc08f	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 11:36:18.602391+00	
00000000-0000-0000-0000-000000000000	12a1632b-ebbd-49dd-a0a2-6069ee1bbaee	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 11:36:38.490908+00	
00000000-0000-0000-0000-000000000000	e96a9005-fd99-4abf-9f05-e18eb5301743	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 11:36:48.596305+00	
00000000-0000-0000-0000-000000000000	a7f0871a-1d03-4133-9865-1d8fe8550b46	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 11:37:07.923164+00	
00000000-0000-0000-0000-000000000000	31e5b527-ba70-4e77-bdbf-976a8d9152ac	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 11:41:04.270954+00	
00000000-0000-0000-0000-000000000000	c308da9f-3cc4-44aa-9c43-91a475cce89d	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 11:41:26.896347+00	
00000000-0000-0000-0000-000000000000	3ac4bd04-75f7-4c80-9848-223bdded871c	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 11:44:01.674031+00	
00000000-0000-0000-0000-000000000000	15edf950-03c8-4961-89e8-9ccc4a7176a3	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 11:44:41.67072+00	
00000000-0000-0000-0000-000000000000	b0cb61fe-521d-4bee-b674-2f9a83289ec4	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 11:45:01.287266+00	
00000000-0000-0000-0000-000000000000	e5db8571-f006-4aff-a0e8-54e5275359c1	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 11:45:18.279224+00	
00000000-0000-0000-0000-000000000000	b79b3654-bcda-446e-910f-0feb89f5a7d4	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 11:47:47.785014+00	
00000000-0000-0000-0000-000000000000	a3c45d89-20f7-4887-98e5-9ad8cf684ddf	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 11:48:20.268731+00	
00000000-0000-0000-0000-000000000000	94b04f94-3d8c-4ba8-bd84-c25b14b90b69	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 11:50:03.105332+00	
00000000-0000-0000-0000-000000000000	bb2dd638-f5c6-48c4-ad5d-0a22f831c1b2	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 11:50:24.367253+00	
00000000-0000-0000-0000-000000000000	df5a415c-9484-4122-ba7a-727532acf7df	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 11:52:33.05791+00	
00000000-0000-0000-0000-000000000000	b7fbf413-bb2d-4281-93d8-86e2375c3916	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 12:19:11.446909+00	
00000000-0000-0000-0000-000000000000	1c571241-84d2-4ff0-a699-a09b7b07693f	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-11 15:42:00.661673+00	
00000000-0000-0000-0000-000000000000	ccf75305-b6c2-4089-bd9d-d1e722de75bf	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-11 15:42:00.669553+00	
00000000-0000-0000-0000-000000000000	1dfe1899-a745-41f7-a053-0a2690c02e80	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 15:45:05.52119+00	
00000000-0000-0000-0000-000000000000	5d2f1b78-caf6-4ec3-ab6d-75f617d7f7c9	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 15:46:01.07539+00	
00000000-0000-0000-0000-000000000000	316e9272-5e57-4e2f-8559-9bc133bc7d48	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 15:58:17.258426+00	
00000000-0000-0000-0000-000000000000	9570e771-f455-489c-8774-dbb38cddbeb5	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 15:58:39.498344+00	
00000000-0000-0000-0000-000000000000	0d99901e-0187-448f-9c8c-0a4664e5beb7	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 16:00:25.165898+00	
00000000-0000-0000-0000-000000000000	c8c87fe8-9315-45f2-a77d-081a9b717f83	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 16:00:42.430445+00	
00000000-0000-0000-0000-000000000000	a73d9614-e3e3-48ec-b62d-f78d51e2ed16	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 16:01:23.359435+00	
00000000-0000-0000-0000-000000000000	bd1b7eaf-6766-41ab-9810-b75da1085f52	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 16:30:18.509916+00	
00000000-0000-0000-0000-000000000000	318aec75-5b48-4df6-80a1-210607bbd64a	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 16:36:08.673025+00	
00000000-0000-0000-0000-000000000000	9b0e4790-e9cd-49c6-a8ba-dcb84505dfdc	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 16:36:30.243876+00	
00000000-0000-0000-0000-000000000000	edbac8eb-e47a-4399-9e6d-f10767963ce2	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 16:38:53.126276+00	
00000000-0000-0000-0000-000000000000	841f952d-48dc-49f3-99bb-43885f94db42	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 16:39:22.399051+00	
00000000-0000-0000-0000-000000000000	58203bc4-be60-4bf9-8f33-aa1075d3a9bf	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 16:42:39.032154+00	
00000000-0000-0000-0000-000000000000	26ee3565-ee3d-4093-aa99-e0e829a68427	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 16:45:59.693495+00	
00000000-0000-0000-0000-000000000000	97274a2e-8595-44f8-8c4b-4de4ed7747b6	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 16:46:52.472034+00	
00000000-0000-0000-0000-000000000000	662871dd-ca89-4829-9c3c-8da9c6cbffe2	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 16:47:18.016597+00	
00000000-0000-0000-0000-000000000000	51e0364c-f617-460e-8885-c63252412059	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 16:48:32.664765+00	
00000000-0000-0000-0000-000000000000	c4d1a60c-2000-48af-ad94-cf3f3a466188	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 16:48:56.075413+00	
00000000-0000-0000-0000-000000000000	3d525378-5f91-4697-9692-59f5c967b106	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 16:51:37.115335+00	
00000000-0000-0000-0000-000000000000	b3bdfd6b-a507-4950-bdcc-c3497429996b	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 16:51:52.728833+00	
00000000-0000-0000-0000-000000000000	31787aa9-183b-44ee-926a-095a4b88fdcc	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-11 20:58:54.955813+00	
00000000-0000-0000-0000-000000000000	af71c3ad-fe54-4b1d-8a97-0bb1d0c90ec9	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-11 20:58:54.969738+00	
00000000-0000-0000-0000-000000000000	8920b45f-c39e-4f5b-b319-a2b42dd2427a	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 21:03:37.140996+00	
00000000-0000-0000-0000-000000000000	d804f0bc-3cc1-4748-87b0-cba46cfc2c62	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 21:03:56.351+00	
00000000-0000-0000-0000-000000000000	e94d108c-ddeb-4540-ac3a-a23afa77e89b	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 21:50:30.322629+00	
00000000-0000-0000-0000-000000000000	c9520a5f-4c8c-4de9-9468-9bfd57c805e1	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 21:50:46.47833+00	
00000000-0000-0000-0000-000000000000	a0d0ee36-9bbd-4ad2-a6df-534b3423d501	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 22:26:33.037198+00	
00000000-0000-0000-0000-000000000000	7be97c70-be65-46f4-8116-e701717c82c8	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 22:26:50.924791+00	
00000000-0000-0000-0000-000000000000	ca0878ef-a08c-4c1a-9912-38cee16cca4f	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 23:07:51.416713+00	
00000000-0000-0000-0000-000000000000	7cfb0ce2-1190-421f-a002-12bca06edb3e	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-11 23:35:23.017422+00	
00000000-0000-0000-0000-000000000000	811d332c-8a31-4c39-97f3-9cb73e8f3f04	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-11 23:35:48.396608+00	
00000000-0000-0000-0000-000000000000	36c24e52-d4ba-45db-a296-28d708892fd1	{"action":"user_repeated_signup","actor_id":"2e1eace1-bcba-446c-acf8-23995208ea15","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-06-12 04:57:36.991964+00	
00000000-0000-0000-0000-000000000000	1d061da4-906a-4597-9419-a152ca18cf4f	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"mkulima3@example.com","user_id":"2e1eace1-bcba-446c-acf8-23995208ea15","user_phone":""}}	2025-06-12 04:59:26.523278+00	
00000000-0000-0000-0000-000000000000	3915b721-79f5-4391-bf30-86b6b6375a54	{"action":"user_signedup","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-06-12 05:01:47.160357+00	
00000000-0000-0000-0000-000000000000	8645df16-34fe-4da4-ae73-baa8e23df04c	{"action":"login","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-12 05:01:47.169187+00	
00000000-0000-0000-0000-000000000000	0d6a5c9a-1fa1-490b-a389-334ac4213d2e	{"action":"logout","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-12 05:07:26.325327+00	
00000000-0000-0000-0000-000000000000	9ba71d3d-dee1-4646-9f01-750f176de942	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-12 05:07:54.832396+00	
00000000-0000-0000-0000-000000000000	312ef48a-0e02-4569-8a1e-9030916d5413	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-12 05:18:53.930701+00	
00000000-0000-0000-0000-000000000000	0b32b9de-7223-4b03-a8e5-3be23eddee2a	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-12 05:19:11.543883+00	
00000000-0000-0000-0000-000000000000	49e3603f-0244-45bc-8062-d635bb90be93	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-12 05:20:40.884115+00	
00000000-0000-0000-0000-000000000000	45c2c345-8bb4-4d0a-a3b6-cbc49f6fbc7a	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-12 05:27:31.375276+00	
00000000-0000-0000-0000-000000000000	707f5049-c811-4b4d-a94a-57d86a5cfb97	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-12 05:33:10.192143+00	
00000000-0000-0000-0000-000000000000	0a6d90cd-55bc-468d-8158-1ea810e1f9b2	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-12 05:33:32.723684+00	
00000000-0000-0000-0000-000000000000	ef5b136a-4be3-4e61-a2f0-ecd08047b878	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-12 05:33:45.644497+00	
00000000-0000-0000-0000-000000000000	b0d2a119-4e77-4dd8-877c-e9ea4a1165bb	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-12 05:34:12.118305+00	
00000000-0000-0000-0000-000000000000	9f0a1844-11f0-4b20-83c3-442ce8d17034	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-12 05:34:15.239524+00	
00000000-0000-0000-0000-000000000000	3c3fa914-8af3-4bb4-9bcb-342793adda94	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-12 05:37:08.284826+00	
00000000-0000-0000-0000-000000000000	fde3a6d7-f420-49b3-bdfc-2ed7649ca588	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-12 06:16:43.267152+00	
00000000-0000-0000-0000-000000000000	3d03b1e6-6e9f-4cf1-a20a-f12549baf607	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-12 06:17:02.911295+00	
00000000-0000-0000-0000-000000000000	14d8cd51-7a73-4875-be0d-042550577e13	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-12 06:24:31.065617+00	
00000000-0000-0000-0000-000000000000	140205fe-4640-4ef2-9796-ebc714b53c62	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-12 06:27:58.892942+00	
00000000-0000-0000-0000-000000000000	6d52697e-5dfe-4b1d-bf11-dee9033df8f6	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-12 06:32:47.822486+00	
00000000-0000-0000-0000-000000000000	c8dc6574-d04e-4e68-8a2f-3e04ef55e5ac	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-12 06:33:43.209046+00	
00000000-0000-0000-0000-000000000000	5ac29d16-d1db-41da-9e19-a8417ea95b58	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-12 06:56:10.474315+00	
00000000-0000-0000-0000-000000000000	1e7ecb72-1615-4bbb-8f63-995db1e6f8fd	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-12 06:56:31.393748+00	
00000000-0000-0000-0000-000000000000	d6aa6418-9f72-418d-a396-2a524d293126	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-12 06:56:58.446604+00	
00000000-0000-0000-0000-000000000000	e2ea7a7d-54e9-4b9b-89f0-f55cec72c6d9	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-12 22:41:39.250964+00	
00000000-0000-0000-0000-000000000000	43a43924-6d89-4f1c-b02c-016b089f59c7	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-12 22:45:02.182972+00	
00000000-0000-0000-0000-000000000000	f09ce62c-42cf-46a8-8e5d-1571c0fcf110	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-12 22:45:27.161019+00	
00000000-0000-0000-0000-000000000000	7ee7c84b-7eb8-4dfc-a99d-cb826027af3d	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-12 22:46:59.739264+00	
00000000-0000-0000-0000-000000000000	87ca5878-ba6f-4864-80c8-797aa03b2ce8	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-12 22:47:20.19755+00	
00000000-0000-0000-0000-000000000000	72e09f6c-9e61-4b3a-a307-1503843dca0e	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-12 22:56:14.600287+00	
00000000-0000-0000-0000-000000000000	200e9a98-a02a-424c-b114-0da48e64dbc5	{"action":"login","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-12 23:14:52.772727+00	
00000000-0000-0000-0000-000000000000	e657f240-c472-430f-b815-4b14fce9a0a7	{"action":"logout","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-12 23:16:10.425656+00	
00000000-0000-0000-0000-000000000000	715f09ce-c3be-4984-b76a-a0d1eb00fc6d	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-12 23:17:43.357312+00	
00000000-0000-0000-0000-000000000000	ece8c633-cdfb-430d-8c75-4aab0bac9a84	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-12 23:18:35.40347+00	
00000000-0000-0000-0000-000000000000	68a7652c-6c83-4c3b-88de-44ffe1e356e3	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-12 23:18:53.984023+00	
00000000-0000-0000-0000-000000000000	a3f84312-2c08-48f7-82c0-6f80cd290e55	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-12 23:20:48.698015+00	
00000000-0000-0000-0000-000000000000	c1f452c5-6bcd-4ec1-a2d1-907e7a711ec5	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-12 23:21:05.81384+00	
00000000-0000-0000-0000-000000000000	6a70ecd0-c9b6-47b5-bf67-4bc391c0f845	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-12 23:25:12.625422+00	
00000000-0000-0000-0000-000000000000	e645ca4e-8da0-4ddd-8a23-08a5dd6221c4	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-12 23:25:33.171828+00	
00000000-0000-0000-0000-000000000000	4cef5649-34a2-46fb-aa32-559d069047ca	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-13 00:14:54.528265+00	
00000000-0000-0000-0000-000000000000	167d0846-adff-41d4-8d36-16b94155c637	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 11:45:20.273966+00	
00000000-0000-0000-0000-000000000000	e6d4793b-5573-4583-8c96-80463f0330d4	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-13 11:53:02.523292+00	
00000000-0000-0000-0000-000000000000	47c7054e-3ab1-47ee-bbf0-94e59f8406d1	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 11:53:21.457238+00	
00000000-0000-0000-0000-000000000000	3b304c21-d8a5-4902-a3b5-2485c5999d99	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-13 11:55:24.874484+00	
00000000-0000-0000-0000-000000000000	0d437f72-7fe9-4cb0-9e4a-7ac33f9a1f96	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 17:11:49.471571+00	
00000000-0000-0000-0000-000000000000	5cec5365-fc55-44e2-b4a0-132a57e9a561	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 17:20:23.614613+00	
00000000-0000-0000-0000-000000000000	677f8204-792f-4fb9-81ed-581d86da514d	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 17:20:41.225077+00	
00000000-0000-0000-0000-000000000000	1ea6ff9d-fef4-49ea-96a1-f81742b3655a	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 17:48:23.877722+00	
00000000-0000-0000-0000-000000000000	c2bd1e64-e6c7-4ce6-b7ae-589aeeb89776	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 17:48:45.578875+00	
00000000-0000-0000-0000-000000000000	a76fce52-2216-4ab2-ac2c-353bad0fe201	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 17:49:00.144927+00	
00000000-0000-0000-0000-000000000000	85ab6d55-1314-4b48-83a7-f732a7f7b97f	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 17:49:17.667087+00	
00000000-0000-0000-0000-000000000000	37f67a96-0b16-4d1e-87e7-a0f7411567a8	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 17:49:39.792158+00	
00000000-0000-0000-0000-000000000000	f0b11f74-be2a-464f-a58d-1dd7562aebf0	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 17:49:57.442424+00	
00000000-0000-0000-0000-000000000000	e3f60320-d1e3-4e97-8945-c6839d370887	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 17:52:27.544357+00	
00000000-0000-0000-0000-000000000000	3abe41ba-8413-498e-84fa-a85f6475c807	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 17:52:51.644546+00	
00000000-0000-0000-0000-000000000000	978d4565-0576-4965-8924-1afa551ea02a	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 17:54:31.385612+00	
00000000-0000-0000-0000-000000000000	06cfa395-47af-43e7-8b64-ddd7012c41cf	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 17:54:50.427944+00	
00000000-0000-0000-0000-000000000000	8a2c79c1-028b-489f-b22b-c7a6722204bf	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 17:55:57.887544+00	
00000000-0000-0000-0000-000000000000	44d05c8e-1160-49d5-b933-a6eb32de269c	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 17:56:15.002839+00	
00000000-0000-0000-0000-000000000000	0400b906-b0c0-421b-bac1-e6cce3c54103	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 17:57:08.00285+00	
00000000-0000-0000-0000-000000000000	28cb6258-c3cd-4629-8141-ca182803eead	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 17:57:27.217138+00	
00000000-0000-0000-0000-000000000000	d20cc077-730f-4926-90c1-9ddca9e84bc0	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 17:57:52.051705+00	
00000000-0000-0000-0000-000000000000	9037ac57-f3b0-4224-afbf-ea9e91d7b086	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 17:58:19.467397+00	
00000000-0000-0000-0000-000000000000	b2d1a6cc-1872-43f1-9369-ff928be021a7	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 18:00:07.450666+00	
00000000-0000-0000-0000-000000000000	a540f135-5790-4753-8561-0fede3060706	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 18:00:26.360974+00	
00000000-0000-0000-0000-000000000000	ba9cd3b0-cf62-430d-bb99-2d2b9e5cd2ea	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 18:13:33.928347+00	
00000000-0000-0000-0000-000000000000	80b27a4c-a4b6-4994-b71a-956051f28b87	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 18:13:56.629868+00	
00000000-0000-0000-0000-000000000000	448a592c-7f71-4c99-8d78-1ae230e3c735	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 18:14:53.774909+00	
00000000-0000-0000-0000-000000000000	936b1038-c526-4603-b616-81323e6c5926	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 18:15:11.240993+00	
00000000-0000-0000-0000-000000000000	41d2def1-b95b-42e3-887a-3f6025e35d21	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 18:23:46.962618+00	
00000000-0000-0000-0000-000000000000	89b71b93-d9ee-4948-bcd0-3980d4f1d48b	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 18:24:05.306966+00	
00000000-0000-0000-0000-000000000000	dcd9f2b9-8a50-4c9e-9396-ccb582e47a38	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 18:24:45.773615+00	
00000000-0000-0000-0000-000000000000	1a2b967a-2c44-4421-9ebb-7aad47388844	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 18:25:03.929922+00	
00000000-0000-0000-0000-000000000000	30dcf52c-0f42-477a-8816-6a1d539476f1	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 18:25:41.072694+00	
00000000-0000-0000-0000-000000000000	d7a93819-a25e-4d51-9725-5e699275213b	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 18:25:59.448426+00	
00000000-0000-0000-0000-000000000000	01fd2f4b-af94-4f79-98be-e2273fa80199	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 18:26:57.080915+00	
00000000-0000-0000-0000-000000000000	3a80fafb-4803-4b37-ad1f-e8300079b614	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 18:27:17.267921+00	
00000000-0000-0000-0000-000000000000	90ecd10f-8de5-46ea-bc56-d21e21c779bc	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 18:28:01.506902+00	
00000000-0000-0000-0000-000000000000	4b8477b3-7363-4c05-811b-eace6a172eb3	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 18:28:18.798504+00	
00000000-0000-0000-0000-000000000000	654ce870-188f-4a3b-bf4a-51212e34bb8e	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 18:32:08.733175+00	
00000000-0000-0000-0000-000000000000	d4014b50-676e-48dd-8133-bdfc06430e67	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 18:32:25.459124+00	
00000000-0000-0000-0000-000000000000	730efaf4-2b55-4983-975c-921976838d49	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 18:32:42.907485+00	
00000000-0000-0000-0000-000000000000	45a7dae1-18b7-423a-8272-634bc3b5f4d6	{"action":"user_signedup","actor_id":"59eff280-f6c7-4d91-9e61-c1283f1c432b","actor_username":"mshiru24@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-06-16 20:12:26.431792+00	
00000000-0000-0000-0000-000000000000	56c5ac59-3ece-4a4f-a9bb-0cfafae73a19	{"action":"login","actor_id":"59eff280-f6c7-4d91-9e61-c1283f1c432b","actor_username":"mshiru24@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-16 20:12:26.448323+00	
00000000-0000-0000-0000-000000000000	ce12e13a-4adf-4f1f-b10c-eb547a5c9a4c	{"action":"logout","actor_id":"59eff280-f6c7-4d91-9e61-c1283f1c432b","actor_username":"mshiru24@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-16 20:18:50.701513+00	
00000000-0000-0000-0000-000000000000	678fc86e-dfde-4e9b-b3ba-e9e589b73fc6	{"action":"login","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-16 20:19:13.615682+00	
00000000-0000-0000-0000-000000000000	2b843dfb-d8ef-4ed7-91fe-53e46ae33fb7	{"action":"token_refreshed","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-17 12:43:54.394074+00	
00000000-0000-0000-0000-000000000000	1b5903a6-aa92-42c8-ae92-9ce38729fc89	{"action":"token_revoked","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-17 12:43:54.40394+00	
00000000-0000-0000-0000-000000000000	6156a29c-b85e-4789-82b7-33642921b8e4	{"action":"logout","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 12:44:48.136623+00	
00000000-0000-0000-0000-000000000000	c07b3969-bfab-4b4c-bb97-4152288cbb07	{"action":"user_signedup","actor_id":"3414523a-4dba-4314-a3ee-c7c3674dc963","actor_username":"kariukialfred68@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-06-17 12:50:27.074055+00	
00000000-0000-0000-0000-000000000000	65ef6c9f-011a-4add-9fa2-97f48e886c8f	{"action":"login","actor_id":"3414523a-4dba-4314-a3ee-c7c3674dc963","actor_username":"kariukialfred68@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 12:50:27.083632+00	
00000000-0000-0000-0000-000000000000	10935718-3a13-4e68-b734-2becc90fc34d	{"action":"logout","actor_id":"3414523a-4dba-4314-a3ee-c7c3674dc963","actor_username":"kariukialfred68@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 12:51:42.794445+00	
00000000-0000-0000-0000-000000000000	61c50df7-60b6-451f-9b49-0a70b976410b	{"action":"login","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 12:51:59.823028+00	
00000000-0000-0000-0000-000000000000	c098b3be-882c-46f8-9cc8-a7baece4693a	{"action":"logout","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 12:54:46.07799+00	
00000000-0000-0000-0000-000000000000	4c15e08c-0a45-4c29-b54b-0a1c2683020b	{"action":"login","actor_id":"3414523a-4dba-4314-a3ee-c7c3674dc963","actor_username":"kariukialfred68@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 12:55:31.445885+00	
00000000-0000-0000-0000-000000000000	7c48c7af-7512-4871-b483-e70607b1bc4f	{"action":"logout","actor_id":"3414523a-4dba-4314-a3ee-c7c3674dc963","actor_username":"kariukialfred68@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 12:55:58.595399+00	
00000000-0000-0000-0000-000000000000	a4c1bf14-ec61-48ef-9170-3be2c798514f	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 12:56:19.562888+00	
00000000-0000-0000-0000-000000000000	6ec4322e-faea-4a51-bd2e-b0289aa8b5c5	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 12:58:50.25183+00	
00000000-0000-0000-0000-000000000000	5a72522a-c2f1-4598-9357-0e33c60ec435	{"action":"login","actor_id":"3414523a-4dba-4314-a3ee-c7c3674dc963","actor_username":"kariukialfred68@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 12:59:03.107171+00	
00000000-0000-0000-0000-000000000000	ba01bbc5-be5c-42d7-aa28-6acfd4774176	{"action":"logout","actor_id":"3414523a-4dba-4314-a3ee-c7c3674dc963","actor_username":"kariukialfred68@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 13:06:04.063761+00	
00000000-0000-0000-0000-000000000000	874ea274-485b-4233-9ddc-535c76eb3213	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 13:06:40.053902+00	
00000000-0000-0000-0000-000000000000	64dff829-376b-4df8-8409-c23841699bc2	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 13:07:36.775595+00	
00000000-0000-0000-0000-000000000000	5dcfe3d9-75c1-4b7d-aacf-e8f194bb717c	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 13:07:56.795261+00	
00000000-0000-0000-0000-000000000000	440b5b50-dca3-46f2-b228-9828a12377a1	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 13:09:25.360737+00	
00000000-0000-0000-0000-000000000000	e9eff30f-4f74-4904-b2cd-aa39a8e9341f	{"action":"login","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 13:15:38.830554+00	
00000000-0000-0000-0000-000000000000	4f4002a4-98d2-4da6-8c52-aff7389e4674	{"action":"logout","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 13:26:20.157984+00	
00000000-0000-0000-0000-000000000000	7f913c4a-915f-4119-9594-90ad2d567f91	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 13:26:43.155034+00	
00000000-0000-0000-0000-000000000000	8f94a309-f343-42c2-93aa-cb1028a5a2c0	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 13:35:05.44636+00	
00000000-0000-0000-0000-000000000000	4bd0452f-fd10-4ac2-b458-a986c1cba8e6	{"action":"login","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 13:35:27.221487+00	
00000000-0000-0000-0000-000000000000	c3591cdd-b794-46e0-b4c3-35cd3a569d6b	{"action":"logout","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 13:37:05.285319+00	
00000000-0000-0000-0000-000000000000	ee3826d8-46e5-429f-98d2-154e81f04f1e	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 13:37:28.577+00	
00000000-0000-0000-0000-000000000000	33809b3a-3164-4e2b-9d99-f20c382a7722	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 13:51:24.870564+00	
00000000-0000-0000-0000-000000000000	055dc916-a0c6-4c96-b04f-0988e17d91ec	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 13:51:47.205871+00	
00000000-0000-0000-0000-000000000000	25544f29-0911-4062-8e14-0ced96921fc0	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 13:52:13.846109+00	
00000000-0000-0000-0000-000000000000	e99e5fcc-5980-4c8e-915c-ba446c29bbd3	{"action":"login","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 13:52:30.315919+00	
00000000-0000-0000-0000-000000000000	2bb51024-411d-454a-ab54-da7127c26226	{"action":"logout","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 13:53:06.571392+00	
00000000-0000-0000-0000-000000000000	f2af9105-1f12-414d-b27e-35570044be8f	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 13:57:52.014166+00	
00000000-0000-0000-0000-000000000000	eb9822a5-1e4b-4cd5-a495-4f32953ceb31	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 14:01:35.689359+00	
00000000-0000-0000-0000-000000000000	3560fcfb-942d-44d3-9b83-c516dcced961	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 14:02:23.160229+00	
00000000-0000-0000-0000-000000000000	cba2af10-224a-4d64-ae5a-442fbd0ae3b5	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 14:04:04.155245+00	
00000000-0000-0000-0000-000000000000	df7007fc-2680-45af-b99d-e7427388487d	{"action":"login","actor_id":"3414523a-4dba-4314-a3ee-c7c3674dc963","actor_username":"kariukialfred68@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 14:04:48.773267+00	
00000000-0000-0000-0000-000000000000	a2ead9f9-19c3-46a4-a430-89e986209372	{"action":"logout","actor_id":"3414523a-4dba-4314-a3ee-c7c3674dc963","actor_username":"kariukialfred68@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 14:05:28.674042+00	
00000000-0000-0000-0000-000000000000	9e04c08e-27a8-4415-ac8a-52448d55c478	{"action":"login","actor_id":"59eff280-f6c7-4d91-9e61-c1283f1c432b","actor_username":"mshiru24@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 14:06:00.856503+00	
00000000-0000-0000-0000-000000000000	f8c47902-e76a-4794-9b1b-56bf14e23e73	{"action":"logout","actor_id":"59eff280-f6c7-4d91-9e61-c1283f1c432b","actor_username":"mshiru24@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 14:27:35.66682+00	
00000000-0000-0000-0000-000000000000	ff2c2b87-6322-456e-9303-47f59b23fb50	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 14:28:45.521901+00	
00000000-0000-0000-0000-000000000000	25935c5e-6c7a-47d2-b076-5e224c04a8b4	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-17 15:27:09.037851+00	
00000000-0000-0000-0000-000000000000	f9d5888c-ee2a-4679-a16c-9594d288afcf	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-17 15:27:09.041379+00	
00000000-0000-0000-0000-000000000000	23531784-2719-421c-bcb1-7e6f59aec6bd	{"action":"token_refreshed","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-17 21:32:13.252856+00	
00000000-0000-0000-0000-000000000000	3a32e271-505e-481e-8787-1c113e802b16	{"action":"token_revoked","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-17 21:32:13.262877+00	
00000000-0000-0000-0000-000000000000	2a6000b0-e5a3-4513-a731-1e558b1648a2	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 22:25:12.830292+00	
00000000-0000-0000-0000-000000000000	c7c21cd9-ad8c-4402-8580-26e990815553	{"action":"login","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 22:25:32.847762+00	
00000000-0000-0000-0000-000000000000	d8151e0a-c04e-4f55-a1e8-689be0754dd6	{"action":"logout","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 22:27:47.595796+00	
00000000-0000-0000-0000-000000000000	21ea0302-6c98-4e60-9cb1-b64aba689ff0	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 22:28:14.945253+00	
00000000-0000-0000-0000-000000000000	51f56ea0-dc12-4e8e-98df-21a1928f8389	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 22:29:20.886913+00	
00000000-0000-0000-0000-000000000000	1e518fe7-9472-4635-9bd9-c598f962e009	{"action":"login","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 22:29:37.857252+00	
00000000-0000-0000-0000-000000000000	8a82254d-196e-4e35-a200-1c99032db0f7	{"action":"logout","actor_id":"75b9f51d-d709-40df-9be0-276c60692342","actor_username":"buyer1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 22:57:17.921475+00	
00000000-0000-0000-0000-000000000000	f58a543d-577f-4098-9e63-0e6927b04a4f	{"action":"login","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 22:57:40.368481+00	
00000000-0000-0000-0000-000000000000	5d5a732c-a4ee-4d71-a086-195b7abca6ce	{"action":"logout","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 22:58:32.0004+00	
00000000-0000-0000-0000-000000000000	9d377d17-3be0-486c-af30-8fba6e94f695	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 23:21:45.791605+00	
00000000-0000-0000-0000-000000000000	f455d835-72df-4203-aadd-6229dd698948	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-17 23:55:36.626233+00	
00000000-0000-0000-0000-000000000000	5eb0b6b5-fc63-422f-a20f-bfbb9c262b53	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 23:55:59.881707+00	
00000000-0000-0000-0000-000000000000	87a6dec6-ca39-4743-ba4f-4ec8c0e5515e	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-18 00:20:29.758942+00	
00000000-0000-0000-0000-000000000000	c7fc2ff0-13e8-4d48-82ca-e994f684e492	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-18 00:21:17.251314+00	
00000000-0000-0000-0000-000000000000	b9dc3fed-3190-4326-8a55-e4420d229ec1	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-18 00:21:23.545874+00	
00000000-0000-0000-0000-000000000000	afb8a624-4731-4e71-8a09-bee88724af6b	{"action":"login","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-18 00:21:39.542598+00	
00000000-0000-0000-0000-000000000000	119f7988-4ad8-4fad-ba13-02c2ba0c4877	{"action":"logout","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-18 00:22:10.853711+00	
00000000-0000-0000-0000-000000000000	a87d4824-8ebe-418a-b6a7-3d4e352c7e51	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-18 00:22:34.244887+00	
00000000-0000-0000-0000-000000000000	450470b9-990e-457f-9970-9c862fda9f63	{"action":"token_refreshed","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-06-18 06:28:22.117619+00	
00000000-0000-0000-0000-000000000000	f0b4cef0-5d1f-4ff2-9adc-f035029c3d87	{"action":"token_revoked","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-06-18 06:28:22.128047+00	
00000000-0000-0000-0000-000000000000	e92a4a66-0845-4922-b569-de10d0f4c560	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-18 06:28:30.183007+00	
00000000-0000-0000-0000-000000000000	34799314-16ae-4d20-aeb5-57625b51452d	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-18 06:28:56.280866+00	
00000000-0000-0000-0000-000000000000	c36d063f-3013-43f7-b992-2646560dc5f3	{"action":"token_refreshed","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-18 08:55:11.633197+00	
00000000-0000-0000-0000-000000000000	6487ad3b-98d7-4259-851e-9a7736e33bc4	{"action":"token_revoked","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-18 08:55:11.643627+00	
00000000-0000-0000-0000-000000000000	93249894-3826-4cbd-bb32-bb6b6acb2a1d	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-18 08:55:28.132315+00	
00000000-0000-0000-0000-000000000000	c0cdb9c4-7fff-423d-aa43-6d6c0936c5bb	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-18 08:55:54.870067+00	
00000000-0000-0000-0000-000000000000	e14e6993-6d6a-4168-8fb3-223fbdec7dab	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-18 08:59:40.695408+00	
00000000-0000-0000-0000-000000000000	5b54e2cc-59af-44e9-9430-40bd1b0a50f6	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-18 08:59:58.76985+00	
00000000-0000-0000-0000-000000000000	a6fd6bd4-4f1e-4a92-bd13-9a8aeb9a5d30	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-18 09:29:26.402091+00	
00000000-0000-0000-0000-000000000000	27f3529f-5467-4647-a4de-b7430bd4398c	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-18 09:29:50.87814+00	
00000000-0000-0000-0000-000000000000	d306b75c-1ad6-4d86-ab9a-dea783e445ac	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-18 09:46:55.404163+00	
00000000-0000-0000-0000-000000000000	b4029e78-e326-4528-8dbc-d0d5d31a65e0	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-18 09:47:12.357619+00	
00000000-0000-0000-0000-000000000000	4bd74938-253a-44d7-90cc-4717f0392490	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-18 10:00:08.820716+00	
00000000-0000-0000-0000-000000000000	2f75820e-0d0f-4679-b1b4-f403d86aa29b	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-18 10:00:45.692893+00	
00000000-0000-0000-0000-000000000000	98d71d01-d5bf-4602-b892-4eb6cd5598bb	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-18 10:06:44.446902+00	
00000000-0000-0000-0000-000000000000	3c98558a-8e59-46d4-baf9-6601f51663d0	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-18 10:07:00.226846+00	
00000000-0000-0000-0000-000000000000	030862df-be4b-468c-8bcf-1de227b73ed2	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-18 10:08:25.29289+00	
00000000-0000-0000-0000-000000000000	ceefa77b-422d-44a5-b3ba-555d75bd9839	{"action":"user_signedup","actor_id":"97670167-f7a0-4fe5-94cc-0ea9cc627c74","actor_username":"lenmwangi123@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-06-18 10:09:08.981723+00	
00000000-0000-0000-0000-000000000000	4d6544e2-3167-4340-8bce-1da9f5788cde	{"action":"login","actor_id":"97670167-f7a0-4fe5-94cc-0ea9cc627c74","actor_username":"lenmwangi123@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-18 10:09:08.993196+00	
00000000-0000-0000-0000-000000000000	47732d28-ce36-4a0e-9fc7-25ac129bc5e2	{"action":"logout","actor_id":"97670167-f7a0-4fe5-94cc-0ea9cc627c74","actor_username":"lenmwangi123@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-18 10:09:19.949309+00	
00000000-0000-0000-0000-000000000000	ecffe7de-3204-4268-8c16-b70876665b26	{"action":"login","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-18 10:09:36.092857+00	
00000000-0000-0000-0000-000000000000	8a8409d7-24ee-4ab8-97c7-ffd7fb30b8b3	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"lenmwangi123@example.com","user_id":"97670167-f7a0-4fe5-94cc-0ea9cc627c74","user_phone":""}}	2025-06-18 10:14:46.581094+00	
00000000-0000-0000-0000-000000000000	ba15d13b-14a7-4706-8cb5-19163dfb7211	{"action":"token_refreshed","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-18 11:38:17.171992+00	
00000000-0000-0000-0000-000000000000	b80107ab-e7f6-4c61-8d4f-c069c5759f1e	{"action":"token_revoked","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-18 11:38:17.17572+00	
00000000-0000-0000-0000-000000000000	bb0cd88f-f662-4976-9b46-88c3093bc8ac	{"action":"token_refreshed","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-18 12:37:12.265226+00	
00000000-0000-0000-0000-000000000000	c44d3df8-5832-458f-88ce-b684030b408c	{"action":"token_revoked","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"token"}	2025-06-18 12:37:12.269949+00	
00000000-0000-0000-0000-000000000000	d0bf94c4-c63d-4c08-9ee2-532508cb00b0	{"action":"logout","actor_id":"20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d","actor_username":"admin1@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-18 12:47:04.546048+00	
00000000-0000-0000-0000-000000000000	3d8d7776-0814-42e6-9a19-61ae306e5b6f	{"action":"login","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-18 15:07:13.874485+00	
00000000-0000-0000-0000-000000000000	117157ea-2c90-4d0d-93fb-4bc541b3722e	{"action":"logout","actor_id":"c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2","actor_username":"mkulima3@example.com","actor_via_sso":false,"log_type":"account"}	2025-06-18 15:07:27.234829+00	
00000000-0000-0000-0000-000000000000	ec83600e-4833-4755-9b8e-b9f465ba24bc	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-18 15:07:53.224576+00	
00000000-0000-0000-0000-000000000000	1e35d747-effa-46a8-bc6f-d72bb16cd61f	{"action":"logout","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-06-18 15:20:42.7692+00	
00000000-0000-0000-0000-000000000000	b9e5450a-f635-4593-b287-b09a9f9771fa	{"action":"login","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-15 18:15:19.462261+00	
00000000-0000-0000-0000-000000000000	2d80d81c-e18d-4adb-8bb6-a530cd262c34	{"action":"logout","actor_id":"e77050cf-481b-4adc-bc68-bd81d2775a8b","actor_username":"mkulima1@example.com","actor_via_sso":false,"log_type":"account"}	2025-07-15 18:22:18.135423+00	
00000000-0000-0000-0000-000000000000	7d513691-23bd-439a-a910-994632ef1854	{"action":"login","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-15 18:22:39.689572+00	
00000000-0000-0000-0000-000000000000	645ea196-da41-4e6d-9bba-9348b7d28eac	{"action":"logout","actor_id":"efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c","actor_username":"buyer2@example.com","actor_via_sso":false,"log_type":"account"}	2025-07-15 18:25:31.06074+00	
00000000-0000-0000-0000-000000000000	466748ed-fc4b-4495-970c-f72fd4322e4d	{"action":"login","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 09:10:20.271963+00	
00000000-0000-0000-0000-000000000000	4843636b-63f3-46e6-bebf-2af93781bc30	{"action":"logout","actor_id":"e839b936-ba33-4b9d-90b1-b08a74a5ea4d","actor_username":"mkulima2@example.com","actor_via_sso":false,"log_type":"account"}	2025-07-20 09:14:22.891666+00	
00000000-0000-0000-0000-000000000000	58e03480-e058-4622-8b86-e3fb19e455c9	{"action":"login","actor_id":"ad2c26db-54a7-4613-9bc0-0f349cecb7f9","actor_username":"bryankinyua4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 09:14:54.256653+00	
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
e77050cf-481b-4adc-bc68-bd81d2775a8b	e77050cf-481b-4adc-bc68-bd81d2775a8b	{"sub": "e77050cf-481b-4adc-bc68-bd81d2775a8b", "email": "mkulima1@example.com", "email_verified": false, "phone_verified": false}	email	2025-05-04 13:59:51.25753+00	2025-05-04 13:59:51.25758+00	2025-05-04 13:59:51.25758+00	5129d98f-f23e-4ed8-8ae8-e9500545a6c1
75b9f51d-d709-40df-9be0-276c60692342	75b9f51d-d709-40df-9be0-276c60692342	{"sub": "75b9f51d-d709-40df-9be0-276c60692342", "email": "buyer1@example.com", "email_verified": false, "phone_verified": false}	email	2025-05-04 14:03:13.411736+00	2025-05-04 14:03:13.411782+00	2025-05-04 14:03:13.411782+00	b1e2d2f2-3d8f-4554-ae57-5533bd070594
20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d	20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d	{"sub": "20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d", "email": "admin1@example.com", "email_verified": false, "phone_verified": false}	email	2025-05-04 14:06:28.304323+00	2025-05-04 14:06:28.304368+00	2025-05-04 14:06:28.304368+00	4a4626b0-6a4b-4ac7-8234-fcef5d7d208f
efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	{"sub": "efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c", "email": "buyer2@example.com", "email_verified": false, "phone_verified": false}	email	2025-05-09 17:36:34.012999+00	2025-05-09 17:36:34.013053+00	2025-05-09 17:36:34.013053+00	4ef2c83d-0b21-4b37-b6a3-b1da75825284
e839b936-ba33-4b9d-90b1-b08a74a5ea4d	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	{"sub": "e839b936-ba33-4b9d-90b1-b08a74a5ea4d", "email": "mkulima2@example.com", "email_verified": false, "phone_verified": false}	email	2025-05-11 13:23:05.701969+00	2025-05-11 13:23:05.702022+00	2025-05-11 13:23:05.702022+00	e65d7d58-20e0-4154-b8a2-035cefe3ad37
ad2c26db-54a7-4613-9bc0-0f349cecb7f9	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	{"sub": "ad2c26db-54a7-4613-9bc0-0f349cecb7f9", "email": "bryankinyua4@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-06-05 12:32:11.645015+00	2025-06-05 12:32:11.645073+00	2025-06-05 12:32:11.645073+00	0e050645-1eec-4337-a9a0-442e96cf30d6
c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2	c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2	{"sub": "c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2", "email": "mkulima3@example.com", "email_verified": false, "phone_verified": false}	email	2025-06-12 05:01:47.15002+00	2025-06-12 05:01:47.150076+00	2025-06-12 05:01:47.150076+00	ce4e50ec-adc1-4fe4-878d-7f2338bb11a5
59eff280-f6c7-4d91-9e61-c1283f1c432b	59eff280-f6c7-4d91-9e61-c1283f1c432b	{"sub": "59eff280-f6c7-4d91-9e61-c1283f1c432b", "email": "mshiru24@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-06-16 20:12:26.421557+00	2025-06-16 20:12:26.42162+00	2025-06-16 20:12:26.42162+00	03018a4f-dc45-4375-99cb-e1123b65998c
3414523a-4dba-4314-a3ee-c7c3674dc963	3414523a-4dba-4314-a3ee-c7c3674dc963	{"sub": "3414523a-4dba-4314-a3ee-c7c3674dc963", "email": "kariukialfred68@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-06-17 12:50:27.070693+00	2025-06-17 12:50:27.07075+00	2025-06-17 12:50:27.07075+00	2fd7e9ef-8b91-4602-8d87-7a3c4925ad65
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
9d26a733-beec-44ca-81ee-79fb059c7d2c	2025-07-20 09:14:54.260469+00	2025-07-20 09:14:54.260469+00	password	ac363fd5-178a-4337-a20d-89d97071163c
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	398	wm3jzel42mmc	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	f	2025-07-20 09:14:54.258189+00	2025-07-20 09:14:54.258189+00	\N	9d26a733-beec-44ca-81ee-79fb059c7d2c
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;
9d26a733-beec-44ca-81ee-79fb059c7d2c	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	2025-07-20 09:14:54.257397+00	2025-07-20 09:14:54.257397+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0	102.209.155.242	\N
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d	authenticated	authenticated	admin1@example.com	$2a$10$elzUslouSwlWwqzxJ8eyVeV3TAztsqcl9a8VXfzBCfx/4uLyAZSq.	2025-05-04 14:06:28.307571+00	\N		\N		\N			\N	2025-06-18 10:09:36.09494+00	{"provider": "email", "providers": ["email"]}	{"sub": "20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d", "email": "admin1@example.com", "email_verified": true, "phone_verified": false}	\N	2025-05-04 14:06:28.302032+00	2025-06-18 12:37:12.273606+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2	authenticated	authenticated	mkulima3@example.com	$2a$10$LjuQc3a5qpMDwS3R3pbqD.YvKSdQNPqMdPYTk9tL1uYmTkc9BXY1K	2025-06-12 05:01:47.163484+00	\N		\N		\N			\N	2025-06-18 15:07:13.886704+00	{"provider": "email", "providers": ["email"]}	{"sub": "c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2", "email": "mkulima3@example.com", "email_verified": true, "phone_verified": false}	\N	2025-06-12 05:01:47.134629+00	2025-06-18 15:07:13.904325+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	75b9f51d-d709-40df-9be0-276c60692342	authenticated	authenticated	buyer1@example.com	$2a$10$UbALv76RWLSonta35qcvo.CHm9VNv47YcX4p/hi6/OocyX9f8Cu.m	2025-05-04 14:03:13.416171+00	\N		\N		\N			\N	2025-06-17 22:29:37.857883+00	{"provider": "email", "providers": ["email"]}	{"sub": "75b9f51d-d709-40df-9be0-276c60692342", "email": "buyer1@example.com", "email_verified": true, "phone_verified": false}	\N	2025-05-04 14:03:13.407905+00	2025-06-17 22:29:37.86009+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	3414523a-4dba-4314-a3ee-c7c3674dc963	authenticated	authenticated	kariukialfred68@gmail.com	$2a$10$MxRhXPpvGHrTFTDAlAkK9uNhLGZ7BmjpnN1cl9j6b/Oo/j3JEBeRO	2025-06-17 12:50:27.07745+00	\N		\N		\N			\N	2025-06-17 14:04:48.773963+00	{"provider": "email", "providers": ["email"]}	{"sub": "3414523a-4dba-4314-a3ee-c7c3674dc963", "email": "kariukialfred68@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-06-17 12:50:27.04845+00	2025-06-17 14:04:48.775687+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	59eff280-f6c7-4d91-9e61-c1283f1c432b	authenticated	authenticated	mshiru24@gmail.com	$2a$10$n3YsJRFCxYUjfoE9VCiROep5v9uuFeq2e77wydhqQuaSTWqpW8ytC	2025-06-16 20:12:26.439355+00	\N		\N		\N			\N	2025-06-17 14:06:00.857265+00	{"provider": "email", "providers": ["email"]}	{"sub": "59eff280-f6c7-4d91-9e61-c1283f1c432b", "email": "mshiru24@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-06-16 20:12:26.390099+00	2025-06-17 14:06:00.85907+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	e77050cf-481b-4adc-bc68-bd81d2775a8b	authenticated	authenticated	mkulima1@example.com	$2a$10$ipM0WdYhOSwzM8uz7ZOtqe0dkQWUKxkaJwn.HnppVP0O50g9Y4If6	2025-05-04 13:59:51.26075+00	\N		\N		\N			\N	2025-07-15 18:15:19.48866+00	{"provider": "email", "providers": ["email"]}	{"sub": "e77050cf-481b-4adc-bc68-bd81d2775a8b", "email": "mkulima1@example.com", "email_verified": true, "phone_verified": false}	\N	2025-05-04 13:59:51.251713+00	2025-07-15 18:15:19.527863+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	authenticated	authenticated	buyer2@example.com	$2a$10$skrlvRy2axu0IIGCngydpuF6xvuZl4w1L7.KaNQP/Y8AakZ.5kzO2	2025-05-09 17:36:34.017771+00	\N		\N		\N			\N	2025-07-15 18:22:39.690991+00	{"provider": "email", "providers": ["email"]}	{"sub": "efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c", "email": "buyer2@example.com", "email_verified": true, "phone_verified": false}	\N	2025-05-09 17:36:34.009891+00	2025-07-15 18:22:39.694116+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	authenticated	authenticated	mkulima2@example.com	$2a$10$XrKGrBQYEqlpt0yq4l/xOO.orYyVMFNf9vQcYc8IZp3.H6sHdRxHK	2025-05-11 13:23:05.706699+00	\N		\N		\N			\N	2025-07-20 09:10:20.288553+00	{"provider": "email", "providers": ["email"]}	{"sub": "e839b936-ba33-4b9d-90b1-b08a74a5ea4d", "email": "mkulima2@example.com", "email_verified": true, "phone_verified": false}	\N	2025-05-11 13:23:05.686093+00	2025-07-20 09:10:20.303431+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	authenticated	authenticated	bryankinyua4@gmail.com	$2a$10$ilRZgjTfPjWckI2AUHXDPO.tDB7VADw3o9vhwthaNlI.8Qxyq/c6e	2025-06-05 12:32:11.648189+00	\N		\N		\N			\N	2025-07-20 09:14:54.257322+00	{"provider": "email", "providers": ["email"]}	{"sub": "ad2c26db-54a7-4613-9bc0-0f349cecb7f9", "email": "bryankinyua4@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-06-05 12:32:11.641385+00	2025-07-20 09:14:54.259924+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carts (id, buyer_id, product_id, farmer_id, quantity, price, created_at) FROM stdin;
\.


--
-- Data for Name: favorites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.favorites (id, buyer_id, product_id, farmer_id, created_at) FROM stdin;
3b3d0107-4f17-4774-828f-159e3082c61f	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	6b2de285-9f52-4372-bc95-0c6b402cec57	\N	2025-06-04 07:47:26.613554
813669dc-1634-4e1b-9996-16200e75f848	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	88d3af3e-1ff9-4428-9a4b-2fbf411dc55e	\N	2025-06-11 11:13:06.247472
8a49a883-dfa2-4330-b907-aa92e26a1d75	75b9f51d-d709-40df-9be0-276c60692342	e87d3bdf-f197-4e23-943e-797ba8876ee4	\N	2025-06-17 22:54:08.824316
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, sender_id, receiver_id, content, created_at, status, product_id) FROM stdin;
2d23d5d4-ae23-4749-98b2-ecb7877c3305	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	e77050cf-481b-4adc-bc68-bd81d2775a8b	Hello	2025-06-06 08:25:01.684946	read	88d3af3e-1ff9-4428-9a4b-2fbf411dc55e
97e24639-0896-403f-8091-f3e1cc0957dc	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	e77050cf-481b-4adc-bc68-bd81d2775a8b	Okay, in a few	2025-06-11 11:14:56.292001	read	c7b1c937-ab95-455b-937d-dc1a2d425e0d
c5e5638b-ec39-46d3-b9ad-0a91ad26db1c	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	e77050cf-481b-4adc-bc68-bd81d2775a8b	Hey	2025-06-06 08:24:44.181998	read	c7b1c937-ab95-455b-937d-dc1a2d425e0d
6abf61df-af03-4dbc-9056-cb3f3d11c676	e77050cf-481b-4adc-bc68-bd81d2775a8b	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	Hey there, how can I assist you today?	2025-06-06 09:22:40.900945	read	c7b1c937-ab95-455b-937d-dc1a2d425e0d
de165107-3313-4949-9564-4dc03decd14d	e77050cf-481b-4adc-bc68-bd81d2775a8b	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	Hey there, how can I assist you today?	2025-06-06 09:23:00.143726	read	88d3af3e-1ff9-4428-9a4b-2fbf411dc55e
a699c371-0222-4193-9020-df772a1f8c47	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	Hey, What can I do for you?	2025-05-29 17:39:24	read	71f31cab-e03a-4f1b-ab3f-b4e5fc7b86ec
266eeb80-86d2-4026-8fd0-7ed169fc93fb	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	Hey, Good afternoon too.\nHow can I help you?	2025-05-29 17:44:02	read	d9c3efbf-efaa-4be0-9c3b-f963f94a8a51
47da4fe5-eb17-495a-8438-46a1e39f139d	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	Hello there	2025-05-29 14:37:33.673098	read	71f31cab-e03a-4f1b-ab3f-b4e5fc7b86ec
bc991979-5ed3-4d02-b48d-d999c783aa1e	75b9f51d-d709-40df-9be0-276c60692342	e77050cf-481b-4adc-bc68-bd81d2775a8b	5kg	2025-06-11 11:16:47.191189	read	c7b1c937-ab95-455b-937d-dc1a2d425e0d
97adcb6f-1836-483a-8d28-d3e9d73b55f3	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	Good afternoon	2025-05-29 14:35:54.912165	read	d9c3efbf-efaa-4be0-9c3b-f963f94a8a51
e3bdf95c-8957-4d91-9b54-da6843c3fd9f	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	I need 20 liters of your milk. Can you deliver that order?	2025-06-01 17:14:20.559076	read	d9c3efbf-efaa-4be0-9c3b-f963f94a8a51
a0a5f7dd-466d-49a6-abdd-d5939ab83ed9	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	Yeah, lemme know day of deliver and your details.	2025-06-01 18:00:16.198516	read	d9c3efbf-efaa-4be0-9c3b-f963f94a8a51
ca037748-bc1c-4447-b9da-8b6e43070c3d	e77050cf-481b-4adc-bc68-bd81d2775a8b	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	Hey	2025-06-09 18:13:38.236923	read	c7b1c937-ab95-455b-937d-dc1a2d425e0d
9b8ca668-059f-4fea-9f62-8e255eeea2d5	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	e77050cf-481b-4adc-bc68-bd81d2775a8b	Hey, can you supply 30kgs of pepper?	2025-06-01 18:02:47.53134	read	6b2de285-9f52-4372-bc95-0c6b402cec57
ce5171e4-65b2-438a-bc7d-59b83faf0851	e77050cf-481b-4adc-bc68-bd81d2775a8b	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	Hey	2025-06-09 18:13:21.634981	read	88d3af3e-1ff9-4428-9a4b-2fbf411dc55e
572d02bd-f010-4b71-8637-ffa197d6c092	75b9f51d-d709-40df-9be0-276c60692342	e77050cf-481b-4adc-bc68-bd81d2775a8b	Hello, wanted to purchase some carrots	2025-05-30 14:19:41.681711	read	c7b1c937-ab95-455b-937d-dc1a2d425e0d
b144534b-f0b0-42ce-a546-9efc8809e2bb	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	Hey, how many kgs of Peas can you provide for a bulk supply?	2025-06-06 08:10:39.386904	read	31abe511-d72e-40cc-a15e-463616976a9f
e8e54311-ae95-4315-9218-c945ba86e4b4	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	e77050cf-481b-4adc-bc68-bd81d2775a8b	Thanks for reaching out, I need 2kgs of carrots	2025-06-09 18:15:29.326877	read	c7b1c937-ab95-455b-937d-dc1a2d425e0d
8843df8b-e510-4607-9ab7-a4a1ec029e04	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	Notify me as soon as possible	2025-06-06 08:15:00.068973	read	31abe511-d72e-40cc-a15e-463616976a9f
991e64ab-5cd6-46bb-b643-d855aa0c850b	e77050cf-481b-4adc-bc68-bd81d2775a8b	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	Hello	2025-06-11 11:10:01.778296	read	88d3af3e-1ff9-4428-9a4b-2fbf411dc55e
1004891e-19b6-420a-94c4-f4b5a04b20f2	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	Hello	2025-06-11 15:43:14.923088	read	d9c3efbf-efaa-4be0-9c3b-f963f94a8a51
181158ff-d642-4575-82fc-980681e1f22a	e77050cf-481b-4adc-bc68-bd81d2775a8b	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	I can deliver, Send your delivery location and confirm the payment	2025-06-11 11:10:45.204188	read	c7b1c937-ab95-455b-937d-dc1a2d425e0d
b9cdab3e-7595-440c-84e8-7260c0b8da8f	e77050cf-481b-4adc-bc68-bd81d2775a8b	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	Alright👍	2025-06-11 11:40:00.671521	read	c7b1c937-ab95-455b-937d-dc1a2d425e0d
293348e8-78b5-495d-a210-e7e221b49ea1	e77050cf-481b-4adc-bc68-bd81d2775a8b	75b9f51d-d709-40df-9be0-276c60692342	Hey, what quantity?	2025-06-11 11:12:02.815602	read	c7b1c937-ab95-455b-937d-dc1a2d425e0d
dea8f1bb-f4c4-404c-95a7-29f3fa01c0fd	e77050cf-481b-4adc-bc68-bd81d2775a8b	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	Yeah, I can deliver. Let me know once you make the payment	2025-06-11 11:11:28.0137	read	6b2de285-9f52-4372-bc95-0c6b402cec57
f583074a-cc25-4cee-ae9b-f1b332b1aeb7	e77050cf-481b-4adc-bc68-bd81d2775a8b	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	Yes, I can. Once the payment is confirmed I can the delivery. I will need your location	2025-06-11 11:38:24.403897	read	88d3af3e-1ff9-4428-9a4b-2fbf411dc55e
42c7aab2-28da-412d-9f50-b9907101c894	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	e77050cf-481b-4adc-bc68-bd81d2775a8b	okay	2025-06-11 11:18:04.906799	read	6b2de285-9f52-4372-bc95-0c6b402cec57
1320b5da-09ad-48d2-a2b4-6b285d4bb2fc	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	e77050cf-481b-4adc-bc68-bd81d2775a8b	I need 30kg of groundnuts, can you deliver that quantity?	2025-06-11 11:14:06.107628	read	88d3af3e-1ff9-4428-9a4b-2fbf411dc55e
b25d7647-3c2f-4e2c-bb88-12bacd3093df	e77050cf-481b-4adc-bc68-bd81d2775a8b	75b9f51d-d709-40df-9be0-276c60692342	Okay. Let me know once you make the payment	2025-06-11 11:40:57.319641	read	c7b1c937-ab95-455b-937d-dc1a2d425e0d
7cb831c3-06a4-44cd-acdc-4e61bb6cd964	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	Hey,25kgs	2025-06-11 11:49:06.238451	read	31abe511-d72e-40cc-a15e-463616976a9f
cec20884-863b-4dac-a2b9-2fd89e202e69	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	Hey there	2025-06-11 15:59:13.429891	read	d9c3efbf-efaa-4be0-9c3b-f963f94a8a51
638b4a65-348e-4d61-9126-8228a0a1a452	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	Hey again	2025-06-11 11:49:28.030772	read	71f31cab-e03a-4f1b-ab3f-b4e5fc7b86ec
b874c93d-d103-4067-b3b6-9d2c75d4f8c0	e77050cf-481b-4adc-bc68-bd81d2775a8b	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	👍	2025-06-11 16:34:55.605414	read	c7b1c937-ab95-455b-937d-dc1a2d425e0d
25e2d499-bb78-48b2-8fb0-2b8ffb186d3c	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	Hey	2025-06-11 11:49:55.060497	read	d9c3efbf-efaa-4be0-9c3b-f963f94a8a51
aa75de16-df51-436d-a6f9-c26d8c43c16b	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	Hey	2025-06-11 11:49:56.075706	read	d9c3efbf-efaa-4be0-9c3b-f963f94a8a51
a8129dc7-8087-4c15-81f0-81a3e4232cf0	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	Hallo	2025-06-11 16:51:32.906933	read	d9c3efbf-efaa-4be0-9c3b-f963f94a8a51
0590b73b-84e1-4bfd-9e0c-65d7ea174e13	e77050cf-481b-4adc-bc68-bd81d2775a8b	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	Payment confirmed, I need your delivery details	2025-06-11 16:32:45.66421	read	88d3af3e-1ff9-4428-9a4b-2fbf411dc55e
a1d684bd-b8bd-4eb9-b1cf-e4442c1191d9	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	Good evening	2025-06-11 15:59:47.48331	read	71f31cab-e03a-4f1b-ab3f-b4e5fc7b86ec
5a35eb30-ced6-441c-a0cd-3ca99f14e1c8	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	Need 30kgs of red onions	2025-06-11 16:00:21.808693	read	71f31cab-e03a-4f1b-ab3f-b4e5fc7b86ec
9b85a2b2-bd5e-4e44-a94c-700fabb8dcfc	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	I'll notify you shortly where I have that stock	2025-06-11 15:44:59.881228	read	31abe511-d72e-40cc-a15e-463616976a9f
07de2be0-7517-4626-ace2-176cc83290bd	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	e77050cf-481b-4adc-bc68-bd81d2775a8b	Hello	2025-06-11 15:43:52.277188	read	88d3af3e-1ff9-4428-9a4b-2fbf411dc55e
c7d8c7eb-0b8c-4a64-af09-4351125b080c	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	That okay. That can be arranged. Once you initiate payment, the rest will be on my side	2025-06-11 16:50:57.710687	read	71f31cab-e03a-4f1b-ab3f-b4e5fc7b86ec
17c63a07-59ee-47b5-94df-c62e666c0645	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	You'll also share your delivery location	2025-06-11 16:51:18.508667	read	71f31cab-e03a-4f1b-ab3f-b4e5fc7b86ec
e292e484-408d-4ccc-882f-2f0636f033e9	e77050cf-481b-4adc-bc68-bd81d2775a8b	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	Hey there, how can help you	2025-06-11 16:30:52.724833	read	88d3af3e-1ff9-4428-9a4b-2fbf411dc55e
c668b9b8-8e71-403f-a188-e7063327a5ac	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	I have the 25kgs	2025-06-11 16:49:20.54182	read	31abe511-d72e-40cc-a15e-463616976a9f
dc554d15-2e6a-4828-8af7-a3e1883c0398	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	Are we going to use the same delivery location as last time	2025-06-11 16:49:59.124073	read	31abe511-d72e-40cc-a15e-463616976a9f
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, buyer_id, farmer_id, product_id, quantity, status, created_at, billing_details) FROM stdin;
1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d	5b8c9d0e-1f2a-3b4c-5d6e-7f0a1b2c3d4e	e77050cf-481b-4adc-bc68-bd81d2775a8b	6b2de285-9f52-4372-bc95-0c6b402cec57	2	Delivered	2025-03-10 10:15:23.456789	{"email": "samuelmaina2@gmail.com", "fullName": "Samuel Maina", "location": "Nyeri", "townCity": "Karatina", "phoneNumber": "0701234567", "order_amount": 240}
2b3c4d5e-6f7a-8b9c-0d1e-2f3a4b5c6d7e	6c9d0e1f-2a3b-4c5d-6e7f-0a1b2c3d4e5f	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	31abe511-d72e-40cc-a15e-463616976a9f	10	Confirmed	2025-04-05 14:32:45.123456	{"email": "faithwanjiru2@gmail.com", "fullName": "Faith Wanjiru", "location": "Kirinyaga", "townCity": "Kerugoya", "phoneNumber": "+254701234567", "order_amount": 1500}
3c4d5e6f-7a8b-9c0d-1e2f-3a4b5c6d7e8f	7d0e1f2a-3b4c-5d6e-7f0a-1b2c3d4e5f6a	e77050cf-481b-4adc-bc68-bd81d2775a8b	999b7630-e203-4c62-b248-0f076edb930e	5	Delivered	2025-02-15 09:45:12.789012	{"email": "davidmwangi2@gmail.com", "fullName": "David Mwangi", "location": "Meru", "townCity": "Maua", "phoneNumber": "0712345678", "order_amount": 400}
4d5e6f7a-8b9c-0d1e-2f3a-4b5c6d7e8f9a	8e1f2a3b-4c5d-6e7f-0a1b-2c3d4e5f6a7b	c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2	e87d3bdf-f197-4e23-943e-797ba8876ee4	30	Pending	2025-05-20 16:23:34.345678	{"email": "charitymuthoni2@gmail.com", "fullName": "Charity Muthoni", "location": "Embu", "townCity": "Runyenjes", "phoneNumber": "+254712345678", "order_amount": 6000}
5e6f7a8b-9c0d-1e2f-3a4b-5c6d7e8f9a0b	9f2a3b4c-5d6e-7f0a-1b2c-3d4e5f6a7b8c	e77050cf-481b-4adc-bc68-bd81d2775a8b	c7b1c937-ab95-455b-937d-dc1a2d425e0d	15	Delivered	2025-01-25 11:12:56.901234	{"email": "danielkariuki2@gmail.com", "fullName": "Daniel Kariuki", "location": "Murang’a", "townCity": "Maragua", "phoneNumber": "0723456789", "order_amount": 900}
6f7a8b9c-0d1e-2f3a-4b5c-6d7e8f9a0b1c	0a3b4c5d-6e7f-0a1b-2c3d-4e5f6a7b8c9d	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	71f31cab-e03a-4f1b-ab3f-b4e5fc7b86ec	20	Confirmed	2025-06-10 13:45:23.56789	{"email": "beatricenjeri2@gmail.com", "fullName": "Beatrice Njeri", "location": "Kiambu", "townCity": "Thika", "phoneNumber": "+254723456789", "order_amount": 1000}
dd10e0a0-05bf-40b2-bcda-692bee4b7201	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	e77050cf-481b-4adc-bc68-bd81d2775a8b	6b2de285-9f52-4372-bc95-0c6b402cec57	1	Delivered	2025-06-03 08:03:27.402725	{"email": "buyer2@example.com", "fullName": "Buyer Two", "location": "Nairobi", "townCity": "ggg", "phoneNumber": "+254704186096"}
7a8b9c0d-1e2f-3a4b-5c6d-7e8f9a0b1c2d	1b4c5d6e-7f0a-1b2c-3d4e-5f6a7b8c9d0e	e77050cf-481b-4adc-bc68-bd81d2775a8b	88d3af3e-1ff9-4428-9a4b-2fbf411dc55e	8	Cancelled	2025-03-05 08:56:12.234567	{"email": "victorkinyua2@gmail.com", "fullName": "Victor Kinyua", "location": "Tharaka-Nithi", "townCity": "Chuka", "phoneNumber": "0734567890", "order_amount": 200}
8b9c0d1e-2f3a-4b5c-6d7e-8f9a0b1c2d3e	2c5d6e7f-0a1b-2c3d-4e5f-6a7b8c9d0e1f	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	d9c3efbf-efaa-4be0-9c3b-f963f94a8a51	3	Delivered	2025-04-15 15:34:45.890123	{"email": "priscillawangari2@gmail.com", "fullName": "Priscilla Wangari", "location": "Nyeri", "townCity": "Othaya", "phoneNumber": "+254734567890", "order_amount": 45}
9c0d1e2f-3a4b-5c6d-7e8f-9a0b1c2d3e4f	3d6e7f0a-1b2c-3d4e-5f6a-7b8c9d0e1f2a	e77050cf-481b-4adc-bc68-bd81d2775a8b	6b2de285-9f52-4372-bc95-0c6b402cec57	1	Delivered	2025-02-20 10:23:56.456789	{"email": "thomasmuturi2@gmail.com", "fullName": "Thomas Muturi", "location": "Kirinyaga", "townCity": "Kutus", "phoneNumber": "0745678901", "order_amount": 120}
0d1e2f3a-4b5c-6d7e-8f9a-0b1c2d3e4f5a	4e7f0a1b-2c3d-4e5f-6a7b-8c9d0e1f2a3b	c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2	e87d3bdf-f197-4e23-943e-797ba8876ee4	25	Confirmed	2025-05-30 12:12:34.123456	{"email": "rebeccanjoroge2@gmail.com", "fullName": "Rebecca Njoroge", "location": "Meru", "townCity": "Nkubu", "phoneNumber": "+254745678901", "order_amount": 5000}
1e2f3a4b-5c6d-7e8f-9a0b-1c2d3e4f5a6b	5f0a1b2c-3d4e-5f6a-7b8c-9d0e1f2a3b4c	e77050cf-481b-4adc-bc68-bd81d2775a8b	999b7630-e203-4c62-b248-0f076edb930e	4	Delivered	2025-01-15 09:45:23.789012	{"email": "andrewmugendi2@gmail.com", "fullName": "Andrew Mugendi", "location": "Embu", "townCity": "Kiritiri", "phoneNumber": "0756789012", "order_amount": 320}
ff8dc5ad-f531-409b-bdee-d4e3902a5fb4	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	e77050cf-481b-4adc-bc68-bd81d2775a8b	6b2de285-9f52-4372-bc95-0c6b402cec57	1	Delivered	2025-06-12 05:11:05.925628	{"email": "buyer2@example.com", "fullName": "Buyer Two", "location": "Nairobi", "townCity": "G-city", "phoneNumber": "+254704186096"}
2f3a4b5c-6d7e-8f9a-0b1c-2d3e4f5a6b7c	6a1b2c3d-4e5f-6a7b-8c9d-0e1f2a3b4c5d	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	71f31cab-e03a-4f1b-ab3f-b4e5fc7b86ec	18	Pending	2025-06-05 14:56:12.345678	{"email": "catherinewanjiku2@gmail.com", "fullName": "Catherine Wanjiku", "location": "Murang’a", "townCity": "Kandara", "phoneNumber": "+254756789012", "order_amount": 900}
3a4b5c6d-7e8f-9a0b-1c2d-3e4f5a6b7c8d	7b2c3d4e-5f6a-7b8c-9d0e-1f2a3b4c5d6e	e77050cf-481b-4adc-bc68-bd81d2775a8b	c7b1c937-ab95-455b-937d-dc1a2d425e0d	12	Delivered	2025-03-25 11:34:45.901234	{"email": "edwardmuthomi2@gmail.com", "fullName": "Edward Muthomi", "location": "Kiambu", "townCity": "Ruiru", "phoneNumber": "0767890123", "order_amount": 720}
4b5c6d7e-8f9a-0b1c-2d3e-4f5a6b7c8d9e	8c3d4e5f-6a7b-8c9d-0e1f-2a3b4c5d6e7f	e77050cf-481b-4adc-bc68-bd81d2775a8b	88d3af3e-1ff9-4428-9a4b-2fbf411dc55e	5	Cancelled	2025-04-20 16:23:56.56789	{"email": "margaretwambui2@gmail.com", "fullName": "Margaret-Anne Wambui", "location": "Tharaka-Nithi", "townCity": "Kathwana", "phoneNumber": "+254767890123", "order_amount": 125}
5c6d7e8f-9a0b-1c2d-3e4f-5a6b7c8d9e0a	9d4e5f6a-7b8c-9d0e-1f2a-3b4c5d6e7f0a	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	d9c3efbf-efaa-4be0-9c3b-f963f94a8a51	2	Delivered	2025-02-10 08:45:34.234567	{"email": "godfreymaina2@gmail.com", "fullName": "Godfrey Maina", "location": "Nyeri", "townCity": "Mukurweini", "phoneNumber": "0778901234", "order_amount": 30}
6d7e8f9a-0b1c-2d3e-4f5a-6b7c8d9e0a1b	0e5f6a7b-8c9d-0e1f-2a3b-4c5d6e7f0a1b	c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2	e87d3bdf-f197-4e23-943e-797ba8876ee4	40	Confirmed	2025-05-15 13:12:23.890123	{"email": "janetmwihaki2@gmail.com", "fullName": "Janet Mwihaki", "location": "Kirinyaga", "townCity": "Sagana", "phoneNumber": "+254778901234", "order_amount": 8000}
7e8f9a0b-1c2d-3e4f-5a6b-7c8d9e0a1b2c	1f6a7b8c-9d0e-1f2a-3b4c-5d6e7f0a1b2c	e77050cf-481b-4adc-bc68-bd81d2775a8b	6b2de285-9f52-4372-bc95-0c6b402cec57	3	Delivered	2025-01-30 10:56:12.456789	{"email": "anthonymureithi2@gmail.com", "fullName": "Anthony Mureithi", "location": "Meru", "townCity": "Timau", "phoneNumber": "0789012345", "order_amount": 360}
8f9a0b1c-2d3e-4f5a-6b7c-8d9e0a1b2c3d	2a7b8c9d-0e1f-2a3b-4c5d-6e7f0a1b2c3d	e77050cf-481b-4adc-bc68-bd81d2775a8b	999b7630-e203-4c62-b248-0f076edb930e	6	Pending	2025-06-12 15:34:45.123456	{"email": "christinenjoki2@gmail.com", "fullName": "Christine Njoki", "location": "Embu", "townCity": "Siakago", "phoneNumber": "+254789012345", "order_amount": 480}
9a0b1c2d-3e4f-5a6b-7c8d-9e0a1b2c3d4e	3b8c9d0e-1f2a-3b4c-5d6e-7f0a1b2c3d4e	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	71f31cab-e03a-4f1b-ab3f-b4e5fc7b86ec	25	Delivered	2025-03-15 09:23:56.789012	{"email": "philipngugi2@gmail.com", "fullName": "Philip Ngugi", "location": "Murang’a", "townCity": "Kangema", "phoneNumber": "0701234567", "order_amount": 1250}
0b1c2d3e-4f5a-6b7c-8d9e-0a1b2c3d4e5f	4c9d0e1f-2a3b-4c5d-6e7f-0a1b2c3d4e5f	e77050cf-481b-4adc-bc68-bd81d2775a8b	c7b1c937-ab95-455b-937d-dc1a2d425e0d	10	Confirmed	2025-04-25 12:45:34.345678	{"email": "elizabethwairimu2@gmail.com", "fullName": "Elizabeth Wairimu", "location": "Kiambu", "townCity": "Githunguri", "phoneNumber": "+254701234567", "order_amount": 600}
1c2d3e4f-5a6b-7c8d-9e0a-1b2c3d4e5f6a	5d0e1f2a-3b4c-5d6e-7f0a-1b2c3d4e5f6a	e77050cf-481b-4adc-bc68-bd81d2775a8b	88d3af3e-1ff9-4428-9a4b-2fbf411dc55e	7	Delivered	2025-02-25 11:12:23.901234	{"email": "wilsonkamau2@gmail.com", "fullName": "Wilson Kamau", "location": "Tharaka-Nithi", "townCity": "Marimanti", "phoneNumber": "0712345678", "order_amount": 175}
2d3e4f5a-6b7c-8d9e-0a1b-2c3d4e5f6a7b	6e1f2a3b-4c5d-6e7f-0a1b-2c3d4e5f6a7b	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	d9c3efbf-efaa-4be0-9c3b-f963f94a8a51	4	Cancelled	2025-05-25 14:56:12.56789	{"email": "esthermwende2@gmail.com", "fullName": "Esther Mwende", "location": "Nyeri", "townCity": "Naro Moru", "phoneNumber": "+254712345678", "order_amount": 60}
2fc5d952-0d9c-41e1-b029-1fe17f34f4b3	75b9f51d-d709-40df-9be0-276c60692342	e77050cf-481b-4adc-bc68-bd81d2775a8b	999b7630-e203-4c62-b248-0f076edb930e	4	Delivered	2025-05-29 20:32:20.797734	{"email": "buyer1@example.com", "fullName": "Buyer One ", "location": "Kiambu", "townCity": "Kiambu town", "phoneNumber": "+254111207438"}
79e42214-696c-429f-8528-bedbe11a0a0d	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	e77050cf-481b-4adc-bc68-bd81d2775a8b	999b7630-e203-4c62-b248-0f076edb930e	1	Cancelled	2025-06-11 23:03:05.997526	{"email": "buyer2@example.com", "fullName": "Buyer Two", "location": "Nairobi", "townCity": "jjj", "phoneNumber": "+254704186096"}
0a69e2ba-1afe-4879-a6c2-65becb46433b	75b9f51d-d709-40df-9be0-276c60692342	e77050cf-481b-4adc-bc68-bd81d2775a8b	6b2de285-9f52-4372-bc95-0c6b402cec57	1	Delivered	2025-06-02 09:42:27.994656	{"email": "buyer1@example.com", "fullName": "Buyer One", "location": "Nairobi", "townCity": "hjh", "phoneNumber": "+254704186096"}
3e4f5a6b-7c8d-9e0a-1b2c-3e4f5a6b7b8c	7f2a3b4c-5d6e-7f0a-1b2c-3d4e5f6a7b8c	c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2	e87d3bdf-f197-4e23-943e-797ba8876ee4	35	Confirmed	2025-01-20 08:45:34.234567	{"email": "stephengitonga2@gmail.com", "fullName": "Stephen Gitonga", "location": "Kirinyaga", "townCity": "Mwea", "phoneNumber": "0723456789", "order_amount": 7000}
4f5a6b7c-8d9e-0a1b-2c3d-4e5f6a7b8c9d	8a3b4c5d-6e7f-0a1b-2c3d-4e5f6a7b8c9d	e77050cf-481b-4adc-bc68-bd81d2775a8b	6b2de285-9f52-4372-bc95-0c6b402cec57	1	Delivered	2025-06-15 10:23:56.890123	{"email": "lucymuthiga2@gmail.com", "fullName": "Lucy Muthiga", "location": "Meru", "townCity": "Githongo", "phoneNumber": "+254723456789", "order_amount": 120}
5a6b7c8d-9e0a-1b2c-3d4e-5f6a7b8c9d0e	9b4c5d6e-7f0a-1b2c-3d4e-5f6a7b8c9d0e	e77050cf-481b-4adc-bc68-bd81d2775a8b	999b7630-e203-4c62-b248-0f076edb930e	3	Delivered	2025-03-30 13:12:45.456789	{"email": "markkirimi2@gmail.com", "fullName": "Mark Kirimi", "location": "Embu", "townCity": "Mbeere", "phoneNumber": "0734567890", "order_amount": 240}
6b7c8d9e-0a1b-2c3d-4e5f-6a7b8c9d0e1f	5b8c9d0e-1f2a-3b4c-5d6e-7f0a1b2c3d4e	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	31abe511-d72e-40cc-a15e-463616976a9f	12	Confirmed	2025-04-10 15:34:23.123456	{"email": "samuelmaina2@gmail.com", "fullName": "Samuel Maina", "location": "Nyeri", "townCity": "Karatina", "phoneNumber": "0701234567", "order_amount": 1800}
7c8d9e0a-1b2c-3d4e-5f6a-7b8c9d0e1f2a	6c9d0e1f-2a3b-4c5d-6e7f-0a1b2c3d4e5f	e77050cf-481b-4adc-bc68-bd81d2775a8b	c7b1c937-ab95-455b-937d-dc1a2d425e0d	8	Delivered	2025-02-15 09:45:12.789012	{"email": "faithwanjiru2@gmail.com", "fullName": "Faith Wanjiru", "location": "Kirinyaga", "townCity": "Kerugoya", "phoneNumber": "+254701234567", "order_amount": 480}
8d9e0a1b-2c3d-4e5f-6a7b-8c9d0e1f2a3b	7d0e1f2a-3b4c-5d6e-7f0a-1b2c3d4e5f6a	e77050cf-481b-4adc-bc68-bd81d2775a8b	88d3af3e-1ff9-4428-9a4b-2fbf411dc55e	6	Pending	2025-05-10 11:23:56.345678	{"email": "davidmwangi2@gmail.com", "fullName": "David Mwangi", "location": "Meru", "townCity": "Maua", "phoneNumber": "0712345678", "order_amount": 150}
9e0a1b2c-3d4e-5f6a-7b8c-9d0e1f2a3b4c	8e1f2a3b-4c5d-6e7f-0a1b-2c3d4e5f6a7b	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	d9c3efbf-efaa-4be0-9c3b-f963f94a8a51	2	Delivered	2025-01-25 14:56:34.901234	{"email": "charitymuthoni2@gmail.com", "fullName": "Charity Muthoni", "location": "Embu", "townCity": "Runyenjes", "phoneNumber": "+254712345678", "order_amount": 30}
0a1b2c3d-4e5f-6a7b-8c9d-0e1f2a3b4c5d	9f2a3b4c-5d6e-7f0a-1b2c-3d4e5f6a7b8c	c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2	e87d3bdf-f197-4e23-943e-797ba8876ee4	20	Confirmed	2025-06-08 08:45:23.56789	{"email": "danielkariuki2@gmail.com", "fullName": "Daniel Kariuki", "location": "Murang’a", "townCity": "Maragua", "phoneNumber": "0723456789", "order_amount": 4000}
1b2c3d4e-5f6a-7b8c-9d0e-1f2a3b4c5d6e	0a3b4c5d-6e7f-0a1b-2c3d-4e5f6a7b8c9d	e77050cf-481b-4adc-bc68-bd81d2775a8b	6b2de285-9f52-4372-bc95-0c6b402cec57	1	Delivered	2025-03-20 10:12:45.234567	{"email": "beatricenjeri2@gmail.com", "fullName": "Beatrice Njeri", "location": "Kiambu", "townCity": "Thika", "phoneNumber": "+254723456789", "order_amount": 120}
2c3d4e5f-6a7b-8c9d-0e1f-2a3b4c5d6e7f	1b4c5d6e-7f0a-1b2c-3d4e-5f6a7b8c9d0e	e77050cf-481b-4adc-bc68-bd81d2775a8b	999b7630-e203-4c62-b248-0f076edb930e	4	Delivered	2025-04-30 13:34:56.890123	{"email": "victorkinyua2@gmail.com", "fullName": "Victor Kinyua", "location": "Tharaka-Nithi", "townCity": "Chuka", "phoneNumber": "0734567890", "order_amount": 320}
3d4e5f6a-7b8c-9d0e-1f2a-3b4c5d6e7f0a	2c5d6e7f-0a1b-2c3d-4e5f-6a7b8c9d0e1f	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	71f31cab-e03a-4f1b-ab3f-b4e5fc7b86ec	15	Confirmed	2025-02-28 15:23:12.456789	{"email": "priscillawangari2@gmail.com", "fullName": "Priscilla Wangari", "location": "Nyeri", "townCity": "Othaya", "phoneNumber": "+254734567890", "order_amount": 750}
4e5f6a7b-8c9d-0e1f-2a3b-4c5d6e7f0a1b	3d6e7f0a-1b2c-3d4e-5f6a-7b8c9d0e1f2a	e77050cf-481b-4adc-bc68-bd81d2775a8b	c7b1c937-ab95-455b-937d-dc1a2d425e0d	10	Delivered	2025-05-12 09:45:34.123456	{"email": "thomasmuturi2@gmail.com", "fullName": "Thomas Muturi", "location": "Kirinyaga", "townCity": "Kutus", "phoneNumber": "0745678901", "order_amount": 600}
5f6a7b8c-9d0e-1f2a-3b4c-5d6e7f0a1b2c	4e7f0a1b-2c3d-4e5f-6a7b-8c9d0e1f2a3b	e77050cf-481b-4adc-bc68-bd81d2775a8b	88d3af3e-1ff9-4428-9a4b-2fbf411dc55e	5	Cancelled	2025-01-18 11:56:23.789012	{"email": "rebeccanjoroge2@gmail.com", "fullName": "Rebecca Njoroge", "location": "Meru", "townCity": "Nkubu", "phoneNumber": "+254745678901", "order_amount": 125}
6a7b8c9d-0e1f-2a3b-4c5d-6e7f0a1b2c3d	5f0a1b2c-3d4e-5f6a-7b8c-9d0e1f2a3b4c	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	d9c3efbf-efaa-4be0-9c3b-f963f94a8a51	3	Delivered	2025-06-03 14:12:45.345678	{"email": "andrewmugendi2@gmail.com", "fullName": "Andrew Mugendi", "location": "Embu", "townCity": "Kiritiri", "phoneNumber": "0756789012", "order_amount": 45}
7b8c9d0e-1f2a-3b4c-5d6e-7f0a1b2c3d4e	6a1b2c3d-4e5f-6a7b-8c9d-0e1f2a3b4c5d	c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2	e87d3bdf-f197-4e23-943e-797ba8876ee4	28	Confirmed	2025-03-08 10:34:56.901234	{"email": "catherinewanjiku2@gmail.com", "fullName": "Catherine Wanjiku", "location": "Murang’a", "townCity": "Kandara", "phoneNumber": "+254756789012", "order_amount": 5600}
8c9d0e1f-2a3b-4c5d-6e7f-0a1b2c3d4e5f	7b2c3d4e-5f6a-7b8c-9d0e-1f2a3b4c5d6e	e77050cf-481b-4adc-bc68-bd81d2775a8b	6b2de285-9f52-4372-bc95-0c6b402cec57	2	Delivered	2025-04-18 13:23:12.56789	{"email": "edwardmuthomi2@gmail.com", "fullName": "Edward Muthomi", "location": "Kiambu", "townCity": "Ruiru", "phoneNumber": "0767890123", "order_amount": 240}
9d0e1f2a-3b4c-5d6e-7f0a-1b2c3d4e5f6a	8c3d4e5f-6a7b-8c9d-0e1f-2a3b4c5d6e7f	e77050cf-481b-4adc-bc68-bd81d2775a8b	999b7630-e203-4c62-b248-0f076edb930e	5	Pending	2025-02-20 15:45:34.234567	{"email": "margaretwambui2@gmail.com", "fullName": "Margaret-Anne Wambui", "location": "Tharaka-Nithi", "townCity": "Kathwana", "phoneNumber": "+254767890123", "order_amount": 400}
0e1f2a3b-4c5d-6e7f-0a1b-2c3d4e5f6a7b	9d4e5f6a-7b8c-9d0e-1f2a-3b4c5d6e7f0a	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	31abe511-d72e-40cc-a15e-463616976a9f	8	Delivered	2025-05-28 09:12:56.890123	{"email": "godfreymaina2@gmail.com", "fullName": "Godfrey Maina", "location": "Nyeri", "townCity": "Mukurweini", "phoneNumber": "0778901234", "order_amount": 1200}
1f2a3b4c-5d6e-7f0a-1b2c-3d4e5f6a7b8c	0e5f6a7b-8c9d-0e1f-2a3b-4c5d6e7f0a1b	e77050cf-481b-4adc-bc68-bd81d2775a8b	c7b1c937-ab95-455b-937d-dc1a2d425e0d	12	Confirmed	2025-01-30 11:34:23.456789	{"email": "janetmwihaki2@gmail.com", "fullName": "Janet Mwihaki", "location": "Kirinyaga", "townCity": "Sagana", "phoneNumber": "+254778901234", "order_amount": 720}
2a3b4c5d-6e7f-0a1b-2c3d-4e5f6a7b8c9d	1f6a7b8c-9d0e-1f2a-3b4c-5d6e7f0a1b2c	e77050cf-481b-4adc-bc68-bd81d2775a8b	88d3af3e-1ff9-4428-9a4b-2fbf411dc55e	6	Delivered	2025-06-10 14:56:12.123456	{"email": "anthonymureithi2@gmail.com", "fullName": "Anthony Mureithi", "location": "Meru", "townCity": "Timau", "phoneNumber": "0789012345", "order_amount": 150}
3b4c5d6e-7f0a-1b2c-3d4e-5f6a7b8c9d0e	2a7b8c9d-0e1f-2a3b-4c5d-6e7f0a1b2c3d	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	d9c3efbf-efaa-4be0-9c3b-f963f94a8a51	3	Cancelled	2025-03-25 10:45:34.789012	{"email": "christinenjoki2@gmail.com", "fullName": "Christine Njoki", "location": "Embu", "townCity": "Siakago", "phoneNumber": "+254789012345", "order_amount": 45}
4c5d6e7f-0a1b-2c3d-4e5f-6a7b8c9d0e1f	3b8c9d0e-1f2a-3b4c-5d6e-7f0a1b2c3d4e	c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2	e87d3bdf-f197-4e23-943e-797ba8876ee4	22	Confirmed	2025-04-15 13:12:56.345678	{"email": "philipngugi2@gmail.com", "fullName": "Philip Ngugi", "location": "Murang’a", "townCity": "Kangema", "phoneNumber": "0701234567", "order_amount": 4400}
5d6e7f0a-1b2c-3d4e-5f6a-7b8c9d0e1f2a	4c9d0e1f-2a3b-4c5d-6e7f-0a1b2c3d4e5f	e77050cf-481b-4adc-bc68-bd81d2775a8b	6b2de285-9f52-4372-bc95-0c6b402cec57	1	Delivered	2025-02-10 15:34:23.901234	{"email": "elizabethwairimu2@gmail.com", "fullName": "Elizabeth Wairimu", "location": "Kiambu", "townCity": "Githunguri", "phoneNumber": "+254701234567", "order_amount": 120}
f5cbdfcd-8b1d-4d19-b7af-d7635dad4865	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	e77050cf-481b-4adc-bc68-bd81d2775a8b	88d3af3e-1ff9-4428-9a4b-2fbf411dc55e	13	Pending	2025-06-18 15:15:52.503329	{"email": "bryankinyua4@gmail.com", "fullName": "Bryan Kinyua", "location": "Rongai", "townCity": "Maasai Lodge", "phoneNumber": "+254722171281", "order_amount": 325}
99e065ae-6d15-4880-a856-bc7fff5aedf1	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	e77050cf-481b-4adc-bc68-bd81d2775a8b	6b2de285-9f52-4372-bc95-0c6b402cec57	1	Pending	2025-06-18 15:15:52.503329	{"email": "bryankinyua4@gmail.com", "fullName": "Bryan Kinyua", "location": "Rongai", "townCity": "Maasai Lodge", "phoneNumber": "+254722171281", "order_amount": 1}
0327bde3-d9cc-4f5a-bce7-e7d4eee56ffd	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	e77050cf-481b-4adc-bc68-bd81d2775a8b	88d3af3e-1ff9-4428-9a4b-2fbf411dc55e	1	Confirmed	2025-06-17 23:56:49.930048	{"email": "bryankinyua4@gmail.com", "fullName": "Bryan Kinyua", "location": "Rongai", "townCity": "Maasai Lodge", "phoneNumber": "+254704186096", "order_amount": 25}
baf5fbe7-d748-4ddf-8570-a9ac7e44d29a	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	d9c3efbf-efaa-4be0-9c3b-f963f94a8a51	1	Confirmed	2025-06-18 00:02:01.923246	{"email": "bryankinyua4@gmail.com", "fullName": "Bryan Kinyua", "location": "Rongai", "townCity": "MS", "phoneNumber": "+254704186096", "order_amount": 80}
2efc7bc4-965f-4a6a-a166-54c7d02b885f	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	e77050cf-481b-4adc-bc68-bd81d2775a8b	c7b1c937-ab95-455b-937d-dc1a2d425e0d	4	Confirmed	2025-06-18 00:03:27.267223	{"email": "bryankinyua4@gmail.com", "fullName": "Bryan Kinyua", "location": "Rongai", "townCity": "ML", "phoneNumber": "+254704186096", "order_amount": 72}
2245b7fa-eb5b-4429-a8ee-3c3d48b7914b	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	71f31cab-e03a-4f1b-ab3f-b4e5fc7b86ec	1	Pending	2025-06-18 00:04:59.589644	{"email": "bryankinyua4@gmail.com", "fullName": "Bryan Kinyua", "location": "Rongai", "townCity": "MS", "phoneNumber": "+254704186096", "order_amount": 14}
e59d3f53-afe6-4825-9bea-6eb587f3af2c	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	71f31cab-e03a-4f1b-ab3f-b4e5fc7b86ec	1	Cancelled	2025-06-18 00:05:12.636697	{"email": "bryankinyua4@gmail.com", "fullName": "Bryan Kinyua", "location": "Rongai", "townCity": "MS", "phoneNumber": "+254704186096", "order_amount": 14}
bb866da2-6721-45cc-9dc5-93222faaa9ba	ad2c26db-54a7-4613-9bc0-0f349cecb7f9	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	31abe511-d72e-40cc-a15e-463616976a9f	4	Pending	2025-06-18 00:08:49.724279	{"email": "bryankinyua4@gmail.com", "fullName": "Bryan Kinyua", "location": "Rongai", "townCity": "MS", "phoneNumber": "+254704186096", "order_amount": 520}
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, farmer_id, name, description, price, category, created_at, images, stock, status) FROM stdin;
31abe511-d72e-40cc-a15e-463616976a9f	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	Peas	Fully grown peas	130	Cereals & Grains	2025-05-11 13:57:50.673268	["https://nctitrjdmpxpbkntmbcd.supabase.co/storage/v1/object/public/product-images/e839b936-ba33-4b9d-90b1-b08a74a5ea4d/5e3e5218-533b-4937-8057-f6c11dee6050_Screenshot%202025-05-11%20165710.png"]	259	active
88d3af3e-1ff9-4428-9a4b-2fbf411dc55e	e77050cf-481b-4adc-bc68-bd81d2775a8b	Ground nuts	Farm-Fresh Quality – Directly sourced from sustainable farms ✅ Rich in Nutrients – A powerhouse of protein and healthy fats ✅ Multiple Uses – Ideal for roasting, grinding, or adding to recipes ✅ Secure Packaging – Ensuring freshness and long shelf life	25	Cereals & Grains	2025-05-30 18:34:30.193403	["https://nctitrjdmpxpbkntmbcd.supabase.co/storage/v1/object/public/product-images/e77050cf-481b-4adc-bc68-bd81d2775a8b/6c522e2e-0fcf-4f02-ae5a-da9000dee5dc_Screenshot%202025-05-30%20212936.png"]	30	active
e87d3bdf-f197-4e23-943e-797ba8876ee4	c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2	Eggs	Fresh Farm Eggs – Natural Goodness in Every Bite Discover the rich taste and superior quality of our fresh farm eggs sourced directly from trusted poultry farmers. With a firm yolk and smooth texture, these eggs are packed with essential nutrients, ensuring a wholesome addition to your daily meals. Perfect for breakfast, baking, and cooking, our eggs deliver farm-fresh goodness straight to your kitchen.	12	Poultry Eggs	2025-06-12 05:05:53.070902	["https://nctitrjdmpxpbkntmbcd.supabase.co/storage/v1/object/public/product-images/c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2/f173e336-737f-410f-8357-beff2f4a34ba_Screenshot%202025-06-12%20080325.png"]	170	active
999b7630-e203-4c62-b248-0f076edb930e	e77050cf-481b-4adc-bc68-bd81d2775a8b	Milk	Dairy fresh milk available daily	44	Dairy	2025-05-11 11:42:31.876191	["https://nctitrjdmpxpbkntmbcd.supabase.co/storage/v1/object/public/product-images/e77050cf-481b-4adc-bc68-bd81d2775a8b/373951f4-688c-437f-af4c-e42f4f828a6d_Screenshot%202025-03-30%20134332.png"]	24	active
6b2de285-9f52-4372-bc95-0c6b402cec57	e77050cf-481b-4adc-bc68-bd81d2775a8b	Red Pepper	Fresh, Hot and Spicy peppers	1	Vegetables	2025-05-30 17:13:24.472359	["https://nctitrjdmpxpbkntmbcd.supabase.co/storage/v1/object/public/product-images/e77050cf-481b-4adc-bc68-bd81d2775a8b/14142bd4-7929-4cfa-9f02-654f6e19c55a_Screenshot%202025-05-30%20193514.png"]	56	active
c7b1c937-ab95-455b-937d-dc1a2d425e0d	e77050cf-481b-4adc-bc68-bd81d2775a8b	Carrots	Fresh and juicy Carrots from the farm	18	Vegetables	2025-05-11 13:00:55.010306	["https://nctitrjdmpxpbkntmbcd.supabase.co/storage/v1/object/public/product-images/e77050cf-481b-4adc-bc68-bd81d2775a8b/2fed5f7f-7631-4ac3-a8c1-5627aa99dd8e_Screenshot%202025-03-24%20234031.png"]	263	active
d9c3efbf-efaa-4be0-9c3b-f963f94a8a51	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	Goat Milk	Highly nutritious goat milk available	80	Dairy	2025-05-11 14:16:14.378394	["https://nctitrjdmpxpbkntmbcd.supabase.co/storage/v1/object/public/product-images/e839b936-ba33-4b9d-90b1-b08a74a5ea4d/7c977bc6-df6f-450d-b9e4-76a8b42519d8_Screenshot%202025-03-28%20205641.png"]	12	active
71f31cab-e03a-4f1b-ab3f-b4e5fc7b86ec	e839b936-ba33-4b9d-90b1-b08a74a5ea4d	Onions	Large red and white onions 	14	Vegetables	2025-05-11 13:24:21.600538	["https://nctitrjdmpxpbkntmbcd.supabase.co/storage/v1/object/public/product-images/e839b936-ba33-4b9d-90b1-b08a74a5ea4d/57464c8d-f544-4600-9207-e44121480b36_Screenshot%202025-04-10%20005749.png"]	350	active
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (id, product_id, buyer_id, rating, comment, created_at) FROM stdin;
8f6809e9-c4d8-4977-962f-5c3e59acb79e	d9c3efbf-efaa-4be0-9c3b-f963f94a8a51	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	5	Good Quality	2025-06-02 10:18:02.094432
eadc44b7-d51e-4eaf-b775-3ba2ddd6daec	71f31cab-e03a-4f1b-ab3f-b4e5fc7b86ec	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	5	Affordable and worth every shilling! You get high-quality onions at a great price. I'll definitely be ordering again.	2025-06-02 10:21:48.501072
6448b98d-da33-4d00-ab37-b2165f0d494d	6b2de285-9f52-4372-bc95-0c6b402cec57	75b9f51d-d709-40df-9be0-276c60692342	5	⭐⭐⭐⭐⭐ Spicy and Fresh – Perfect for Any Dish! I recently purchased these red peppers from Mkulima One, and I must say, they exceeded my expectations. They were incredibly fresh, vibrant in color, and packed just the right amount of heat. Whether you’re adding them to a stew, making salsa, or using them for seasoning, they bring out a rich and bold flavor. I also appreciate the easy ordering process and the safety tips provided for the transaction. Definitely recommend these peppers to anyone who loves a good kick in their meals!	2025-06-02 12:50:47.715275
f12ada7c-f461-4506-9a86-d49b33765cbc	6b2de285-9f52-4372-bc95-0c6b402cec57	efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	5	⭐⭐⭐⭐⭐ Fresh, Spicy, and Full of Flavor! I recently bought these red peppers from Mkulima One, and they were absolutely fantastic! They arrived fresh, vibrant in color, and packed with just the right amount of heat to add a delicious kick to any dish. Whether you're making salsa, seasoning a stew, or just spicing up your meal, these peppers deliver bold, rich flavor. The ordering process was seamless, and I appreciate the safety tips provided for transactions. I highly recommend these to anyone who loves high-quality produce!	2025-06-03 08:08:47.565497
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, role, name, location, created_at, phone_number) FROM stdin;
0c1a2b3c-4d5e-6f7a-8b9c-0d1e2f3a4b5c	johnmuriuki1@gmail.com	Farmer	John Muriuki	Nyeri	2025-03-15 09:12:34.123456	+254712345678
1d2e3f4a-5b6c-7d8e-9f0a-1b2c3d4e5f6a	gracewanjiru1@gmail.com	Farmer	Grace Wanjiru	Kirinyaga	2025-04-22 14:45:56.789012	0712345678
2e3f4a5b-6c7d-8e9f-0a1b-2c3d4e5f6a7b	petermwangi1@gmail.com	Farmer	Peter Mwangi	Meru	2025-01-10 11:23:45.345678	+254723456789
3f4a5b6c-7d8e-9f0a-1b2c-3d4e5f6a7b8c	annemuthoni1@gmail.com	Farmer	Anne Muthoni	Embu	2025-05-30 16:34:12.901234	0734567890
4a5b6c7d-8e9f-0a1b-2c3d-4e5f6a7b8c9d	jameskariuki1@gmail.com	Farmer	James Kariuki	Murang’a	2025-02-18 08:56:23.56789	+254734567890
5b6c7d8e-9f0a-1b2c-3d4e-5f6a7b8c9d0e	marynjeri1@gmail.com	Farmer	Mary Njeri	Kiambu	2025-06-05 13:12:45.234567	0745678901
6c7d8e9f-0a1b-2c3d-4e5f-6a7b8c9d0e1f	josephkinyua1@gmail.com	Farmer	Joseph Kinyua	Tharaka-Nithi	2025-03-25 10:45:34.890123	+254745678901
7d8e9f0a-1b2c-3d4e-5f6a-7b8c9d0e1f2a	estherwangari1@gmail.com	Farmer	Esther Wangari	Nyeri	2025-04-12 15:23:56.456789	0756789012
8e9f0a1b-2c3d-4e5f-6a7b-8c9d0e1f2a3b	georgemuturi1@gmail.com	Farmer	George Muturi	Kirinyaga	2025-01-30 09:34:12.123456	+254756789012
9f0a1b2c-3d4e-5f6a-7b8c-9d0e1f2a3b4c	janenjoroge1@gmail.com	Farmer	Jane Njoroge	Meru	2025-05-15 17:56:23.789012	0767890123
0a1b2c3d-4e5f-6a7b-8c9d-0e1f2a3b4c5d	stephenmugendi1@gmail.com	Farmer	Stephen Mugendi	Embu	2025-02-28 12:12:45.345678	+254767890123
1b2c3d4e-5f6a-7b8c-9d0e-1f2a3b4c5d6e	lucywanjiku1@gmail.com	Farmer	Lucy Wanjiku	Murang’a	2025-06-10 14:45:34.901234	0778901234
2c3d4e5f-6a7b-8c9d-0e1f-2a3b4c5d6e7f	paulmuthomi1@gmail.com	Farmer	Paul Muthomi	Kiambu	2025-03-05 11:23:56.56789	+254778901234
3d4e5f6a-7b8c-9d0e-1f2a-3b4c5d6e7f0a	carolinewambui1@gmail.com	Farmer	Caroline Wambui	Tharaka-Nithi	2025-04-20 16:34:12.234567	0789012345
4e5f6a7b-8c9d-0e1f-2a3b-4c5d6e7f0a1b	benjaminmaina1@gmail.com	Farmer	Benjamin Maina	Nyeri	2025-01-15 08:56:23.890123	+254789012345
5f6a7b8c-9d0e-1f2a-3b4c-5d6e7f0a1b2c	florencemwihaki1@gmail.com	Farmer	Florence Mwihaki	Kirinyaga	2025-05-25 13:12:45.456789	0790123456
20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d	admin1@example.com	Admin	Admin One	Nairobi	2025-05-04 14:06:28.583401	+254704186096
75b9f51d-d709-40df-9be0-276c60692342	buyer1@example.com	Buyer	Buyer One	Nairobi	2025-05-04 14:03:13.647162	+254704186096
e77050cf-481b-4adc-bc68-bd81d2775a8b	mkulima1@example.com	Farmer	Mkulima One	Kiambu	2025-05-04 13:59:51.556272	+254704186096
e839b936-ba33-4b9d-90b1-b08a74a5ea4d	mkulima2@example.com	Farmer	Mkulima Two	Kajiado	2025-05-11 13:23:05.994999	+254704186096
efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c	buyer2@example.com	Buyer	Buyer Two	Nairobi	2025-05-09 17:36:34.550875	+254704186096
6a7b8c9d-0e1f-2a3b-4c5d-6e7f0a1b2c3d	isaacmureithi1@gmail.com	Farmer	Isaac Mureithi	Meru	2025-02-10 10:45:34.123456	+254790123456
7b8c9d0e-1f2a-3b4c-5d6e-7f0a1b2c3d4e	mercynjoki1@gmail.com	Farmer	Mercy Njoki	Embu	2025-06-15 15:23:56.789012	0701234567
8c9d0e1f-2a3b-4c5d-6e7f-0a1b2c3d4e5f	edwinngugi1@gmail.com	Farmer	Edwin Ngugi	Murang’a	2025-03-30 09:34:12.345678	+254701234567
9d0e1f2a-3b4c-5d6e-7f0a-1b2c3d4e5f6a	veronicawairimu1@gmail.com	Farmer	Veronica Wairimu	Kiambu	2025-04-05 17:56:23.901234	0712345678
0e1f2a3b-4c5d-6e7f-0a1b-2c3d4e5f6a7b	henrykamau1@gmail.com	Farmer	Henry Kamau	Tharaka-Nithi	2025-01-20 12:12:45.56789	+254712345678
1f2a3b4c-5d6e-7f0a-1b2c-3d4e5f6a7b8c	lydiamwende1@gmail.com	Farmer	Lydia Mwende	Nyeri	2025-05-20 14:45:34.234567	0723456789
ad2c26db-54a7-4613-9bc0-0f349cecb7f9	bryankinyua4@gmail.com	Buyer	Bryan Kinyua	Rongai	2025-06-05 12:32:11.873162	+254704186096
c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2	mkulima3@example.com	Farmer	Mkulima Three	G-city	2025-06-12 05:01:47.88819	+254704186096
59eff280-f6c7-4d91-9e61-c1283f1c432b	Mshiru24@gmail.com	Buyer	Mary Wanjiru	Ruiru	2025-06-16 20:12:27.053064	+254725647891
3414523a-4dba-4314-a3ee-c7c3674dc963	Kariukialfred68@gmail.com	Buyer	Alfred Kariuki	Nyeri 	2025-06-17 12:50:27.373609	0704186096
2a3b4c5d-6e7f-0a1b-2c3d-4e5f6a7b8c9d	michaelgitonga1@gmail.com	Farmer	Michael Gitonga	Kirinyaga	2025-02-15 11:23:56.890123	+254723456789
3b4c5d6e-7f0a-1b2c-3d4e-5f6a7b8c9d0e	susanmuthiga1@gmail.com	Farmer	Susan Muthiga	Meru	2025-06-12 16:34:12.456789	0734567890
4c5d6e7f-0a1b-2c3d-4e5f-6a7b8c9d0e1f	denniskirimi1@gmail.com	Farmer	Dennis Kirimi	Embu	2025-03-10 08:56:23.123456	+254734567890
5d6e7f0a-1b2c-3d4e-5f6a-7b8c9d0e1f2a	juliamwangangi1@gmail.com	Farmer	Julia Mwangangi	Murang’a	2025-04-25 13:12:45.789012	0745678901
6e7f0a1b-2c3d-4e5f-6a7b-8c9d0e1f2a3b	patricknjue1@gmail.com	Farmer	Patrick Njue	Kiambu	2025-01-25 10:45:34.345678	+254745678901
7f0a1b2c-3d4e-5f6a-7b8c-9d0e1f2a3b4c	agneswangeci1@gmail.com	Farmer	Agnes Wangeci	Tharaka-Nithi	2025-05-10 15:23:56.901234	0756789012
8a1b2c3d-4e5f-6a7b-8c9d-0e1f2a3b4c5d	simonmuriithi1@gmail.com	Farmer	Simon Muriithi	Nyeri	2025-02-20 09:34:12.56789	+254756789012
9b2c3d4e-5f6a-7b8c-9d0e-1f2a3b4c5d6e	eunicewaithera1@gmail.com	Farmer	Eunice Waithera	Kirinyaga	2025-06-08 17:56:23.234567	0767890123
0c3d4e5f-6a7b-8c9d-0e1f-2a3b4c5d6e7f	jacksonmugambi1@gmail.com	Farmer	Jackson Mugambi	Meru	2025-03-20 12:12:45.890123	+254767890123
1d4e5f6a-7b8c-9d0e-1f2a-3b4c5d6e7f0a	rosemarynyambura1@gmail.com	Farmer	Rosemary Nyambura	Embu	2025-04-15 14:45:34.456789	0778901234
2e5f6a7b-8c9d-0e1f-2a3b-4c5d6e7f0a1b	lawrencemwiti1@gmail.com	Farmer	Lawrence Mwiti	Murang’a	2025-01-12 11:23:56.123456	+254778901234
3f6a7b8c-9d0e-1f2a-3b4c-5d6e7f0a1b2c	monicahwairimu1@gmail.com	Farmer	Monica Wairimu	Kiambu	2025-05-28 16:34:12.789012	0789012345
4a7b8c9d-0e1f-2a3b-4c5d-6e7f0a1b2c3d	emmanuelmutembei1@gmail.com	Farmer	Emmanuel Mutembei	Tharaka-Nithi	2025-02-25 08:56:23.345678	+254789012345
5b8c9d0e-1f2a-3b4c-5d6e-7f0a1b2c3d4e	samuelmaina2@gmail.com	Buyer	Samuel Maina	Nyeri	2025-03-22 13:12:45.901234	0701234567
6c9d0e1f-2a3b-4c5d-6e7f-0a1b2c3d4e5f	faithwanjiru2@gmail.com	Buyer	Faith Wanjiru	Kirinyaga	2025-04-18 10:45:34.56789	+254701234567
7d0e1f2a-3b4c-5d6e-7f0a-1b2c3d4e5f6a	davidmwangi2@gmail.com	Buyer	David Mwangi	Meru	2025-01-28 15:23:56.234567	0712345678
8e1f2a3b-4c5d-6e7f-0a1b-2c3d4e5f6a7b	charitymuthoni2@gmail.com	Buyer	Charity Muthoni	Embu	2025-06-03 09:34:12.890123	+254712345678
9f2a3b4c-5d6e-7f0a-1b2c-3d4e5f6a7b8c	danielkariuki2@gmail.com	Buyer	Daniel Kariuki	Murang’a	2025-02-12 17:56:23.456789	0723456789
0a3b4c5d-6e7f-0a1b-2c3d-4e5f6a7b8c9d	beatricenjeri2@gmail.com	Buyer	Beatrice Njeri	Kiambu	2025-05-18 12:12:45.123456	+254723456789
1b4c5d6e-7f0a-1b2c-3d4e-5f6a7b8c9d0e	victorkinyua2@gmail.com	Buyer	Victor Kinyua	Tharaka-Nithi	2025-03-08 14:45:34.789012	0734567890
2c5d6e7f-0a1b-2c3d-4e5f-6a7b8c9d0e1f	priscillawangari2@gmail.com	Buyer	Priscilla Wangari	Nyeri	2025-04-30 11:23:56.345678	+254734567890
3d6e7f0a-1b2c-3d4e-5f6a-7b8c9d0e1f2a	thomasmuturi2@gmail.com	Buyer	Thomas CLUSTERED INDEX	Nyeri	2025-01-18 16:34:12.901234	0745678901
4e7f0a1b-2c3d-4e5f-6a7b-8c9d0e1f2a3b	rebeccanjoroge2@gmail.com	Buyer	Rebecca Njoroge	Meru	2025-06-14 08:56:23.56789	+254745678901
5f0a1b2c-3d4e-5f6a-7b8c-9d0e1f2a3b4c	andrewmugendi2@gmail.com	Buyer	Andrew Mugendi	Embu	2025-02-22 13:12:45.234567	0756789012
6a1b2c3d-4e5f-6a7b-8c9d-0e1f2a3b4c5d	catherinewanjiku2@gmail.com	Buyer	Catherine Wanjiku	Murang’a	2025-05-05 10:45:34.890123	+254756789012
7b2c3d4e-5f6a-7b8c-9d0e-1f2a3b4c5d6e	edwardmuthomi2@gmail.com	Buyer	Edward Muthomi	Kiambu	2025-03-15 15:23:56.456789	0767890123
8c3d4e5f-6a7b-8c9d-0e1f-2a3b4c5d6e7f	margaretwambui2@gmail.com	Buyer	Margaret-Anne Wambui	Tharaka-Nithi	2025-04-10 09:34:12.123456	+254767890123
9d4e5f6a-7b8c-9d0e-1f2a-3b4c5d6e7f0a	godfreymaina2@gmail.com	Buyer	Godfrey Maina	Nyeri	2025-01-23 17:56:23.789012	0778901234
0e5f6a7b-8c9d-0e1f-2a3b-4c5d6e7f0a1b	janetmwihaki2@gmail.com	Buyer	Janet Mwihaki	Kirinyaga	2025-06-07 12:12:45.345678	+254778901234
1f6a7b8c-9d0e-1f2a-3b4c-5d6e7f0a1b2c	anthonymureithi2@gmail.com	Buyer	Anthony Mureithi	Meru	2025-02-17 14:45:34.901234	0789012345
2a7b8c9d-0e1f-2a3b-4c5d-6e7f0a1b2c3d	christinenjoki2@gmail.com	Buyer	Christine Njoki	Embu	2025-05-12 11:23:56.56789	+254789012345
3b8c9d0e-1f2a-3b4c-5d6e-7f0a1b2c3d4e	philipngugi2@gmail.com	Buyer	Philip Ngugi	Murang’a	2025-03-28 16:34:12.234567	0701234567
4c9d0e1f-2a3b-4c5d-6e7f-0a1b2c3d4e5f	elizabethwairimu2@gmail.com	Buyer	Elizabeth Wairimu	Kiambu	2025-04-02 08:56:23.890123	+254701234567
5d0e1f2a-3b4c-5d6e-7f0a-1b2c3d4e5f6a	wilsonkamau2@gmail.com	Buyer	Wilson Kamau	Tharaka-Nithi	2025-01-31 13:12:45.456789	0712345678
6e1f2a3b-4c5d-6e7f-0a1b-2c3d4e5f6a7b	esthermwende2@gmail.com	Buyer	Esther Mwende	Nyeri	2025-06-16 10:45:34.123456	+254712345678
7f2a3b4c-5d6e-7f0a-1b2c-3d4e5f6a7b8c	stephengitonga2@gmail.com	Buyer	Stephen Gitonga	Kirinyaga	2025-02-27 15:23:56.789012	0723456789
8a3b4c5d-6e7f-0a1b-2c3d-4e5f6a7b8c9d	lucymuthiga2@gmail.com	Buyer	Lucy Muthiga	Meru	2025-05-22 09:34:12.345678	+254723456789
9b4c5d6e-7f0a-1b2c-3d4e-5f6a7b8c9d0e	markkirimi2@gmail.com	Buyer	Mark Kirimi	Embu	2025-03-17 17:56:23.901234	0734567890
\.


--
-- Data for Name: messages_2025_07_17; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_17 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_07_18; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_18 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_07_19; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_19 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_07_20; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_20 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_07_21; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_21 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_07_22; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_22 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_07_23; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_23 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-05-03 22:05:37
20211116045059	2025-05-03 22:05:40
20211116050929	2025-05-03 22:05:41
20211116051442	2025-05-03 22:05:43
20211116212300	2025-05-03 22:05:45
20211116213355	2025-05-03 22:05:46
20211116213934	2025-05-03 22:05:48
20211116214523	2025-05-03 22:05:50
20211122062447	2025-05-03 22:05:52
20211124070109	2025-05-03 22:05:53
20211202204204	2025-05-03 22:05:55
20211202204605	2025-05-03 22:05:57
20211210212804	2025-05-03 22:06:02
20211228014915	2025-05-03 22:06:03
20220107221237	2025-05-03 22:06:05
20220228202821	2025-05-03 22:06:07
20220312004840	2025-05-03 22:06:08
20220603231003	2025-05-03 22:06:11
20220603232444	2025-05-03 22:06:12
20220615214548	2025-05-03 22:06:14
20220712093339	2025-05-03 22:06:16
20220908172859	2025-05-03 22:06:17
20220916233421	2025-05-03 22:06:19
20230119133233	2025-05-03 22:06:21
20230128025114	2025-05-03 22:06:23
20230128025212	2025-05-03 22:06:24
20230227211149	2025-05-03 22:06:26
20230228184745	2025-05-03 22:06:28
20230308225145	2025-05-03 22:06:29
20230328144023	2025-05-03 22:06:31
20231018144023	2025-05-03 22:06:33
20231204144023	2025-05-03 22:06:35
20231204144024	2025-05-03 22:06:37
20231204144025	2025-05-03 22:06:38
20240108234812	2025-05-03 22:06:40
20240109165339	2025-05-03 22:06:42
20240227174441	2025-05-03 22:06:45
20240311171622	2025-05-03 22:06:47
20240321100241	2025-05-03 22:06:50
20240401105812	2025-05-03 22:06:55
20240418121054	2025-05-03 22:06:57
20240523004032	2025-05-03 22:07:03
20240618124746	2025-05-03 22:07:04
20240801235015	2025-05-03 22:07:06
20240805133720	2025-05-03 22:07:08
20240827160934	2025-05-03 22:07:09
20240919163303	2025-05-03 22:07:11
20240919163305	2025-05-03 22:07:13
20241019105805	2025-05-03 22:07:15
20241030150047	2025-05-03 22:07:21
20241108114728	2025-05-03 22:07:23
20241121104152	2025-05-03 22:07:24
20241130184212	2025-05-03 22:07:26
20241220035512	2025-05-03 22:07:28
20241220123912	2025-05-03 22:07:30
20241224161212	2025-05-03 22:07:31
20250107150512	2025-05-03 22:07:33
20250110162412	2025-05-03 22:07:34
20250123174212	2025-05-03 22:07:36
20250128220012	2025-05-03 22:07:38
20250506224012	2025-05-22 13:03:52
20250523164012	2025-05-28 09:51:29
20250714121412	2025-07-20 09:10:25
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) FROM stdin;
product-images	product-images	\N	2025-05-09 18:28:33.126492+00	2025-05-09 18:28:33.126492+00	t	f	\N	\N	\N
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-05-03 22:05:35.793146
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-05-03 22:05:35.796719
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-05-03 22:05:35.799517
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-05-03 22:05:35.822324
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-05-03 22:05:35.8461
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-05-03 22:05:35.849162
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-05-03 22:05:35.852632
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-05-03 22:05:35.856369
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-05-03 22:05:35.859531
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-05-03 22:05:35.864637
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-05-03 22:05:35.868876
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-05-03 22:05:35.872685
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-05-03 22:05:35.879271
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-05-03 22:05:35.882494
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-05-03 22:05:35.886212
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-05-03 22:05:35.918107
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-05-03 22:05:35.923837
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-05-03 22:05:35.927307
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-05-03 22:05:35.932508
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-05-03 22:05:35.938326
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-05-03 22:05:35.941634
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-05-03 22:05:35.950473
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-05-03 22:05:35.975922
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-05-03 22:05:36.000677
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-05-03 22:05:36.004197
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-05-03 22:05:36.007448
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
aa1abbc8-cabc-4e94-af6a-1d28823a03da	product-images	e77050cf-481b-4adc-bc68-bd81d2775a8b/c12cc494-053a-4ec2-adcc-f12329c37ddd_Screenshot 2025-03-14 001827.png	\N	2025-05-09 19:50:39.548957+00	2025-05-09 19:50:39.548957+00	2025-05-09 19:50:39.548957+00	{"eTag": "\\"39623b088e8f4d7de9ae31d3642cd905\\"", "size": 624245, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-09T19:50:40.000Z", "contentLength": 624245, "httpStatusCode": 200}	f33908c6-7a7f-4b3b-9fb3-09133701116c	\N	{}
20c56e5e-f7fd-4c70-b64b-d05aca247b5d	product-images	e77050cf-481b-4adc-bc68-bd81d2775a8b/6e550a1e-e1ba-4dd7-b196-b41d182978b1_Screenshot 2025-03-30 134332.png	\N	2025-05-11 11:42:31.647169+00	2025-05-11 11:42:31.647169+00	2025-05-11 11:42:31.647169+00	{"eTag": "\\"ebcecb1394ace40c5a2b63d8876bf263\\"", "size": 294250, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-11T11:42:32.000Z", "contentLength": 294250, "httpStatusCode": 200}	17033a54-c988-4d35-87f3-d75fcb2b1765	\N	{}
132373c6-82ba-4fea-a40e-e5bf6046fd43	product-images	e77050cf-481b-4adc-bc68-bd81d2775a8b/3ffe86d3-92d1-4dd0-a0ce-68461c9b1b0e_Screenshot 2025-03-28 205641.png	\N	2025-05-11 12:28:35.06738+00	2025-05-11 12:28:35.06738+00	2025-05-11 12:28:35.06738+00	{"eTag": "\\"0f874246f2c0ea098179247f710954d8\\"", "size": 311657, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-11T12:28:35.000Z", "contentLength": 311657, "httpStatusCode": 200}	ef4ff71f-b264-45a7-a041-f0dcd0545df7	\N	{}
95875cb5-f59d-4cd7-a348-580807f821c5	product-images	e77050cf-481b-4adc-bc68-bd81d2775a8b/2125a06a-631f-4438-ac60-b86e06e5c3fe_Screenshot 2025-03-24 234031.png	\N	2025-05-11 13:00:54.799059+00	2025-05-11 13:00:54.799059+00	2025-05-11 13:00:54.799059+00	{"eTag": "\\"6c84ca9db90424a779e6de7e5ea7035f\\"", "size": 770011, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-11T13:00:55.000Z", "contentLength": 770011, "httpStatusCode": 200}	2494c632-11e8-4b18-af7d-65f2c40f8898	\N	{}
902fe163-f0cb-449d-940d-457a6a25a1b3	product-images	e77050cf-481b-4adc-bc68-bd81d2775a8b/ed51b353-fe3c-4e6b-bf79-0ccd8cfe6dd5_Screenshot 2025-03-14 001827.png	\N	2025-05-11 13:05:15.924891+00	2025-05-11 13:05:15.924891+00	2025-05-11 13:05:15.924891+00	{"eTag": "\\"39623b088e8f4d7de9ae31d3642cd905\\"", "size": 624245, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-11T13:05:16.000Z", "contentLength": 624245, "httpStatusCode": 200}	6e1eea31-a746-41d6-b7f7-6a9511ca1bcd	\N	{}
b5073e46-4b1e-45b4-a835-2065b7009844	product-images	e77050cf-481b-4adc-bc68-bd81d2775a8b/2fed5f7f-7631-4ac3-a8c1-5627aa99dd8e_Screenshot 2025-03-24 234031.png	\N	2025-05-11 13:20:36.725209+00	2025-05-11 13:20:36.725209+00	2025-05-11 13:20:36.725209+00	{"eTag": "\\"6c84ca9db90424a779e6de7e5ea7035f\\"", "size": 770011, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-11T13:20:37.000Z", "contentLength": 770011, "httpStatusCode": 200}	e52dfc18-796f-41c6-819d-cd2968cd651e	\N	{}
bac58103-16b1-4e16-9243-f032a0a969c9	product-images	e77050cf-481b-4adc-bc68-bd81d2775a8b/373951f4-688c-437f-af4c-e42f4f828a6d_Screenshot 2025-03-30 134332.png	\N	2025-05-11 13:21:51.755637+00	2025-05-11 13:21:51.755637+00	2025-05-11 13:21:51.755637+00	{"eTag": "\\"ebcecb1394ace40c5a2b63d8876bf263\\"", "size": 294250, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-11T13:21:52.000Z", "contentLength": 294250, "httpStatusCode": 200}	a35bd7b3-5a4f-439d-b6e9-aa2f33f1e152	\N	{}
f1a02043-3c06-46af-9330-6e261b24c2cf	product-images	e839b936-ba33-4b9d-90b1-b08a74a5ea4d/57464c8d-f544-4600-9207-e44121480b36_Screenshot 2025-04-10 005749.png	\N	2025-05-11 13:24:21.368598+00	2025-05-11 13:24:21.368598+00	2025-05-11 13:24:21.368598+00	{"eTag": "\\"2c480bc11532e7cbfced977bbfde2ee3\\"", "size": 703068, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-11T13:24:22.000Z", "contentLength": 703068, "httpStatusCode": 200}	44d1afb7-deae-4591-9e5a-5109d8f08d65	\N	{}
02c9825f-a0e8-416a-91e6-ec2c903c1eeb	product-images	e839b936-ba33-4b9d-90b1-b08a74a5ea4d/5e3e5218-533b-4937-8057-f6c11dee6050_Screenshot 2025-05-11 165710.png	\N	2025-05-11 13:57:50.426852+00	2025-05-11 13:57:50.426852+00	2025-05-11 13:57:50.426852+00	{"eTag": "\\"d4ca8af607bcca779fa12c2c453fec90\\"", "size": 526321, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-11T13:57:51.000Z", "contentLength": 526321, "httpStatusCode": 200}	62339d22-a444-4ce9-bd78-43ed3b3174c8	\N	{}
fc5a9dd9-dda8-41ad-8f98-e1187509c1c8	product-images	e839b936-ba33-4b9d-90b1-b08a74a5ea4d/7c977bc6-df6f-450d-b9e4-76a8b42519d8_Screenshot 2025-03-28 205641.png	\N	2025-05-11 14:16:14.138822+00	2025-05-11 14:16:14.138822+00	2025-05-11 14:16:14.138822+00	{"eTag": "\\"0f874246f2c0ea098179247f710954d8\\"", "size": 311657, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-11T14:16:14.000Z", "contentLength": 311657, "httpStatusCode": 200}	6f2f7354-d200-4644-8884-55cacde86b95	\N	{}
f276646e-54e8-4378-8184-15972d086e6c	product-images	e77050cf-481b-4adc-bc68-bd81d2775a8b/6f607ea8-560d-40ef-bd84-f8d48b133d3f_Screenshot 2025-05-30 193514.png	\N	2025-05-30 17:13:24.190909+00	2025-05-30 17:13:24.190909+00	2025-05-30 17:13:24.190909+00	{"eTag": "\\"d41d8cd98f00b204e9800998ecf8427e\\"", "size": 0, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-30T17:13:25.000Z", "contentLength": 0, "httpStatusCode": 200}	1315ba42-378b-4fd9-82f8-8257848adbb0	\N	{}
eb416344-2bcb-4af0-9e88-332164bf66bd	product-images	e77050cf-481b-4adc-bc68-bd81d2775a8b/14142bd4-7929-4cfa-9f02-654f6e19c55a_Screenshot 2025-05-30 193514.png	\N	2025-05-30 18:27:06.806574+00	2025-05-30 18:27:06.806574+00	2025-05-30 18:27:06.806574+00	{"eTag": "\\"8303bafe70a4627ea7f530c9e82d26d7\\"", "size": 706782, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-30T18:27:07.000Z", "contentLength": 706782, "httpStatusCode": 200}	fbf207c4-5f25-4b61-9bd2-22b3c073b3d9	\N	{}
4ce81ca4-ad7a-4ce2-8224-7ec05bd262b9	product-images	e77050cf-481b-4adc-bc68-bd81d2775a8b/6c522e2e-0fcf-4f02-ae5a-da9000dee5dc_Screenshot 2025-05-30 212936.png	\N	2025-05-30 18:34:29.989699+00	2025-05-30 18:34:29.989699+00	2025-05-30 18:34:29.989699+00	{"eTag": "\\"91d732652feaa644f6c314cae36b8edf\\"", "size": 459712, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-30T18:34:30.000Z", "contentLength": 459712, "httpStatusCode": 200}	b24d1be3-a07c-48a3-ab71-646bf6a61201	\N	{}
0f780be4-7e31-46a3-8186-70e1e6320f91	product-images	c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2/f173e336-737f-410f-8357-beff2f4a34ba_Screenshot 2025-06-12 080325.png	\N	2025-06-12 05:05:52.764819+00	2025-06-12 05:05:52.764819+00	2025-06-12 05:05:52.764819+00	{"eTag": "\\"9e6e8ac835c08ed509203830e4ddd53b\\"", "size": 144786, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-06-12T05:05:53.000Z", "contentLength": 144786, "httpStatusCode": 200}	10b20da7-077d-4727-8e51-7d95cda2f5d4	\N	{}
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 398, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 8829, true);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: carts carts_buyer_id_product_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_buyer_id_product_id_key UNIQUE (buyer_id, product_id);


--
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: favorites favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_07_17 messages_2025_07_17_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_17
    ADD CONSTRAINT messages_2025_07_17_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_07_18 messages_2025_07_18_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_18
    ADD CONSTRAINT messages_2025_07_18_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_07_19 messages_2025_07_19_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_19
    ADD CONSTRAINT messages_2025_07_19_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_07_20 messages_2025_07_20_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_20
    ADD CONSTRAINT messages_2025_07_20_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_07_21 messages_2025_07_21_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_21
    ADD CONSTRAINT messages_2025_07_21_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_07_22 messages_2025_07_22_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_22
    ADD CONSTRAINT messages_2025_07_22_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_07_23 messages_2025_07_23_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_23
    ADD CONSTRAINT messages_2025_07_23_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: idx_messages_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_messages_product_id ON public.messages USING btree (product_id);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: messages_2025_07_17_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_17_pkey;


--
-- Name: messages_2025_07_18_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_18_pkey;


--
-- Name: messages_2025_07_19_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_19_pkey;


--
-- Name: messages_2025_07_20_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_20_pkey;


--
-- Name: messages_2025_07_21_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_21_pkey;


--
-- Name: messages_2025_07_22_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_22_pkey;


--
-- Name: messages_2025_07_23_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_23_pkey;


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: carts carts_buyer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_buyer_id_fkey FOREIGN KEY (buyer_id) REFERENCES public.users(id);


--
-- Name: carts carts_farmer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_farmer_id_fkey FOREIGN KEY (farmer_id) REFERENCES public.users(id);


--
-- Name: carts carts_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: favorites favorites_buyer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_buyer_id_fkey FOREIGN KEY (buyer_id) REFERENCES public.users(id);


--
-- Name: favorites favorites_farmer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_farmer_id_fkey FOREIGN KEY (farmer_id) REFERENCES public.users(id);


--
-- Name: favorites favorites_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: messages messages_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: messages messages_receiver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_receiver_id_fkey FOREIGN KEY (receiver_id) REFERENCES public.users(id);


--
-- Name: messages messages_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(id);


--
-- Name: orders orders_buyer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_buyer_id_fkey FOREIGN KEY (buyer_id) REFERENCES public.users(id);


--
-- Name: orders orders_farmer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_farmer_id_fkey FOREIGN KEY (farmer_id) REFERENCES public.users(id);


--
-- Name: orders orders_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: products products_farmer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_farmer_id_fkey FOREIGN KEY (farmer_id) REFERENCES public.users(id);


--
-- Name: reviews reviews_buyer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_buyer_id_fkey FOREIGN KEY (buyer_id) REFERENCES public.users(id);


--
-- Name: reviews reviews_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: orders Admins and service role can update orders; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins and service role can update orders" ON public.orders FOR UPDATE TO authenticated, service_role USING ((EXISTS ( SELECT 1
   FROM public.users
  WHERE ((users.id = auth.uid()) AND (users.role = 'Admin'::text))))) WITH CHECK (true);


--
-- Name: products Admins can delete products; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can delete products" ON public.products FOR DELETE TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.users
  WHERE ((users.id = auth.uid()) AND (users.role = 'Admin'::text)))));


--
-- Name: users Admins can delete users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can delete users" ON public.users FOR DELETE TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.users users_1
  WHERE ((users_1.id = auth.uid()) AND (users_1.role = 'Admin'::text)))));


--
-- Name: products Farmers manage own products; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Farmers manage own products" ON public.products TO authenticated USING ((farmer_id = auth.uid())) WITH CHECK ((farmer_id = auth.uid()));


--
-- Name: orders Farmers view own orders; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Farmers view own orders" ON public.orders FOR SELECT TO authenticated USING ((farmer_id = auth.uid()));


--
-- Name: carts admin_manage_cart; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY admin_manage_cart ON public.carts USING ((EXISTS ( SELECT 1
   FROM public.users
  WHERE ((users.id = auth.uid()) AND (users.role = 'Admin'::text)))));


--
-- Name: messages admin_manage_messages; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY admin_manage_messages ON public.messages USING ((EXISTS ( SELECT 1
   FROM public.users
  WHERE ((users.id = auth.uid()) AND (users.role = 'Admin'::text)))));


--
-- Name: products admin_manage_products; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY admin_manage_products ON public.products USING (true);


--
-- Name: reviews admin_manage_reviews; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY admin_manage_reviews ON public.reviews USING ((EXISTS ( SELECT 1
   FROM public.users
  WHERE ((users.id = auth.uid()) AND (users.role = 'Admin'::text)))));


--
-- Name: orders admin_view_orders; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY admin_view_orders ON public.orders FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.users
  WHERE ((users.id = auth.uid()) AND (users.role = 'Admin'::text)))));


--
-- Name: users admin_view_users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY admin_view_users ON public.users FOR SELECT USING (true);


--
-- Name: orders buyer_create_orders; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY buyer_create_orders ON public.orders FOR INSERT WITH CHECK ((buyer_id = auth.uid()));


--
-- Name: carts buyer_manage_cart; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY buyer_manage_cart ON public.carts USING ((buyer_id = auth.uid())) WITH CHECK ((buyer_id = auth.uid()));


--
-- Name: favorites buyer_manage_favorites; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY buyer_manage_favorites ON public.favorites USING ((buyer_id = auth.uid())) WITH CHECK ((buyer_id = auth.uid()));


--
-- Name: reviews buyer_manage_own_reviews; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY buyer_manage_own_reviews ON public.reviews USING ((buyer_id = auth.uid())) WITH CHECK ((buyer_id = auth.uid()));


--
-- Name: orders buyer_view_own_orders; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY buyer_view_own_orders ON public.orders FOR SELECT USING ((buyer_id = auth.uid()));


--
-- Name: carts; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.carts ENABLE ROW LEVEL SECURITY;

--
-- Name: orders farmer_update_orders; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY farmer_update_orders ON public.orders FOR UPDATE USING ((farmer_id = auth.uid()));


--
-- Name: favorites; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.favorites ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: orders; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;

--
-- Name: products; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;

--
-- Name: users public_view_farmer_for_products; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY public_view_farmer_for_products ON public.users FOR SELECT TO authenticated USING ((id IN ( SELECT products.farmer_id
   FROM public.products
  WHERE true)));


--
-- Name: products public_view_products; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY public_view_products ON public.products FOR SELECT USING (true);


--
-- Name: reviews public_view_reviews; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY public_view_reviews ON public.reviews FOR SELECT USING (true);


--
-- Name: reviews; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.reviews ENABLE ROW LEVEL SECURITY;

--
-- Name: messages user_send_messages; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY user_send_messages ON public.messages FOR INSERT WITH CHECK ((sender_id = auth.uid()));


--
-- Name: users user_signup; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY user_signup ON public.users FOR INSERT WITH CHECK ((id = auth.uid()));


--
-- Name: users user_update_own; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY user_update_own ON public.users FOR UPDATE USING ((id = auth.uid()));


--
-- Name: users user_view_own; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY user_view_own ON public.users FOR SELECT USING ((id = auth.uid()));


--
-- Name: messages user_view_own_messages; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY user_view_own_messages ON public.messages FOR SELECT USING (((sender_id = auth.uid()) OR (receiver_id = auth.uid())));


--
-- Name: users; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: objects Allow authenticated uploads; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow authenticated uploads" ON storage.objects FOR INSERT TO authenticated WITH CHECK ((bucket_id = 'product-images'::text));


--
-- Name: objects Allow public read access; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow public read access" ON storage.objects FOR SELECT USING ((bucket_id = 'product-images'::text));


--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: supabase_realtime_messages_publication; Type: PUBLICATION; Schema: -; Owner: supabase_admin
--

CREATE PUBLICATION supabase_realtime_messages_publication WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime_messages_publication OWNER TO supabase_admin;

--
-- Name: supabase_realtime messages; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.messages;


--
-- Name: supabase_realtime orders; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.orders;


--
-- Name: supabase_realtime_messages_publication messages; Type: PUBLICATION TABLE; Schema: realtime; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY realtime.messages;


--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;
GRANT ALL ON FUNCTION auth.email() TO postgres;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;
GRANT ALL ON FUNCTION auth.role() TO postgres;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;
GRANT ALL ON FUNCTION auth.uid() TO postgres;


--
-- Name: FUNCTION algorithm_sign(signables text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sign(payload json, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION try_cast_double(inp text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO dashboard_user;


--
-- Name: FUNCTION url_decode(data text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.url_decode(data text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO dashboard_user;


--
-- Name: FUNCTION url_encode(data bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION verify(token text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO postgres;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION can_insert_object(bucketid text, name text, owner uuid, metadata jsonb); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) TO postgres;


--
-- Name: FUNCTION extension(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.extension(name text) TO postgres;


--
-- Name: FUNCTION filename(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.filename(name text) TO postgres;


--
-- Name: FUNCTION foldername(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.foldername(name text) TO postgres;


--
-- Name: FUNCTION get_size_by_bucket(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.get_size_by_bucket() TO postgres;


--
-- Name: FUNCTION list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) TO postgres;


--
-- Name: FUNCTION list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) TO postgres;


--
-- Name: FUNCTION operation(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.operation() TO postgres;


--
-- Name: FUNCTION search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) TO postgres;


--
-- Name: FUNCTION update_updated_at_column(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.update_updated_at_column() TO postgres;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE carts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.carts TO anon;
GRANT ALL ON TABLE public.carts TO authenticated;
GRANT ALL ON TABLE public.carts TO service_role;


--
-- Name: TABLE favorites; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.favorites TO anon;
GRANT ALL ON TABLE public.favorites TO authenticated;
GRANT ALL ON TABLE public.favorites TO service_role;


--
-- Name: TABLE orders; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.orders TO anon;
GRANT ALL ON TABLE public.orders TO authenticated;
GRANT ALL ON TABLE public.orders TO service_role;


--
-- Name: TABLE products; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.products TO anon;
GRANT ALL ON TABLE public.products TO authenticated;
GRANT ALL ON TABLE public.products TO service_role;


--
-- Name: TABLE reviews; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.reviews TO anon;
GRANT ALL ON TABLE public.reviews TO authenticated;
GRANT ALL ON TABLE public.reviews TO service_role;


--
-- Name: TABLE farmer_analytics; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.farmer_analytics TO anon;
GRANT ALL ON TABLE public.farmer_analytics TO authenticated;
GRANT ALL ON TABLE public.farmer_analytics TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.messages TO anon;
GRANT ALL ON TABLE public.messages TO authenticated;
GRANT ALL ON TABLE public.messages TO service_role;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.users TO anon;
GRANT ALL ON TABLE public.users TO authenticated;
GRANT ALL ON TABLE public.users TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE messages_2025_07_17; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_17 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_17 TO dashboard_user;


--
-- Name: TABLE messages_2025_07_18; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_18 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_18 TO dashboard_user;


--
-- Name: TABLE messages_2025_07_19; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_19 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_19 TO dashboard_user;


--
-- Name: TABLE messages_2025_07_20; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_20 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_20 TO dashboard_user;


--
-- Name: TABLE messages_2025_07_21; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_21 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_21 TO dashboard_user;


--
-- Name: TABLE messages_2025_07_22; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_22 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_22 TO dashboard_user;


--
-- Name: TABLE messages_2025_07_23; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_23 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_23 TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;
GRANT ALL ON TABLE storage.s3_multipart_uploads TO postgres;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;
GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO postgres;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES  TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS  TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES  TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

\unrestrict mX4Y7G2ZrvjMGbeDHn6DZK0T4Glk2IWfx7alKPbkYVNYOQ72zBn8GpdLv5u9B9Y

--
-- PostgreSQL database cluster dump complete
--

