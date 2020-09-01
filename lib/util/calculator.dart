class Calculator {
  double _operand1 = 0.0, _operand2 = 0.0;
  double _result = 0.0;
  String _op = "";
  String _resultBuffer = "";

  // Getter & Setters
  double get result => _result;
  String get resultBuffer => _resultBuffer;

  set num1(double num1) => this._operand1 = num1;
  set num2(double num2) => this._operand2 = num2;
  set op(String op) => this._op = op;

  clear() {
    this._result = 0.0;
    clearResultBuffer();
    clearOperation();
  }

  clearResultBuffer() {
    if (_resultBuffer.isNotEmpty) {
      _result = double.parse(_resultBuffer);
    }
    _resultBuffer = "";
  }

  clearOperation() {
    _operand1 = 0.0;
    _operand2 = 0.0;
    _op = "";
  }

  calculate() {
    switch (_op) {
      case '+':
        _result = _operand1 + _operand2;
        break;
      case '-':
        _result = _operand1 - _operand2;
        break;
      case 'X':
        _result = _operand1 * _operand2;
        break;
      case '/':
        _result = _operand1 / _operand2;
        break;
    }
    _resultBuffer = _result.toString();
  }

  void addToResultBuffer(String toBeAdded) =>
      this._resultBuffer = _resultBuffer + toBeAdded;

  @override
  String toString() => '$_operand1 $_op $_operand2 = $_result';
}
