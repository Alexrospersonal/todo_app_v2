import 'package:todo_app_v2/l10n/l10n.dart';

class UserStatusProvider {
  UserStatusProvider({required AppLocalizations l10n})
      : _statuses = [
          l10n.statusProductive,
          // add anothers statuses
        ];

  final List<String> _statuses;

  int get statusesCount => _statuses.length;

  String getStatus(int idx) {
    if (idx < 0 || idx > _statuses.length - 1) {
      throw RangeError.index(idx, _statuses, 'Invalid index');
    }
    return _statuses[idx];
  }
}
