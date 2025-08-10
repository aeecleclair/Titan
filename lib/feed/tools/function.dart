enum NewsStatus { waitingApproval, rejected, published }


String newsStatusToString(NewsStatus status) {
  switch (status) {
    case NewsStatus.waitingApproval:
      return 'waiting_approval';
    case NewsStatus.rejected:
      return 'rejected';
    case NewsStatus.published:
      return 'published';
  }
}

NewsStatus stringToNewsStatus(String status) {
  switch (status) {
    case 'waiting_approval':
      return NewsStatus.waitingApproval;
    case 'rejected':
      return NewsStatus.rejected;
    case 'published':
      return NewsStatus.published;
    default:
      return NewsStatus.waitingApproval; // Default case
  }
}
