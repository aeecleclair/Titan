class FundingUrl {
  String url;

  FundingUrl({required this.url});

  factory FundingUrl.fromJson(Map<String, dynamic> json) {
    return FundingUrl(url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {'url': url};
  }

  @override
  String toString() {
    return 'FundingUrl{url: $url}';
  }

  FundingUrl copyWith({String? url}) {
    return FundingUrl(url: url ?? this.url);
  }

  FundingUrl.empty() : this(url: '');
}
