import 'package:titan/feed/tools/function.dart';
import 'package:titan/tools/functions.dart';

class News {
  final String id;
  final String title;
  final DateTime start;
  final DateTime? end;
  final String entity;
  final String? location;
  final DateTime? actionStart;
  final String module;
  final String moduleObjectId;
  final NewsStatus status;

  const News({
    required this.id,
    required this.title,
    required this.start,
    this.end,
    required this.entity,
    this.location,
    this.actionStart,
    required this.module,
    required this.moduleObjectId,
    required this.status,
  });

  News.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      title = json['title'],
      start = processDateFromAPI(json['start']),
      end = json['end'] != null ? processDateFromAPI(json['end']) : null,
      entity = json['entity'],
      location = json['location'],
      actionStart = json['action_start'] != null
          ? processDateFromAPI(json['action_start'])
          : null,
      module = json['module'],
      moduleObjectId = json['module_object_id'],
      status = stringToNewsStatus(json['status']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'start': processDateToAPI(start),
      'end': end != null ? processDateToAPI(end!) : null,
      'entity': entity,
      'location': location,
      'action_start': actionStart != null
          ? processDateToAPI(actionStart!)
          : null,
      'module': module,
      'module_object_id': moduleObjectId,
      'status': status.toString().split('.').last,
    };
  }

  News copyWith({
    String? id,
    String? title,
    DateTime? start,
    DateTime? end,
    String? entity,
    String? location,
    DateTime? actionStart,
    String? module,
    String? moduleObjectId,
    NewsStatus? status,
  }) {
    return News(
      id: id ?? this.id,
      title: title ?? this.title,
      start: start ?? this.start,
      end: end ?? this.end,
      entity: entity ?? this.entity,
      location: location ?? this.location,
      actionStart: actionStart ?? this.actionStart,
      module: module ?? this.module,
      moduleObjectId: moduleObjectId ?? this.moduleObjectId,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'News(id: $id, title: $title, start: $start, end: $end, entity: $entity, location: $location, actionStart: $actionStart, module: $module, moduleObjectId: $moduleObjectId, status: $status)';
  }

  News.empty()
    : id = '',
      title = '',
      start = DateTime.now(),
      end = null,
      entity = '',
      location = null,
      actionStart = null,
      module = '',
      moduleObjectId = '',
      status = NewsStatus.waitingApproval;
}
