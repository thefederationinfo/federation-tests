--
-- PostgreSQL database dump
--

-- Dumped from database version 10.1
-- Dumped by pg_dump version 10.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: account_deletions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE account_deletions (
    id integer NOT NULL,
    person_id integer,
    completed_at timestamp without time zone
);


ALTER TABLE account_deletions OWNER TO postgres;

--
-- Name: account_deletions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE account_deletions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE account_deletions_id_seq OWNER TO postgres;

--
-- Name: account_deletions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE account_deletions_id_seq OWNED BY account_deletions.id;


--
-- Name: account_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE account_migrations (
    id bigint NOT NULL,
    old_person_id integer NOT NULL,
    new_person_id integer NOT NULL
);


ALTER TABLE account_migrations OWNER TO postgres;

--
-- Name: account_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE account_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE account_migrations_id_seq OWNER TO postgres;

--
-- Name: account_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE account_migrations_id_seq OWNED BY account_migrations.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE ar_internal_metadata OWNER TO postgres;

--
-- Name: aspect_memberships; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE aspect_memberships (
    id integer NOT NULL,
    aspect_id integer NOT NULL,
    contact_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE aspect_memberships OWNER TO postgres;

--
-- Name: aspect_memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE aspect_memberships_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE aspect_memberships_id_seq OWNER TO postgres;

--
-- Name: aspect_memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE aspect_memberships_id_seq OWNED BY aspect_memberships.id;


--
-- Name: aspect_visibilities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE aspect_visibilities (
    id integer NOT NULL,
    shareable_id integer NOT NULL,
    aspect_id integer NOT NULL,
    shareable_type character varying DEFAULT 'Post'::character varying NOT NULL
);


ALTER TABLE aspect_visibilities OWNER TO postgres;

--
-- Name: aspect_visibilities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE aspect_visibilities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE aspect_visibilities_id_seq OWNER TO postgres;

--
-- Name: aspect_visibilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE aspect_visibilities_id_seq OWNED BY aspect_visibilities.id;


--
-- Name: aspects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE aspects (
    id integer NOT NULL,
    name character varying NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    contacts_visible boolean DEFAULT true NOT NULL,
    order_id integer,
    chat_enabled boolean DEFAULT false,
    post_default boolean DEFAULT true
);


ALTER TABLE aspects OWNER TO postgres;

--
-- Name: aspects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE aspects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE aspects_id_seq OWNER TO postgres;

--
-- Name: aspects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE aspects_id_seq OWNED BY aspects.id;


--
-- Name: authorizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE authorizations (
    id integer NOT NULL,
    user_id integer,
    o_auth_application_id integer,
    refresh_token character varying,
    code character varying,
    redirect_uri character varying,
    nonce character varying,
    scopes character varying,
    code_used boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE authorizations OWNER TO postgres;

--
-- Name: authorizations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE authorizations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE authorizations_id_seq OWNER TO postgres;

--
-- Name: authorizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE authorizations_id_seq OWNED BY authorizations.id;


--
-- Name: blocks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE blocks (
    id integer NOT NULL,
    user_id integer,
    person_id integer
);


ALTER TABLE blocks OWNER TO postgres;

--
-- Name: blocks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE blocks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE blocks_id_seq OWNER TO postgres;

--
-- Name: blocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE blocks_id_seq OWNED BY blocks.id;


--
-- Name: chat_contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE chat_contacts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    jid character varying NOT NULL,
    name character varying(255),
    ask character varying(128),
    subscription character varying(128) NOT NULL
);


ALTER TABLE chat_contacts OWNER TO postgres;

--
-- Name: chat_contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE chat_contacts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_contacts_id_seq OWNER TO postgres;

--
-- Name: chat_contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE chat_contacts_id_seq OWNED BY chat_contacts.id;


--
-- Name: chat_fragments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE chat_fragments (
    id integer NOT NULL,
    user_id integer NOT NULL,
    root character varying(256) NOT NULL,
    namespace character varying(256) NOT NULL,
    xml text NOT NULL
);


ALTER TABLE chat_fragments OWNER TO postgres;

--
-- Name: chat_fragments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE chat_fragments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_fragments_id_seq OWNER TO postgres;

--
-- Name: chat_fragments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE chat_fragments_id_seq OWNED BY chat_fragments.id;


--
-- Name: chat_offline_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE chat_offline_messages (
    id integer NOT NULL,
    "from" character varying NOT NULL,
    "to" character varying NOT NULL,
    message text NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE chat_offline_messages OWNER TO postgres;

--
-- Name: chat_offline_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE chat_offline_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_offline_messages_id_seq OWNER TO postgres;

--
-- Name: chat_offline_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE chat_offline_messages_id_seq OWNED BY chat_offline_messages.id;


--
-- Name: comment_signatures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE comment_signatures (
    comment_id integer NOT NULL,
    author_signature text NOT NULL,
    signature_order_id integer NOT NULL,
    additional_data text
);


ALTER TABLE comment_signatures OWNER TO postgres;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE comments (
    id integer NOT NULL,
    text text NOT NULL,
    commentable_id integer NOT NULL,
    author_id integer NOT NULL,
    guid character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    likes_count integer DEFAULT 0 NOT NULL,
    commentable_type character varying(60) DEFAULT 'Post'::character varying NOT NULL
);


ALTER TABLE comments OWNER TO postgres;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comments_id_seq OWNER TO postgres;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE contacts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    person_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    sharing boolean DEFAULT false NOT NULL,
    receiving boolean DEFAULT false NOT NULL
);


ALTER TABLE contacts OWNER TO postgres;

--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE contacts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts_id_seq OWNER TO postgres;

--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: conversation_visibilities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE conversation_visibilities (
    id integer NOT NULL,
    conversation_id integer NOT NULL,
    person_id integer NOT NULL,
    unread integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE conversation_visibilities OWNER TO postgres;

--
-- Name: conversation_visibilities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE conversation_visibilities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE conversation_visibilities_id_seq OWNER TO postgres;

--
-- Name: conversation_visibilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE conversation_visibilities_id_seq OWNED BY conversation_visibilities.id;


--
-- Name: conversations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE conversations (
    id integer NOT NULL,
    subject character varying,
    guid character varying NOT NULL,
    author_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE conversations OWNER TO postgres;

--
-- Name: conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE conversations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE conversations_id_seq OWNER TO postgres;

--
-- Name: conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE conversations_id_seq OWNED BY conversations.id;


--
-- Name: invitation_codes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE invitation_codes (
    id integer NOT NULL,
    token character varying,
    user_id integer,
    count integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE invitation_codes OWNER TO postgres;

--
-- Name: invitation_codes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE invitation_codes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE invitation_codes_id_seq OWNER TO postgres;

--
-- Name: invitation_codes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE invitation_codes_id_seq OWNED BY invitation_codes.id;


--
-- Name: like_signatures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE like_signatures (
    like_id integer NOT NULL,
    author_signature text NOT NULL,
    signature_order_id integer NOT NULL,
    additional_data text
);


ALTER TABLE like_signatures OWNER TO postgres;

--
-- Name: likes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE likes (
    id integer NOT NULL,
    positive boolean DEFAULT true,
    target_id integer,
    author_id integer,
    guid character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    target_type character varying(60) NOT NULL
);


ALTER TABLE likes OWNER TO postgres;

--
-- Name: likes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE likes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE likes_id_seq OWNER TO postgres;

--
-- Name: likes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE likes_id_seq OWNED BY likes.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE locations (
    id integer NOT NULL,
    address character varying,
    lat character varying,
    lng character varying,
    status_message_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE locations OWNER TO postgres;

--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE locations_id_seq OWNER TO postgres;

--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE locations_id_seq OWNED BY locations.id;


--
-- Name: mentions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE mentions (
    id integer NOT NULL,
    mentions_container_id integer NOT NULL,
    person_id integer NOT NULL,
    mentions_container_type character varying NOT NULL
);


ALTER TABLE mentions OWNER TO postgres;

--
-- Name: mentions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE mentions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mentions_id_seq OWNER TO postgres;

--
-- Name: mentions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE mentions_id_seq OWNED BY mentions.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE messages (
    id integer NOT NULL,
    conversation_id integer NOT NULL,
    author_id integer NOT NULL,
    guid character varying NOT NULL,
    text text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE messages OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE messages_id_seq OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE messages_id_seq OWNED BY messages.id;


--
-- Name: notification_actors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE notification_actors (
    id integer NOT NULL,
    notification_id integer,
    person_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE notification_actors OWNER TO postgres;

--
-- Name: notification_actors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE notification_actors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE notification_actors_id_seq OWNER TO postgres;

--
-- Name: notification_actors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE notification_actors_id_seq OWNED BY notification_actors.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE notifications (
    id integer NOT NULL,
    target_type character varying,
    target_id integer,
    recipient_id integer NOT NULL,
    unread boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    type character varying
);


ALTER TABLE notifications OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE notifications_id_seq OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE notifications_id_seq OWNED BY notifications.id;


--
-- Name: o_auth_access_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE o_auth_access_tokens (
    id integer NOT NULL,
    authorization_id integer,
    token character varying,
    expires_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE o_auth_access_tokens OWNER TO postgres;

--
-- Name: o_auth_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE o_auth_access_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE o_auth_access_tokens_id_seq OWNER TO postgres;

--
-- Name: o_auth_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE o_auth_access_tokens_id_seq OWNED BY o_auth_access_tokens.id;


--
-- Name: o_auth_applications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE o_auth_applications (
    id integer NOT NULL,
    user_id integer,
    client_id character varying,
    client_secret character varying,
    client_name character varying,
    redirect_uris text,
    response_types character varying,
    grant_types character varying,
    application_type character varying DEFAULT 'web'::character varying,
    contacts character varying,
    logo_uri character varying,
    client_uri character varying,
    policy_uri character varying,
    tos_uri character varying,
    sector_identifier_uri character varying,
    token_endpoint_auth_method character varying,
    jwks text,
    jwks_uri character varying,
    ppid boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE o_auth_applications OWNER TO postgres;

--
-- Name: o_auth_applications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE o_auth_applications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE o_auth_applications_id_seq OWNER TO postgres;

--
-- Name: o_auth_applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE o_auth_applications_id_seq OWNED BY o_auth_applications.id;


--
-- Name: o_embed_caches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE o_embed_caches (
    id integer NOT NULL,
    url character varying(1024) NOT NULL,
    data text NOT NULL
);


ALTER TABLE o_embed_caches OWNER TO postgres;

--
-- Name: o_embed_caches_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE o_embed_caches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE o_embed_caches_id_seq OWNER TO postgres;

--
-- Name: o_embed_caches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE o_embed_caches_id_seq OWNED BY o_embed_caches.id;


--
-- Name: open_graph_caches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE open_graph_caches (
    id integer NOT NULL,
    title character varying,
    ob_type character varying,
    image text,
    url text,
    description text,
    video_url text
);


ALTER TABLE open_graph_caches OWNER TO postgres;

--
-- Name: open_graph_caches_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE open_graph_caches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE open_graph_caches_id_seq OWNER TO postgres;

--
-- Name: open_graph_caches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE open_graph_caches_id_seq OWNED BY open_graph_caches.id;


--
-- Name: participations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE participations (
    id integer NOT NULL,
    guid character varying,
    target_id integer,
    target_type character varying(60) NOT NULL,
    author_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    count integer DEFAULT 1 NOT NULL
);


ALTER TABLE participations OWNER TO postgres;

--
-- Name: participations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE participations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE participations_id_seq OWNER TO postgres;

--
-- Name: participations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE participations_id_seq OWNED BY participations.id;


--
-- Name: people; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE people (
    id integer NOT NULL,
    guid character varying NOT NULL,
    diaspora_handle character varying NOT NULL,
    serialized_public_key text NOT NULL,
    owner_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    closed_account boolean DEFAULT false,
    fetch_status integer DEFAULT 0,
    pod_id integer
);


ALTER TABLE people OWNER TO postgres;

--
-- Name: people_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE people_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE people_id_seq OWNER TO postgres;

--
-- Name: people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE people_id_seq OWNED BY people.id;


--
-- Name: photos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE photos (
    id integer NOT NULL,
    author_id integer NOT NULL,
    public boolean DEFAULT false NOT NULL,
    guid character varying NOT NULL,
    pending boolean DEFAULT false NOT NULL,
    text text,
    remote_photo_path text,
    remote_photo_name character varying,
    random_string character varying,
    processed_image character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    unprocessed_image character varying,
    status_message_guid character varying,
    comments_count integer,
    height integer,
    width integer
);


ALTER TABLE photos OWNER TO postgres;

--
-- Name: photos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE photos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE photos_id_seq OWNER TO postgres;

--
-- Name: photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE photos_id_seq OWNED BY photos.id;


--
-- Name: pods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pods (
    id integer NOT NULL,
    host character varying NOT NULL,
    ssl boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    status integer DEFAULT 0,
    checked_at timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone,
    offline_since timestamp without time zone,
    response_time integer DEFAULT '-1'::integer,
    software character varying,
    error character varying,
    port integer,
    blocked boolean DEFAULT false,
    scheduled_check boolean DEFAULT false NOT NULL
);


ALTER TABLE pods OWNER TO postgres;

--
-- Name: pods_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pods_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pods_id_seq OWNER TO postgres;

--
-- Name: pods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pods_id_seq OWNED BY pods.id;


--
-- Name: poll_answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE poll_answers (
    id integer NOT NULL,
    answer character varying NOT NULL,
    poll_id integer NOT NULL,
    guid character varying,
    vote_count integer DEFAULT 0
);


ALTER TABLE poll_answers OWNER TO postgres;

--
-- Name: poll_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE poll_answers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE poll_answers_id_seq OWNER TO postgres;

--
-- Name: poll_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE poll_answers_id_seq OWNED BY poll_answers.id;


--
-- Name: poll_participation_signatures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE poll_participation_signatures (
    poll_participation_id integer NOT NULL,
    author_signature text NOT NULL,
    signature_order_id integer NOT NULL,
    additional_data text
);


ALTER TABLE poll_participation_signatures OWNER TO postgres;

--
-- Name: poll_participations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE poll_participations (
    id integer NOT NULL,
    poll_answer_id integer NOT NULL,
    author_id integer NOT NULL,
    poll_id integer NOT NULL,
    guid character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE poll_participations OWNER TO postgres;

--
-- Name: poll_participations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE poll_participations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE poll_participations_id_seq OWNER TO postgres;

--
-- Name: poll_participations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE poll_participations_id_seq OWNED BY poll_participations.id;


--
-- Name: polls; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE polls (
    id integer NOT NULL,
    question character varying NOT NULL,
    status_message_id integer NOT NULL,
    status boolean,
    guid character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE polls OWNER TO postgres;

--
-- Name: polls_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE polls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE polls_id_seq OWNER TO postgres;

--
-- Name: polls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE polls_id_seq OWNED BY polls.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE posts (
    id integer NOT NULL,
    author_id integer NOT NULL,
    public boolean DEFAULT false NOT NULL,
    guid character varying NOT NULL,
    type character varying(40) NOT NULL,
    text text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    provider_display_name character varying,
    root_guid character varying,
    likes_count integer DEFAULT 0,
    comments_count integer DEFAULT 0,
    o_embed_cache_id integer,
    reshares_count integer DEFAULT 0,
    interacted_at timestamp without time zone,
    facebook_id character varying,
    tweet_id character varying,
    open_graph_cache_id integer,
    tumblr_ids text
);


ALTER TABLE posts OWNER TO postgres;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE posts_id_seq OWNER TO postgres;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE posts_id_seq OWNED BY posts.id;


--
-- Name: ppid; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ppid (
    id integer NOT NULL,
    o_auth_application_id integer,
    user_id integer,
    guid character varying(32),
    identifier character varying
);


ALTER TABLE ppid OWNER TO postgres;

--
-- Name: ppid_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ppid_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ppid_id_seq OWNER TO postgres;

--
-- Name: ppid_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ppid_id_seq OWNED BY ppid.id;


--
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE profiles (
    id integer NOT NULL,
    diaspora_handle character varying,
    first_name character varying(127),
    last_name character varying(127),
    image_url character varying,
    image_url_small character varying,
    image_url_medium character varying,
    birthday date,
    gender character varying,
    bio text,
    searchable boolean DEFAULT true NOT NULL,
    person_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    location character varying,
    full_name character varying(70),
    nsfw boolean DEFAULT false,
    public_details boolean DEFAULT false
);


ALTER TABLE profiles OWNER TO postgres;

--
-- Name: profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE profiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE profiles_id_seq OWNER TO postgres;

--
-- Name: profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE profiles_id_seq OWNED BY profiles.id;


--
-- Name: references; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "references" (
    id bigint NOT NULL,
    source_id integer NOT NULL,
    source_type character varying(60) NOT NULL,
    target_id integer NOT NULL,
    target_type character varying(60) NOT NULL
);


ALTER TABLE "references" OWNER TO postgres;

--
-- Name: references_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE references_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE references_id_seq OWNER TO postgres;

--
-- Name: references_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE references_id_seq OWNED BY "references".id;


--
-- Name: reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE reports (
    id integer NOT NULL,
    item_id integer NOT NULL,
    item_type character varying NOT NULL,
    reviewed boolean DEFAULT false,
    text text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer NOT NULL
);


ALTER TABLE reports OWNER TO postgres;

--
-- Name: reports_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reports_id_seq OWNER TO postgres;

--
-- Name: reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE reports_id_seq OWNED BY reports.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE roles (
    id integer NOT NULL,
    person_id integer,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO postgres;

--
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE services (
    id integer NOT NULL,
    type character varying(127) NOT NULL,
    user_id integer NOT NULL,
    uid character varying(127),
    access_token character varying,
    access_secret character varying,
    nickname character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE services OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE services_id_seq OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE services_id_seq OWNED BY services.id;


--
-- Name: share_visibilities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE share_visibilities (
    id integer NOT NULL,
    shareable_id integer NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    shareable_type character varying(60) DEFAULT 'Post'::character varying NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE share_visibilities OWNER TO postgres;

--
-- Name: share_visibilities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE share_visibilities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE share_visibilities_id_seq OWNER TO postgres;

--
-- Name: share_visibilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE share_visibilities_id_seq OWNED BY share_visibilities.id;


--
-- Name: signature_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE signature_orders (
    id integer NOT NULL,
    "order" character varying NOT NULL
);


ALTER TABLE signature_orders OWNER TO postgres;

--
-- Name: signature_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE signature_orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE signature_orders_id_seq OWNER TO postgres;

--
-- Name: signature_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE signature_orders_id_seq OWNED BY signature_orders.id;


--
-- Name: simple_captcha_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE simple_captcha_data (
    id integer NOT NULL,
    key character varying(40),
    value character varying(12),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE simple_captcha_data OWNER TO postgres;

--
-- Name: simple_captcha_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE simple_captcha_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE simple_captcha_data_id_seq OWNER TO postgres;

--
-- Name: simple_captcha_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE simple_captcha_data_id_seq OWNED BY simple_captcha_data.id;


--
-- Name: tag_followings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tag_followings (
    id integer NOT NULL,
    tag_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE tag_followings OWNER TO postgres;

--
-- Name: tag_followings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tag_followings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tag_followings_id_seq OWNER TO postgres;

--
-- Name: tag_followings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tag_followings_id_seq OWNED BY tag_followings.id;


--
-- Name: taggings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE taggings (
    id integer NOT NULL,
    tag_id integer,
    taggable_id integer,
    taggable_type character varying(127),
    tagger_id integer,
    tagger_type character varying(127),
    context character varying(127),
    created_at timestamp without time zone
);


ALTER TABLE taggings OWNER TO postgres;

--
-- Name: taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE taggings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE taggings_id_seq OWNER TO postgres;

--
-- Name: taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE taggings_id_seq OWNED BY taggings.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tags (
    id integer NOT NULL,
    name character varying,
    taggings_count integer DEFAULT 0
);


ALTER TABLE tags OWNER TO postgres;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tags_id_seq OWNER TO postgres;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: user_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE user_preferences (
    id integer NOT NULL,
    email_type character varying,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE user_preferences OWNER TO postgres;

--
-- Name: user_preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_preferences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_preferences_id_seq OWNER TO postgres;

--
-- Name: user_preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_preferences_id_seq OWNED BY user_preferences.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users (
    id integer NOT NULL,
    username character varying NOT NULL,
    serialized_private_key text,
    getting_started boolean DEFAULT true NOT NULL,
    disable_mail boolean DEFAULT false NOT NULL,
    language character varying,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    invited_by_id integer,
    authentication_token character varying(30),
    unconfirmed_email character varying,
    confirm_email_token character varying(30),
    locked_at timestamp without time zone,
    show_community_spotlight_in_stream boolean DEFAULT true NOT NULL,
    auto_follow_back boolean DEFAULT false,
    auto_follow_back_aspect_id integer,
    hidden_shareables text,
    reset_password_sent_at timestamp without time zone,
    last_seen timestamp without time zone,
    remove_after timestamp without time zone,
    export character varying,
    exported_at timestamp without time zone,
    exporting boolean DEFAULT false,
    strip_exif boolean DEFAULT true,
    exported_photos_file character varying,
    exported_photos_at timestamp without time zone,
    exporting_photos boolean DEFAULT false,
    color_theme character varying,
    post_default_public boolean DEFAULT false
);


ALTER TABLE users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: account_deletions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account_deletions ALTER COLUMN id SET DEFAULT nextval('account_deletions_id_seq'::regclass);


--
-- Name: account_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account_migrations ALTER COLUMN id SET DEFAULT nextval('account_migrations_id_seq'::regclass);


--
-- Name: aspect_memberships id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY aspect_memberships ALTER COLUMN id SET DEFAULT nextval('aspect_memberships_id_seq'::regclass);


--
-- Name: aspect_visibilities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY aspect_visibilities ALTER COLUMN id SET DEFAULT nextval('aspect_visibilities_id_seq'::regclass);


--
-- Name: aspects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY aspects ALTER COLUMN id SET DEFAULT nextval('aspects_id_seq'::regclass);


--
-- Name: authorizations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY authorizations ALTER COLUMN id SET DEFAULT nextval('authorizations_id_seq'::regclass);


--
-- Name: blocks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY blocks ALTER COLUMN id SET DEFAULT nextval('blocks_id_seq'::regclass);


--
-- Name: chat_contacts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY chat_contacts ALTER COLUMN id SET DEFAULT nextval('chat_contacts_id_seq'::regclass);


--
-- Name: chat_fragments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY chat_fragments ALTER COLUMN id SET DEFAULT nextval('chat_fragments_id_seq'::regclass);


--
-- Name: chat_offline_messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY chat_offline_messages ALTER COLUMN id SET DEFAULT nextval('chat_offline_messages_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: contacts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: conversation_visibilities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversation_visibilities ALTER COLUMN id SET DEFAULT nextval('conversation_visibilities_id_seq'::regclass);


--
-- Name: conversations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversations ALTER COLUMN id SET DEFAULT nextval('conversations_id_seq'::regclass);


--
-- Name: invitation_codes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY invitation_codes ALTER COLUMN id SET DEFAULT nextval('invitation_codes_id_seq'::regclass);


--
-- Name: likes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY likes ALTER COLUMN id SET DEFAULT nextval('likes_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY locations ALTER COLUMN id SET DEFAULT nextval('locations_id_seq'::regclass);


--
-- Name: mentions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mentions ALTER COLUMN id SET DEFAULT nextval('mentions_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages ALTER COLUMN id SET DEFAULT nextval('messages_id_seq'::regclass);


--
-- Name: notification_actors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notification_actors ALTER COLUMN id SET DEFAULT nextval('notification_actors_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notifications ALTER COLUMN id SET DEFAULT nextval('notifications_id_seq'::regclass);


--
-- Name: o_auth_access_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY o_auth_access_tokens ALTER COLUMN id SET DEFAULT nextval('o_auth_access_tokens_id_seq'::regclass);


--
-- Name: o_auth_applications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY o_auth_applications ALTER COLUMN id SET DEFAULT nextval('o_auth_applications_id_seq'::regclass);


--
-- Name: o_embed_caches id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY o_embed_caches ALTER COLUMN id SET DEFAULT nextval('o_embed_caches_id_seq'::regclass);


--
-- Name: open_graph_caches id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY open_graph_caches ALTER COLUMN id SET DEFAULT nextval('open_graph_caches_id_seq'::regclass);


--
-- Name: participations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY participations ALTER COLUMN id SET DEFAULT nextval('participations_id_seq'::regclass);


--
-- Name: people id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY people ALTER COLUMN id SET DEFAULT nextval('people_id_seq'::regclass);


--
-- Name: photos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY photos ALTER COLUMN id SET DEFAULT nextval('photos_id_seq'::regclass);


--
-- Name: pods id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pods ALTER COLUMN id SET DEFAULT nextval('pods_id_seq'::regclass);


--
-- Name: poll_answers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY poll_answers ALTER COLUMN id SET DEFAULT nextval('poll_answers_id_seq'::regclass);


--
-- Name: poll_participations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY poll_participations ALTER COLUMN id SET DEFAULT nextval('poll_participations_id_seq'::regclass);


--
-- Name: polls id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY polls ALTER COLUMN id SET DEFAULT nextval('polls_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq'::regclass);


--
-- Name: ppid id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ppid ALTER COLUMN id SET DEFAULT nextval('ppid_id_seq'::regclass);


--
-- Name: profiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY profiles ALTER COLUMN id SET DEFAULT nextval('profiles_id_seq'::regclass);


--
-- Name: references id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "references" ALTER COLUMN id SET DEFAULT nextval('references_id_seq'::regclass);


--
-- Name: reports id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reports ALTER COLUMN id SET DEFAULT nextval('reports_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: services id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY services ALTER COLUMN id SET DEFAULT nextval('services_id_seq'::regclass);


--
-- Name: share_visibilities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY share_visibilities ALTER COLUMN id SET DEFAULT nextval('share_visibilities_id_seq'::regclass);


--
-- Name: signature_orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY signature_orders ALTER COLUMN id SET DEFAULT nextval('signature_orders_id_seq'::regclass);


--
-- Name: simple_captcha_data id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY simple_captcha_data ALTER COLUMN id SET DEFAULT nextval('simple_captcha_data_id_seq'::regclass);


--
-- Name: tag_followings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tag_followings ALTER COLUMN id SET DEFAULT nextval('tag_followings_id_seq'::regclass);


--
-- Name: taggings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY taggings ALTER COLUMN id SET DEFAULT nextval('taggings_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: user_preferences id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_preferences ALTER COLUMN id SET DEFAULT nextval('user_preferences_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: account_deletions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY account_deletions (id, person_id, completed_at) FROM stdin;
\.


--
-- Data for Name: account_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY account_migrations (id, old_person_id, new_person_id) FROM stdin;
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	production	2018-01-27 02:30:08.033037	2018-01-27 02:30:08.033037
\.


--
-- Data for Name: aspect_memberships; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY aspect_memberships (id, aspect_id, contact_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: aspect_visibilities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY aspect_visibilities (id, shareable_id, aspect_id, shareable_type) FROM stdin;
\.


--
-- Data for Name: aspects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY aspects (id, name, user_id, created_at, updated_at, contacts_visible, order_id, chat_enabled, post_default) FROM stdin;
1	Family	1	2018-01-27 02:32:01.263642	2018-01-27 02:32:01.263642	t	1	f	t
2	Friends	1	2018-01-27 02:32:01.281543	2018-01-27 02:32:01.281543	t	2	f	t
3	Work	1	2018-01-27 02:32:01.300581	2018-01-27 02:32:01.300581	t	3	f	t
4	Acquaintances	1	2018-01-27 02:32:01.313774	2018-01-27 02:32:01.313774	t	4	f	t
\.


--
-- Data for Name: authorizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY authorizations (id, user_id, o_auth_application_id, refresh_token, code, redirect_uri, nonce, scopes, code_used, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: blocks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY blocks (id, user_id, person_id) FROM stdin;
\.


--
-- Data for Name: chat_contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY chat_contacts (id, user_id, jid, name, ask, subscription) FROM stdin;
\.


--
-- Data for Name: chat_fragments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY chat_fragments (id, user_id, root, namespace, xml) FROM stdin;
\.


--
-- Data for Name: chat_offline_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY chat_offline_messages (id, "from", "to", message, created_at) FROM stdin;
\.


--
-- Data for Name: comment_signatures; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY comment_signatures (comment_id, author_signature, signature_order_id, additional_data) FROM stdin;
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY comments (id, text, commentable_id, author_id, guid, created_at, updated_at, likes_count, commentable_type) FROM stdin;
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY contacts (id, user_id, person_id, created_at, updated_at, sharing, receiving) FROM stdin;
\.


--
-- Data for Name: conversation_visibilities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY conversation_visibilities (id, conversation_id, person_id, unread, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY conversations (id, subject, guid, author_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: invitation_codes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY invitation_codes (id, token, user_id, count, created_at, updated_at) FROM stdin;
1	21d5740b9cdd	1	25	2018-01-27 02:32:01.497205	2018-01-27 02:32:01.497205
\.


--
-- Data for Name: like_signatures; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY like_signatures (like_id, author_signature, signature_order_id, additional_data) FROM stdin;
\.


--
-- Data for Name: likes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY likes (id, positive, target_id, author_id, guid, created_at, updated_at, target_type) FROM stdin;
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY locations (id, address, lat, lng, status_message_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mentions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY mentions (id, mentions_container_id, person_id, mentions_container_type) FROM stdin;
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY messages (id, conversation_id, author_id, guid, text, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: notification_actors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY notification_actors (id, notification_id, person_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY notifications (id, target_type, target_id, recipient_id, unread, created_at, updated_at, type) FROM stdin;
\.


--
-- Data for Name: o_auth_access_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY o_auth_access_tokens (id, authorization_id, token, expires_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: o_auth_applications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY o_auth_applications (id, user_id, client_id, client_secret, client_name, redirect_uris, response_types, grant_types, application_type, contacts, logo_uri, client_uri, policy_uri, tos_uri, sector_identifier_uri, token_endpoint_auth_method, jwks, jwks_uri, ppid, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: o_embed_caches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY o_embed_caches (id, url, data) FROM stdin;
\.


--
-- Data for Name: open_graph_caches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY open_graph_caches (id, title, ob_type, image, url, description, video_url) FROM stdin;
\.


--
-- Data for Name: participations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY participations (id, guid, target_id, target_type, author_id, created_at, updated_at, count) FROM stdin;
\.


--
-- Data for Name: people; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY people (id, guid, diaspora_handle, serialized_public_key, owner_id, created_at, updated_at, closed_account, fetch_status, pod_id) FROM stdin;
1	2d4fa7e0e5380135fa593c970e8692GUID	USERNAME@localhost:PORT	-----BEGIN PUBLIC KEY-----\nMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAp7nqLKGcKJY12UwNoNXu\nLr/aD0dLiKB+t0F+dcd1bllZE8wBXwWcUtd4g91YxtKniFxY810ov554lzk4uG63\nLIkyQY6wQMVWAxl9xd4lEirF4qLbO2Z2BzOcoRcu86DTppxrFHJ9VA78aWfyXFnH\n69SHmaq4p3HolN3Z64wFFtHuQ94XAxuDDtKkx7NX91tXj9/W9pEJSSxny8mlNZDB\nT7tDmV3ZgDdorq3tBT4h57/MQZquo3UE0V4g44yYP6jqhb+yS20QnO+0EB8plMAk\n0+e8qD885xZxoNvyEx7wUL4XyFYFrMNBQPjXCrwOHc/Wxs5m7t7HKLcTCzq3DX/q\nYmB4647awHfPa8GfdOsfaaKcnw0KEzf2Ekt/FNwkdKpS1aNGmuZs64x0zvDW9AFZ\nIxBZEu0TbTkovcuRoG1QDDzrDs3v9s7obEZh/Dmcn1jV9htGHRnqCVGVreDxVd5Y\nE19+7sKIkVK9PP3BYxrB6q/Kp8xbBGWdgRuhV+sszmSHi5u47oTg4mFfmzu7szpv\nzm0eIvryHD2wf9t0DDggCNNHzcRruR983h3dElfk37beKxon9r5XWbIeQkZYyaj1\nUcNV9q3P6Y00n00MqMt2sSFZS5gRvbigd/VUVcCqrsVwLtBU2NLogBKgpQW/OKo/\nuvVC3r23765SqzBLwSqvubMCAwEAAQ==\n-----END PUBLIC KEY-----\n	1	2018-01-27 02:32:01.197194	2018-01-27 02:32:01.197194	f	0	\N
\.


--
-- Data for Name: photos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY photos (id, author_id, public, guid, pending, text, remote_photo_path, remote_photo_name, random_string, processed_image, created_at, updated_at, unprocessed_image, status_message_guid, comments_count, height, width) FROM stdin;
\.


--
-- Data for Name: pods; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pods (id, host, ssl, created_at, updated_at, status, checked_at, offline_since, response_time, software, error, port, blocked, scheduled_check) FROM stdin;
\.


--
-- Data for Name: poll_answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY poll_answers (id, answer, poll_id, guid, vote_count) FROM stdin;
\.


--
-- Data for Name: poll_participation_signatures; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY poll_participation_signatures (poll_participation_id, author_signature, signature_order_id, additional_data) FROM stdin;
\.


--
-- Data for Name: poll_participations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY poll_participations (id, poll_answer_id, author_id, poll_id, guid, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: polls; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY polls (id, question, status_message_id, status, guid, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY posts (id, author_id, public, guid, type, text, created_at, updated_at, provider_display_name, root_guid, likes_count, comments_count, o_embed_cache_id, reshares_count, interacted_at, facebook_id, tweet_id, open_graph_cache_id, tumblr_ids) FROM stdin;
\.


--
-- Data for Name: ppid; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ppid (id, o_auth_application_id, user_id, guid, identifier) FROM stdin;
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY profiles (id, diaspora_handle, first_name, last_name, image_url, image_url_small, image_url_medium, birthday, gender, bio, searchable, person_id, created_at, updated_at, location, full_name, nsfw, public_details) FROM stdin;
1	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	1	2018-01-27 02:32:01.201093	2018-01-27 02:32:01.201093	\N		f	f
\.


--
-- Data for Name: references; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "references" (id, source_id, source_type, target_id, target_type) FROM stdin;
\.


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY reports (id, item_id, item_type, reviewed, text, created_at, updated_at, user_id) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY roles (id, person_id, name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schema_migrations (version) FROM stdin;
0
20160829170244
20160901072443
20160902180630
20160906225138
20161015174300
20161024231443
20161107100840
20170430022507
20170730154117
20170813141631
20170813153048
20170813160104
20170813164435
20170813222333
20170824202628
20170827222357
20170827231800
20170914202650
20170914212336
20170917163640
20170920214158
20170928233609
20171009232054
20171012202650
20171017221434
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY services (id, type, user_id, uid, access_token, access_secret, nickname, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: share_visibilities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY share_visibilities (id, shareable_id, hidden, shareable_type, user_id) FROM stdin;
\.


--
-- Data for Name: signature_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY signature_orders (id, "order") FROM stdin;
\.


--
-- Data for Name: simple_captcha_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY simple_captcha_data (id, key, value, created_at, updated_at) FROM stdin;
2	e99c956d879719b7774625a711c3e1c2b7aa1725	54298	2018-01-27 02:33:29.528515	2018-01-27 02:33:29.528515
\.


--
-- Data for Name: tag_followings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tag_followings (id, tag_id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: taggings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY taggings (id, tag_id, taggable_id, taggable_type, tagger_id, tagger_type, context, created_at) FROM stdin;
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tags (id, name, taggings_count) FROM stdin;
\.


--
-- Data for Name: user_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_preferences (id, email_type, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, username, serialized_private_key, getting_started, disable_mail, language, email, encrypted_password, reset_password_token, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at, invited_by_id, authentication_token, unconfirmed_email, confirm_email_token, locked_at, show_community_spotlight_in_stream, auto_follow_back, auto_follow_back_aspect_id, hidden_shareables, reset_password_sent_at, last_seen, remove_after, export, exported_at, exporting, strip_exif, exported_photos_file, exported_photos_at, exporting_photos, color_theme, post_default_public) FROM stdin;
1	USERNAME	-----BEGIN RSA PRIVATE KEY-----\nMIIJKQIBAAKCAgEAp7nqLKGcKJY12UwNoNXuLr/aD0dLiKB+t0F+dcd1bllZE8wB\nXwWcUtd4g91YxtKniFxY810ov554lzk4uG63LIkyQY6wQMVWAxl9xd4lEirF4qLb\nO2Z2BzOcoRcu86DTppxrFHJ9VA78aWfyXFnH69SHmaq4p3HolN3Z64wFFtHuQ94X\nAxuDDtKkx7NX91tXj9/W9pEJSSxny8mlNZDBT7tDmV3ZgDdorq3tBT4h57/MQZqu\no3UE0V4g44yYP6jqhb+yS20QnO+0EB8plMAk0+e8qD885xZxoNvyEx7wUL4XyFYF\nrMNBQPjXCrwOHc/Wxs5m7t7HKLcTCzq3DX/qYmB4647awHfPa8GfdOsfaaKcnw0K\nEzf2Ekt/FNwkdKpS1aNGmuZs64x0zvDW9AFZIxBZEu0TbTkovcuRoG1QDDzrDs3v\n9s7obEZh/Dmcn1jV9htGHRnqCVGVreDxVd5YE19+7sKIkVK9PP3BYxrB6q/Kp8xb\nBGWdgRuhV+sszmSHi5u47oTg4mFfmzu7szpvzm0eIvryHD2wf9t0DDggCNNHzcRr\nuR983h3dElfk37beKxon9r5XWbIeQkZYyaj1UcNV9q3P6Y00n00MqMt2sSFZS5gR\nvbigd/VUVcCqrsVwLtBU2NLogBKgpQW/OKo/uvVC3r23765SqzBLwSqvubMCAwEA\nAQKCAgEApWj8QLfAwWYiBQK0DgHsu74I1ziAjWV6kk/M32qtrP4Akz2FvKhT2n8V\nIzaP7sSg5CHut1MQdKlcVAbioUDO9OT44x5NRBNZGAVzvEewV5JHRZNGkfYiQEfu\nGBA9BZd+I7nvAGNIpjWBSJJyuhDw0OrwL+Pl53y22tlPqLSV8ENorxW/rBjdzyh9\nyVRdVFyIpiMiZFf0yG06kAd1HrZ7bp5HtGCRt5jtbBeqwJjd5yeH0Mszn5AwCCrE\nVKS7IUz8vJqowyn0UFE1SxDwePplV3Ya3/I9pcjEltdSjPjeF0LhQXlUb2TAXcsK\niFOduFjYf4fei4S49LZX2aM2E+IqyvGL87egHKHtolW93otTvjbN4J5yXIcdBOQW\n/1dsBO0v5yXd6gj5z2nNahgQBE/0WZ0UT/tAddNqNi6Q70vetT73PcziNjJ6qvdO\nHAOLAPAIcsqH9EfsQgCBReMY8YuwqUp7UHp4zxOH0pzVlpyxNry+PPrmU5tfcRFk\n1yhfizqX/tYS4vVnXJiAw04Sm2QA0oiC39j/oqxeNgtbUgC/94bVlOkg7ZW02iO5\nQcObEhRPVEhTJy4HmdOXemMRpq9iRCjrivMRRceeOZQ8nOTXf48QjkbMt9yco5oM\nkNTlebpUqj/a5CpkB7aZlLE8chJhKQRVcOMFnLLLlfuBoarBoAECggEBANGb5Zb3\nK6RsoNZzXoSRKRn3HhXMeWES6QSI26+yODafw97OpFrSEaF757jr9azKZhql81+w\nkL/5092mCyEymLOkkMnLUzrxAw4JiQNitPA+1uO6XOBuVRJl8m9Fey0EbvKOZQRg\nt3hPXFnkZowjnRuDzIE4EJFTmcEg7gXIAnF/89lo8R1f8fXcrTAEaeKugbxDMRse\nCVxyM1KNeJrMLZRdQ+pXc6kuhS5u14rk64woqcjo063RKztjgssecrNe7mF1yOcZ\npTYPBrnubElcXbnDPPa/cFy/nB5zvwM4tyOUwqRc+DyRlAJoqwbMqoooDW9mTnwl\n1D9ivFl5ZRNdJ7MCggEBAMzZAogtRMarn9evEKD6RGvTpHhKU84amQh9vET1b2Zn\nSdSsHtLy8JdtDXmIlnXLccK5L+eQ3dotYvB1bjVGzG1/7AySZA746RHXaDW5Hx+0\nW6HomUgWvcwmO4GE/M0jpfc8SkhGS9CD+IOCibbMXMwO29PiidxjdSZid5iOxI7K\nZj1g1+K5vwU0TJKt9vY8ugGKdUwKuCzwuCtrGjykd6BVb5agPQHQjN4+I33TiaMl\nY9FsUyER07sjAapk21gJFNleb8EWLjAHdPLaGsmSTrBe9r2bMBMjfvAhmW15QsNb\nUz9veuoGPQuONzxiXaYVms5Fzq2I2wsnSYf8WzfaJgECggEABlOIOGg5XvsQV6if\nv6yJ6wi0VcAYIb/qXIKs7r6YR73GsaDXAQ66DX+p3MDyZ0askj1T/R1dIQ4vQM9U\nIqpeRX3ACPckCfFgQDo1cm62O1IKNlFXoEZ0Ntvw1z7nmtI5bwSxM9KfdvgeN3BX\nT/97LGtr7rJ8fYZia5vM00vYFwjfmT47mMFekicY6wwXDgpqS/5TKxha+/lOZz1x\n2Go1Lfcqp5YAHakTx/T8eGq0WUSY60FrsiFQBrjYJ71BhPxmgXaGm8MAY4NMlqwF\nhKlPAt5Lpr7ca1A1LA4eQ8Cgdmh0/3T24Q0bxH7YOppOw2C2FxilYcXahBc8zA6H\n6G+1VQKCAQAise632dL4Q0FDaqdKXJkSGjqVFSG0mtSol4M3usovcfcTSkO+Pt95\nBkNt/jBdqyONc4gllGe++Ej1qS4NX/xn326/glvoHUh8eRtxXfVjjUyn05mCmDd1\nSFRzz25x4EPP6Co8q4tTucZxn75rc5mUBkA9VvU6mq3Q3oSbFjM8bBN8+dYW1JcB\n7qW5gjV95zMp56WOR5KCKhNHZ1B+TOzl/xJzVJiAoi35xlSEjzuUolSRt+MsirRt\n0bQKhCKSepdJabFL5tHT2K96Im6/DUS+opbv7kTqOOzbBxXRcORZ6jHjYKJU2NGm\nD2RTmeV6p9Yccb5brf5LmU/e9GMOxqgBAoIBAQC6UdFwAP1NgQetWhMPsKcx6yqU\nUfErIKTlncANGuXhWIy9roJkWcTcpHNVrLveIxyNUaqrxm1fksZZ9f3iB6Dmyem6\nloi05Lw4L+WZjmCTFFz85+bC+T+cTCoa95FueFij5dKQ01wKazHdy4sEcwDF8JHj\nVgUso5CAfQ60kUqmhKd3PVV6fiaE7gNOFhe/vFGEJ5tHgpQSZQTqoJtUc3sOEzAF\nw/BRouPRyWnsz977YdziLfvqtjvEUoP+Eu3z5YKDpokZe04lVGPrf9vBBUl4MAaT\nF+182Iezs4CKiB2MEgYxKGpv89e9rOkJvKQwL1aqgbMnXETNqzDIWZ3maPm7\n-----END RSA PRIVATE KEY-----\n	f	f	en	d1@test.de	$2a$10$qV8jzGwV99agKj2flKzqFu1H8akLPS6jfzKnkc7YcpRuxz932rr2.	\N	\N	1	2018-01-27 02:32:01.321835	2018-01-27 02:32:01.321835	127.0.0.1	127.0.0.1	2018-01-27 02:32:01.184283	2018-01-27 02:33:20.131561	\N	a_igUxzq2o9y4V9zWXdPhg582u3hNA	\N	\N	\N	t	f	\N	\N	\N	2018-01-27 02:32:01.331007	\N	\N	\N	f	t	\N	\N	f	original	f
\.


--
-- Name: account_deletions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('account_deletions_id_seq', 1, false);


--
-- Name: account_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('account_migrations_id_seq', 1, false);


--
-- Name: aspect_memberships_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('aspect_memberships_id_seq', 1, false);


--
-- Name: aspect_visibilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('aspect_visibilities_id_seq', 1, false);


--
-- Name: aspects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('aspects_id_seq', 4, true);


--
-- Name: authorizations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('authorizations_id_seq', 1, false);


--
-- Name: blocks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('blocks_id_seq', 1, false);


--
-- Name: chat_contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('chat_contacts_id_seq', 1, false);


--
-- Name: chat_fragments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('chat_fragments_id_seq', 1, false);


--
-- Name: chat_offline_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('chat_offline_messages_id_seq', 1, false);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('comments_id_seq', 1, false);


--
-- Name: contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('contacts_id_seq', 1, false);


--
-- Name: conversation_visibilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('conversation_visibilities_id_seq', 1, false);


--
-- Name: conversations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('conversations_id_seq', 1, false);


--
-- Name: invitation_codes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('invitation_codes_id_seq', 1, true);


--
-- Name: likes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('likes_id_seq', 1, false);


--
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('locations_id_seq', 1, false);


--
-- Name: mentions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('mentions_id_seq', 1, false);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('messages_id_seq', 1, false);


--
-- Name: notification_actors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('notification_actors_id_seq', 1, false);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('notifications_id_seq', 1, false);


--
-- Name: o_auth_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('o_auth_access_tokens_id_seq', 1, false);


--
-- Name: o_auth_applications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('o_auth_applications_id_seq', 1, false);


--
-- Name: o_embed_caches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('o_embed_caches_id_seq', 1, false);


--
-- Name: open_graph_caches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('open_graph_caches_id_seq', 1, false);


--
-- Name: participations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('participations_id_seq', 1, false);


--
-- Name: people_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('people_id_seq', 1, true);


--
-- Name: photos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('photos_id_seq', 1, false);


--
-- Name: pods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pods_id_seq', 1, false);


--
-- Name: poll_answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('poll_answers_id_seq', 1, false);


--
-- Name: poll_participations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('poll_participations_id_seq', 1, false);


--
-- Name: polls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('polls_id_seq', 1, false);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('posts_id_seq', 1, false);


--
-- Name: ppid_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ppid_id_seq', 1, false);


--
-- Name: profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('profiles_id_seq', 1, true);


--
-- Name: references_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('references_id_seq', 1, false);


--
-- Name: reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('reports_id_seq', 1, false);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('roles_id_seq', 1, false);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('services_id_seq', 1, false);


--
-- Name: share_visibilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('share_visibilities_id_seq', 1, false);


--
-- Name: signature_orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('signature_orders_id_seq', 1, false);


--
-- Name: simple_captcha_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('simple_captcha_data_id_seq', 2, true);


--
-- Name: tag_followings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tag_followings_id_seq', 1, false);


--
-- Name: taggings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('taggings_id_seq', 1, false);


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tags_id_seq', 1, false);


--
-- Name: user_preferences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_preferences_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 1, true);


--
-- Name: account_deletions account_deletions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account_deletions
    ADD CONSTRAINT account_deletions_pkey PRIMARY KEY (id);


--
-- Name: account_migrations account_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account_migrations
    ADD CONSTRAINT account_migrations_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: aspect_memberships aspect_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY aspect_memberships
    ADD CONSTRAINT aspect_memberships_pkey PRIMARY KEY (id);


--
-- Name: aspect_visibilities aspect_visibilities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY aspect_visibilities
    ADD CONSTRAINT aspect_visibilities_pkey PRIMARY KEY (id);


--
-- Name: aspects aspects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY aspects
    ADD CONSTRAINT aspects_pkey PRIMARY KEY (id);


--
-- Name: authorizations authorizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY authorizations
    ADD CONSTRAINT authorizations_pkey PRIMARY KEY (id);


--
-- Name: blocks blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY blocks
    ADD CONSTRAINT blocks_pkey PRIMARY KEY (id);


--
-- Name: chat_contacts chat_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY chat_contacts
    ADD CONSTRAINT chat_contacts_pkey PRIMARY KEY (id);


--
-- Name: chat_fragments chat_fragments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY chat_fragments
    ADD CONSTRAINT chat_fragments_pkey PRIMARY KEY (id);


--
-- Name: chat_offline_messages chat_offline_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY chat_offline_messages
    ADD CONSTRAINT chat_offline_messages_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: conversation_visibilities conversation_visibilities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversation_visibilities
    ADD CONSTRAINT conversation_visibilities_pkey PRIMARY KEY (id);


--
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


--
-- Name: invitation_codes invitation_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY invitation_codes
    ADD CONSTRAINT invitation_codes_pkey PRIMARY KEY (id);


--
-- Name: likes likes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY likes
    ADD CONSTRAINT likes_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: mentions mentions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mentions
    ADD CONSTRAINT mentions_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: notification_actors notification_actors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notification_actors
    ADD CONSTRAINT notification_actors_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: o_auth_access_tokens o_auth_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY o_auth_access_tokens
    ADD CONSTRAINT o_auth_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: o_auth_applications o_auth_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY o_auth_applications
    ADD CONSTRAINT o_auth_applications_pkey PRIMARY KEY (id);


--
-- Name: o_embed_caches o_embed_caches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY o_embed_caches
    ADD CONSTRAINT o_embed_caches_pkey PRIMARY KEY (id);


--
-- Name: open_graph_caches open_graph_caches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY open_graph_caches
    ADD CONSTRAINT open_graph_caches_pkey PRIMARY KEY (id);


--
-- Name: participations participations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY participations
    ADD CONSTRAINT participations_pkey PRIMARY KEY (id);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- Name: photos photos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY photos
    ADD CONSTRAINT photos_pkey PRIMARY KEY (id);


--
-- Name: pods pods_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pods
    ADD CONSTRAINT pods_pkey PRIMARY KEY (id);


--
-- Name: poll_answers poll_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY poll_answers
    ADD CONSTRAINT poll_answers_pkey PRIMARY KEY (id);


--
-- Name: poll_participations poll_participations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY poll_participations
    ADD CONSTRAINT poll_participations_pkey PRIMARY KEY (id);


--
-- Name: polls polls_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY polls
    ADD CONSTRAINT polls_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: ppid ppid_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ppid
    ADD CONSTRAINT ppid_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: references references_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "references"
    ADD CONSTRAINT references_pkey PRIMARY KEY (id);


--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: share_visibilities share_visibilities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY share_visibilities
    ADD CONSTRAINT share_visibilities_pkey PRIMARY KEY (id);


--
-- Name: signature_orders signature_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY signature_orders
    ADD CONSTRAINT signature_orders_pkey PRIMARY KEY (id);


--
-- Name: simple_captcha_data simple_captcha_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY simple_captcha_data
    ADD CONSTRAINT simple_captcha_data_pkey PRIMARY KEY (id);


--
-- Name: tag_followings tag_followings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tag_followings
    ADD CONSTRAINT tag_followings_pkey PRIMARY KEY (id);


--
-- Name: taggings taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: user_preferences user_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_preferences
    ADD CONSTRAINT user_preferences_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: conversations_author_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversations_author_id_fk ON conversations USING btree (author_id);


--
-- Name: idx_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_key ON simple_captcha_data USING btree (key);


--
-- Name: index_account_deletions_on_person_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_account_deletions_on_person_id ON account_deletions USING btree (person_id);


--
-- Name: index_account_migrations_on_old_person_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_account_migrations_on_old_person_id ON account_migrations USING btree (old_person_id);


--
-- Name: index_account_migrations_on_old_person_id_and_new_person_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_account_migrations_on_old_person_id_and_new_person_id ON account_migrations USING btree (old_person_id, new_person_id);


--
-- Name: index_aspect_memberships_on_aspect_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_aspect_memberships_on_aspect_id ON aspect_memberships USING btree (aspect_id);


--
-- Name: index_aspect_memberships_on_aspect_id_and_contact_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_aspect_memberships_on_aspect_id_and_contact_id ON aspect_memberships USING btree (aspect_id, contact_id);


--
-- Name: index_aspect_memberships_on_contact_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_aspect_memberships_on_contact_id ON aspect_memberships USING btree (contact_id);


--
-- Name: index_aspect_visibilities_on_aspect_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_aspect_visibilities_on_aspect_id ON aspect_visibilities USING btree (aspect_id);


--
-- Name: index_aspect_visibilities_on_shareable_and_aspect_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_aspect_visibilities_on_shareable_and_aspect_id ON aspect_visibilities USING btree (shareable_id, shareable_type, aspect_id);


--
-- Name: index_aspect_visibilities_on_shareable_id_and_shareable_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_aspect_visibilities_on_shareable_id_and_shareable_type ON aspect_visibilities USING btree (shareable_id, shareable_type);


--
-- Name: index_aspects_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_aspects_on_user_id ON aspects USING btree (user_id);


--
-- Name: index_aspects_on_user_id_and_contacts_visible; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_aspects_on_user_id_and_contacts_visible ON aspects USING btree (user_id, contacts_visible);


--
-- Name: index_aspects_on_user_id_and_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_aspects_on_user_id_and_name ON aspects USING btree (user_id, name);


--
-- Name: index_authorizations_on_o_auth_application_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_authorizations_on_o_auth_application_id ON authorizations USING btree (o_auth_application_id);


--
-- Name: index_authorizations_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_authorizations_on_user_id ON authorizations USING btree (user_id);


--
-- Name: index_blocks_on_user_id_and_person_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_blocks_on_user_id_and_person_id ON blocks USING btree (user_id, person_id);


--
-- Name: index_chat_contacts_on_user_id_and_jid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_chat_contacts_on_user_id_and_jid ON chat_contacts USING btree (user_id, jid);


--
-- Name: index_chat_fragments_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_chat_fragments_on_user_id ON chat_fragments USING btree (user_id);


--
-- Name: index_comment_signatures_on_comment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_comment_signatures_on_comment_id ON comment_signatures USING btree (comment_id);


--
-- Name: index_comments_on_commentable_id_and_commentable_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_comments_on_commentable_id_and_commentable_type ON comments USING btree (commentable_id, commentable_type);


--
-- Name: index_comments_on_guid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_comments_on_guid ON comments USING btree (guid);


--
-- Name: index_comments_on_person_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_comments_on_person_id ON comments USING btree (author_id);


--
-- Name: index_contacts_on_person_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_contacts_on_person_id ON contacts USING btree (person_id);


--
-- Name: index_contacts_on_user_id_and_person_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_contacts_on_user_id_and_person_id ON contacts USING btree (user_id, person_id);


--
-- Name: index_conversation_visibilities_on_conversation_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_conversation_visibilities_on_conversation_id ON conversation_visibilities USING btree (conversation_id);


--
-- Name: index_conversation_visibilities_on_person_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_conversation_visibilities_on_person_id ON conversation_visibilities USING btree (person_id);


--
-- Name: index_conversation_visibilities_usefully; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_conversation_visibilities_usefully ON conversation_visibilities USING btree (conversation_id, person_id);


--
-- Name: index_conversations_on_guid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_conversations_on_guid ON conversations USING btree (guid);


--
-- Name: index_like_signatures_on_like_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_like_signatures_on_like_id ON like_signatures USING btree (like_id);


--
-- Name: index_likes_on_guid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_likes_on_guid ON likes USING btree (guid);


--
-- Name: index_likes_on_post_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_likes_on_post_id ON likes USING btree (target_id);


--
-- Name: index_likes_on_target_id_and_author_id_and_target_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_likes_on_target_id_and_author_id_and_target_type ON likes USING btree (target_id, author_id, target_type);


--
-- Name: index_locations_on_status_message_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_locations_on_status_message_id ON locations USING btree (status_message_id);


--
-- Name: index_mentions_on_mc_id_and_mc_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_mentions_on_mc_id_and_mc_type ON mentions USING btree (mentions_container_id, mentions_container_type);


--
-- Name: index_mentions_on_person_and_mc_id_and_mc_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_mentions_on_person_and_mc_id_and_mc_type ON mentions USING btree (person_id, mentions_container_id, mentions_container_type);


--
-- Name: index_mentions_on_person_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_mentions_on_person_id ON mentions USING btree (person_id);


--
-- Name: index_messages_on_author_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_messages_on_author_id ON messages USING btree (author_id);


--
-- Name: index_messages_on_guid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_messages_on_guid ON messages USING btree (guid);


--
-- Name: index_notification_actors_on_notification_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_notification_actors_on_notification_id ON notification_actors USING btree (notification_id);


--
-- Name: index_notification_actors_on_notification_id_and_person_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_notification_actors_on_notification_id_and_person_id ON notification_actors USING btree (notification_id, person_id);


--
-- Name: index_notification_actors_on_person_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_notification_actors_on_person_id ON notification_actors USING btree (person_id);


--
-- Name: index_notifications_on_recipient_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_notifications_on_recipient_id ON notifications USING btree (recipient_id);


--
-- Name: index_notifications_on_target_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_notifications_on_target_id ON notifications USING btree (target_id);


--
-- Name: index_notifications_on_target_type_and_target_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_notifications_on_target_type_and_target_id ON notifications USING btree (target_type, target_id);


--
-- Name: index_o_auth_access_tokens_on_authorization_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_o_auth_access_tokens_on_authorization_id ON o_auth_access_tokens USING btree (authorization_id);


--
-- Name: index_o_auth_access_tokens_on_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_o_auth_access_tokens_on_token ON o_auth_access_tokens USING btree (token);


--
-- Name: index_o_auth_applications_on_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_o_auth_applications_on_client_id ON o_auth_applications USING btree (client_id);


--
-- Name: index_o_auth_applications_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_o_auth_applications_on_user_id ON o_auth_applications USING btree (user_id);


--
-- Name: index_o_embed_caches_on_url; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_o_embed_caches_on_url ON o_embed_caches USING btree (url);


--
-- Name: index_participations_on_author_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_participations_on_author_id ON participations USING btree (author_id);


--
-- Name: index_participations_on_guid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_participations_on_guid ON participations USING btree (guid);


--
-- Name: index_participations_on_target_id_and_target_type_and_author_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_participations_on_target_id_and_target_type_and_author_id ON participations USING btree (target_id, target_type, author_id);


--
-- Name: index_people_on_diaspora_handle; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_people_on_diaspora_handle ON people USING btree (diaspora_handle);


--
-- Name: index_people_on_guid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_people_on_guid ON people USING btree (guid);


--
-- Name: index_people_on_owner_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_people_on_owner_id ON people USING btree (owner_id);


--
-- Name: index_photos_on_author_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_photos_on_author_id ON photos USING btree (author_id);


--
-- Name: index_photos_on_guid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_photos_on_guid ON photos USING btree (guid);


--
-- Name: index_photos_on_status_message_guid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_photos_on_status_message_guid ON photos USING btree (status_message_guid);


--
-- Name: index_pods_on_checked_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_pods_on_checked_at ON pods USING btree (checked_at);


--
-- Name: index_pods_on_host_and_port; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_pods_on_host_and_port ON pods USING btree (host, port);


--
-- Name: index_pods_on_offline_since; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_pods_on_offline_since ON pods USING btree (offline_since);


--
-- Name: index_pods_on_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_pods_on_status ON pods USING btree (status);


--
-- Name: index_poll_answers_on_guid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_poll_answers_on_guid ON poll_answers USING btree (guid);


--
-- Name: index_poll_answers_on_poll_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_poll_answers_on_poll_id ON poll_answers USING btree (poll_id);


--
-- Name: index_poll_participation_signatures_on_poll_participation_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_poll_participation_signatures_on_poll_participation_id ON poll_participation_signatures USING btree (poll_participation_id);


--
-- Name: index_poll_participations_on_guid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_poll_participations_on_guid ON poll_participations USING btree (guid);


--
-- Name: index_poll_participations_on_poll_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_poll_participations_on_poll_id ON poll_participations USING btree (poll_id);


--
-- Name: index_polls_on_guid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_polls_on_guid ON polls USING btree (guid);


--
-- Name: index_polls_on_status_message_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_polls_on_status_message_id ON polls USING btree (status_message_id);


--
-- Name: index_post_visibilities_on_post_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_post_visibilities_on_post_id ON share_visibilities USING btree (shareable_id);


--
-- Name: index_posts_on_author_id_and_root_guid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_posts_on_author_id_and_root_guid ON posts USING btree (author_id, root_guid);


--
-- Name: index_posts_on_guid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_posts_on_guid ON posts USING btree (guid);


--
-- Name: index_posts_on_id_and_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_posts_on_id_and_type ON posts USING btree (id, type);


--
-- Name: index_posts_on_id_and_type_and_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_posts_on_id_and_type_and_created_at ON posts USING btree (id, type, created_at);


--
-- Name: index_posts_on_person_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_posts_on_person_id ON posts USING btree (author_id);


--
-- Name: index_posts_on_root_guid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_posts_on_root_guid ON posts USING btree (root_guid);


--
-- Name: index_posts_on_tweet_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_posts_on_tweet_id ON posts USING btree (tweet_id);


--
-- Name: index_ppid_on_o_auth_application_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_ppid_on_o_auth_application_id ON ppid USING btree (o_auth_application_id);


--
-- Name: index_ppid_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_ppid_on_user_id ON ppid USING btree (user_id);


--
-- Name: index_profiles_on_full_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_profiles_on_full_name ON profiles USING btree (full_name);


--
-- Name: index_profiles_on_full_name_and_searchable; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_profiles_on_full_name_and_searchable ON profiles USING btree (full_name, searchable);


--
-- Name: index_profiles_on_person_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_profiles_on_person_id ON profiles USING btree (person_id);


--
-- Name: index_references_on_source_and_target; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_references_on_source_and_target ON "references" USING btree (source_id, source_type, target_id, target_type);


--
-- Name: index_references_on_source_id_and_source_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_references_on_source_id_and_source_type ON "references" USING btree (source_id, source_type);


--
-- Name: index_reports_on_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_reports_on_item_id ON reports USING btree (item_id);


--
-- Name: index_roles_on_person_id_and_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_roles_on_person_id_and_name ON roles USING btree (person_id, name);


--
-- Name: index_services_on_type_and_uid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_services_on_type_and_uid ON services USING btree (type, uid);


--
-- Name: index_services_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_services_on_user_id ON services USING btree (user_id);


--
-- Name: index_share_visibilities_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_share_visibilities_on_user_id ON share_visibilities USING btree (user_id);


--
-- Name: index_signature_orders_on_order; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_signature_orders_on_order ON signature_orders USING btree ("order");


--
-- Name: index_tag_followings_on_tag_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_tag_followings_on_tag_id ON tag_followings USING btree (tag_id);


--
-- Name: index_tag_followings_on_tag_id_and_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_tag_followings_on_tag_id_and_user_id ON tag_followings USING btree (tag_id, user_id);


--
-- Name: index_tag_followings_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_tag_followings_on_user_id ON tag_followings USING btree (user_id);


--
-- Name: index_taggings_on_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_taggings_on_created_at ON taggings USING btree (created_at);


--
-- Name: index_taggings_on_tag_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_taggings_on_tag_id ON taggings USING btree (tag_id);


--
-- Name: index_taggings_on_taggable_id_and_taggable_type_and_context; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_taggings_on_taggable_id_and_taggable_type_and_context ON taggings USING btree (taggable_id, taggable_type, context);


--
-- Name: index_taggings_uniquely; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_taggings_uniquely ON taggings USING btree (taggable_id, taggable_type, tag_id);


--
-- Name: index_tags_on_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_tags_on_name ON tags USING btree (name);


--
-- Name: index_user_preferences_on_user_id_and_email_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_user_preferences_on_user_id_and_email_type ON user_preferences USING btree (user_id, email_type);


--
-- Name: index_users_on_authentication_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_authentication_token ON users USING btree (authentication_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_username ON users USING btree (username);


--
-- Name: likes_author_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX likes_author_id_fk ON likes USING btree (author_id);


--
-- Name: messages_conversation_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX messages_conversation_id_fk ON messages USING btree (conversation_id);


--
-- Name: shareable_and_hidden_and_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX shareable_and_hidden_and_user_id ON share_visibilities USING btree (shareable_id, shareable_type, hidden, user_id);


--
-- Name: shareable_and_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX shareable_and_user_id ON share_visibilities USING btree (shareable_id, shareable_type, user_id);


--
-- Name: aspect_memberships aspect_memberships_aspect_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY aspect_memberships
    ADD CONSTRAINT aspect_memberships_aspect_id_fk FOREIGN KEY (aspect_id) REFERENCES aspects(id) ON DELETE CASCADE;


--
-- Name: aspect_memberships aspect_memberships_contact_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY aspect_memberships
    ADD CONSTRAINT aspect_memberships_contact_id_fk FOREIGN KEY (contact_id) REFERENCES contacts(id) ON DELETE CASCADE;


--
-- Name: aspect_visibilities aspect_visibilities_aspect_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY aspect_visibilities
    ADD CONSTRAINT aspect_visibilities_aspect_id_fk FOREIGN KEY (aspect_id) REFERENCES aspects(id) ON DELETE CASCADE;


--
-- Name: comment_signatures comment_signatures_comment_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment_signatures
    ADD CONSTRAINT comment_signatures_comment_id_fk FOREIGN KEY (comment_id) REFERENCES comments(id) ON DELETE CASCADE;


--
-- Name: comment_signatures comment_signatures_signature_orders_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment_signatures
    ADD CONSTRAINT comment_signatures_signature_orders_id_fk FOREIGN KEY (signature_order_id) REFERENCES signature_orders(id);


--
-- Name: comments comments_author_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_author_id_fk FOREIGN KEY (author_id) REFERENCES people(id) ON DELETE CASCADE;


--
-- Name: contacts contacts_person_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_person_id_fk FOREIGN KEY (person_id) REFERENCES people(id) ON DELETE CASCADE;


--
-- Name: conversation_visibilities conversation_visibilities_conversation_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversation_visibilities
    ADD CONSTRAINT conversation_visibilities_conversation_id_fk FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE;


--
-- Name: conversation_visibilities conversation_visibilities_person_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversation_visibilities
    ADD CONSTRAINT conversation_visibilities_person_id_fk FOREIGN KEY (person_id) REFERENCES people(id) ON DELETE CASCADE;


--
-- Name: conversations conversations_author_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversations
    ADD CONSTRAINT conversations_author_id_fk FOREIGN KEY (author_id) REFERENCES people(id) ON DELETE CASCADE;


--
-- Name: ppid fk_rails_150457f962; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ppid
    ADD CONSTRAINT fk_rails_150457f962 FOREIGN KEY (o_auth_application_id) REFERENCES o_auth_applications(id);


--
-- Name: authorizations fk_rails_4ecef5b8c5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY authorizations
    ADD CONSTRAINT fk_rails_4ecef5b8c5 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: o_auth_access_tokens fk_rails_5debabcff3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY o_auth_access_tokens
    ADD CONSTRAINT fk_rails_5debabcff3 FOREIGN KEY (authorization_id) REFERENCES authorizations(id);


--
-- Name: account_migrations fk_rails_610fe19943; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account_migrations
    ADD CONSTRAINT fk_rails_610fe19943 FOREIGN KEY (new_person_id) REFERENCES people(id);


--
-- Name: o_auth_applications fk_rails_ad75323da2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY o_auth_applications
    ADD CONSTRAINT fk_rails_ad75323da2 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: account_migrations fk_rails_ddbe553eee; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account_migrations
    ADD CONSTRAINT fk_rails_ddbe553eee FOREIGN KEY (old_person_id) REFERENCES people(id);


--
-- Name: authorizations fk_rails_e166644de5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY authorizations
    ADD CONSTRAINT fk_rails_e166644de5 FOREIGN KEY (o_auth_application_id) REFERENCES o_auth_applications(id);


--
-- Name: ppid fk_rails_e6b8e5264f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ppid
    ADD CONSTRAINT fk_rails_e6b8e5264f FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: like_signatures like_signatures_like_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY like_signatures
    ADD CONSTRAINT like_signatures_like_id_fk FOREIGN KEY (like_id) REFERENCES likes(id) ON DELETE CASCADE;


--
-- Name: like_signatures like_signatures_signature_orders_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY like_signatures
    ADD CONSTRAINT like_signatures_signature_orders_id_fk FOREIGN KEY (signature_order_id) REFERENCES signature_orders(id);


--
-- Name: likes likes_author_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY likes
    ADD CONSTRAINT likes_author_id_fk FOREIGN KEY (author_id) REFERENCES people(id) ON DELETE CASCADE;


--
-- Name: messages messages_author_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_author_id_fk FOREIGN KEY (author_id) REFERENCES people(id) ON DELETE CASCADE;


--
-- Name: messages messages_conversation_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_conversation_id_fk FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE;


--
-- Name: notification_actors notification_actors_notification_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notification_actors
    ADD CONSTRAINT notification_actors_notification_id_fk FOREIGN KEY (notification_id) REFERENCES notifications(id) ON DELETE CASCADE;


--
-- Name: people people_pod_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY people
    ADD CONSTRAINT people_pod_id_fk FOREIGN KEY (pod_id) REFERENCES pods(id) ON DELETE CASCADE;


--
-- Name: poll_participation_signatures poll_participation_signatures_poll_participation_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY poll_participation_signatures
    ADD CONSTRAINT poll_participation_signatures_poll_participation_id_fk FOREIGN KEY (poll_participation_id) REFERENCES poll_participations(id) ON DELETE CASCADE;


--
-- Name: poll_participation_signatures poll_participation_signatures_signature_orders_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY poll_participation_signatures
    ADD CONSTRAINT poll_participation_signatures_signature_orders_id_fk FOREIGN KEY (signature_order_id) REFERENCES signature_orders(id);


--
-- Name: posts posts_author_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_author_id_fk FOREIGN KEY (author_id) REFERENCES people(id) ON DELETE CASCADE;


--
-- Name: profiles profiles_person_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_person_id_fk FOREIGN KEY (person_id) REFERENCES people(id) ON DELETE CASCADE;


--
-- Name: services services_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY services
    ADD CONSTRAINT services_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;


--
-- Name: share_visibilities share_visibilities_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY share_visibilities
    ADD CONSTRAINT share_visibilities_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

