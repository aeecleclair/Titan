enum NewsFilterType { all, pending, approved, rejected }

extension NewsFilterTypeExtension on NewsFilterType {
  String getKey() {
    switch (this) {
      case NewsFilterType.all:
        return 'feedFilterAll';
      case NewsFilterType.pending:
        return 'feedFilterPending';
      case NewsFilterType.approved:
        return 'feedFilterApproved';
      case NewsFilterType.rejected:
        return 'feedFilterRejected';
    }
  }
}
