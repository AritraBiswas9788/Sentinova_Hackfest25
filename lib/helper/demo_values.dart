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

  static final List<PostModel> posts = [
    PostModel(
      id: "6",
      author: users[1],
      title: "Proposal Accepted!",
      summary: "My project with KDE was selected for GSoC 2024!",
      body: "The excitement is unreal. After weeks of drafting and feedback, my proposal for improving KDE's Kdenlive timeline rendering got accepted!\n\nBig thanks to my mentor and the community for reviewing it and giving helpful suggestions. Can't wait to get started with community bonding and coding!",
      imageURL: "https://talk.openmrs.org/uploads/default/original/3X/9/7/97eb29677309c8e89d474a25a0071680dea8b820.png",
      postTime: DateTime(2024, 4, 22),
      reacts: 89,
      views: 340,
      comments: [
        CommentModel(
          comment: "Congrats! KDE has an amazing dev community.",
          user: users[0],
          time: DateTime(2024, 4, 23),
        ),
        CommentModel(
          comment: "Excited to follow your journey. All the best!",
          user: users[2],
          time: DateTime(2024, 4, 23),
        ),
      ],
    ),
    PostModel(
      id: "7",
      author: users[2],
      title: "GSoC Midterm Update",
      summary: "Halfway there! Here’s what I’ve accomplished so far.",
      body: "It’s midterm time! I’ve finished implementing the core parser for the Open Source Reporting CLI tool under CCExtractor. Writing tests and documentation now.\n\nShoutout to my mentor who’s been super responsive and helpful. Also, huge thanks to the community on Matrix and GitHub for their suggestions!",
      imageURL: "https://tse4.mm.bing.net/th?id=OIP.qoJZhwQt_46aLIqsds0q6wHaFj&pid=Api&P=0&h=180",
      postTime: DateTime(2024, 7, 3),
      reacts: 113,
      views: 415,
      comments: [
        CommentModel(
          comment: "You’re making solid progress. Great work!",
          user: users[1],
          time: DateTime(2024, 7, 3),
        ),
        CommentModel(
          comment: "Your weekly blog updates have been really helpful!",
          user: users[0],
          time: DateTime(2024, 7, 4),
        ),
      ],
    ),
    PostModel(
      id: "8",
      author: users[0],
      title: "Meeting My Mentor in SF",
      summary: "Met my mentor in person at the San Francisco meetup ❤️",
      body: "We’ve been working remotely for months, and meeting in person was just amazing. Discussed the future of our project and had some great tacos afterward 😄\n\nIt’s moments like these that make GSoC special. In-person connections, shared passion, and lots of open-source energy!",
      imageURL: "https://www.everbridge.com/wp-content/uploads/2023/06/GSOC.jpg",
      postTime: DateTime(2024, 6, 20),
      reacts: 157,
      views: 520,
      comments: [
        CommentModel(
          comment: "Love this! Hope to meet my mentor someday too.",
          user: users[2],
          time: DateTime(2024, 6, 20),
        ),
        CommentModel(
          comment: "Tacos & open source? Count me in!",
          user: users[1],
          time: DateTime(2024, 6, 21),
        ),
      ],
    ),
    PostModel(
      id: "9",
      author: users[2],
      title: "My First Open Source Contribution",
      summary: "I finally sent my first PR for GSoC. Here’s how it went.",
      body: "It might have been a small typo fix, but it meant everything to me. My first pull request was accepted into the main branch 🎉\n\nThe community was so welcoming and gave me feedback in just a few hours. If you’re starting with GSoC, don’t hesitate to begin small. Every bit counts.",
      imageURL: "https://gsoc.co.uk/resources/uploads/promotions/top-level-home/Banner-GSOC-Analyst.jpg",
      postTime: DateTime(2024, 5, 2),
      reacts: 77,
      views: 300,
      comments: [
        CommentModel(
          comment: "That first PR always hits different. Congrats!",
          user: users[0],
          time: DateTime(2024, 5, 2),
        ),
        CommentModel(
          comment: "Keep going! Your confidence will grow with each one.",
          user: users[1],
          time: DateTime(2024, 5, 3),
        ),
      ],
    ),
    PostModel(
      id: "10",
      author: users[1],
      title: "Swag Received!",
      summary: "Got my GSoC 2024 package and it’s awesome!",
      body: "The stickers, hoodie, notebook… it all feels surreal 😍\n\nBeyond the material things, this symbolizes a summer of learning and collaboration. Thanks Google and my org for such an amazing opportunity!",
      imageURL: "https://www.pinterestcareers.com/media/vcthjb4u/bellaseth-24.jpg?width=600&height=450&rnd=133561072070400000&width=600&height=450&rmode=crop&quality=85",
      postTime: DateTime(2024, 9, 20),
      reacts: 142,
      views: 600,
      comments: [
        CommentModel(
          comment: "Swag goals! Looks awesome 🔥",
          user: users[0],
          time: DateTime(2024, 9, 20),
        ),
        CommentModel(
          comment: "The hoodie is 🔥🔥🔥. Can’t wait to wear mine.",
          user: users[2],
          time: DateTime(2024, 9, 21),
        ),
      ],
    ),
  ];
}
