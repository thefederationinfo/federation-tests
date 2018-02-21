FROM thefederation/diaspora_image:v1.0.2

ENV DISABLE_DATABASE_ENVIRONMENT_CHECK 1

COPY private_post.rb /diaspora/private_post.rb
COPY public_post.rb /diaspora/public_post.rb
COPY like.rb /diaspora/like.rb
COPY comment.rb /diaspora/comment.rb
COPY share_with.rb /diaspora/share_with.rb
COPY schema.sql /diaspora/schema.sql
COPY start.sh /start.sh

CMD ["/bin/bash", "/start.sh"]
