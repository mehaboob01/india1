class DummyJsonModal {
  List<Map<String, dynamic>> get accoutModal => _accountModal();

  List<Map<String, dynamic>> _accountModal() {
    return [
      {
        'id': 01,
        'name': 'SBI',
        'account': 123456789,
        'ifsc': 'SBIN000483',
        'type': 'Savings Account'
      },
      {
        'id': 02,
        'name': 'ICICI',
        'account': 246812,
        'ifsc': 'ICICI000483',
        'type': 'Current Account'
      },
      {
        'id': 03,
        'name': 'Kotak Bank',
        'account': 135791113,
        'ifsc': 'KOTAB000483',
        'type': 'Joint Account'
      },
      {
        'id': 04,
        'name': 'Canara Bank',
        'account': 123571113,
        'ifsc': 'CANRB000483',
        'type': 'Illegal Account'
      }
    ];
  }
}

  //  this.id,
  //   this.name,
  //   this.maskAccountNumber,
  //   this.ifscCode,
  //   this.accountType,