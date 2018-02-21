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

SET search_path = public, pg_catalog;


--
-- Data for Name: people; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY people (id, guid, diaspora_handle, serialized_public_key, owner_id, created_at, updated_at, closed_account, fetch_status, pod_id) FROM stdin;
1	2d4fa7e0e5380135fa593c970e8692NAME	NAME@localhost:PORT	-----BEGIN PUBLIC KEY-----\nMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAp7nqLKGcKJY12UwNoNXu\nLr/aD0dLiKB+t0F+dcd1bllZE8wBXwWcUtd4g91YxtKniFxY810ov554lzk4uG63\nLIkyQY6wQMVWAxl9xd4lEirF4qLbO2Z2BzOcoRcu86DTppxrFHJ9VA78aWfyXFnH\n69SHmaq4p3HolN3Z64wFFtHuQ94XAxuDDtKkx7NX91tXj9/W9pEJSSxny8mlNZDB\nT7tDmV3ZgDdorq3tBT4h57/MQZquo3UE0V4g44yYP6jqhb+yS20QnO+0EB8plMAk\n0+e8qD885xZxoNvyEx7wUL4XyFYFrMNBQPjXCrwOHc/Wxs5m7t7HKLcTCzq3DX/q\nYmB4647awHfPa8GfdOsfaaKcnw0KEzf2Ekt/FNwkdKpS1aNGmuZs64x0zvDW9AFZ\nIxBZEu0TbTkovcuRoG1QDDzrDs3v9s7obEZh/Dmcn1jV9htGHRnqCVGVreDxVd5Y\nE19+7sKIkVK9PP3BYxrB6q/Kp8xbBGWdgRuhV+sszmSHi5u47oTg4mFfmzu7szpv\nzm0eIvryHD2wf9t0DDggCNNHzcRruR983h3dElfk37beKxon9r5XWbIeQkZYyaj1\nUcNV9q3P6Y00n00MqMt2sSFZS5gRvbigd/VUVcCqrsVwLtBU2NLogBKgpQW/OKo/\nuvVC3r23765SqzBLwSqvubMCAwEAAQ==\n-----END PUBLIC KEY-----\n	1	2018-01-27 02:32:01.197194	2018-01-27 02:32:01.197194	f	0	\N
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	production	2018-02-21 15:16:54.311527	2018-02-21 15:16:54.311527
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
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, username, serialized_private_key, getting_started, disable_mail, language, email, encrypted_password, reset_password_token, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at, invited_by_id, authentication_token, unconfirmed_email, confirm_email_token, locked_at, show_community_spotlight_in_stream, auto_follow_back, auto_follow_back_aspect_id, hidden_shareables, reset_password_sent_at, last_seen, remove_after, export, exported_at, exporting, strip_exif, exported_photos_file, exported_photos_at, exporting_photos, color_theme, post_default_public) FROM stdin;
1	NAME	-----BEGIN RSA PRIVATE KEY-----\n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\n-----END RSA PRIVATE KEY-----\n	f	f	en	NAME@test.de	$2a$10$qV8jzGwV99agKj2flKzqFu1H8akLPS6jfzKnkc7YcpRuxz932rr2.	\N	\N	1	2018-01-27 02:32:01.321835	2018-01-27 02:32:01.321835	127.0.0.1	127.0.0.1	2018-01-27 02:32:01.184283	2018-01-27 02:33:20.131561	\N	a_igUxzq2o9y4V9zWXdPhg582u3hNA	\N	\N	\N	t	f	\N	\N	\N	2018-01-27 02:32:01.331007	\N	\N	\N	f	t	\N	\N	f	original	f
\.


--
-- Data for Name: invitation_codes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY invitation_codes (id, token, user_id, count, created_at, updated_at) FROM stdin;
1	21d5740b9cdd	1	25	2018-01-27 02:32:01.497205	2018-01-27 02:32:01.497205
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY profiles (id, diaspora_handle, first_name, last_name, image_url, image_url_small, image_url_medium, birthday, gender, bio, searchable, person_id, created_at, updated_at, location, full_name, nsfw, public_details) FROM stdin;
1	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	1	2018-01-27 02:32:01.201093	2018-01-27 02:32:01.201093	\N		f	f
\.


--
-- Data for Name: simple_captcha_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY simple_captcha_data (id, key, value, created_at, updated_at) FROM stdin;
2	e99c956d879719b7774625a711c3e1c2b7aa1725	54298	2018-01-27 02:33:29.528515	2018-01-27 02:33:29.528515
\.
