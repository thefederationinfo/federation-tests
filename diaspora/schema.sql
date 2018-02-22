SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;
SET search_path = public, pg_catalog;
COPY pods (id, host, ssl, created_at, updated_at, status, checked_at, offline_since, response_time, software, error, port, blocked, scheduled_check) FROM stdin;
1	pod.diaspora.software	t	2018-02-21 19:09:54.076511	2018-02-21 19:09:54.486298	1	1970-01-01 00:00:00	\N	-1	\N	\N	\N	f	f
\.
COPY people (id, guid, diaspora_handle, serialized_public_key, owner_id, created_at, updated_at, closed_account, fetch_status, pod_id) FROM stdin;
1	b81ca1f0f96801351c6f5296f2e7447bNAME	NAME@localhost:PORT	-----BEGIN PUBLIC KEY-----\nMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAn+oAMwYDZMSxYSrblICT\n/DIvXcYCOVLeFhdzgPqMmXvNi8BNIG89Y5dJbLeaye2sTsbCJ1K2YebgYtuVi4RQ\nqzC0iaIiamKZldF34cHgjuWSoHdTCMXXNPReEsu/7LEATsV3wC02YOyAIKSScMAn\ncbBeYCIiqf6YMEN5prprU1kt8CSB1wzkA3mnrUpdq4jsNxhi4/DmddGZiBpBE8rp\nIAwZxiQlgvQd5hSBCjDIb9REDaVYN/rf0wvcJgz9jWHNYxpgKm8rQMP+hFg3wan9\n0aOlacq4XADLaxCUhA5xA+VlFUdTt2EWmj+z/psokeXfxEhb1I0ZGR/8jcwUFETM\nwEARWTWuNtzBgVcBbUS6WzlgoLIZDL8staqVbX5pqB5pl4NRR0jGrSABXliy3hfY\nBv5eTfLzBAd2hlj2eXhK8iuJrsxFf5RYJpdBD0bw0vEH01ygYNQV9h0+CQ2nt2/u\nWNLoDVB6rNSynY4aEsWQ8kNo39vRs61pGEXVVBYeQJ7TS03q/MpgRjGVElcdPJZQ\nbR9fNw4g4FwrudGyy0XppkrH4AuPI9iqdoRjVnNC4GEW2GBxueLebnwk5e4ZPjYo\npSnTcxaqDXna4OR2XIhdJdoTl9ZQ9M4Ys4QB31IaiOS5gPtStI1sbEpzIlf4y4Za\nlJJ6u50OOxyUwX5e8vuQ4d8CAwEAAQ==\n-----END PUBLIC KEY-----\n	1	2018-02-21 19:09:53.741066	2018-02-21 19:09:53.741066	f	0	\N
2	7bca7c80311b01332d046c626dd55703	hq@pod.diaspora.software	-----BEGIN PUBLIC KEY-----\nMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAnRrtHuUwbXHXjRCypB2Q\nRv55JOsaNAVKJid5pc0FuxQ0rLK/vNXi/7fplMm4HHTwmeuK9eXZoQyvoH+qBVv6\nbFZ8KP0M95QcrOSJtvvKYm51ybO82/W/e2LLKNfLMgTq2uoCWJsq33fohRXFgpCZ\nAz+aeK41YdxCnXUkd2tZBK44dv+tHZJOXFIr0KZFLeWCEbryL5367JSe2Qjj6N4B\nWktt4dLpWO8J0HP5SiGhxTM/WUqKu3rCHtPyOWMTZz0f6R595ZOh04cwo+4iqJB2\nKvlsQAEsDfHnICNidRmSxTghn3QquYZS5N/3sKGpayOzC0GGo2g7eK7oX3ZzBGHq\nu0f4whcdq055MAGjg4pjJu1EYfMDux7Ik8JHyVinsVAvjIHbVeurWe8oMtriQ3pB\nFNIjR8SH1JNaZ1PSdIO8V/j0C24wa77jvN2AdZFdCoAvpXSd33fexwMd5vpuyfYB\naq2jOze+Hb0lxIsxOvpv2Vf76Zuc86lHYBNjB/n+e8aoDIqIMjvr+DSMsNpHHi3k\ntuEXcs0gomoOO6A2EeMdO4M57EP4S4yLaKtCNDLGNbR6rxagrxctLeylh0/a1IyS\nmUrPD6mYt9mjbmNrRpAGFS4n8KPoeqZSVdvb3bcyY2ewwYD2xAeKymiy9jxKPujK\nD2X2Zb3zifqQzfgAf2k44MECAwEAAQ==\n-----END PUBLIC KEY-----\n	\N	2018-02-21 19:09:54.093913	2018-02-21 19:09:54.093913	f	0	1
\.
COPY ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	production	2018-02-21 19:09:03.106945	2018-02-21 19:09:03.106945
\.
COPY aspects (id, name, user_id, created_at, updated_at, contacts_visible, order_id, chat_enabled, post_default) FROM stdin;
1	Family	1	2018-02-21 19:09:53.791664	2018-02-21 19:09:53.791664	t	1	f	t
2	Friends	1	2018-02-21 19:09:53.804478	2018-02-21 19:09:53.804478	t	2	f	t
3	Work	1	2018-02-21 19:09:53.816461	2018-02-21 19:09:53.816461	t	3	f	t
4	Acquaintances	1	2018-02-21 19:09:53.828097	2018-02-21 19:09:53.828097	t	4	f	t
\.
COPY contacts (id, user_id, person_id, created_at, updated_at, sharing, receiving) FROM stdin;
1	1	2	2018-02-21 19:09:54.146627	2018-02-21 19:09:54.146627	f	t
\.
COPY aspect_memberships (id, aspect_id, contact_id, created_at, updated_at) FROM stdin;
1	4	1	2018-02-21 19:09:54.148996	2018-02-21 19:09:54.148996
\.
COPY users (id, username, serialized_private_key, getting_started, disable_mail, language, email, encrypted_password, reset_password_token, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at, invited_by_id, authentication_token, unconfirmed_email, confirm_email_token, locked_at, show_community_spotlight_in_stream, auto_follow_back, auto_follow_back_aspect_id, hidden_shareables, reset_password_sent_at, last_seen, remove_after, export, exported_at, exporting, strip_exif, exported_photos_file, exported_photos_at, exporting_photos, color_theme, post_default_public) FROM stdin;
1	NAME	-----BEGIN RSA PRIVATE KEY-----\nMIIJKQIBAAKCAgEAn+oAMwYDZMSxYSrblICT/DIvXcYCOVLeFhdzgPqMmXvNi8BN\nIG89Y5dJbLeaye2sTsbCJ1K2YebgYtuVi4RQqzC0iaIiamKZldF34cHgjuWSoHdT\nCMXXNPReEsu/7LEATsV3wC02YOyAIKSScMAncbBeYCIiqf6YMEN5prprU1kt8CSB\n1wzkA3mnrUpdq4jsNxhi4/DmddGZiBpBE8rpIAwZxiQlgvQd5hSBCjDIb9REDaVY\nN/rf0wvcJgz9jWHNYxpgKm8rQMP+hFg3wan90aOlacq4XADLaxCUhA5xA+VlFUdT\nt2EWmj+z/psokeXfxEhb1I0ZGR/8jcwUFETMwEARWTWuNtzBgVcBbUS6WzlgoLIZ\nDL8staqVbX5pqB5pl4NRR0jGrSABXliy3hfYBv5eTfLzBAd2hlj2eXhK8iuJrsxF\nf5RYJpdBD0bw0vEH01ygYNQV9h0+CQ2nt2/uWNLoDVB6rNSynY4aEsWQ8kNo39vR\ns61pGEXVVBYeQJ7TS03q/MpgRjGVElcdPJZQbR9fNw4g4FwrudGyy0XppkrH4AuP\nI9iqdoRjVnNC4GEW2GBxueLebnwk5e4ZPjYopSnTcxaqDXna4OR2XIhdJdoTl9ZQ\n9M4Ys4QB31IaiOS5gPtStI1sbEpzIlf4y4ZalJJ6u50OOxyUwX5e8vuQ4d8CAwEA\nAQKCAgANlNQbgUE8h7AA7qDjheALpT98mVqK/8y415kJtT3Hs0oLunNSc+Ak2y5z\nO0y8JaFit2K58D5pJjCcdMXIqZ4oS+SpY8nEe0dMABRMaijmOf0v/7Jfpl3Ws4Jh\n2kgclBPQnNjEy5I4vR1MqG1/gfJXp4D8bSnAgkzunGxyipae544NPSyB1ShwWx6w\niwZVkTVuoHWVoloQW5LMil5Ijg0qmZx+xYciDhWT+t3Svb3oMYDuH8LUTkxAIlu6\nJ5RJM6s75XuRXwuvXnX5S3zAx+00ps9fosXxmmesWiYi6Q8UI6FoIzyq8GX5B7wD\nva2+ZmWQyAx0it880QikClcSOZ2h++/SsefmfX54y7CKEL0FBOtT+ZusRDw9qWtK\nz+FmCCUDB7bdwJ3ia9MbTZ2UTlJ8cnTZScBafd3bGPlFyU6CynPRl4ms1SF8LsAI\nd/AFd85jJ/9pvL9NSWxxdARkxYfBP77R2XkzPSBGAmwOLXu+03kHMuw1OWRf51ci\ndlRqHbUzpzvXH0Dtoh/YKFPVmTniRR0K0IMKYfA60UoUBLfPXed7tx35C9OCmMmM\nBhYrNYDAKQJRLGuDzB9rw8c2on+quakDSkSfFGXtOWfUGrU22xrWDY8Dui7N1rKZ\nd2IposCD+7r6sWDnpZH6RKJOam3WX0xW4Zh7LDWAFicGYE0V0QKCAQEAzUOxwFF8\n8q4xnuQ/dKNeVPFlPL4g0+ZL1IyJIab27TEUWAGZnwifdNRsLFVkZZJ7mhCQcfnj\nuOar1CVQabra5mnH1rFLCOOBkFN3b2PjLXKrozd4QBdtgCFu3qeV1xxAcg+m2iKU\nLUtyHqx82JycWKVfHuyyX5m7lAPNBP68kJOa7rBrvSUS7yDqF1lXlQpYqrBSIjcD\n/y7v9pkYds+6qYS3XZhZThfCIS7lzO9kBe6WCS73s1XIElQ7v6E0jIJWwHySbOgn\ncH7uJXQwa46YOLXR3stFGmzfZwDeaU1Yk0C0C1g8Vk6QGiPzWBtSEjQNKunAJw7p\nArHkNYKy2XWvawKCAQEAx3C32DiOncYe9Whvhlu2nfTZLFVoeUedLjTZ6fNzB6/D\n/JYqPMEiGmjeo4ovSIrGfwMmhoJEiidP2y0FP01lUp5h4jQPzgonuthJvw83tK/4\nm/KgFb1/SibdUB92aZtrSBj+aVNfSPRo2cMbJOLYBdCIvjWrxj1Rq1Tk6xeVnpud\nCOBPmTu2G9fbtTuqRLlc5U6WSwjpSdNzmBe041im1jUxwjcss2PFk062BloMm124\nGGlifDgmwIC7siY+BD42bw366Zm68JGAh2ZeZ5+o75HI5G6J1w/RSNyRsqNhNprN\nS0b7vYc66d1PoHK4nXDo284lOd38be5w8Jf4yEJ4XQKCAQEAxLbGZ6/wlcaY6VSG\n96oFIlTBl8gCP/Ep5QXV+flAFap+e6T063NhFZ7qGEax06HhcJHFTGWWdsIiFEq6\nWMlpNX5UtQzuAxO9PGqxQIAy3IBTuzTSumF5YF0qGpnywNdjb6xOVCjlZs8yC/F0\nKEdWkqHRmhpvC62SFdTaq5nRbqD2zx8l8XvRPHiHv16wz7W9qb8Wx5F/9BOwhtzL\nlDmaAxGchUcW9v9P3WtLce5OJl0zTpPDcQuZlO9C33CHoszahNgdn9+QxH/wjNZf\n/QQIH/knq2OU0zFZnCY6ACLO6zgME/84u+HIujSP5nUwXx+hKuofa48fgaSoNxwN\neNgPBwKCAQEAo8uvMaVBe9J7GpHrBi3MjW3J7t82LmTiclB1p+6JSobQL2IkzkDQ\nAWCfeTDEJI/U9ftgaJgUMmKW8yrGZHbsAC6TtXOMh2tPteRsrL2SwpLDW1CoqTI4\nmG3S1TsBxTofodblGxud5gzVEANtB55GTIA3zf/GU8mIiW3vlCSKfPjQv7l5ph+k\nMLnXd8DI1ihmYu1oAbgP4NII3aCarxzf6I1HkHo//BS074Z1eEH8mJ0f1Oy4Nczo\nBrGzdVxzEokFq6+Posre/TSCmrE4V2KJHDhfBTzDeB1FhNGh11TXQkFg2bIyjjXB\n7NAV1XBirutMUzm62Qu3hZGOsAogCFiPAQKCAQBVcrAoIH4i+5sd6jwzOVk5c24L\nIDtn2X68ZoMSFRT3jCSnLrPsMqxHbTrkha623eAke/XXtqXy8OJx89uC7lptB9/D\nNgqegAKJBhrYEm4lCh3Qnh+e/mAz+yHvdTXmqYrgxcRXtqYMqMsdZwwlij9U7HhO\nd2/kc/Hp3IaTnL3O1F/OvSHKFRA9t7xsQxFaRW2ANRdHfkGZyrQjXMqugFbOtmnM\nSm3M+MdyVhvUyjCC/oAsvR1jNACxn1uHnk6cAF9Dcn68szWuuFb62uLGs15YmqI4\n5wMkM42Wlg05vc33v8PXkyFcFQrz2iboEQYpeOElnzXH9JIBt8J1B5mgvDB0\n-----END RSA PRIVATE KEY-----\n	t	f	en	NAME@test.de	$2a$10$YoYB8icyOfr9GF7lyHCcHekmSgxzXh7oM1jkZB9eo4Qx2/ldtX516	\N	\N	1	2018-02-21 19:09:54.168178	2018-02-21 19:09:54.168178	127.0.0.1	127.0.0.1	2018-02-21 19:09:53.732021	2018-02-21 19:09:54.187634	\N	\N	\N	\N	\N	t	f	\N	\N	\N	2018-02-21 19:09:54.178565	\N	\N	\N	f	t	\N	\N	f	original	f
\.
COPY invitation_codes (id, token, user_id, count, created_at, updated_at) FROM stdin;
1	e9a8deed0451	1	25	2018-02-21 19:09:54.394384	2018-02-21 19:09:54.394384
\.
COPY profiles (id, diaspora_handle, first_name, last_name, image_url, image_url_small, image_url_medium, birthday, gender, bio, searchable, person_id, created_at, updated_at, location, full_name, nsfw, public_details) FROM stdin;
1	NAME@localhost:PORT	NA	ME	\N	\N	\N	\N	\N	\N	t	1	2018-02-21 19:09:53.745056	2018-02-21 19:09:53.745056	\N		f	f
2	\N	diaspora* HQ	\N	https://pod.diaspora.software/uploads/images/thumb_large_0f0e529bef78176741dc.png	https://pod.diaspora.software/uploads/images/thumb_small_0f0e529bef78176741dc.png	https://pod.diaspora.software/uploads/images/thumb_medium_0f0e529bef78176741dc.png	\N	\N	\N	t	2	2018-02-21 19:09:54.096031	2018-02-21 19:09:54.096031	\N	diaspora* hq	f	f
\.
SELECT pg_catalog.setval('account_deletions_id_seq', 1, false);
SELECT pg_catalog.setval('account_migrations_id_seq', 1, false);
SELECT pg_catalog.setval('aspect_memberships_id_seq', 1, true);
SELECT pg_catalog.setval('aspect_visibilities_id_seq', 1, false);
SELECT pg_catalog.setval('aspects_id_seq', 4, true);
SELECT pg_catalog.setval('authorizations_id_seq', 1, false);
SELECT pg_catalog.setval('blocks_id_seq', 1, false);
SELECT pg_catalog.setval('chat_contacts_id_seq', 1, false);
SELECT pg_catalog.setval('chat_fragments_id_seq', 1, false);
SELECT pg_catalog.setval('chat_offline_messages_id_seq', 1, false);
SELECT pg_catalog.setval('comments_id_seq', 1, false);
SELECT pg_catalog.setval('contacts_id_seq', 1, true);
SELECT pg_catalog.setval('conversation_visibilities_id_seq', 1, false);
SELECT pg_catalog.setval('conversations_id_seq', 1, false);
SELECT pg_catalog.setval('invitation_codes_id_seq', 1, true);
SELECT pg_catalog.setval('likes_id_seq', 1, false);
SELECT pg_catalog.setval('locations_id_seq', 1, false);
SELECT pg_catalog.setval('mentions_id_seq', 1, false);
SELECT pg_catalog.setval('messages_id_seq', 1, false);
SELECT pg_catalog.setval('notification_actors_id_seq', 1, false);
SELECT pg_catalog.setval('notifications_id_seq', 1, false);
SELECT pg_catalog.setval('o_auth_access_tokens_id_seq', 1, false);
SELECT pg_catalog.setval('o_auth_applications_id_seq', 1, false);
SELECT pg_catalog.setval('o_embed_caches_id_seq', 1, false);
SELECT pg_catalog.setval('open_graph_caches_id_seq', 1, false);
SELECT pg_catalog.setval('participations_id_seq', 1, false);
SELECT pg_catalog.setval('people_id_seq', 2, true);
SELECT pg_catalog.setval('photos_id_seq', 1, false);
SELECT pg_catalog.setval('pods_id_seq', 1, true);
SELECT pg_catalog.setval('poll_answers_id_seq', 1, false);
SELECT pg_catalog.setval('poll_participations_id_seq', 1, false);
SELECT pg_catalog.setval('polls_id_seq', 1, false);
SELECT pg_catalog.setval('posts_id_seq', 1, false);
SELECT pg_catalog.setval('ppid_id_seq', 1, false);
SELECT pg_catalog.setval('profiles_id_seq', 2, true);
SELECT pg_catalog.setval('references_id_seq', 1, false);
SELECT pg_catalog.setval('reports_id_seq', 1, false);
SELECT pg_catalog.setval('roles_id_seq', 1, false);
SELECT pg_catalog.setval('services_id_seq', 1, false);
SELECT pg_catalog.setval('share_visibilities_id_seq', 1, false);
SELECT pg_catalog.setval('signature_orders_id_seq', 1, false);
SELECT pg_catalog.setval('simple_captcha_data_id_seq', 1, true);
SELECT pg_catalog.setval('tag_followings_id_seq', 1, false);
SELECT pg_catalog.setval('taggings_id_seq', 1, false);
SELECT pg_catalog.setval('tags_id_seq', 1, false);
SELECT pg_catalog.setval('user_preferences_id_seq', 1, false);
SELECT pg_catalog.setval('users_id_seq', 1, true);
