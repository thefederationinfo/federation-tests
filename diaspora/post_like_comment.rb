user = User.find_by(username: ARGV[0])

publicPost = StatusMessageCreationService.new(user).create(
  status_message: {
    text: "StatusMessageCreationService publicPost"
  },
  public: true
)

aspectIds = Aspect.find_each.collect {|obj| obj.id if obj.user_id == 1 }
privatePost = StatusMessageCreationService.new(user).create(
  status_message: {
    text: "StatusMessageCreationService privatePost"
  },
  public: false,
  aspect_ids: aspectIds
)

CommentService.new(user).create(publicPost.id, "publicComment")
CommentService.new(user).create(privatePost.id, "privateComment")

LikeService.new(user).create(publicPost.id)
LikeService.new(user).create(privatePost.id)
