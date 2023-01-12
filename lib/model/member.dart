class Member {
  final int chapter;
  final int diamond;
  final String highScore;
  final int level;
  final String phone;
  final int rank;
  final DateTime time;
  final String userName;
  final String userID;

  Member({
    required this.chapter,
    required this.diamond,
    required this.highScore,
    required this.level,
    required this.phone,
    required this.rank,
    required this.time,
    required this.userName,
    required this.userID,
  });

  factory Member.FromRTDB(Map<String, dynamic> data) {
    return Member(
      chapter: data['chapter'] ?? 'Unknown',
      diamond: data['diamond'] ?? 'Unknown',
      highScore: data['highScore'] ?? 'Unknown',
      level: data['highScore'] ?? 'Unknown',
      phone: data['phone'] ?? 'Unknown',
      rank: data['rank'] ?? 'Unknown',
      time: (data['time'] != null)
          ? DateTime.fromMillisecondsSinceEpoch(data['time'])
          : DateTime.now(),
      userName: data['userName'] ?? 'Unknown',
      userID: data['userID'] ?? 'Unknown',
    );
  }
}
