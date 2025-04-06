import '../models/comment_model.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';

class DemoValues {
  static final List<UserModel> users = [
    UserModel(
      id: "1",
      name: "Ishfar",
      email: "ishfar@gmail.com",
      password: "123",
      image: "assets/user.png",
      joined: DateTime(2019, 4, 30),
      posts: 12,
    ),
    UserModel(
      id: "2",
      name: "Ishrak",
      email: "ishrak@gmail.com",
      password: "123",
      image: "assets/user.png",
      joined: DateTime(2018, 5, 30),
      posts: 13,
    ),
    UserModel(
      id: "3",
      name: "Shakleen",
      email: "shakleen@gmail.com",
      password: "123",
      image: "assets/user.png",
      joined: DateTime(2017, 6, 30),
      posts: 14,
    ),
  ];

  static const String _body =
  """Aspernatur omnis consequatur dignissimos recusandae non. Praesentium nihil earum. Porro perspiciatis a velit doloremque consequatur impedit. Autem odio sed qui consequatur laboriosam sapiente omnis sit. Tenetur blanditiis iure molestias quidem odit numquam sunt aliquam.
 
Vitae libero perferendis voluptate et quasi aut impedit fuga. Maiores suscipit fugiat a est molestiae voluptas quasi earum recusandae. Ut omnis excepturi ut dolore ab.
 
Quia quo quisquam velit adipisci dolorem adipisci voluptatem. Eum ut quae et dolorem sapiente. Ut reprehenderit et ut voluptatum saepe et voluptatem. Sit eveniet quaerat.

Sit necessitatibus voluptatem est iste nihil nulla. Autem quasi sit et. Qui veniam fugit autem. Minima error deserunt fuga dolorum rerum provident velit.
 
Quod necessitatibus vel laboriosam ut id. Ab eaque eos voluptatem beatae tenetur repellendus adipisci repudiandae quisquam. Quis quam harum aspernatur nulla. Deleniti velit molestiae.
 
Repudiandae sint soluta ullam sunt eos id laborum. Veniam molestiae ipsa odit soluta in rerum amet. Deserunt rerum vero est eaque voluptas aspernatur ut voluptatem. Sint sed enim.""";

  static final List<CommentModel> _comments = <CommentModel>[
    CommentModel(
      comment:
      "Et hic et sequi inventore. Molestiae laboriosam commodi exercitationem eum. ",
      user: users[0],
      time: DateTime(2019, 4, 30),
    ),
    CommentModel(
      comment: "Unde id provident ut sunt in consequuntur qui sed. ",
      user: users[1],
      time: DateTime(2018, 5, 30),
    ),
    CommentModel(
      comment: "Eveniet nesciunt distinctio sint ut. ",
      user: users[0],
      time: DateTime(2017, 6, 30),
    ),
    CommentModel(
      comment: "Et facere a eos accusantium culpa quaerat in fugiat suscipit. ",
      user: users[2],
      time: DateTime(2019, 4, 30),
    ),
    CommentModel(
      comment: "Necessitatibus pariatur harum deserunt cum illum ut.",
      user: users[1],
      time: DateTime(2018, 5, 30),
    ),
    CommentModel(
      comment:
      "Accusantium neque quis provident voluptatem labore quod dignissimos eum quaerat. ",
      user: users[2],
      time: DateTime(2017, 6, 30),
    ),
    CommentModel(
      comment:
      "Accusantium neque quis provident voluptatem labore quod dignissimos eum quaerat. ",
      user: users[1],
      time: DateTime(2019, 4, 30),
    ),
    CommentModel(
      comment: "Neque est ut rerum vel sunt harum voluptatibus et. ",
      user: users[0],
      time: DateTime(2018, 5, 30),
    ),
    CommentModel(
      comment:
      "Hic accusantium minus fuga exercitationem id aut expedita doloribus. ",
      user: users[1],
      time: DateTime(2017, 6, 30),
    ),
  ];

  static final List<PostModel> posts = [
    PostModel(
      id: "1",
      author: users[0],
      title: "Maple Trees",
      summary: "An in-depth study on maple trees.",
      body: "This is a short body.",
      imageURL: "assets/leaf.png",
      postTime: DateTime(2019, 11, 27, 7, 36),
      reacts: 123,
      views: 456,
      comments: _comments,
    ),
    PostModel(
      id: "2",
      author: users[1],
      title: "Oak Trees",
      summary: "Preaching about oak trees",
      body: _body,
      imageURL: "assets/leaf.png",
      postTime: DateTime(2019, 4, 13),
      reacts: 321,
      views: 654,
      comments: _comments,
    ),
    PostModel(
      id: "3",
      author: users[2],
      title: "Mango Trees",
      summary: "Gives shadow and fruit. Absolute win, no?",
      body: _body * 2,
      imageURL: "assets/leaf.png",
      postTime: DateTime(2019, 1, 12),
      reacts: 213,
      views: 546,
      comments: _comments,
    ),


    PostModel(
      id: 'poll1',
      title: 'What’s your favorite programming language?',
      summary: 'Vote your favorite language among the most popular ones!',
      body: '',
      imageURL: 'assets/images/poll_code.png',
      isPoll: true,
      postTime: DateTime.now().subtract(const Duration(days: 1)),
      reacts: 42,
      views: 300,
      author: users[2],
      comments: [],
      options: [
        PollOption(text: 'Python', votes: 10),
        PollOption(text: 'JavaScript', votes: 5),
        PollOption(text: 'C++', votes: 8),
        PollOption(text: 'Dart', votes: 12),
      ],
      votedUids: ['uid1', 'uid2', 'uid3', 'abc'],
    ),
    PostModel(
      id: 'poll2',
      title: 'Preferred Code Editor?',
      summary: 'Tell us what IDE or editor you swear by!',
      body: '',
      imageURL: 'assets/images/editor_poll.png',
      isPoll: true,
      postTime: DateTime.now().subtract(const Duration(hours: 3)),
      reacts: 30,
      views: 210,
      author: users[0],
      comments: [],
      options: [
        PollOption(text: 'VS Code', votes: 15),
        PollOption(text: 'Android Studio', votes: 7),
        PollOption(text: 'IntelliJ IDEA', votes: 4),
        PollOption(text: 'Vim', votes: 2),
      ],
      votedUids: ['uid5', 'uid9'],
    ),
  ];
}