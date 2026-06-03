class MusicProject {
  final String id;
  final String title;
  final String genre;
  final String mood;
  final String lyrics;

  final String beatGenre;
  final String beatBpm;
  final String beatMood;
  final String beatInstruments;

  final String recordingName;
  final String recordingDuration;
  final String recordingStatus;
  final String recordingNotes;

  final String mixStatus;
  final String mixMastering;
  final String mixNotes;

  final DateTime createdAt;

  const MusicProject({
    required this.id,
    required this.title,
    this.genre = '',
    this.mood = '',
    this.lyrics = '',
    this.beatGenre = '',
    this.beatBpm = '',
    this.beatMood = '',
    this.beatInstruments = '',
    this.recordingName = '',
    this.recordingDuration = '',
    this.recordingStatus = '',
    this.recordingNotes = '',
    this.mixStatus = '',
    this.mixMastering = '',
    this.mixNotes = '',
    required this.createdAt,
  });

  MusicProject copyWith({
    String? title,
    String? genre,
    String? mood,
    String? lyrics,
    String? beatGenre,
    String? beatBpm,
    String? beatMood,
    String? beatInstruments,
    String? recordingName,
    String? recordingDuration,
    String? recordingStatus,
    String? recordingNotes,
    String? mixStatus,
    String? mixMastering,
    String? mixNotes,
  }) {
    return MusicProject(
      id: id,
      title: title ?? this.title,
      genre: genre ?? this.genre,
      mood: mood ?? this.mood,
      lyrics: lyrics ?? this.lyrics,
      beatGenre: beatGenre ?? this.beatGenre,
      beatBpm: beatBpm ?? this.beatBpm,
      beatMood: beatMood ?? this.beatMood,
      beatInstruments: beatInstruments ?? this.beatInstruments,
      recordingName: recordingName ?? this.recordingName,
      recordingDuration: recordingDuration ?? this.recordingDuration,
      recordingStatus: recordingStatus ?? this.recordingStatus,
      recordingNotes: recordingNotes ?? this.recordingNotes,
      mixStatus: mixStatus ?? this.mixStatus,
      mixMastering: mixMastering ?? this.mixMastering,
      mixNotes: mixNotes ?? this.mixNotes,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'genre': genre,
      'mood': mood,
      'lyrics': lyrics,
      'beatGenre': beatGenre,
      'beatBpm': beatBpm,
      'beatMood': beatMood,
      'beatInstruments': beatInstruments,
      'recordingName': recordingName,
      'recordingDuration': recordingDuration,
      'recordingStatus': recordingStatus,
      'recordingNotes': recordingNotes,
      'mixStatus': mixStatus,
      'mixMastering': mixMastering,
      'mixNotes': mixNotes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory MusicProject.fromJson(Map<String, dynamic> json) {
    return MusicProject(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      genre: json['genre'] ?? '',
      mood: json['mood'] ?? '',
      lyrics: json['lyrics'] ?? '',
      beatGenre: json['beatGenre'] ?? '',
      beatBpm: json['beatBpm'] ?? '',
      beatMood: json['beatMood'] ?? '',
      beatInstruments: json['beatInstruments'] ?? '',
      recordingName: json['recordingName'] ?? '',
      recordingDuration: json['recordingDuration'] ?? '',
      recordingStatus: json['recordingStatus'] ?? '',
      recordingNotes: json['recordingNotes'] ?? '',
      mixStatus: json['mixStatus'] ?? '',
      mixMastering: json['mixMastering'] ?? '',
      mixNotes: json['mixNotes'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}