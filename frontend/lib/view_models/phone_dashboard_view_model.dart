import 'package:flutter/material.dart';

import '../models/phone_number.dart';
import '../services/phone_service.dart';

class PhoneDashboardViewModel with ChangeNotifier {
  List<PhoneNumber> _origPhoneNumbers = [];
  List<PhoneNumber> _phoneNumbers = [];
  List<PhoneNumber> get phoneNumbers => _phoneNumbers;

  String _filter = 'All';
  String get filter => _filter;

  String _sortBy = 'Status';
  String get sortBy => _sortBy;

  final PhoneService _service = PhoneService();

  /// returns true if the fetch was successful
  Future<bool> fetchPhoneNumbers() async {
    _phoneNumbers = await _service.fetchPhoneNumbers();
    _origPhoneNumbers = List.from(_phoneNumbers);
    applyFilterAndSort();
    return true;
  }

  void setFilter(String newFilter) {
    _filter = newFilter;
    applyFilterAndSort();
    notifyListeners();
  }

  void setSortBy(String criterion) {
    _sortBy = criterion;
    applyFilterAndSort();
    notifyListeners();
  }

  List<PhoneNumber> get _filteredNumbers {
    return _origPhoneNumbers.where((phoneNum) {
      if (_filter == 'All') return true;
      return phoneNum.status.name == _filter.toLowerCase();
    }).toList();
  }

  void applyFilterAndSort() {
    List<PhoneNumber> tempList = _filteredNumbers;

    if (_sortBy == 'Messages') {
      // Sort by messages descending
      tempList.sort((a, b) => b.messages.compareTo(a.messages));
    } else if (_sortBy == 'Status') {
      // Sort by status alphabetically, Active first then Inactive
      tempList.sort((a, b) => a.status.name.compareTo(b.status.name));
    } else if (_sortBy == 'Phone Number') {
      // Sort by phone number alphabetically
      tempList.sort((a, b) => a.number.compareTo(b.number));
    }

    _phoneNumbers = List.from(tempList);

    notifyListeners();
  }

  void toggleStatus(PhoneNumber phoneNumber) {
    phoneNumber.status =
        phoneNumber.status == PhoneNumberStatus.active ? PhoneNumberStatus.inactive : PhoneNumberStatus.active;
    _phoneNumbers = _phoneNumbers.map((phoneNum) {
      if (phoneNum.number == phoneNumber.number) {
        return phoneNumber;
      }
      return phoneNum;
    }).toList();
    applyFilterAndSort();
    notifyListeners();
  }
}
