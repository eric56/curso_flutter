import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CreateFormTransfer(),
        drawer: DrawerByteBank(),
      ),
    );
  }
}

class CreateFormTransfer extends StatelessWidget {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _agencyController = TextEditingController();
  final TextEditingController _bankController = TextEditingController();

  void createTransfer(TransferDTO transfer){
    debugPrint(transfer.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fazer Transfrência'),
      ),
      body: Column(
        children: <Widget>[
          InputTextApp(
              this._valueController, 'Valor',
              hint: 'Valor maior que zero',
              icon: Icons.monetization_on,
              inputType: TextInputType.number),
          InputTextApp(
              this._bankController, 'Banco',
              hint: 'Código Banco',
              icon: Icons.account_balance,
              inputType: TextInputType.number),
          InputTextApp(
              this._agencyController, 'Agência', hint: '0000',
              icon: Icons.book,
              inputType: TextInputType.number),
          InputTextApp(
              this._accountController, 'Conta', hint: '0000-0',
              icon: Icons.account_balance_wallet,
              inputType: TextInputType.number),
          ElevatedButton(
            child: Text('Transferir'),
            onPressed: () {
              double value = double.tryParse(this._valueController.text);
              TransferDTO transfer = TransferDTO(
                  value,
                  this._agencyController.text,
                  this._accountController.text,
                  this._bankController.text);
              if (!transfer.isValid()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Tranferência inválida. Por favor verifique os campos!"),
                  ),
                );
                return;
              }
              createTransfer(transfer);
            },
          ),
        ],
      ),
    );
  }
}

class InputTextApp extends StatelessWidget {

  TextEditingController _controller;
  String _label;
  TextInputType inputType;
  String hint;
  IconData icon;

  InputTextApp(this._controller, this._label,
      {this.hint, this.inputType, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        style: TextStyle(fontSize: 16.0),
        decoration: InputDecoration(
            icon: this.icon != null ? Icon(this.icon) : null,
            labelText: this._label,
            hintText: this.hint != null ? this.hint : null),
        keyboardType: this.inputType != null ? this.inputType : TextInputType
            .text,
        controller: this._controller,
      ),
    );
  }
}

void callback() {}

class HomeBytebank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transferências')),
      body: Column(
        children: [
          TransferData(TransferDTO(560.76, '3567', '12289-0', 'Itaú')),
          TransferData(TransferDTO(1490.21, '4561', '11456-9', 'Santander')),
          TransferData(TransferDTO(90.00, '4561', '11456-9', 'Santander')),
          TransferData(TransferDTO(341.09, '3567', '12289-0', 'Itaú')),
          TransferData(TransferDTO(128.55, '3567', '12289-0', 'Itaú'))
        ],
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add)),
      drawer: DrawerByteBank(),
    );
  }
}

class TransferData extends StatelessWidget {
  final TransferDTO _transfer;

  const TransferData(this._transfer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(this._transfer._value.toString()),
        subtitle: Text(this._transfer.getDetailTransfer()),
        leading: Icon(Icons.monetization_on),
      ),
    );
  }
}

class TransferDTO {
  final double _value;
  final String _agency;
  final String _account;
  final String _bank;

  TransferDTO(this._value, this._agency, this._account, this._bank);

  bool isValid() {
    return this._value != null && this._value > 0 &&
        this._agency != null &&
        this._account != null &&
        this._bank != null;
  }

  String getDetailTransfer() {
    return _bank.toString() +
        ' - Agência: ' +
        this._agency +
        ' - Conta: ' +
        this._account;
  }

  @override
  String toString() {
    return 'TransferDTO{_value: $_value, _agency: $_agency, _account: $_account, _bank: $_bank}';
  }
}

//Drawer App
class DrawerByteBank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Messages'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
