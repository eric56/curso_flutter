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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fazer Transfrência'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(
                fontSize: 16.0,
              ),
              decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on),
                  labelText: 'Valor',
                  hintText: '0.00'),
              keyboardType: TextInputType.number,
              controller: this._valueController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(
                fontSize: 16.0,
              ),
              decoration: InputDecoration(
                  icon: Icon(Icons.account_balance),
                  labelText: 'Banco',
                  hintText: 'Codigo Banco'),
              keyboardType: TextInputType.number,
              controller: this._bankController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(
                fontSize: 16.0,
              ),
              decoration: InputDecoration(
                  icon: Icon(Icons.book),
                  labelText: 'Agência',
                  hintText: '0000'),
              keyboardType: TextInputType.number,
              controller: this._agencyController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(
                fontSize: 16.0,
              ),
              decoration: InputDecoration(
                  icon: Icon(Icons.account_balance_wallet),
                  labelText: 'Conta',
                  hintText: '0000'),
              keyboardType: TextInputType.number,
              controller: this._accountController,
            ),
          ),
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
              //Tranferencia válida, executar codigo
              debugPrint(transfer.toString());
            },
          ),
        ],
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
