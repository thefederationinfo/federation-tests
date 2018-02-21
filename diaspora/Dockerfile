FROM thefederation/diaspora_image:v1.0.1

ENV DISABLE_DATABASE_ENVIRONMENT_CHECK 1

COPY post_like_comment.rb /diaspora/post_like_comment.rb
COPY share_with.rb /diaspora/share_with.rb
COPY schema.sql /diaspora/schema.sql
COPY start.sh /start.sh

CMD ["/bin/bash", "/start.sh"]
